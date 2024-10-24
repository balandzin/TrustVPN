import UIKit
import SnapKit

final class TermsOfUseViewController: UIViewController, UIScrollViewDelegate {
    
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
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 26
        view.layer.masksToBounds = true
        return view
    }()
    
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
        let view = UIView()
        view.isUserInteractionEnabled = false
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, AppColors.termsView.withAlphaComponent(1).cgColor]
        gradientLayer.locations = [0.0, 1.0]
        view.layer.addSublayer(gradientLayer)
        view.layer.cornerRadius = 26
        //view.isHidden = true
        return view
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateGradientFrame()
        checkContentHeight()
    }
    
    // MARK: - Private Methods
    
    @objc private func acceptButtonTapped() {
        navigationController?.pushViewController(OnboardViewController(), animated: true)
    }
    
    private func setupUI() {
        self.navigationItem.hidesBackButton = true
        view.applyDefaultBackgroundImage()
        view.addSubview(shield)
        view.addSubview(dataSecurityLabel)
        view.addSubview(termsView)
        termsView.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(termsHeaderLabel)
        contentView.addSubview(termsLabel)
        termsView.addSubview(gradientView)
        view.addSubview(acceptButton)
        setupConstraints()
    }
    
    private func updateGradientFrame() {
        gradientView.frame = CGRect(x: 0, y: scrollView.frame.maxY - 100, width: scrollView.frame.width, height: 100)
        if let gradientLayer = gradientView.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = gradientView.bounds
        }
    }
    
    private func checkContentHeight() {
            let contentHeight = contentView.frame.height
            let termsViewHeight = termsView.frame.height
            
            if contentHeight > termsViewHeight {
                gradientView.isHidden = false
            } else {
                gradientView.isHidden = true
            }
        }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateGradientFrame()
    }
}

// MARK: - Constraints
extension TermsOfUseViewController {
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
            make.bottom.equalTo(acceptButton.snp.top).offset(-40)
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
        
        acceptButton.snp.makeConstraints { make in
            make.height.equalTo(52)
            make.leading.equalToSuperview().inset(24)
            make.trailing.equalToSuperview().inset(24)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(25)
        }
        
        gradientView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(termsView)
            make.height.equalTo(100)
        }
    }
}
