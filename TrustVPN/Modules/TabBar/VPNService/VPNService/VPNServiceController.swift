import UIKit
import AVVPNService

final class VPNServiceController: UIViewController {
    
    // MARK: - Properties
    var selectedServers: [VpnServers] = []
    private let vpnService = VpnService()
    private var isConnectVpn: Bool = false
    private var currentlyRenamedServerIndex: Int? = nil
    private var currentlyConnectedServer: VpnServers? = nil
    private var activeSwipeCell: ServerСell? = nil
    
    // MARK: - GUI Variables
    let renameView = RenameView()
    private let vpnServersTableView = VPNServiceTableView()
    
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
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.image =  .loadImage(LoadService.shared.load?.images?.serverNotSelected) ?? UIImage(named: "serverNotSelected")
        return image
    }()
    
    private lazy var selectServerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(AppText.selectServer, for: .normal)
        button.setTitleColor(AppColors.almostWhite, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.backgroundColor = AppColors.termsAcceptButton
        button.layer.cornerRadius = 22
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
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
        view.backgroundColor = .black
        self.navigationController?.isNavigationBarHidden = true
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if selectedServers.isEmpty {
            image.isHidden = false
            selectServerButton.isHidden = false
            vpnServersTableView.isHidden = true
        } else {
            image.isHidden = true
            selectServerButton.isHidden = true
            vpnServersTableView.isHidden = false
            
        }
        vpnServersTableView.reloadData()
    }
    
    // MARK: - ObjC Methods
    @objc private func buttonTapped() {
        let chooseServerController = ChooseServerController()
        chooseServerController.selectedServers = self.selectedServers
        chooseServerController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(chooseServerController, animated: false)
    }
    
    @objc func renameButtonTapped(sender: UIButton) {
        renameView.isHidden = false
        let index = sender.tag
        currentlyRenamedServerIndex = index
        let cell = vpnServersTableView.cellForRow(at: IndexPath(row: index, section: 0)) as? ServerСell
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
    }
    
    @objc func cancelButtonTapped(sender: UIButton) {
        renameView.isHidden = true
        vpnServersTableView.reloadData()
        renameView.renameTextField.resignFirstResponder()
    }
    
    @objc func removeButtonTapped(sender: UIButton) {
        let index = sender.tag
        selectedServers.remove(at: index)
        
        let cell = vpnServersTableView.cellForRow(at: IndexPath(row: index, section: 0)) as? ServerСell
        cell?.popupView.isHidden = true
        vpnServersTableView.reloadData()
        
        if selectedServers.isEmpty {
            image.isHidden = false
            selectServerButton.isHidden = false
            vpnServersTableView.isHidden = true
        }
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        view.addSubview(headerLabel)
        view.addSubview(plusImage)
        view.addSubview(image)
        view.addSubview(selectServerButton)
        view.addSubview(vpnServersTableView)
        view.addSubview(renameView)
        
        renameView.isHidden = true
        
        vpnServersTableView.dataSource = self
        vpnServersTableView.delegate = self
        
        setupConstraints()
        
        renameView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(cancelButtonTapped))
        renameView.closeButton.addGestureRecognizer(recognizer)
        renameView.closeButton.isUserInteractionEnabled = true
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
        
        image.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(80)
            make.leading.equalToSuperview().inset(24)
            make.trailing.equalToSuperview().inset(24)
            make.height.equalTo(267)
        }
        
        selectServerButton.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(24)
            make.width.equalTo(174)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
        }
        
        vpnServersTableView.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        renameView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
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
                
            } else {
                cell.updateCell(model: server, isConnect: false)
                self?.vpnService.disconnectToVPN()
                self?.isConnectVpn = false
                self?.activeSwipeCell = nil
                self?.currentlyConnectedServer = nil
            }
        }
        
        cell.popupView.renameButton.tag = indexPath.row
        cell.popupView.removeButton.tag = indexPath.row
        cell.popupView.renameButton.addTarget(self, action: #selector(renameButtonTapped), for:.touchUpInside)
        cell.popupView.removeButton.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
        
        renameView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        //cell.selectionStyle = .none
        return cell
    }
}
