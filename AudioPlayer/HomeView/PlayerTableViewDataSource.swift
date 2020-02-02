//
//  PlayerTableViewDataSource.swift
//  AudioPlayer
//
//  Created by Matthew Shehan on 1/30/20.
//  Copyright © 2020 Matthew Shehan. All rights reserved.
//

import UIKit

class PlayerTableViewDataSource: NSObject, UITableViewDataSource {
    var songs: [Song] = setupSongs()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AudioPlayerTableViewCell.reuseIdentifier, for: indexPath) as? AudioPlayerTableViewCell else {
            return UITableViewCell()
        }
        
        cell.song = songs[indexPath.row]
        
        return cell
    }
    
    private static func setupSongs() -> [Song] {
        let song1 = Song(title: "Let Her Know", artist: "Jonathan Links", image: "Let Her Know")
        let song2 = Song(title: "Hollow Hollow", artist: "Thomas Town Flowers, King Sis", image: "Hollow Hollow")
        let song3 = Song(title: "Tides and Drift", artist: "Joseph Beg", image: "Tides and Drift")
        return [song1, song2, song3]
    }
    
    
}
