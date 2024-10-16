import UIKit

final class SupportController: UIViewController, SearchBottomSheetDelegate {
    func didTapContinue(index: Int) {
        navigationController?.popViewController(animated: true)
        guard let tabBarController = tabBarController as? TabBarController else { return }
        tabBarController.selectedIndex = index
        tabBarController.programUpdate(index: index)
    }
    
    
    // MARK: - GUI Variables
    private lazy var backButton: UIImageView = {
        let button = UIImageView()
        button.image = .loadImage(LoadService.shared.load?.images?.сhooseServerBackButton) ?? UIImage(named: "сhooseServerBackButton")
        button.tintColor = AppColors.dataSecurityLabel
        let tap = UITapGestureRecognizer(target: self, action: #selector(backButtonTapped))
        button.addGestureRecognizer(tap)
        button.isUserInteractionEnabled = true
        return button
    }()
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = AppText.supportAndFAQ
        label.textColor = AppColors.almostWhite
        label.textAlignment = .center
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 26, weight: .bold)
        return label
    }()
    
    private let supportLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.dataSecurityLabel
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var faqLabel: UILabel = {
        let label = UILabel()
        label.text = AppText.faqLabel
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = AppColors.almostWhite
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let deviceSearchView = faqContainerView(title: AppText.howDoesTheDeviceSearchWork)
    private let passwordSearchView = faqContainerView(title: AppText.howDoesPasswordSecurityWork)
    private let vpnView = faqContainerView(title: AppText.howDoesVpnWork)
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupStyle()
        setupUI()
        addTargets()
    }
    
    // MARK: - Private Methods
    private func setupStyle() {
        view.backgroundColor = .gradientColor
    }
    
    private func setupUI() {
        view.addSubview(backButton)
        view.addSubview(headerLabel)
        view.addSubview(supportLabel)
        view.addSubview(faqLabel)
        view.addSubview(deviceSearchView)
        view.addSubview(passwordSearchView)
        view.addSubview(vpnView)
        
        setupConstraints()
        setupSupportLabel()
    }
    
    private func addTargets() {
        deviceSearchView.openButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(deviceSearchViewTapped)))
        passwordSearchView.openButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(passwordSearchViewTapped)))
        vpnView.openButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(vpnViewTapped)))
    }
    
    private func setupSupportLabel() {
        let text = AppText.supportText
        let attributedText = NSMutableAttributedString(string: text)
        
        if let emailRange = text.range(of: AppText.supportEmail) {
            let nsRange = NSRange(emailRange, in: text)
            attributedText.addAttribute(.link, value: "mailto:\(AppText.supportEmail)", range: nsRange)
            attributedText.addAttribute(.foregroundColor, value: UIColor.blue, range: nsRange)
        }
        
        supportLabel.attributedText = attributedText
        supportLabel.numberOfLines = 0
        supportLabel.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleLabelTap))
        supportLabel.addGestureRecognizer(tapGesture)
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func handleLabelTap(gesture: UITapGestureRecognizer) {
        let text = AppText.supportText
        let nsText = text as NSString
        
        let emailRange = nsText.range(of: AppText.supportEmail)
        let tapLocation = gesture.location(in: supportLabel)
        
        let layoutManager = NSLayoutManager()
        let textStorage = NSTextStorage(attributedString: supportLabel.attributedText!)
        let textContainer = NSTextContainer(size: supportLabel.bounds.size)
        
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        textContainer.lineFragmentPadding = 0
        textContainer.lineBreakMode = supportLabel.lineBreakMode
        textContainer.maximumNumberOfLines = supportLabel.numberOfLines
        
        let index = layoutManager.characterIndex(for: tapLocation, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        if NSLocationInRange(index, emailRange) {
            if let url = URL(string: "mailto:\(AppText.supportEmail)") {
                UIApplication.shared.open(url)
            }
        }
    }
    
    @objc private func deviceSearchViewTapped() {
        let controller = SearchBottomSheetController()
        controller.delegate = self
        controller.panToDismissEnabled = true
        controller.preferredSheetSizing = UIScreen.height
        present(controller, animated: false)
    }
    
    @objc private func passwordSearchViewTapped() {
        print("passwordSearchViewTapped")
    }
    
    @objc private func vpnViewTapped() {
        print("vpnViewTapped")
    }
}

// MARK: - Setup Constraints
extension SupportController {
    private func setupConstraints() {
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(24)
            make.width.height.equalTo(40)
        }
        
        headerLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backButton)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        supportLabel.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(25)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        faqLabel.snp.makeConstraints { make in
            make.top.equalTo(supportLabel.snp.bottom).offset(25)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        deviceSearchView.snp.makeConstraints { make in
            make.top.equalTo(faqLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(68)
        }
        
        passwordSearchView.snp.makeConstraints { make in
            make.top.equalTo(deviceSearchView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(68)
        }
        
        vpnView.snp.makeConstraints { make in
            make.top.equalTo(passwordSearchView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(68)
        }
        
    }
}
