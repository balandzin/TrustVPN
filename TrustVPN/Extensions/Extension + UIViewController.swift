import UIKit
import SystemConfiguration.CaptiveNetwork

extension UIViewController {
    
    static func createNavController(
        for rootViewController: UIViewController,
        image: UIImage,
        title: String,
        tag: Int) -> UIViewController {
            let navController = UINavigationController(rootViewController: rootViewController)
            navController.tabBarItem.tag = tag
            navController.tabBarItem.image = image
            navController.tabBarItem.title = title
            return navController
        }
    
    static func createNavController(
        for rootViewController: UIViewController,
        image: UIImage,
        tag: Int) -> UIViewController {
            let navController = UINavigationController(rootViewController: rootViewController)
            navController.tabBarItem.tag = tag
            navController.tabBarItem.image = image
            return navController
        }
    
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = true
        view.addGestureRecognizer(tapGesture)
    }
    
    var tabBarView: TabBarController {
        return tabBarController as? TabBarController ?? TabBarController()
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    func openWiFiSettings() {
        if let url = URL(string: "App-Prefs:root=WIFI") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
                }
            }
        }
    }
    
    func openAppSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                print("Cannot open Settings.")
            }
        } else {
            print("Invalid URL.")
        }
    }
    
    func getWiFiName() -> String? {
        var ssid: String?
        
        if let interfaces = CNCopySupportedInterfaces() as NSArray? {
            for interface in interfaces {
                if let interfaceInfo = CNCopyCurrentNetworkInfo(interface as! CFString) as NSDictionary? {
                    ssid = interfaceInfo[kCNNetworkInfoKeySSID as String] as? String
                    break
                }
            }
        }
        return ssid
    }
}
