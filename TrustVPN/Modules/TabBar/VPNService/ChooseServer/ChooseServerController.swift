import UIKit

final class ChooseServerController: UIViewController {
    
    // MARK: - Properties
    var selectedServers: [VpnServers] = []
    private var isConnectVpn: Bool = false
    private let vpnService = VpnService()
    private var vpnItems: [VpnServers] = []
    
    // MARK: - GUI Variables
    private lazy var backButton: UIImageView = {
        let button = UIImageView()
        button.image = .loadImage(LoadService.shared.load?.images?.сhooseServerBackButton) ?? UIImage(named: "сhooseServerBackButton")
        button.tintColor = AppColors.dataSecurityLabel
        let tap = UITapGestureRecognizer(target: self, action: #selector(backButtonTapped))
        button.addGestureRecognizer(tap)
        button.isUserInteractionEnabled = true
        return button
    }()
    
    private lazy var chooseServerLabel: UILabel = {
        let label = UILabel()
        label.text = AppText.vpnServers
        label.textColor = AppColors.almostWhite
        label.textAlignment = .center
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 26, weight: .bold)
        return label
    }()
    
    private let serversTableView = ServersTableView()
    private let serverAddedView = ServerAddedView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSelectedServers()
        setupUI()
        loadVpnServers()
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        view.applyDefaultBackgroundImage()
        view.addSubview(backButton)
        view.addSubview(chooseServerLabel)
        view.addSubview(serversTableView)
        view.addSubview(serverAddedView)
        serverAddedView.isHidden = true
        
        serversTableView.dataSource = self
        serversTableView.delegate = self
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(24)
            make.width.height.equalTo(40)
        }
        
        chooseServerLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backButton)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        serversTableView.snp.makeConstraints { make in
            make.top.equalTo(chooseServerLabel.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(80)
        }
        
        serverAddedView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(5)
            make.leading.equalToSuperview().inset(45)
            make.trailing.equalToSuperview().inset(45)
        }
    }
    
    private func showServerAddedView() {
        let controller = ServerAddedViewController()
        controller.panToDismissEnabled = true
        controller.preferredSheetSizing = UIScreen.height
        present(controller, animated: true)
    }
    
    // MARK: - ObjC Methods
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func selectButtonTapped(_ sender: UIButton) {
        let server = vpnItems[sender.tag]
        
        if let index = selectedServers.firstIndex(where: { $0.id == server.id }) {
            selectedServers.remove(at: index)
            sender.setTitle(AppText.select, for: .normal)
            sender.backgroundColor = AppColors.termsAcceptButton
        } else {
            selectedServers.append(server)
            sender.setTitle(AppText.added, for: .normal)
            sender.backgroundColor = AppColors.dataSecurityLabel
            
            serverAddedView.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.serverAddedView.isHidden = true
            }
            
            if selectedServers.count == 1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.showServerAddedView()
                }
            }
        }
        saveSelectedServers()
    }
}

// MARK: - LoadVPNServers
extension ChooseServerController {
    
    private func loadVpnServers() {
        guard var servers = LoadService.shared.load?.vpnServers else { return }
        vpnItems.removeAll()
        
        for (index, var server) in servers.enumerated() {
            if let savedName = UserDefaults.standard.string(forKey: "ServerName_\(index)") {
                server.serverName = savedName
            } else {
                server.serverName = generateRandomServerName()
            }
            
            
            if index < 2 {
                server.isPay = false
            } else {
                server.isPay = false
            }
            servers[index] = server
            vpnItems.append(server)
        }
        
        serversTableView.reloadData()
    }
    
    private func generateRandomServerName() -> String {
        let fixedWord = "Server"
        
        let uppercaseLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let randomUppercaseLetter = uppercaseLetters.randomElement()!
        
        let lowercaseLetters = "abcdefghijklmnopqrstuvwxyz"
        let randomLowercaseLetter = lowercaseLetters.randomElement()!
        
        let digits = "0123456789"
        let randomDigits = String((0..<2).map { _ in digits.randomElement()! })
        
        let additionalLowercaseLetter = lowercaseLetters.randomElement()!
        
        let lastTwoDigits = String((0..<2).map { _ in digits.randomElement()! })
        
        let finalLowercaseLetter = lowercaseLetters.randomElement()!
        
        let randomServerName = "\(fixedWord) \(randomUppercaseLetter)\(randomLowercaseLetter)-\(randomDigits)\(additionalLowercaseLetter)\(lastTwoDigits)\(finalLowercaseLetter)"
        
        UserDefaults.standard.set(randomServerName, forKey: "LastGeneratedServerName")
        
        return randomServerName
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ChooseServerController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vpnItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChooseServerСell", for: indexPath) as? ChooseServerСell else { return UITableViewCell() }
        
        let server = vpnItems[indexPath.row]
        cell.setupCell(model: server)
        
        if selectedServers.contains(where: { $0.id == server.id }) {
            cell.selectButton.setTitle(AppText.added, for: .normal)
            cell.selectButton.backgroundColor = AppColors.dataSecurityLabel
        } else {
            cell.selectButton.setTitle(AppText.select, for: .normal)
            cell.selectButton.backgroundColor = AppColors.termsAcceptButton
        }
        
        cell.selectButton.tag = indexPath.row
        cell.selectButton.addTarget(self, action: #selector(selectButtonTapped(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}

// MARK: - Save Selected Servers
extension ChooseServerController {
    func saveSelectedServers() {
        do {
            let encodedData = try JSONEncoder().encode(selectedServers)
            UserDefaults.standard.set(encodedData, forKey: "selectedServers")
        } catch {
            print("Ошибка при сохранении серверов: \(error)")
        }
    }
    
    func loadSelectedServers() {
        if let savedServersData = UserDefaults.standard.data(forKey: "selectedServers") {
            do {
                let decodedServers = try JSONDecoder().decode([VpnServers].self, from: savedServersData)
                selectedServers = decodedServers
            } catch {
                print("Ошибка при загрузке серверов: \(error)")
            }
        }
    }
}
