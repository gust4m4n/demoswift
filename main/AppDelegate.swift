import UIKit
import UserNotifications
import SDWebImage
import Photos
import KeychainSwift
import Reachability
import Alamofire
import SwiftyJSON
import Wormholy

class AppDelegate: UIResponder, UIApplicationDelegate,
    UNUserNotificationCenterDelegate {
    var window: UIWindow?
    var navigationController: UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        NSSetUncaughtExceptionHandler { exception in
        }
        DemoApi.loadBaseUrlDev()
        Wormholy.shakeEnabled = true
        
#if DEBUG
        NetworkActivityLogger.shared.level = .debug
        NetworkActivityLogger.shared.startLogging()
#else
        NetworkActivityLogger.shared.level = .off
        NetworkActivityLogger.shared.stopLogging()
#endif

        UINavigationBar.appearance().tintColor = UIColor(hex: 0xE83534)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.navigationController = UINavigationController()
        self.navigationController?.view.backgroundColor = UIColor.white
        self.window?.rootViewController = self.navigationController
        self.window?.makeKeyAndVisible()
        
        let controller = DemoController()
        self.navigationController?.viewControllers = [controller]

        return true
    }

}

