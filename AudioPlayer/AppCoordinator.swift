//
//  AppCoordinator.swift
//  AudioPlayer
//
//  Created by Matthew Shehan on 1/30/20.
//  Copyright © 2020 Matthew Shehan. All rights reserved.
//

import UIKit

class AppCoordinator: NSObject, Coordinator {
    var coordinators = [Coordinator]()
    
    var tabBarController: UITabBarController
    
    var homeCoordinator: HomeViewCoordinator
    var playerCoordinator: PlayerCoordinator
    
    required init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
        self.homeCoordinator = HomeViewCoordinator(tabBarController: tabBarController)
        self.playerCoordinator = PlayerCoordinator(tabBarController: tabBarController)
    }
    
    func start() {
        let initialVC = LaunchScreenViewController.loadFromNib()
        let tabItem = UITabBarItem(title: "Songs", image: UIImage(named: "songs"), tag: 0)
        //let tabItem = UITabBarItem(tabBarSystemItem: .history, tag: 0)
        initialVC.coordinator = homeCoordinator
        initialVC.tabBarItem = tabItem
        
        
        let playerVC = PlayerViewController.loadFromNib()
        //let playerTab = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        let playerTab = UITabBarItem(title: "Now Playing", image: UIImage(named: "playing"), tag: 1)
        playerVC.coordinator = playerCoordinator
        playerVC.tabBarItem = playerTab
        
        
        tabBarController.viewControllers = [initialVC, playerVC]
        tabBarController.selectedViewController = initialVC
        
    }
    
    
}
