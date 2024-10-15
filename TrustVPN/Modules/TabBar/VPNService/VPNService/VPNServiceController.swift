import UIKit
import AVVPNService
import SnapKit

final class VPNServiceController: UIViewController {
    
    // MARK: - Properties
    var selectedServers: [VpnServers] = []
    private let vpnService = VpnService()
    
    private lazy var serverNotSelectedView: UIView =  {
        let view = ServerNotSelectedView()
        view.selectServerButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return view
    }()
    
    private var isConnectVpn: Bool = false
    private var currentlyRenamedServerIndex: Int? = nil
    private var currentlyRemovedServerIndex: Int? = nil
    private var currentlyConnectedServer: VpnServers? = nil
    private var activeSwipeCell: ServerСell? = nil
    
    // MARK: - GUI Variables
    let renameView = RenameView()
    private let vpnServersTableView = VPNServiceTableView()
    private let serverRenamedView = ServerRenamedView()
    private let removeView = RemoveView()
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = AppText.vpnService
        label.textAlignment = .left
        label.textColor = AppColors.almostWhite
        label.font = .systemFont(ofSize: 26, weight: .bold)
        return label
    }()
    
    private lazy var plusImage: UIImageView = {
        let image = UIImageView()
        image.image = .loadImage(LoadService.shared.load?.images?.plus) ?? UIImage(named: "plus")
        image.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(buttonTapped))
        image.addGestureRecognizer(tapGestureRecognizer)
        return image
    }()
    
    // MARK: - Initialization
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gradientColor
        self.navigationController?.isNavigationBarHidden = true
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if selectedServers.isEmpty {
            serverNotSelectedView.isHidden = false
            vpnServersTableView.isHidden = true
        } else {
            serverNotSelectedView.isHidden = true
            vpnServersTableView.isHidden = false
        }
        vpnServersTableView.reloadData()
    }
    
    // MARK: - Private Methods
    private func addedNotificationCenter() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appMovedToForeground),
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )
    }
    
    @objc private func appMovedToForeground() {
        setupStyleAllViews()
    }
    
    private func setupStyleAllViews() {
        AVVPNService.shared.getStatus { [weak self] type in
            guard let self = self else { return }
            
            switch type {
            case .invalid, .disconnected, .disconnecting:
                activeSwipeCell?.updateStatus(for: false)
                activeSwipeCell?.swipeConnectView.type(.off, isAnimate: true)
                activeSwipeCell = nil
                isConnectVpn = false
                currentlyConnectedServer = nil
                Default.shared.isConnectVpn = true
            case .connecting, .connected:
                activeSwipeCell?.updateStatus(for: true)
                activeSwipeCell?.swipeConnectView.type(.on, isAnimate: true)
                Default.shared.isConnectVpn = false
            default:
                return
            }
        }
        
        vpnService.stateConnect = { [weak self] type in
            guard let self = self else { return }
            switch type {
            case .invalid, .disconnected, .disconnecting:
                activeSwipeCell?.updateStatus(for: false)
                activeSwipeCell?.swipeConnectView.type(.off, isAnimate: true)
                activeSwipeCell = nil
                isConnectVpn = false
                currentlyConnectedServer = nil
                Default.shared.isConnectVpn = false
            case .connecting, .connected:
                activeSwipeCell?.updateStatus(for: true)
                activeSwipeCell?.swipeConnectView.type(.on, isAnimate: true)
                Default.shared.isConnectVpn = true
            default:
                return
            }
        }
    }
    
    private func setupUI() {
        vpnService.vpnStartDelegate()
        view.addSubview(headerLabel)
        view.addSubview(plusImage)
        view.addSubview(serverNotSelectedView)
        view.addSubview(vpnServersTableView)
        view.addSubview(renameView)
        view.addSubview(serverRenamedView)
        view.addSubview(removeView)
        
        serverRenamedView.isHidden = true
        renameView.isHidden = true
        removeView.isHidden = true
        
        vpnServersTableView.dataSource = self
        vpnServersTableView.delegate = self
        
        addTargets()
        setupConstraints()
        addedNotificationCenter()
        
        vpnService.vpnStartDelegate()
    }
    
    private func connectToCountryVPN(_ isActivateVpn: Bool, server: VpnServers) {
        let model = server
        
        if isActivateVpn {
            vpnService.disconnectToVPN()
            
            let creditianal = AVVPNCredentials.IPSec(
                title: "TrustVPN",
                server: model.ip ?? "",
                username: model.username ?? "",
                password: model.password ?? "",
                shared: model.ipsecPsk ?? ""
            )
            
            vpnService.connect(credentials: creditianal) {
                
                
            } complitionError: {}
        } else {
            vpnService.disconnectToVPN()
        }
    }
    
    private func resetOtherServers(from currentIndex: Int) {
        for (index, _) in selectedServers.enumerated() {
            if index != currentIndex {
                let cell = vpnServersTableView.cellForRow(at: IndexPath(row: index, section: 0)) as? ServerСell
                cell?.updateCell(model: selectedServers[index], isConnect: false)
                cell?.swipeConnectView.type(.off, isAnimate: true)
                self.vpnServersTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
            }
        }
    }
    
    private func showConnectionToView(server: VpnServers) {
        let connectionToView = ConnectionToViewController()
        connectionToView.setupView(server: server)
        connectionToView.modalPresentationStyle = .overFullScreen
        self.present(connectionToView, animated: false)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            connectionToView.dismiss(animated: false)
        }
    }
    
    // MARK: - ObjC Methods
    @objc private func buttonTapped() {
        print("buttonTapped")
        let chooseServerController = ChooseServerController()
        chooseServerController.selectedServers = self.selectedServers
        chooseServerController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(chooseServerController, animated: false)
    }
    
    @objc func popupButtonTapped(sender: UIButton) {
        renameView.isHidden = false
        let index = sender.tag
        currentlyRenamedServerIndex = index
        let cell = vpnServersTableView.cellForRow(at: IndexPath(row: index, section: 0)) as? ServerСell
        renameView.renameTextField.becomeFirstResponder()
        cell?.popupView.isHidden = true
    }
    
    @objc func saveButtonTapped(sender: UIButton) {
        guard let index = currentlyRenamedServerIndex else { return }
        let cell = vpnServersTableView.cellForRow(at: IndexPath(row: index, section: 0)) as? ServerСell
        
        let newName = renameView.renameTextField.text ?? ""
        
        UserDefaults.standard.set(newName, forKey: "ServerName_\(index)")
        
        if index  < selectedServers.count {
            selectedServers[index].serverName = newName
        }
        
        cell?.popupView.isHidden = true
        renameView.isHidden = true
        
        vpnServersTableView.reloadData()
        currentlyRenamedServerIndex = nil
        renameView.renameTextField.resignFirstResponder()
        
        serverRenamedView.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.serverRenamedView.isHidden = true
        }
    }
    
    @objc func cancelButtonTapped(sender: UIButton) {
        renameView.isHidden = true
        vpnServersTableView.reloadData()
        renameView.renameTextField.resignFirstResponder()
    }
    
    @objc func removeButtonTapped(sender: UIButton) {
        currentlyRemovedServerIndex = sender.tag
        removeView.isHidden = false
    }
    
    @objc func removeServerTapped() {
        guard let index = currentlyRemovedServerIndex else { return }
        
        selectedServers.remove(at: index)
        
        let cell = vpnServersTableView.cellForRow(at: IndexPath(row: index, section: 0)) as? ServerСell
        cell?.popupView.isHidden = true
        removeView.isHidden = true
        vpnServersTableView.reloadData()
        
        if selectedServers.isEmpty {
            serverNotSelectedView.isHidden = false
            vpnServersTableView.isHidden = true
        }
        currentlyRemovedServerIndex = nil
    }
    
    @objc func canselRemoveTapped() {
        guard let index = currentlyRemovedServerIndex else { return }
        let cell = vpnServersTableView.cellForRow(at: IndexPath(row: index, section: 0)) as? ServerСell
        cell?.popupView.isHidden = true
        removeView.isHidden = true
        currentlyRemovedServerIndex = nil
    }
}

extension VPNServiceController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedServers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ServerСell", for: indexPath) as! ServerСell
        let server = selectedServers[indexPath.row]
        
        if let currentlyConnectedServer = self.currentlyConnectedServer {
            if !selectedServers.contains(currentlyConnectedServer) {
                self.vpnService.disconnectToVPN()
                print("disconnectToVPN")
            }
        }
        
        if isConnectVpn && server == currentlyConnectedServer {
            cell.swipeConnectView.type(.on, isAnimate: false)
            cell.updateCell(model: server, isConnect: true)
        } else {
            cell.swipeConnectView.type(.off, isAnimate: false)
            cell.updateCell(model: server, isConnect: false)
        }
        
        cell.swipeConnectView.connected = { [weak self] isConnect in
            if isConnect {
                cell.updateCell(model: server, isConnect: true)
                self?.connectToCountryVPN(true, server: server)
                self?.isConnectVpn = true
                self?.activeSwipeCell = cell
                self?.currentlyConnectedServer = server
                self?.resetOtherServers(from: indexPath.row)
                self?.showConnectionToView(server: server)
                Default.shared.isConnectVpn = true
                
            } else {
                cell.updateCell(model: server, isConnect: false)
                self?.vpnService.disconnectToVPN()
                self?.isConnectVpn = false
                self?.activeSwipeCell = nil
                self?.currentlyConnectedServer = nil
                Default.shared.isConnectVpn = false
            }
        }
        
        cell.popupView.renameButton.tag = indexPath.row
        cell.popupView.removeButton.tag = indexPath.row
        cell.popupView.renameButton.addTarget(self, action: #selector(popupButtonTapped), for:.touchUpInside)
        cell.popupView.removeButton.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
        
        renameView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - Setup Constraints
extension VPNServiceController {
    private func setupConstraints() {
        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        plusImage.snp.makeConstraints { make in
            make.centerY.equalTo(headerLabel)
            make.trailing.equalToSuperview().inset(24)
            make.width.equalTo(44)
            make.height.equalTo(44)
        }
        
        vpnServersTableView.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        serverNotSelectedView.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(80)
            make.leading.equalToSuperview().inset(24)
            make.trailing.equalToSuperview().inset(24)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        renameView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        serverRenamedView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(5)
            make.leading.equalToSuperview().inset(45)
            make.trailing.equalToSuperview().inset(45)
        }
        
        removeView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Add Targets
extension VPNServiceController {
    private func addTargets() {
        removeView.removeButton.addTarget(self, action: #selector(removeServerTapped), for: .touchUpInside)
        removeView.cancelButton.addTarget(self, action: #selector(canselRemoveTapped), for: .touchUpInside)
        let recognizerRemove = UITapGestureRecognizer(target: self, action: #selector(canselRemoveTapped))
        removeView.closeButton.addGestureRecognizer(recognizerRemove)
        removeView.closeButton.isUserInteractionEnabled = true
        
        renameView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        let recognizerRename = UITapGestureRecognizer(target: self, action: #selector(cancelButtonTapped))
        renameView.closeButton.addGestureRecognizer(recognizerRename)
        renameView.closeButton.isUserInteractionEnabled = true
    }
}

