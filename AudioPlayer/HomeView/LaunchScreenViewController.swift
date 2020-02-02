//
//  LaunchScreenViewController.swift
//  AudioPlayer
//
//  Created by Matthew Shehan on 1/30/20.
//  Copyright © 2020 Matthew Shehan. All rights reserved.
//

import UIKit

protocol HomeScreenViewing {
    func cellTapped(withSong song: Song)
}

class LaunchScreenViewController: UIViewController {

    var playerTableViewDataSource: PlayerTableViewDataSource?
    var playerTableViewDelegate: PlayerTableViewDelegate?
    weak var coordinator: HomeViewCoordinator?
    @IBOutlet weak var tabBar: UITabBar!
    
    @IBOutlet weak var playerTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        playerTableView.register(AudioPlayerTableViewCell.nib, forCellReuseIdentifier: AudioPlayerTableViewCell.reuseIdentifier)
        
        playerTableViewDelegate = PlayerTableViewDelegate(coordinator: coordinator)
        playerTableViewDataSource =  PlayerTableViewDataSource()
        playerTableView.delegate = playerTableViewDelegate
        playerTableView.dataSource = playerTableViewDataSource
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
