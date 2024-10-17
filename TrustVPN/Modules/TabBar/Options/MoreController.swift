import UIKit
import Network

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
    
    private var connectionType = CustomLabel()
    private var ipAdress = CustomLabel(title: "456.32.234.23")
    private var versionIVP = CustomLabel(title: "IPV4")
    private var asn = CustomLabel(title: "2Fd200AS921")
    private var timeZone = CustomLabel(title: "Europe/Moscow")
    private var statusLabel = CustomLabel()
    
    private lazy var dropView: UIView = {
        let image = UIView()
        image.backgroundColor = AppColors.dropRed
        image.layer.cornerRadius = 4
        return image
    }()
    
    private var monitor: NWPathMonitor?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .vpnConnectionStatusChanged, object: nil)
        stopMonitoringNetwork()
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        view.clipsToBounds = true
        
        view.addSubview(containerView)
        containerView.addSubview(cancelView)
        containerView.addSubview(topLabel)
        containerView.addSubview(vpnStatusView)
        vpnStatusView.addSubview(dropView)
        vpnStatusView.addSubview(statusLabel)
        containerView.addSubview(connectionTypeView)
        connectionTypeView.addSubview(connectionType)
        containerView.addSubview(ipAdressView)
        ipAdressView.addSubview(ipAdress)
        containerView.addSubview(versionIVPView)
        versionIVPView.addSubview(versionIVP)
        containerView.addSubview(asnView)
        asnView.addSubview(asn)
        containerView.addSubview(timeZoneView)
        timeZoneView.addSubview(timeZone)
        
        setupConstraints()
        setupStatus()
    }
    
    @objc private func continueButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func vpnStatusChanged() {
        setupConnectionInfo()
    }
    
    // MARK: - Private Methods
    private func setupStatus() {
        startMonitoringNetwork()
        setupConnectionInfo()
        fetchAndDisplayConnectionInfo()
        NotificationCenter.default.addObserver(self, selector: #selector(vpnStatusChanged), name: .vpnConnectionStatusChanged, object: nil)
    }
    
    private func setupConnectionInfo() {
        if Default.shared.isConnectVpn {
            dropView.backgroundColor = AppColors.loadingIndicator
            statusLabel.text = AppText.connected
        } else {
            dropView.backgroundColor = AppColors.dropRed
            statusLabel.text = AppText.disconnected
        }
    }
    
    private func startMonitoringNetwork() {
        monitor = NWPathMonitor()
        let queue = DispatchQueue.global(qos: .background)
        
        monitor?.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied {
                if path.usesInterfaceType(.wifi) {
                    DispatchQueue.main.async {
                        self?.connectionType.text = "Wi-Fi"
                    }
                } else if path.usesInterfaceType(.cellular) {
                    DispatchQueue.main.async {
                        self?.connectionType.text = "Cellular"
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.connectionType.text = "Internet"
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self?.connectionType.text = "No Internet Connection"
                }
            }
        }
        
        monitor?.start(queue: queue)
    }
    
    private func stopMonitoringNetwork() {
        monitor?.cancel()
    }
    
    private func fetchAndDisplayConnectionInfo() {
        NetworkInfoFetcher.shared.fetchConnectionInfo { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let connectionInfo):
                    self?.updateFetchUI(with: connectionInfo)
                case .failure(let error):
                    print("Error fetching connection info: \(error)")
                }
            }
        }
    }
    
    private func updateFetchUI(with connectionInfo: ConnectionInfo) {
        ipAdress.text = "\(connectionInfo.ip)"
        versionIVP.text = "\(connectionInfo.ip.contains(":") ? "IPv6" : "IPv4")"
        asn.text = "\(connectionInfo.asn?.asn ?? "Unknown")"
        timeZone.text = "\(connectionInfo.timezone)"
    }
}

// MARK: - Setup Constraints
extension MoreController {
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
        
        connectionType.snp.makeConstraints { make in
            make.centerY.equalTo(statusLabel)
            make.leading.equalTo(connectionTypeView).offset(20)
            make.trailing.equalTo(connectionTypeView).inset(5)
        }
        
        ipAdressView.snp.makeConstraints { make in
            make.top.equalTo(connectionTypeView.snp.bottom).offset(20)
            make.leading.equalTo(vpnStatusView)
            make.trailing.equalTo(vpnStatusView)
            make.height.equalTo(vpnStatusView)
        }
        
        ipAdress.snp.makeConstraints { make in
            make.top.equalTo(ipAdressView.snp.centerY).offset(5)
            make.leading.equalTo(ipAdressView).offset(20)
            make.trailing.equalTo(ipAdressView).inset(5)
        }
        
        versionIVPView.snp.makeConstraints { make in
            make.top.equalTo(ipAdressView)
            make.leading.equalTo(connectionTypeView)
            make.trailing.equalTo(connectionTypeView)
            make.height.equalTo(vpnStatusView)
        }
        
        versionIVP.snp.makeConstraints { make in
            make.centerY.equalTo(ipAdress)
            make.leading.equalTo(versionIVPView).offset(20)
            make.trailing.equalTo(versionIVPView).inset(5)
        }
        
        asnView.snp.makeConstraints { make in
            make.top.equalTo(ipAdressView.snp.bottom).offset(20)
            make.leading.equalTo(ipAdressView)
            make.trailing.equalTo(ipAdressView)
            make.height.equalTo(ipAdressView)
        }
        
        asn.snp.makeConstraints { make in
            make.top.equalTo(asnView.snp.centerY).offset(5)
            make.leading.equalTo(asnView).offset(20)
            make.trailing.equalTo(asnView).inset(5)
        }
        
        timeZoneView.snp.makeConstraints { make in
            make.top.equalTo(asnView)
            make.leading.equalTo(versionIVPView)
            make.trailing.equalTo(versionIVPView)
            make.height.equalTo(vpnStatusView)
        }
        
        timeZone.snp.makeConstraints { make in
            make.centerY.equalTo(asn)
            make.leading.equalTo(timeZoneView).offset(20)
            make.trailing.equalTo(timeZoneView).inset(5)
        }
    }
}
