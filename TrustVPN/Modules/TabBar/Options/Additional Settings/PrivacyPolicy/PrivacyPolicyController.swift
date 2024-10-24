import UIKit

final class PrivacyPolicyController: UIViewController {
    // MARK: - GUI Variables
    private lazy var backButton: UIImageView = {
        let button = UIImageView()
        button.image = .loadImage(LoadService.shared.load?.images?.сhooseServerBackButton) ?? 
        UIImage(named: "сhooseServerBackButton")
        button.tintColor = AppColors.dataSecurityLabel
        let tap = UITapGestureRecognizer(target: self, action: #selector(backButtonTapped))
        button.addGestureRecognizer(tap)
        button.isUserInteractionEnabled = true
        return button
    }()
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = AppText.privatePolicyCapital
        label.textColor = AppColors.almostWhite
        label.textAlignment = .center
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 26, weight: .bold)
        return label
    }()
    
    private lazy var cetralLogo: UIImageView = {
        let view = UIImageView()
        view.image = .loadImage(LoadService.shared.load?.images?.centralLogo) ?? 
        UIImage(named: "centralLogo")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var gradientView: UIView = {
        let gradientView = UIView()
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, AppColors.primary.withAlphaComponent(0.7).cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientView.layer.addSublayer(gradientLayer)
        return gradientView
    }()
    
    private let termsLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.dataSecurityLabel
        label.textAlignment = .left
        label.text = AppText.privatePolicyDescription
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(AppText.goToSupport, for: .normal)
        button.setTitleColor(AppColors.almostWhite, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.backgroundColor = AppColors.loadingIndicator
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(goToSupportTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupStyle()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        gradientView.frame = CGRect(x: 0, y: scrollView.frame.maxY, width: view.bounds.width, height: 100)
        if let gradientLayer = gradientView.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = gradientView.bounds
        }
    }
    
    // MARK: - Private Methods
    private func setupStyle() {
        view.applyDefaultBackgroundImage()
    }
    
    private func setupUI() {
        view.addSubview(backButton)
        view.addSubview(headerLabel)
        view.addSubview(cetralLogo)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(termsLabel)
        scrollView.addSubview(gradientView)
        view.addSubview(continueButton)
        
        setupConstraints()
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: false)
    }
    
    @objc private func goToSupportTapped() {
        if let viewControllers = navigationController?.viewControllers {
            for controller in viewControllers {
                if let optionsController = controller as? OptionsController {
                    navigationController?.popToViewController(optionsController, animated: false)
                    let supportController = SupportController()
                    supportController.hidesBottomBarWhenPushed = true
                    optionsController.navigationController?.pushViewController(supportController, animated: false)
                    break
                }
            }
        }
    }
}

// MARK: - Setup Constraints
extension PrivacyPolicyController {
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
        
        cetralLogo.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(108)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(cetralLogo.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(continueButton.snp.top).offset(-20)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        
        termsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(24)
            make.trailing.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(24)
        }
        
        gradientView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(continueButton.snp.top).offset(-20)
            make.height.equalTo(100)
        }
        
        continueButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(50)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }
    }
}
