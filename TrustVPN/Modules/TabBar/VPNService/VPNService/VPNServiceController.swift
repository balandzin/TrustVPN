import UIKit
import AVVPNService

final class VPNServiceController: UIViewController {
    
    // MARK: - Properties
    var selectedServers: [VpnServers] = []
    private let vpnService = VpnService()
    private var isConnectVpn: Bool = false
    private var currentlyConnectedServerIndex: Int? = nil
    private var currentlyConnectedServer: VpnServers? = nil
    
    // MARK: - GUI Variables
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
        image.image = UIImage(named: "plus")
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
    
    // MARK: - Properties
    private let vpnServersTableView = VPNServiceTableView()
    
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
            
            vpnServersTableView.reloadData()
        }
    }
    
    // MARK: - ObjC Methods
    @objc private func buttonTapped() {
        let chooseServerController = ChooseServerController()
        chooseServerController.selectedServers = self.selectedServers
        chooseServerController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(chooseServerController, animated: false)
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        view.addSubview(headerLabel)
        view.addSubview(plusImage)
        view.addSubview(image)
        view.addSubview(selectServerButton)
        view.addSubview(vpnServersTableView)
        
        
        vpnServersTableView.dataSource = self
        vpnServersTableView.delegate = self
        
        setupConstraints()
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
    
    private func resetOtherServers(from index1: Int) {
        for (index, _) in selectedServers.enumerated() {
            if index != index1 {
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
    }
}

extension VPNServiceController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedServers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("----------------->", self.currentlyConnectedServerIndex)

       //let cell = tableView.dequeueReusableCell(withIdentifier: "ServerСell", for: indexPath) as! ServerСell
        let cell = ServerСell()
        let server = selectedServers[indexPath.row]
        
         //Обновляем состояние ячейки
        if let connectedIndex = currentlyConnectedServerIndex, connectedIndex != indexPath.row {
            // Этот сервер не подключен, устанавливаем состояние в отключено
            cell.updateCell(model: server, isConnect: false)
            cell.swipeConnectView.type(.off, isAnimate: false)
        } else {
            cell.updateCell(model: server, isConnect: (currentlyConnectedServerIndex == indexPath.row))
            cell.swipeConnectView.type(.off, isAnimate: false)
            if currentlyConnectedServerIndex == indexPath.row {
                cell.swipeConnectView.type(.on, isAnimate: false)
            }
        }

        cell.swipeConnectView.connected = { isConnect in
            if isConnect {
                // Если пользователь подключился к этому серверу
                self.currentlyConnectedServerIndex = indexPath.row
                self.currentlyConnectedServer = self.selectedServers[indexPath.row]
                
                print("----------------->", self.currentlyConnectedServerIndex)
                
                // Сброс состояний всех остальных серверов
                self.resetOtherServers(from: indexPath.row)
                
                cell.updateCell(model: server, isConnect: true)
                self.isConnectVpn = true
                self.connectToCountryVPN(self.isConnectVpn, server: server)
            } else {
                // Отключаем от VPN
                self.currentlyConnectedServerIndex = nil // Обнуляем индекс
                cell.updateCell(model: server, isConnect: false)
                self.isConnectVpn = false
                self.vpnService.disconnectToVPN()
            }
            
            // Релоад таблицы, чтобы обновить состояния ячеек
            //self.vpnServersTableView.reloadData()
        }
        return cell
    }
    
    
    //    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        let cell = tableView.dequeueReusableCell(withIdentifier: "ServerСell", for: indexPath) as! ServerСell
    //        let server = selectedServers[indexPath.row]
    //
    //        // Обновляем состояние ячейки
    //        if let connectedIndex = currentlyConnectedServerIndex, connectedIndex != indexPath.row {
    //            // Этот сервер не подключен, устанавливаем состояние в отключено
    //            cell.setupCell(model: server, isConnect: false)
    //            cell.swipeConnectView.type(.off, isAnimate: true)
    //        } else {
    //            cell.setupCell(model: server, isConnect: (currentlyConnectedServerIndex == indexPath.row))
    //        }
    //
    //        cell.swipeConnectView.connected = { isConnect in
    //            if isConnect {
    //                // Если пользователь подключился к этому серверу
    //                self.currentlyConnectedServerIndex = indexPath.row
    //
    //                // Сброс состояний всех остальных серверов
    //                self.resetOtherServers(from: indexPath.row)
    //
    //                cell.setupCell(model: server, isConnect: true)
    //                self.isConnectVpn = true
    //                self.connectToCountryVPN(self.isConnectVpn, server: server)
    //            } else {
    //                // Отключаем от VPN
    //                self.currentlyConnectedServerIndex = nil // Обнуляем индекс
    //                cell.setupCell(model: server, isConnect: false)
    //                self.isConnectVpn = false
    //                self.vpnService.disconnectToVPN()
    //            }
    //
    //            // Релоад таблицы, чтобы обновить состояния ячеек
    //            self.vpnServersTableView.reloadData()
    //        }
    //        return cell
    //    }
    
    //    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        let cell = tableView.dequeueReusableCell(withIdentifier: "ServerСell", for: indexPath) as! ServerСell
    //        let server = selectedServers[indexPath.row]
    //        cell.setupCell(model: server, isConnect: false)
    //
    //        cell.swipeConnectView.connected = { isConnect in
    //            if isConnect {
    //                cell.setupCell(model: server, isConnect: true)
    //                self.isConnectVpn = true
    //                self.connectToCountryVPN(self.isConnectVpn, server: server)
    //            } else {
    //                cell.setupCell(model: server, isConnect: false)
    //                self.isConnectVpn = false
    //                self.vpnService.disconnectToVPN()
    //            }
    //        }
    //        return cell
    //    }
}
