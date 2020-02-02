//
//  PlayerTableViewDelegate.swift
//  AudioPlayer
//
//  Created by Matthew Shehan on 1/30/20.
//  Copyright © 2020 Matthew Shehan. All rights reserved.
//

import UIKit

class PlayerTableViewDelegate: NSObject, UITableViewDelegate {
    weak var coordinator: HomeViewCoordinator?
    
    init(coordinator: HomeViewCoordinator?) {
        self.coordinator = coordinator
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? AudioPlayerTableViewCell else {
            return
        }
        cell.selectionStyle = .none
        
        if let song = cell.song {
            coordinator?.cellTapped(withSong: song)
        }
    }
}
