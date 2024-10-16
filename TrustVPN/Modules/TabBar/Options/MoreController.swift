import UIKit

final class MoreController: BottomSheetController {
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
        image.image = .loadImage(LoadService.shared.load?.images?.closeButton) ?? UIImage(named: "closeButton")
        image.contentMode = .scaleAspectFit
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(continueButtonTapped))
        image.addGestureRecognizer(recognizer)
        image.isUserInteractionEnabled = true
        return image
    }()
    
    private lazy var topLabel: UILabel = {
        let label = UILabel()
        label.text = AppText.connectionInfo
        label.textAlignment = .left
        label.textColor = AppColors.almostWhite
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let vpnStatusView = CustomContainerView(title: AppText.vpnStatus)
    private let connectionTypeView = CustomContainerView(title: AppText.connectionType)
    private let ipAdressView = CustomContainerView(title: AppText.ipAdress)
    private let versionIVPView = CustomContainerView(title: AppText.versionIVP)
    private let asnView = CustomContainerView(title: AppText.asn)
    private let timeZoneView = CustomContainerView(title: AppText.timeZone)

    private lazy var dropView: UIView = {
        let image = UIView()
        image.backgroundColor = AppColors.dropRed
        image.layer.cornerRadius = 4
        return image
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = AppText.disconnected
        label.textAlignment = .left
        label.textColor = AppColors.almostWhite
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(AppText.updateInformation, for: .normal)
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
        containerView.addSubview(topLabel)
        containerView.addSubview(continueButton)
        containerView.addSubview(vpnStatusView)
        vpnStatusView.addSubview(dropView)
        vpnStatusView.addSubview(statusLabel)
        containerView.addSubview(connectionTypeView)
        containerView.addSubview(ipAdressView)
        containerView.addSubview(versionIVPView)
        containerView.addSubview(asnView)
        containerView.addSubview(timeZoneView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(450)
        }
        
        cancelView.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(20)
            make.width.height.equalTo(24)
        }
        
        topLabel.snp.makeConstraints { make in
            make.centerY.equalTo(cancelView)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(50)
        }
        
        vpnStatusView.snp.makeConstraints { make in
            make.top.equalTo(topLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(view.snp.centerX).offset(-10)
            make.height.equalTo(92.vertical)
        }
        
        dropView.snp.makeConstraints { make in
            make.width.equalTo(8)
            make.height.equalTo(8)
            make.top.equalTo(vpnStatusView.snp.centerY).offset(7)
            make.leading.equalTo(vpnStatusView).offset(20)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.leading.equalTo(dropView.snp.trailing).offset(5)
            make.centerY.equalTo(dropView)
            make.trailing.equalTo(vpnStatusView).inset(5)
        }
        
        connectionTypeView.snp.makeConstraints { make in
            make.top.equalTo(vpnStatusView)
            make.leading.equalTo(view.snp.centerX).offset(10)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(vpnStatusView)
        }
        
        ipAdressView.snp.makeConstraints { make in
            make.top.equalTo(connectionTypeView.snp.bottom).offset(20)
            make.leading.equalTo(vpnStatusView)
            make.trailing.equalTo(vpnStatusView)
            make.height.equalTo(vpnStatusView)
        }
        
        versionIVPView.snp.makeConstraints { make in
            make.top.equalTo(ipAdressView)
            make.leading.equalTo(connectionTypeView)
            make.trailing.equalTo(connectionTypeView)
            make.height.equalTo(vpnStatusView)
        }
        
        asnView.snp.makeConstraints { make in
            make.top.equalTo(ipAdressView.snp.bottom).offset(20)
            make.leading.equalTo(ipAdressView)
            make.trailing.equalTo(ipAdressView)
            make.height.equalTo(ipAdressView)
        }
        
        timeZoneView.snp.makeConstraints { make in
            make.top.equalTo(asnView)
            make.leading.equalTo(versionIVPView)
            make.trailing.equalTo(versionIVPView)
            make.height.equalTo(vpnStatusView)
        }
        
        continueButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(52)
            make.bottom.equalToSuperview().inset(40)
        }
    }
    
    @objc private func continueButtonTapped() {
        dismiss(animated: true)
    }
}
