//
//  AppDelegate.swift
//  AudioPlayer
//
//  Created by Matthew Shehan on 1/30/20.
//  Copyright © 2020 Matthew Shehan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let tabController = UITabBarController()
        coordinator = AppCoordinator(tabBarController: tabController)
        coordinator?.start()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabController
        window?.makeKeyAndVisible()
        return true
    }


}

