import UIKit

final class ChooseServerController: UIViewController {
    
    // MARK: - Properties
    private var isConnectVpn: Bool = false
    private let vpnService = VpnService()
    private var vpnItems: [VpnServers] = []
    private var selectedServers: [VpnServers] = []
    
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
        label.font = .systemFont(ofSize: 26, weight: .bold)
        return label
    }()
    
    private let serversTableView = ServersTableView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadVpnServers()
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        view.backgroundColor = .black
        view.addSubview(backButton)
        view.addSubview(chooseServerLabel)
        view.addSubview(serversTableView)
        
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
    }
    
    // MARK: - ObjC Methods
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - LoadVPNServers
extension ChooseServerController {

        private func loadVpnServers() {
            guard var servers = LoadService.shared.load?.vpnServers else { return }
            vpnItems.removeAll()
    
            for (index, var server) in servers.enumerated() {
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
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ChooseServerController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vpnItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ServerСell", for: indexPath) as? ServerСell else { return UITableViewCell() }
        cell.setupCell(model: vpnItems[indexPath.row])
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
