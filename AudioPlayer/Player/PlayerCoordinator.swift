//
//  PlayerCoordinator.swift
//  AudioPlayer
//
//  Created by Matthew Shehan on 1/31/20.
//  Copyright © 2020 Matthew Shehan. All rights reserved.
//

import UIKit

class PlayerCoordinator: Coordinator {
    var coordinators = [Coordinator]()
    
    private var audioManager: AudioPlayer?
    weak var bar: UIProgressView?
    private var barTimer: Timer?
    
    var tabBarController: UITabBarController
    
    var currentSong: Song? = nil {
        didSet {
            guard let playerVC = tabBarController.viewControllers?[1] as? PlayerViewController else {
                return
            }
            playerVC.currentSong = self.currentSong
        }
    }
    
    var nextSong: Song? {
        guard let homeVC = tabBarController.viewControllers?[0] as? LaunchScreenViewController,
            let dataSource = homeVC.playerTableViewDataSource,
            let playingSong = currentSong
        else {
            return nil
        }
        guard let index = dataSource.songs.firstIndex(where: {$0.title == playingSong.title}) else {
            return nil
        }
        
        return dataSource.songs[(index + 1) % dataSource.songs.count]
    }
    
    var previousSong: Song? {
        guard let homeVC = tabBarController.viewControllers?[0] as? LaunchScreenViewController,
            let dataSource = homeVC.playerTableViewDataSource,
            let playingSong = currentSong
        else {
            return nil
        }
        guard let index = dataSource.songs.firstIndex(where: {$0.title == playingSong.title}) else {
            return nil
        }
        let previousIndex = index > 0 ? (index - 1) % dataSource.songs.count : dataSource.songs.count - 1
        return dataSource.songs[previousIndex]
    }
    
    required init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
        audioManager = AudioPlayer()
    }
    
    func start() {
        
    }
    
}

extension PlayerCoordinator: PlayerViewing {
    func songTapped() {
        guard let currentSong = currentSong else { return }
        switch audioManager?.state {
        case .playing(let lastSong):
            if currentSong.title != lastSong.title {
                barTimer?.invalidate()
                bar?.setProgress(0, animated: false)
                barTimer = manageProgressBar()
            }
        case .paused(let song):
            if song.title != currentSong.title {
                barTimer?.invalidate()
                bar?.setProgress(0, animated: false)
                barTimer = manageProgressBar()
            } else {
                barTimer?.invalidate()
                barTimer = manageProgressBar()
            }
        default:
            break
        }
        audioManager?.tapped(currentSong)
        
        switch audioManager?.state {
        case .playing(_):
            barTimer?.invalidate()
            barTimer = manageProgressBar()
        default:
            break
        }
    }
    
    func manageProgressBar() -> Timer? {
        guard let progress = audioManager?.progress, let currentTime = audioManager?.currentTime else { return nil }
        
        progress.completedUnitCount = Int64(currentTime)
        let progressTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            
            guard progress.isFinished == false
            else {
                timer.invalidate()
                self.nextTapped()
                return
            }
            
            progress.completedUnitCount += 1
            self.bar?.setProgress(Float(progress.fractionCompleted), animated: true)
        }
        
        return progressTimer 
    }
    
    func lastTapped() {
        guard let prevSong = previousSong else { return }
        audioManager?.previousSong(prevSong)
        currentSong = prevSong
        barTimer?.invalidate()
        bar?.setProgress(0, animated: false)
        barTimer = manageProgressBar()
    }
    
    
    func playTapped() {
        guard let currentSong = currentSong else { return }
        audioManager?.playPause(song: currentSong)
        switch audioManager?.state {
        case .playing(_):
            barTimer?.invalidate()
            barTimer = manageProgressBar()
        case .paused(_):
            barTimer?.invalidate()
        default:
            break
        }
    }
    
    func nextTapped() {
        guard let nextSong = nextSong else { return }
        currentSong = nextSong
        audioManager?.nextSong(nextSong)
        barTimer?.invalidate()
        bar?.setProgress(0, animated: false)
        barTimer = manageProgressBar()
    }
    
}
