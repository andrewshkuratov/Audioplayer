//
//  ViewController.swift
//  Audioplayer
//
//  Created by Andrew on 02.07.2020.
//  Copyright © 2020 com.andrewShkuratov. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class AudioPlayerController: UIViewController {

    var player: AVAudioPlayer = AVAudioPlayer()
    var isPlaying = false
    
    @IBOutlet weak var playPauseButton: PlayPauseButton!
    @IBOutlet weak var audioProgress: UISlider!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var trackTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let mediaItems = MPMediaQuery.songs().items

        let mediaCollection = MPMediaItemCollection(items: mediaItems!)

        print(#line, mediaCollection)
        print(#line, mediaItems ?? "")
        
        SetAudio()
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
            self.ShowCurrentAudioProgress()
        }
    }

    @IBAction func PlayPauseSong(_ sender: Any) {
        if isPlaying {
            player.pause()
            playPauseButton.ChangeImage(isPlaying)
            isPlaying = !isPlaying
        } else {
            player.play()
            playPauseButton.ChangeImage(isPlaying)
            isPlaying = !isPlaying
        }
    }
    
    @IBAction func StopSong(_ sender: Any) {
        if isPlaying {
            playPauseButton.ChangeImage(isPlaying)
            isPlaying = !isPlaying
        }
        player.stop()
        player.currentTime = 0
    }
    
    @IBAction func SongTimer(_ sender: Any) {
        player.stop()
        player.currentTime = TimeInterval(audioProgress.value)
        player.play()
    }
    
    func SetAudio() {
        let path = Bundle.main.path(forResource: "Example", ofType: "mp3")!
        let url = URL(fileURLWithPath: path)
        GetTitle(url)
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            
        } catch {
            // couldn't load file :(
        }
    }
    
    func ShowCurrentAudioProgress() {
        let currentTimeAudio = Float(player.currentTime)
        let songDuration = Float(player.duration)
        self.timeLabel.text = player.currentTime.positionalTime
        audioProgress.maximumValue = songDuration
        audioProgress.value = currentTimeAudio
    }
    
    func GetTitle(_ url: URL) {
        let audioInfo = MPNowPlayingInfoCenter.default()
        print(audioInfo)

        let playerItem = AVPlayerItem(url: url)
        let metadataList = playerItem.asset.commonMetadata

        for item in metadataList {
            if let stringValue = item.value as? String {
                print(item.commonKey!.rawValue + ":" + (item.value as! String))
                    if item.commonKey!.rawValue == "title" {
                        trackTitle.text = stringValue
                    }
                    if item.commonKey!.rawValue == "artist" {
                        trackTitle.text = stringValue
                    }
                }
            }
    }
}

extension TimeInterval {
    struct DateComponents {
        static let formatterPositional: DateComponentsFormatter = {
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.minute,.second]
            formatter.unitsStyle = .positional
            formatter.zeroFormattingBehavior = .pad
            return formatter
        }()
    }
    var positionalTime: String {
        return DateComponents.formatterPositional.string(from: self) ?? ""
    }
}
