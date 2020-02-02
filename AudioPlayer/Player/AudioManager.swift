//
//  AudioManager.swift
//  AudioPlayer
//
//  Created by Matthew Shehan on 1/31/20.
//  Copyright © 2020 Matthew Shehan. All rights reserved.
//

import Foundation
import AVFoundation

class AudioPlayer {
    enum State {
        case idle
        case playing(_ item: Song)
        case paused(_ item: Song)
    }
    
    var path: (String) ->  (String) = { title in
        return Bundle.main.path(forResource: "\(title).mp3", ofType:nil)!
    }
    
    var audioPlayer: AVAudioPlayer? = nil
    var currentSong: Song? = nil
    
    var currentTime: TimeInterval? {
        return audioPlayer?.currentTime
    }
    
    var totalTime: TimeInterval? {
        return audioPlayer?.duration
    }
    
    var progress: Progress? {
        guard let time = audioPlayer?.duration else { return nil }
        return Progress(totalUnitCount: Int64(time))
    }
    
    var state: State = .idle {
        didSet {
            stateDidChange()
        }
    }
    
    private let notificationCenter: NotificationCenter

    init(notificationCenter: NotificationCenter = .default) {
        self.notificationCenter = notificationCenter
    }
    
    private func playBack(_ song: Song) {
        guard let currentSong = currentSong else { return }
        state = .playing(currentSong)
        audioPlayer?.play()
    }
    
    private func pausePlayBack(_ song: Song) {
        state = .paused(song)
        audioPlayer?.pause()
    }
    
    private func tapSong(_ song: Song) {
        switch state {
        case .idle:
            audioPlayer = openAudioPlayer(with: song)
            currentSong = song
            playBack(song)
        case .paused(let pausedSong):
            if pausedSong.title == song.title {
                state = .playing(pausedSong)
                currentSong = pausedSong
                playBack(pausedSong)
            } else {
                state = .playing(song)
                currentSong = song
                audioPlayer = openAudioPlayer(with: song)
                playBack(song)
            }
        case .playing(let playingSong):
            if playingSong.title != song.title {
                state = .playing(song)
                currentSong = song
                audioPlayer = openAudioPlayer(with: song)
                playBack(song)
            }
        }
    }
    
    private func openAudioPlayer(with song: Song) -> AVAudioPlayer? {
        var player: AVAudioPlayer?
        let filePath = path(song.title)
        let url = URL(fileURLWithPath: filePath)
        do {
            player = try AVAudioPlayer(contentsOf: url)
        } catch {
            print(error.localizedDescription)
        }
        return player
    }
    
    func nextSong(_ song: Song) {
        guard let player = audioPlayer else { return }
        player.currentTime = player.duration
        state = .playing(song)
        audioPlayer = openAudioPlayer(with: song)
        audioPlayer?.play()
    }
    
    func previousSong(_ song: Song) {
        guard let player = audioPlayer else { return }
        player.currentTime = 0
        state = .playing(song)
        audioPlayer = openAudioPlayer(with: song)
        audioPlayer?.play()
    }
    
    private func restartSong(_ item: Song) {
        audioPlayer?.currentTime = 0
    }
    
    func playPause(song newSong: Song) {
        switch state {
        case .playing(let song):
            pausePlayBack(song)
        case .paused(let song):
            if newSong.title != song.title {
                playBack(newSong)
            } else {
                playBack(song)
            }
        case .idle:
            audioPlayer = openAudioPlayer(with: newSong)
            playBack(newSong)
        default:
            break
        }
    }
    
    func tapped(_ song: Song) {
        tapSong(song)
    }
    
}

private extension AudioPlayer {
    func stateDidChange() {
        switch state {
        case .idle:
            notificationCenter.post(name: .playbackStopped, object: nil)
        case .playing(_):
            notificationCenter.post(name: .playbackStarted, object: true)
        case .paused(_):
            notificationCenter.post(name: .playbackPaused, object: false)
        }
    }
}

extension Notification.Name {
    static var playbackStarted: Notification.Name {
        return .init(rawValue: "AudioPlayer.playbackStarted")
    }

    static var playbackPaused: Notification.Name {
        return .init(rawValue: "AudioPlayer.playbackPaused")
    }

    static var playbackStopped: Notification.Name {
        return .init(rawValue: "AudioPlayer.playbackStopped")
    }
    
    static var songEnded: Notification.Name {
        return .init(rawValue: "AudioPlayer.songEnded")
    }
}
