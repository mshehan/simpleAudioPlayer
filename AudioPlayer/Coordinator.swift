//
//  AppCoordinator.swift
//  AudioPlayer
//
//  Created by Matthew Shehan on 1/30/20.
//  Copyright © 2020 Matthew Shehan. All rights reserved.
//

import UIKit

protocol Coordinator: AnyObject {
    var coordinators: [Coordinator] { get set }
    var tabBarController: UITabBarController { get set }
    init(tabBarController: UITabBarController)
    func start()
}


