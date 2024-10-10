import UIKit

final class PasswordSecurityController: UIViewController {
    
    // MARK: - GUI Variables
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
    
    private lazy var progressBar: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progress = 0.5
        progressView.progressTintColor = AppColors.termsView
        progressView.trackTintColor = AppColors.textFieldBackground
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
        label.font = .systemFont(ofSize: 18)
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
    

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupStyle()
        setupUI()
    }
   
    // MARK: - Actions
    @objc private func togglePasswordVisibility() {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
    
    // MARK: - Private Methods
    private func setupStyle() {
        view.backgroundColor = .gradientColor
        navigationController?.isNavigationBarHidden = true
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

        setupConstraints()
        
    }
    
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
            make.top.equalTo(progressStackView.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(24)
        }
    }
}
