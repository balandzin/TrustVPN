import UIKit
import SnapKit

final class TermsOfUseViewController: UIViewController {
    
    // MARK: - GUI Variables
    private lazy var shield: UIImageView = {
        let view = UIImageView()
        view.image = .loadImage(LoadService.shared.load?.images?.shield) ?? UIImage(named: "shield")
        return view
    }()
    
    private lazy var dataSecurityLabel: UILabel = {
        let label = UILabel()
        label.text = AppText.dataSecurityLabel
        label.textColor = AppColors.dataSecurityLabel
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private lazy var termsView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.termsView
        view.layer.cornerRadius = 26
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    private let contentView = UIView()
    
    private lazy var termsHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = AppText.termsView
        label.textColor = AppColors.almostWhite
        label.font = .systemFont(ofSize: 26, weight: .bold)
        return label
    }()
    
    private lazy var termsLabel: UILabel = {
        let label = UILabel()
        label.text = AppText.termsLabel
        label.textColor = AppColors.dataSecurityLabel
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private lazy var acceptButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(AppText.termsAcceptButton, for: .normal)
        button.setTitleColor(AppColors.almostWhite, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.backgroundColor = AppColors.termsAcceptButton
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(acceptButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var gradientView: UIView = {
        let gradientView = UIView()

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.7).cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientView.layer.addSublayer(gradientLayer)
        return gradientView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    @objc private func acceptButtonTapped() {
        navigationController?.pushViewController(OnboardViewController(), animated: true)
    }
    
    private func setupUI() {
        self.navigationItem.hidesBackButton = true
        
        view.addSubview(shield)
        view.addSubview(dataSecurityLabel)
        view.addSubview(termsView)
        termsView.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(termsHeaderLabel)
        contentView.addSubview(termsLabel)
        scrollView.addSubview(gradientView)
        view.addSubview(acceptButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        shield.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(64)
            make.leading.equalToSuperview().inset(24)
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
        
        dataSecurityLabel.snp.makeConstraints { make in
            make.centerY.equalTo(shield)
            make.leading.equalTo(shield.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(24)
            
        }
        
        termsView.snp.makeConstraints { make in
            make.top.equalTo(shield.snp.bottom).offset(24)
            make.leading.equalToSuperview().inset(24)
            make.trailing.equalToSuperview().inset(24)
            make.bottom.equalTo(acceptButton.snp.top).offset(-50)
        }
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(termsView)
            make.width.equalTo(termsView)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        
        termsHeaderLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.leading.equalToSuperview().inset(24)
            make.trailing.equalToSuperview().inset(24)
        }
        
        termsLabel.snp.makeConstraints { make in
            make.top.equalTo(termsHeaderLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(24)
            make.trailing.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(24)
        }
        
        gradientView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(acceptButton.snp.top).offset(-20)
            make.height.equalTo(120)
        }
        
        acceptButton.snp.makeConstraints { make in
            make.height.equalTo(52)
            make.leading.equalToSuperview().inset(24)
            make.trailing.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(68)
        }
    }
}
