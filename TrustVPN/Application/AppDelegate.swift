import UIKit
import AVVPNService

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if Default.hasLoggedInToday == nil {
            Default.hasLoggedInToday = Date()
            Default.shared.dailyLimitSecond = Default.maxTimeLimit
            Default.shared.isFirstShowAverageTime.append(0)
        } else {
            if Date().hasLoggedInToday(lastLogin: Default.hasLoggedInToday ?? Date()) == false {
                Default.hasLoggedInToday = Date()
                Default.shared.dailyLimitSecond = Default.maxTimeLimit
                Default.shared.isFirstShowAverageTime.append(0)
            }
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }


}

