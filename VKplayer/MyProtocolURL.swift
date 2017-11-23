//
//  MyProtocolURL.swift
//  VKplayer
//
//  Created by Артём Горюнов on 24.10.2017.
//  Copyright © 2017 Артём Горюнов. All rights reserved.
//

import Foundation
import AVFoundation
let filemanager = FileManager()
class MyProtocolURL: URLProtocol {
    
    override class func canInit(with request: URLRequest) -> Bool {
        let urlString = request.url?.absoluteString ?? ""
        var numerOfSongs = UserDefaults.standard.integer(forKey: "numberOfSongs")
        let documentsDirectoryURL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("testSong\(numerOfSongs).mp3")
        numerOfSongs += 1
        UserDefaults.standard.set(numerOfSongs, forKey: "numberOfSongs")
        
        if (urlString.contains(".mp3") && urlString.contains("http")) {
            print(urlString)

            let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
            
            let downloadSession = session.dataTask(with: URL(string: urlString)!, completionHandler: { (data, response, error) in
                if let bytes = data {
                    UserDefaults.standard.set(bytes, forKey: "songData")
                    
//                    let artist = "Artist"
                    
                    let playerItem = AVPlayerItem(url: URL(string: urlString)!)

                    let metaDataList = playerItem.asset.commonMetadata as? [AVMetadataItem]
                    
                    func artistToTable () -> String {
                        for item in metaDataList! {
                            if let stringValue = item.value as? String {
                                if item.commonKey!.rawValue == "artist" {
                                    let artist = stringValue
                                    print(stringValue)
                                    return artist
                                }
                                
                            }
                            
                        }
                        return "Artist"
                    }
                    
                    func songToTable () -> String {
                        for item in metaDataList! {
                            if let stringValue = item.value as? String {
                                if item.commonKey!.rawValue == "title" {
                                    let song = stringValue
                                    print(stringValue)
                                    return song
                                }
                                
                            }
                            
                        }
                        return "Song\(numerOfSongs)"
                    }
                        
                    let artist = artistToTable()
                    let title = songToTable()
                    
                    let song = Song(
                        artist: artist,
                        song: title,
                        url: documentsDirectoryURL)

                    SongArchiver.main.songs.append(song)
                    SongArchiver.main.save()
                    
                    filemanager.createFile(atPath: documentsDirectoryURL.path, contents: bytes, attributes: nil)
 
                    }
            })
            downloadSession.resume()
            return true
        }
        return false
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return URLRequest(url: URL(string: "https://vk.com")!)
    }
    
    override func startLoading() {
        
    }
    
    override func stopLoading() {
        
    }
    
}
