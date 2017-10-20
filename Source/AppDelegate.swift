////
/// AppDelegate.swift
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window

        window.makeKeyAndVisible()

        let ctlr = WorldController()
        window.rootViewController = ctlr

        UIApplication.shared.statusBarStyle = .lightContent

        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

}

