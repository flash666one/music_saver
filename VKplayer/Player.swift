//
//  Player.swift
//  VKplayer
//
//  Created by Артём Горюнов on 12.11.2017.
//  Copyright © 2017 Артём Горюнов. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class Player: UIViewController {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var albumImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var artistLabel: UILabel!
    
    @IBOutlet weak var topSlider: UISlider!
    
    @IBOutlet weak var secondsLabel: UILabel!
    
    @IBOutlet weak var durationLabel: UILabel!
    
    var mixing = true
    var updater = CADisplayLink()
    var player = AVAudioPlayer()
    let mpic = MPNowPlayingInfoCenter.default()
    let backgroundPlayer = MPMusicPlayerController()

    

    
    func convert(totalSeconds:Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds - minutes*60
        if seconds < 10 {
            return String(minutes)+":0"+String(seconds)
        }else {
            return String(minutes)+":"+String(seconds)
        }
    }
    
    @objc func trackAudio(){
            if player.isPlaying {
                topSlider.value = Float(player.currentTime / player.duration)
                secondsLabel.text = convert(totalSeconds: Int(player.currentTime))
                durationLabel.text = convert(totalSeconds: Int(player.duration - player.currentTime))
            }
        }
    
    func startUpdater(){
            updater = CADisplayLink(target: self, selector: #selector(trackAudio))
            updater.preferredFramesPerSecond = 1
            updater.add(to: .current, forMode: .commonModes)
        }
    
    func stopUpdater(){
            updater.invalidate()
    }
    
    
    
    @IBAction func playButton(_ sender: Any) {
        if player.isPlaying {
            stopUpdater()
            player.pause()
//            backgroundPlayer.pause()
        } else {
            startUpdater()
            player.play()
//            backgroundPlayer.play()
            }
        }
    
    @IBAction func back(_ sender: Any) {
        if songListVC.thisSong == 0 {
            songListVC.thisSong = SongArchiver.main.songs.count - 1
            playerContainer = SongArchiver.main.songs[songListVC.thisSong]
            player = try! AVAudioPlayer(contentsOf: (playerContainer?.url)!)
            player.play()
            uploadTitle()
            trackAudio()
        } else {
            songListVC.thisSong -= 1
            playerContainer = SongArchiver.main.songs[songListVC.thisSong]
            player = try! AVAudioPlayer(contentsOf: (playerContainer?.url)!)
            player.play()
            uploadTitle()
            trackAudio()
        }
    }
    
    @IBAction func next(_ sender: Any) {
        if songListVC.thisSong == SongArchiver.main.songs.count - 1 {
            songListVC.thisSong = 0
            playerContainer = SongArchiver.main.songs[songListVC.thisSong]
            player = try! AVAudioPlayer(contentsOf: (playerContainer?.url)!)
            player.play()
            uploadTitle()
            trackAudio()
        } else {
            songListVC.thisSong += 1
            playerContainer = SongArchiver.main.songs[songListVC.thisSong]
            player = try! AVAudioPlayer(contentsOf: (playerContainer?.url)!)
            player.play()
            uploadTitle()
            trackAudio()
        }
    }
    
    
    var playerContainer: Song?
    
    
    
    func uploadTitle () {
        let playerItem = AVPlayerItem(url: (playerContainer?.url)!)
        
        
        let metaDataList = playerItem.asset.commonMetadata as? [AVMetadataItem]
        
        for item in metaDataList! {
            if let stringValue = item.value as? String {
                if item.commonKey!.rawValue == "title" {
                    titleLabel.text = stringValue
                    print(stringValue) 
                }
                if item.commonKey!.rawValue == "artist" {
                    artistLabel.text = stringValue
                    print(stringValue)
                }
                if item.commonKey?.rawValue == "artwork" {
                    if let audioImage = UIImage(data: item.value as! Data) {
                        albumImage.image = audioImage
                        albumImage.layer.masksToBounds = true
                        backgroundImage.image = audioImage
                        print("Вот оно")
//                        let audioArtwork = MPMediaItemArtwork(image: audioImage)
                        
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uploadTitle()
        
        
        
        
        mpic.nowPlayingInfo = [
//            MPMediaItemPropertyArtwork:albumArtWork,
            MPMediaItemPropertyTitle:titleLabel.text!,
            MPMediaItemPropertyArtist:artistLabel.text!,
            MPMediaItemPropertyPlaybackDuration:99,
//            MPNowPlayingInfoPropertyElapsedPlaybackTime:String(stringInterpolationSegment:self.player.currentTime),
            MPNowPlayingInfoPropertyPlaybackRate:1.0
        ]
        
        
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayback)
        } catch {
            
        }
        
        
        
        do {
            player = try AVAudioPlayer(contentsOf: (playerContainer?.url)!)
            player.prepareToPlay()
            player.play()
            if player.isPlaying {
                startUpdater()
                trackAudio()
                player.play()
                topSlider.setValue(Float(player.currentTime/player.duration), animated: false)
            } else {
                stopUpdater()
                player.pause()
            }
        } catch {
            print (error)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        updateButtons()
//        updateSliders()
        view.updateConstraintsIfNeeded()
    }
    
    @IBAction func secondsChanged(_ sender: Any) {
            if player.isPlaying {
                player.stop()
                player.currentTime = Double(topSlider.value) * player.duration
                player.play()
            }else{
                player.currentTime = Double(topSlider.value) * player.duration
//                updateButtons()
            }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
