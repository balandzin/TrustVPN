import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    var vpnService: UIImage?
    var deviceSearch: UIImage?
    var passwordSecurity: UIImage?
    var options: UIImage?
    
    var vpnServiceSelected: UIImage?
    var deviceSearchSelected: UIImage?
    var passwordSecuritySelected: UIImage?
    var optionsSelected: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Установка кастомного таббара
        let customTabBar = CustomTabBar()
        setValue(customTabBar, forKey: "tabBar")
        setupImages()
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let vpnService, let vpnServiceSelected else { return }
        updateTabBarImages(selectedIndex: 0, selectedImage: vpnServiceSelected, unselectedImage: vpnService)
    }

    private func setupImages() {
        vpnService = .loadImage(LoadService.shared.load?.images?.vpnService) ?? UIImage(named: "vpnService") ?? UIImage()
        deviceSearch = .loadImage(LoadService.shared.load?.images?.deviceSearch) ?? UIImage(named: "deviceSearch") ?? UIImage()
        passwordSecurity = .loadImage(LoadService.shared.load?.images?.passwordSecurity) ?? UIImage(named: "passwordSecurity") ?? UIImage()
        options = .loadImage(LoadService.shared.load?.images?.options) ?? UIImage(named: "options") ?? UIImage()
        
        vpnServiceSelected = .loadImage(LoadService.shared.load?.images?.vpnServiceSelected) ?? UIImage(named: "vpnServiceSelected") ?? UIImage()
        deviceSearchSelected = .loadImage(LoadService.shared.load?.images?.deviceSearchSelected) ?? UIImage(named: "deviceSearchSelected") ?? UIImage()
        passwordSecuritySelected = .loadImage(LoadService.shared.load?.images?.passwordSecuritySelected) ?? UIImage(named: "passwordSecuritySelected") ?? UIImage()
        optionsSelected = .loadImage(LoadService.shared.load?.images?.optionsSelected) ?? UIImage(named: "optionsSelected") ?? UIImage()
    }
    
    private func updateTabBarImages(selectedIndex: Int, selectedImage: UIImage, unselectedImage: UIImage) {
        let tabBarItem = self.tabBar.items?[selectedIndex]
        
        tabBarItem?.image = unselectedImage.withRenderingMode(.alwaysOriginal)
        tabBarItem?.selectedImage = selectedImage.withRenderingMode(.alwaysOriginal)
    }
    
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let selectedIndex = tabBarController.selectedIndex
        
        if let vpnService , let deviceSearch, let passwordSecurity, let options, let vpnServiceSelected, let deviceSearchSelected, let passwordSecuritySelected, let optionsSelected {
            
            switch selectedIndex {
            case 0:
                
                updateTabBarImages(selectedIndex: selectedIndex, selectedImage: vpnServiceSelected, unselectedImage: vpnService)
            case 1:
                updateTabBarImages(selectedIndex: selectedIndex, selectedImage: deviceSearchSelected, unselectedImage: deviceSearch)
            case 2:
                updateTabBarImages(selectedIndex: selectedIndex, selectedImage: passwordSecuritySelected, unselectedImage: passwordSecurity)
            case 3:
                updateTabBarImages(selectedIndex: selectedIndex, selectedImage: optionsSelected, unselectedImage: options)
            default:
                break
            }
        }
    }
}

class CustomTabBar: UITabBar {
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var tabBarSize = super.sizeThatFits(size)
        tabBarSize.height = 90
        return tabBarSize
    }
}
