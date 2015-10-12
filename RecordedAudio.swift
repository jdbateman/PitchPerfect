//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by john bateman on 3/15/15.
//  Copyright (c) 2015 John Bateman. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    var filePathUrl: NSURL!
    var title: String!
    
    init(fileURL:NSURL, titleOfAudioFile:String) {
        self.filePathUrl = fileURL
        self.title = titleOfAudioFile
    }
}
