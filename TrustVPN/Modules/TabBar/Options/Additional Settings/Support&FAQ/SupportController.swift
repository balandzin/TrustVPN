import UIKit

protocol SearchRequiredControllerDelegate: AnyObject {
    func didTapContinue(index: Int)
}

final class SupportController: UIViewController, SearchRequiredControllerDelegate {
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
    
    private lazy var supportTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        textView.textAlignment = .left
        
        let text = AppText.supportText
        let attributedText = NSMutableAttributedString(string: text, attributes: [
            .font: UIFont.systemFont(ofSize: 16),
            .foregroundColor: AppColors.dataSecurityLabel
        ])
        
        if let emailRange = text.range(of: AppText.supportEmail) {
            let nsRange = NSRange(emailRange, in: text)
            attributedText.addAttributes([
                .link: "mailto:\(AppText.supportEmail)",
                .font: UIFont.systemFont(ofSize: 16),
                .foregroundColor: AppColors.loadingIndicator
            ], range: nsRange)
        }
        
        textView.attributedText = attributedText
        textView.dataDetectorTypes = .link
        textView.linkTextAttributes = [.foregroundColor: AppColors.loadingIndicator]
        return textView
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
        view.applyDefaultBackgroundImage()
    }
    
    private func setupUI() {
        view.addSubview(backButton)
        view.addSubview(headerLabel)
        view.addSubview(supportTextView)
        view.addSubview(faqLabel)
        view.addSubview(deviceSearchView)
        view.addSubview(passwordSearchView)
        view.addSubview(vpnView)
        
        setupConstraints()
    }
    
    private func addTargets() {
        deviceSearchView.openButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(deviceSearchViewTapped)))
        passwordSearchView.openButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(passwordSearchViewTapped)))
        vpnView.openButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(vpnViewTapped)))
        
        deviceSearchView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(deviceSearchViewTapped)))
        passwordSearchView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(passwordSearchViewTapped)))
        vpnView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(vpnViewTapped)))
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popToRootViewController(animated: false)
    }
    
    @objc private func deviceSearchViewTapped() {
        let controller = SearchBottomSheetController()
        controller.delegate = self
        controller.panToDismissEnabled = true
        controller.preferredSheetSizing = UIScreen.height
        present(controller, animated: false)
    }
    
    @objc private func passwordSearchViewTapped() {
        let controller = PasswordBottomSheetController()
        controller.delegate = self
        controller.panToDismissEnabled = true
        controller.preferredSheetSizing = UIScreen.height
        present(controller, animated: false)
    }
    
    @objc private func vpnViewTapped() {
        let controller = VpnBottomSheetController()
        controller.panToDismissEnabled = true
        controller.preferredSheetSizing = UIScreen.height
        present(controller, animated: false)
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
        
        supportTextView.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(25)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        faqLabel.snp.makeConstraints { make in
            make.top.equalTo(supportTextView.snp.bottom).offset(25)
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
