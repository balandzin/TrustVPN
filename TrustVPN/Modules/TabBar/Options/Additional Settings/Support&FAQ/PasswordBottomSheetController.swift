import UIKit

final class PasswordBottomSheetController: BottomSheetController {
    // MARK: - GUI Variables
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20.vertical
        view.backgroundColor = AppColors.termsView
        view.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private lazy var cancelView: UIImageView = {
        let image = UIImageView()
        image.image = .loadImage(LoadService.shared.load?.images?.closeButton) ?? UIImage(named: "closeButton")
        image.contentMode = .scaleAspectFit
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(cancelButtonTapped))
        image.addGestureRecognizer(recognizer)
        image.isUserInteractionEnabled = true
        return image
    }()
    
    private lazy var topImageView: UIImageView = {
        let image = UIImageView()
        image.image = .loadImage(LoadService.shared.load?.images?.passordSecurityImage) ?? UIImage(named: "passordSecurityImage")
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = AppText.howDoesPasswordSecurityWork
        label.textColor = AppColors.almostWhite
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = AppText.passwordSecurityDescription
        label.textColor = AppColors.dataSecurityLabel
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(AppText.goToUse, for: .normal)
        button.setTitleColor(AppColors.almostWhite, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.backgroundColor = AppColors.loadingIndicator
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    weak var delegate: SearchRequiredControllerDelegate?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        view.clipsToBounds = true
        view.isUserInteractionEnabled = true
        view.addSubview(containerView)
        containerView.addSubview(cancelView)
        containerView.addSubview(topImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(subTitleLabel)
        containerView.addSubview(continueButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(600)
        }
        
        cancelView.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(20)
            make.width.height.equalTo(24)
        }
        
        topImageView.snp.makeConstraints { make in
            make.top.equalTo(cancelView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(242)
            make.width.equalTo(210)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(topImageView.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        continueButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(50)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }
    }
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func continueButtonTapped() {
        dismiss(animated: true)
        delegate?.didTapContinue(index: 2)
    }
}
