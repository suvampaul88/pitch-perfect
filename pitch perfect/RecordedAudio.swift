//
//  RecordedAudio.swift
//  pitch perfect
//
//  Created by Suvam Paul on 4/3/16.
//  Copyright © 2016 Suvam Paul. All rights reserved.
//


import Foundation

class RecordedAudio {
    
    var filePathUrl: NSURL!
    var title: String!
    
    init (filePathUrl: NSURL, title: String) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
    
    
}