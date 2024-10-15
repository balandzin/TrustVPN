import UIKit

final class OptionsController: UIViewController {

    // MARK: - GUI Variables
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = AppText.options
        label.textAlignment = .left
        label.textColor = AppColors.almostWhite
        label.font = .systemFont(ofSize: 26, weight: .bold)
        view.addSubview(label)
        return label
    }()
    private lazy var connectionInfoLabel: UILabel = {
        let label = UILabel()
        label.text = AppText.connectionInfo
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = AppColors.almostWhite
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setTitle(AppText.moreButton, for: .normal)
        button.setTitleColor(AppColors.termsAcceptButton, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var vpnStatusView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.termsView
        view.layer.cornerRadius = 26
        return view
    }()
    
    private lazy var vpnStatusLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.dataSecurityLabel
        label.font = .systemFont(ofSize: 16)
        label.text = AppText.vpnStatus
        label.textAlignment = .left
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
        
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
    
    private lazy var connectionTypeView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.termsView
        view.layer.cornerRadius = 26
        return view
    }()
    
    private lazy var connectionTypeLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.dataSecurityLabel
        label.font = .systemFont(ofSize: 16)
        label.text = AppText.connectionType
        label.textAlignment = .left
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var connectionType: UILabel = {
        let label = UILabel()
        label.text = "WI-FI"
        label.textAlignment = .left
        label.textColor = AppColors.almostWhite
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    private lazy var additionalSettingsLabel: UILabel = {
        let label = UILabel()
        label.text = AppText.additionalSettings
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = AppColors.almostWhite
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupStyle()
        setupUI()
    }
    
    // MARK: - Private Methods
    private func setupStyle() {
        view.backgroundColor = .gradientColor
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setupUI() {
        view.addSubview(headerLabel)
        view.addSubview(connectionInfoLabel)
        view.addSubview(moreButton)
        view.addSubview(vpnStatusView)
        vpnStatusView.addSubview(vpnStatusLabel)
        vpnStatusView.addSubview(dropView)
        vpnStatusView.addSubview(statusLabel)
        view.addSubview(connectionTypeView)
        connectionTypeView.addSubview(connectionTypeLabel)
        connectionTypeView.addSubview(connectionType)
        view.addSubview(additionalSettingsLabel)
        setupConstraints()
    }
    
    
    @objc private func moreButtonTapped() {
        print("More button tapped")
    }
}

extension OptionsController {
    private func setupConstraints() {
        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.leading.equalToSuperview().offset(20)
        }
        
        connectionInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(100)
        }
        
        moreButton.snp.makeConstraints { make in
            make.centerY.equalTo(connectionInfoLabel)
            make.trailing.equalToSuperview().inset(20)
        }
        
        vpnStatusView.snp.makeConstraints { make in
            make.top.equalTo(connectionInfoLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(view.snp.centerX).offset(-10)
            make.height.equalTo(92.vertical)
        }
        
        vpnStatusLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(5)
            make.bottom.equalTo(vpnStatusView.snp.centerY).offset(-7)
        }
        
        dropView.snp.makeConstraints { make in
            make.width.equalTo(8)
            make.height.equalTo(8)
            make.top.equalTo(vpnStatusView.snp.centerY).offset(7)
            make.leading.equalTo(vpnStatusLabel)
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
            make.height.equalTo(92.vertical)
        }
        
        connectionTypeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(5)
            make.bottom.equalTo(connectionTypeView.snp.centerY).offset(-7)
        }
        
        connectionType.snp.makeConstraints { make in
            make.leading.equalTo(connectionTypeLabel)
            make.trailing.equalToSuperview().inset(5)
            make.centerY.equalTo(statusLabel)
        }
        
        additionalSettingsLabel.snp.makeConstraints { make in
            make.top.equalTo(connectionTypeView.snp.bottom).offset(50)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
        }
    }
}
