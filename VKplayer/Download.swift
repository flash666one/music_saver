//
//  Download.swift
//  VKplayer
//
//  Created by Артём Горюнов on 01.11.2017.
//  Copyright © 2017 Артём Горюнов. All rights reserved.
//

import Foundation
class Download: NSObject {
    
    var url: String
    var isDownloading = false
    var progress: Float = 0.0
    
    var downloadTask: URLSessionDownloadTask?
    var resumeData: NSData?
    
    init(url: String) {
        self.url = url
    }
}
