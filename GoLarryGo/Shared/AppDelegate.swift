//
//  AppDelegate.swift
//  GoLarryGo
//
//  Created by PATRICIA S SIQUEIRA on 08/03/21.
//

//swiftlint:disable all

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        try! FileManager.default.removeItem(atPath: NSHomeDirectory()+"/Library/SplashBoard")
            do {
                sleep(2)
            }

        // Override point for customization after application launch.
        let window = UIWindow(frame: UIScreen.main.bounds)

        let controller = GameViewController()
        window.rootViewController = controller
        
        self.window = window
        window.makeKeyAndVisible()
        
        UserDefaultsConfiguration.sharedUserDefaultConfig.hasOnboarded()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    
    var orientationLock = UIInterfaceOrientationMask.landscape
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return self.orientationLock
    }

}

//swiftlint: enable all
