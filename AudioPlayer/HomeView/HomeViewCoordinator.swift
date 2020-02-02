//
//  HomeViewCoordinator.swift
//  AudioPlayer
//
//  Created by Matthew Shehan on 1/31/20.
//  Copyright © 2020 Matthew Shehan. All rights reserved.
//

import UIKit

class HomeViewCoordinator: Coordinator {
    var coordinators = [Coordinator]()
    
    var tabBarController: UITabBarController
    
    weak var coordinator: HomeViewCoordinator?
    
    required init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }
    
    func start() {
        
    }
}

extension HomeViewCoordinator: HomeScreenViewing {
    func cellTapped(withSong song: Song) {
        tabBarController.selectedIndex = 1
        guard let playerVC = tabBarController.selectedViewController as? PlayerViewController else {
            return
        }
        playerVC.coordinator?.currentSong = song
        playerVC.currentSong = song
    }
    
    
}
