//
//  AppDelegate.swift
//  SendBird
//
//  Created by apple on 2021/03/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.main.bounds)

        let splashViewController = UIStoryboard(name: "Splash", bundle: nil).instantiateViewController(withIdentifier: "SplashViewController") as UIViewController

        let viewController = splashViewController

        self.window?.rootViewController = viewController
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

