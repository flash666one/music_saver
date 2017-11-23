//
//  SongArchiver.swift
//  VKplayer
//
//  Created by Артём Горюнов on 31.10.2017.
//  Copyright © 2017 Артём Горюнов. All rights reserved.
//

import Foundation

struct Song: Codable {
    var artist: String
    var song: String
    var url: URL
}
