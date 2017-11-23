//
//  SongArchiver.swift
//  VKplayer
//
//  Created by Артём Горюнов on 12.11.2017.
//  Copyright © 2017 Артём Горюнов. All rights reserved.
//

import Foundation

class SongArchiver  {
    static let main = SongArchiver()
    var songs: [Song] = []
    func save() {
        let encoder = PropertyListEncoder()
        let data = try! encoder.encode(songs)
        UserDefaults.standard.set(data, forKey: "songsData")
    }
    func update() {
        if let data = UserDefaults.standard.data(forKey: "songsData"){
        let decoder = PropertyListDecoder()
        songs = try! decoder.decode([Song].self, from: data)
        }
    }
}
