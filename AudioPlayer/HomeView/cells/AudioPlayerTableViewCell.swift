//
//  AudioPlayerTableViewCell.swift
//  AudioPlayer
//
//  Created by Matthew Shehan on 1/30/20.
//  Copyright © 2020 Matthew Shehan. All rights reserved.
//

import UIKit

class AudioPlayerTableViewCell: UITableViewCell {
    static var reuseIdentifier: String { String(describing: self) }
    static var nib: UINib { UINib(nibName: String(describing: self), bundle: nil) }
    
    var song: Song? {
        didSet {
            songTitle.text = song?.title
            artistName.text = song?.artist
            albumImageView.image = UIImage(named:song?.image ?? "album")
        }
    }
    
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var albumImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
