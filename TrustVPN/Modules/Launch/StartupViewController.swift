import UIKit
import AVVPNService
import SnapKit

final class StartupViewController: UIViewController {
    
    // MARK: - GUI Variables
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        //image.image = UIImage(named: "startupBackground")
        image.image = .loadImage(LoadService.shared.load?.images?.startupBackground) ?? UIImage(named: "startupBackground")
        return image
    }()
    
    private lazy var centralLogo: UIImageView = {
        let image = UIImageView()
        image.image = .loadImage(LoadService.shared.load?.images?.centralLogo) ?? UIImage(named: "centralLogo")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var loadingBar: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.loadingBar
        view.layer.cornerRadius = 3
        return view
    }()
    
    private lazy var  loadingIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.loadingIndicator
        view.layer.cornerRadius = 3
        return view
    }()
    
    private var vpnItems: [VpnServers] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        loadServer__asl()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startAnimation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.layer.removeAllAnimations()
        loadingBar.isHidden = true
        loadingIndicator.isHidden = true
    }
    
    // MARK: - Private Functions
    private func loadServer__asl() {
        LoadService.shared.get { [weak self] model in
            guard let self = self else { return }
            LoadService.shared.load = model
            self.loadVpnServers()
            self.getStatusVpn()
            self.showLastScene()
        } errorCompletion: { [weak self] in
            guard let self = self else { return }
            
            let ac = UIAlertController(
                title: "Sorry",
                message: "The app is undergoing technical work. We will finish soon and you will be able to use the app again :)",
                preferredStyle: .actionSheet
            )
            
            ac.addAction(
                UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
                    self.loadServer__asl()
                }))
            
            self.present(ac, animated: true)
        }
    }
    
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
            vpnItems.append(servers[index])
        }
    }
    
    private func getStatusVpn() {
        AVVPNService.shared.getStatus { type in
            switch type {
            case .disconnected:
                if Date().hasLoggedInToday(lastLogin: Default.hasLoggedInToday ?? Date()) {
                    if Default.shared.isConnectVpn {
                        let second = Date().seconds(from: Default.startDateConnectVpn)
                        
                        Default.shared.statistic.append(
                            .init(
                                second: second,
                                date: Date(),
                                vpn: .init(
                                    name: self.vpnItems[Default.shared.vpnIndex].countryName ?? "",
                                    imageUrl: self.vpnItems[Default.shared.vpnIndex].countryImageMin ?? ""
                                )
                            )
                        )
                        
                        Default.shared.isConnectVpn = false
                        Default.startDateConnectVpn = Date()
                    }
                } else {
                    Default.shared.isConnectVpn = false
                    Default.startDateConnectVpn = Date()
                }
            default:
                break
            }
        }
    }
    
    private func setupUI() {
        view.addSubview(imageView)
        view.addSubview(centralLogo)
        imageView.addSubview(loadingBar)
        loadingBar.addSubview(loadingIndicator)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        centralLogo.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(114)
            make.height.equalTo(114)
        }
        
        loadingBar.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(80)
            make.centerX.equalToSuperview()
            make.width.equalTo(104)
            make.height.equalTo(6)
        }
        
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(24)
            make.height.equalTo(6)
        }
        
    }
    
    private func startAnimation() {
        loadingIndicator.frame.origin.x = 0
        let animationDuration: TimeInterval = 1.0
        let loadingBarWidth = loadingBar.frame.width - loadingIndicator.frame.width
        
        UIView.animate(withDuration: animationDuration, delay: 0, options: [.autoreverse, .repeat], animations: {
            self.loadingIndicator.frame.origin.x = loadingBarWidth
        }, completion: nil)
    }
}

extension StartupViewController {
    
    private func showLastScene() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if Default.shared.isShowOnboard {
                self.showTerms()  // ПОМЕНЯТЬ НА showTabBarController()
            } else {
                self.showTerms()
            }
        }
    }
    
    private func showTerms() {
        let controller = TermsOfUseViewController()
        navigationController?.pushViewController(controller, animated: false)
        
        
        
        //        let scene = OnboardScene()
        //        let newNavigationView = UINavigationController(rootViewController: scene)
        //        newNavigationView.modalPresentationStyle = .overFullScreen
        //        newNavigationView.modalTransitionStyle = .crossDissolve
        //        navigationController?.present(OnboardScene(), animated: false)
    }
    
//    private func showTabBarController() {
//        let tabBarController = TabBarScene()
//        let newNavigationController = UINavigationController(rootViewController: tabBarController)
//        //createViewControllers(tabBarController)
//        newNavigationController.modalPresentationStyle = .overFullScreen
//        newNavigationController.modalTransitionStyle = .crossDissolve
//        navigationController?.present(newNavigationController, animated: false)
//    }
    
    //    private func createViewControllers(_ tabBarController: TabBarScene) {
    //        tabBarController.viewControllers = [
    //            UIViewController.createNavController(
    //                for: VpnServiceScene(),
    //                image: .loadImage(LoadService.shared.load?.images?.vpnTabBarIMG),
    //                title: "tab_bar_vpn".localized,
    //                tag: 0
    //            ),
    //            UIViewController.createNavController(
    //                for: LinkVaultScene(),
    //                image: .loadImage(LoadService.shared.load?.images?.vaultTabBarIMG),
    //                title: "tab_bar_vault".localized,
    //                tag: 1
    //            ),
    //            UIViewController.createNavController(
    //                for: StatisticsScene(),
    //                image: .loadImage(LoadService.shared.load?.images?.statisticTabBarIMG),
    //                title: "tab_bar_statisctics".localized,
    //                tag: 2
    //            ),
    //            UIViewController.createNavController(
    //                for: OptionsScene(),
    //                image: .loadImage(LoadService.shared.load?.images?.settingTabBarIMG),
    //                title: "tab_bar_options".localized,
    //                tag: 3
    //            )
    //        ]
    //    }
}

extension Bundle {
    
    public var icon: UIImage? {
        if let icons = infoDictionary?["CFBundleIcons"] as? [String: Any],
           let primaryIcon = icons["CFBundlePrimaryIcon"] as? [String: Any],
           let iconFiles = primaryIcon["CFBundleIconFiles"] as? [String],
           let lastIcon = iconFiles.last {
            return UIImage(named: lastIcon)
        }
        return nil
    }
}
