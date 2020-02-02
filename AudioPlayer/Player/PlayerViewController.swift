//
//  PlayerViewController.swift
//  AudioPlayer
//
//  Created by Matthew Shehan on 1/31/20.
//  Copyright © 2020 Matthew Shehan. All rights reserved.
//

import UIKit

protocol PlayerViewing {
    func lastTapped()
    func playTapped()
    func nextTapped()
    func songTapped()
    func manageProgressBar() -> Timer?
}

class PlayerViewController: UIViewController {
    weak var coordinator: PlayerCoordinator?
    
    var currentSong: Song? = nil {
        didSet {
            songTitleLabel.text = currentSong?.title
            artistTitleLabel.text = currentSong?.artist
            albumImageView.image = UIImage(named: currentSong?.image ?? "album")
            
            coordinator?.songTapped()
        }
    }
    
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var artistTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let song = currentSong {
            songTitleLabel.text = song.title
            artistTitleLabel.text = song.artist
        }
        progressView.progress = 0
        coordinator?.bar = progressView
    }

    @IBAction func lastTapped(_ sender: Any) {
        coordinator?.lastTapped()
        //currentSong = coordinator?.currentSong
    }
    
    @IBAction func playTapped(_ sender: Any) {
        coordinator?.playTapped()
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        coordinator?.nextTapped()
        //currentSong = coordinator?.currentSong
    }
}
