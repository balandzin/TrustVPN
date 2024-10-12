import UIKit

final class PasswordSecurityController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    var expandedSections = Set<Int>()
    
    // MARK: - GUI Variables
    let tableView = DropdownTableView()
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = AppText.passwordSecurity
        label.textAlignment = .left
        label.textColor = AppColors.almostWhite
        label.font = .systemFont(ofSize: 26, weight: .bold)
        return label
    }()
    
    private lazy var dataIsSecureStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var shieldView: UIImageView = {
        let image = UIImageView()
        image.image = .loadImage(LoadService.shared.load?.images?.shield) ?? UIImage(named: "shield")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var dataIsSecureLabel: UILabel = {
        let label = UILabel()
        label.text = AppText.dataIsSecure
        label.textColor = AppColors.dataSecurityLabel
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = PaddedTextField()
        textField.placeholder = AppText.typePassword
        textField.placeHolderColor = AppColors.dataSecurityLabel
        textField.font = .systemFont(ofSize: 14, weight: .bold)
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 40)
        textField.textColor = AppColors.almostWhite
        textField.layer.cornerRadius = 10
        textField.keyboardAppearance = .dark
        textField.backgroundColor = AppColors.textFieldBackground
        textField.addTarget(self, action: #selector(passwordTextChanged), for: .editingChanged)
        
        return textField
    }()
    
    private lazy var togglePasswordVisibilityButton: UIButton = {
        let button = UIButton()
        button.setImage(.loadImage(LoadService.shared.load?.images?.eye) ?? UIImage(named: "eye"), for: .normal)
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        return button
    }()
    
    private lazy var progressStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 13
        return stackView
    }()
    
    private lazy var progressBar: GradientProgressView = {
        let progressView = GradientProgressView()
        progressView.layer.cornerRadius = 4
        progressView.backgroundColor = AppColors.termsView
        return progressView
    }()
    
    private lazy var successStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var successLabel: UILabel = {
        let label = UILabel()
        label.text = AppText.unsecurePassword
        label.textColor = AppColors.unsecurePassword
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private lazy var successImage: UIImageView = {
        let image = UIImageView()
        image.image = .loadImage(LoadService.shared.load?.images?.unsecurePassword) ?? UIImage(named: "unsecurePassword")
        return image
    }()
    
    private lazy var crackedDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = AppText.crackedDescriptionLabel
        label.textColor = AppColors.almostWhite
        label.font = .systemFont(ofSize: 14)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var tipsLabel: UILabel = {
        let label = UILabel()
        label.text = AppText.tips
        label.textColor = AppColors.almostWhite
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let titles = [
        AppText.howToCreateStrongPasswords,
        AppText.whyIsPasswordSecurityImportant,
        AppText.howOurToolWorks,
        AppText.typesOfPasswordAttacks
    ]
    
    private let contents = [
        AppText.howToCreateStrongPasswordsDescription,
        AppText.whyIsPasswordSecurityImportantDescription,
        AppText.howOurToolWorksDescription,
        AppText.typesOfPasswordAttacksDescription
    ]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupStyle()
        setupUI()
        addTapGestureToHideKeyboard()
    }
    
    // MARK: - Actions
    @objc private func togglePasswordVisibility() {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
    
    @objc private func passwordTextChanged() {
        guard let password = passwordTextField.text else { return }
        if password.isEmpty {
            updateHideProgressView(isHidden: true)
            return
        }

        updateHideProgressView(isHidden: false)
        let score = calculatePasswordStrength(password)
        updatePasswordUI(for: score)
    }
    
    // MARK: - Private Methods
    private func addTapGestureToHideKeyboard() {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
            tapGesture.cancelsTouchesInView = false
            view.addGestureRecognizer(tapGesture)
    }
    
    private func updateHideProgressView(isHidden: Bool) {
        if isHidden {
            progressStackView.isHidden = true
            tipsLabel.snp.remakeConstraints { make in
                make.top.equalTo(passwordTextField.snp.bottom).offset(12)
                make.leading.trailing.equalToSuperview().inset(24)
            }
        } else {
            progressStackView.isHidden = false
            
            progressStackView.snp.remakeConstraints { make in
                make.top.equalTo(passwordTextField.snp.bottom).offset(12)
                make.leading.trailing.equalToSuperview().inset(40)
            }
            tipsLabel.snp.remakeConstraints { make in
                make.top.equalTo(progressStackView.snp.bottom).offset(30)
                make.leading.trailing.equalToSuperview().inset(24)
            }
        }
        
    }
    
    // Обновление UI в зависимости от силы пароля
    private func updatePasswordUI(for score: Int) {
        let strength: (color: UIColor, label: String, image: UIImage, progress: Float, crackedLabel: String, crackedLong: String)
        
        switch score {
        case 0:
            strength = (AppColors.unsecurePassword, AppText.unsecurePassword, .loadImage(LoadService.shared.load?.images?.unsecurePassword) ?? UIImage(named: "unsecurePassword") ?? UIImage(), 0.0, crackedLabel: "", crackedLong: "")
        case 1:
            strength = (AppColors.unsecurePassword, AppText.unsecurePassword, .loadImage(LoadService.shared.load?.images?.unsecurePassword) ?? UIImage(named: "unsecurePassword") ?? UIImage(), 0.1, crackedLabel: "3", crackedLong: AppText.min)
        case 2:
            strength = (AppColors.unsecurePassword, AppText.unsecurePassword, .loadImage(LoadService.shared.load?.images?.unsecurePassword) ?? UIImage(named: "unsecurePassword") ?? UIImage(), 0.2, crackedLabel: "5", crackedLong: AppText.min)
        case 3:
            strength = (AppColors.unsecurePassword, AppText.unsecurePassword, .loadImage(LoadService.shared.load?.images?.unsecurePassword) ?? UIImage(named: "unsecurePassword") ?? UIImage(), 0.3, crackedLabel: "23", crackedLong: AppText.min)
        case 4:
            strength = (AppColors.unsecurePassword, AppText.unsecurePassword, .loadImage(LoadService.shared.load?.images?.unsecurePassword) ?? UIImage(named: "unsecurePassword") ?? UIImage(), 0.4, crackedLabel: "2", crackedLong: AppText.hours)
        case 5:
            strength = (AppColors.mediumPassword, AppText.mediumPassword, .loadImage(LoadService.shared.load?.images?.mediumPassword) ?? UIImage(named: "mediumPassword") ?? UIImage(), 0.5, crackedLabel: "9", crackedLong: AppText.hours)
        case 6:
            strength = (AppColors.mediumPassword, AppText.mediumPassword, .loadImage(LoadService.shared.load?.images?.mediumPassword) ?? UIImage(named: "mediumPassword") ?? UIImage(), 0.6, crackedLabel: "112", crackedLong: AppText.hours)
        case 7:
            strength = (AppColors.mediumPassword, AppText.mediumPassword, .loadImage(LoadService.shared.load?.images?.mediumPassword) ?? UIImage(named: "mediumPassword") ?? UIImage(), 0.7, crackedLabel: "1239", crackedLong: AppText.hours)
        case 8:
            strength = (AppColors.strongPassword, AppText.strongPassword, .loadImage(LoadService.shared.load?.images?.strongPassword) ?? UIImage(named: "strongPassword") ?? UIImage(), 0.8, crackedLabel: "67433", crackedLong: AppText.hours)
        case 9:
            strength = (AppColors.strongPassword, AppText.strongPassword, .loadImage(LoadService.shared.load?.images?.strongPassword) ?? UIImage(named: "strongPassword") ?? UIImage(), 0.9, crackedLabel: "78565884", crackedLong: AppText.hours)
        default:
            strength = (AppColors.strongPassword, AppText.strongPassword, .loadImage(LoadService.shared.load?.images?.strongPassword) ?? UIImage(named: "strongPassword") ?? UIImage(), 1.0, crackedLabel: "56854456565858545", crackedLong: AppText.hours)
        }
        
        successLabel.text = strength.label
        successLabel.textColor = strength.color
        successImage.image = strength.image
        crackedDescriptionLabel.text = AppText.crackedDescriptionLabel + " \(strength.crackedLabel)" + " \(strength.crackedLong)"
        progressBar.setProgress(CGFloat(strength.progress), animated: true)
    }
    
    private func setupStyle() {
        view.backgroundColor = .gradientColor
        navigationController?.isNavigationBarHidden = true
        progressStackView.isHidden = true
    }
    
    private func setupUI() {
        view.addSubview(headerLabel)
        view.addSubview(dataIsSecureStackView)
        dataIsSecureStackView.addArrangedSubview(shieldView)
        dataIsSecureStackView.addArrangedSubview(dataIsSecureLabel)
        view.addSubview(passwordTextField)
        passwordTextField.addSubview(togglePasswordVisibilityButton)
        view.addSubview(tipsLabel)
        view.addSubview(progressStackView)
        progressStackView.addArrangedSubview(progressBar)
        progressStackView.addArrangedSubview(successStackView)
        successStackView.addArrangedSubview(successImage)
        successStackView.addArrangedSubview(successLabel)
        progressStackView.addArrangedSubview(crackedDescriptionLabel)
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setupConstraints()
        
    }
}

// MARK: - TableView
extension PasswordSecurityController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expandedSections.contains(section) ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DropdownHeaderCell") as! DropdownHeaderCell
        let resultTitle = "\(section + 1). \(titles[section])"
        cell.setupCell(title: resultTitle, isSectionOpen: false)
        cell.openButton.addTarget(self, action: #selector(didTapHeader(_:)), for: .touchUpInside)
        cell.openButton.tag = section
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DropdownCell", for: indexPath) as! DropdownCell
        cell.setupCell(text: contents[indexPath.section])
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    @objc func didTapHeader(_ sender: UIButton) {
        let section = sender.tag
        
        if expandedSections.contains(section) {
            expandedSections.remove(section)
        } else {
            expandedSections.insert(section)
        }
        
        
        tableView.reloadData()
    }
}

extension PasswordSecurityController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension PasswordSecurityController {
    // Функция расчета силы пароля
    private func calculatePasswordStrength(_ password: String) -> Int {
        var score = 0
        
        // Длина пароля
        if password.count >= 8 { score += 1 }
        if password.count >= 12 { score += 2 }
        if password.count >= 16 { score += 3 }
        
        // Прописные, строчные, цифры и специальные символы
        let uppercase = CharacterSet.uppercaseLetters
        let lowercase = CharacterSet.lowercaseLetters
        let digits = CharacterSet.decimalDigits
        let special = CharacterSet.punctuationCharacters.union(CharacterSet.symbols)
        
        if password.rangeOfCharacter(from: uppercase) != nil { score += 1 }
        if password.rangeOfCharacter(from: lowercase) != nil { score += 1 }
        if password.rangeOfCharacter(from: digits) != nil { score += 1 }
        if password.rangeOfCharacter(from: special) != nil { score += 2 } // Специальные символы более весомы
        
        // Последовательности и повторения
        if hasSequentialCharacters(password) { score -= 1 }
        if hasRepeatedCharacters(password) { score -= 1 }
        
        // Проверка словарных слов (например, популярные пароли)
        if isDictionaryWord(password) { score -= 1 }
        print(score)
        return max(score, 0) // Минимальный балл 0
    }
    
    // Проверка на последовательные символы
    private func hasSequentialCharacters(_ password: String) -> Bool {
        let sequentialPatterns = ["1234", "abcd", "qwerty"]
        return sequentialPatterns.contains { password.contains($0) }
    }
    
    // Проверка на повторяющиеся символы
    private func hasRepeatedCharacters(_ password: String) -> Bool {
        let repeatedPatterns = ["aaaa", "1111"]
        return repeatedPatterns.contains { password.contains($0) }
    }
    
    // Проверка словарных слов
    private func isDictionaryWord(_ password: String) -> Bool {
        let commonPasswords = ["password", "admin", "123456"]
        return commonPasswords.contains(password.lowercased())
    }
}

// MARK: - Setup Constraints
extension PasswordSecurityController {
    private func setupConstraints() {
        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        dataIsSecureStackView.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        shieldView.snp.makeConstraints { make in
            make.width.height.equalTo(24)
        }
        
        dataIsSecureLabel.snp.makeConstraints { make in
            make.leading.equalTo(shieldView.snp.trailing).offset(10)
            make.centerY.equalTo(shieldView)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(dataIsSecureStackView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(50)
        }
        
        togglePasswordVisibilityButton.snp.makeConstraints { make in
            make.width.height.equalTo(18)
            make.trailing.equalTo(passwordTextField.snp.trailing).inset(20)
            make.centerY.equalTo(passwordTextField)
        }
        
        progressStackView.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(40)
        }
        
        progressBar.snp.makeConstraints { make in
            make.height.equalTo(6)
            make.leading.trailing.equalToSuperview()
        }
        
        successImage.snp.makeConstraints { make in
            make.width.height.equalTo(24)
        }
        
        tipsLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(tipsLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
