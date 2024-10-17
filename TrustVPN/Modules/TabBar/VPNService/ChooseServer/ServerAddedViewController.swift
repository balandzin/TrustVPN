import UIKit
import SnapKit

final class ServerAddedViewController: BottomSheetController {
    
    // MARK: - GUI Variables
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20.vertical
        view.backgroundColor = AppColors.termsView
        view.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]
        return view
    }()
    
    private lazy var cancelView: UIImageView = {
        let image = UIImageView()
        image.image = .loadImage(LoadService.shared.load?.images?.closeButton) ??
        UIImage(named: "closeButton")
        image.contentMode = .scaleAspectFit
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(continueButtonTapped))
        image.addGestureRecognizer(recognizer)
        image.isUserInteractionEnabled = true
        return image
    }()
    
    private lazy var topLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var shieldView: UIImageView = {
        let image = UIImageView()
        image.image = .loadImage(LoadService.shared.load?.images?.shield) ??
        UIImage(named: "shield")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var topLabel: UILabel = {
        let label = UILabel()
        label.text = AppText.dataIsSecure
        label.textColor = AppColors.dataSecurityLabel
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var serverAddedView: UIImageView = {
        let view = UIImageView()
        view.image = .loadImage(LoadService.shared.load?.images?.server) ??
        UIImage(named: "serverNotSelected")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var greatLabel: UILabel = {
        let label = UILabel()
        label.text = AppText.great
        label.textColor = AppColors.almostWhite
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var permissionLabel: UILabel = {
        let label = UILabel()
        label.text = AppText.permission
        label.textColor = AppColors.dataSecurityLabel
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(AppText.continueButton, for: .normal)
        button.setTitleColor(AppColors.almostWhite, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.backgroundColor = AppColors.loadingIndicator
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        view.clipsToBounds = true
        
        view.addSubview(containerView)
        containerView.addSubview(cancelView)
        containerView.addSubview(topLabelStackView)
        topLabelStackView.addArrangedSubview(shieldView)
        topLabelStackView.addArrangedSubview(topLabel)
        containerView.addSubview(serverAddedView)
        containerView.addSubview(greatLabel)
        containerView.addSubview(permissionLabel)
        containerView.addSubview(continueButton)
        
        setupConstraints()
    }
    
    @objc private func continueButtonTapped() {
        dismiss(animated: true)
    }
}

extension ServerAddedViewController {
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(600)
        }
        
        cancelView.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(20)
            make.width.height.equalTo(24)
        }
        
        topLabelStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(61)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        shieldView.snp.makeConstraints { make in
            make.width.height.equalTo(24)
        }
        
        serverAddedView.snp.makeConstraints { make in
            make.top.equalTo(topLabelStackView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(181)
            make.leading.trailing.equalToSuperview()
        }
        
        greatLabel.snp.makeConstraints { make in
            make.top.equalTo(serverAddedView.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }
        
        permissionLabel.snp.makeConstraints { make in
            make.top.equalTo(greatLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        continueButton.snp.makeConstraints { make in
            make.top.equalTo(permissionLabel.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }
    }
}
