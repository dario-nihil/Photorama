//
//  Photo.swift
//  Photorama
//
//  Created by Dario on 29/03/2020.
//  Copyright © 2020 Dario. All rights reserved.
//

import Foundation

class Photo {
    
    let title: String
    let remoteUrl: URL
    let photoID: String
    let dataTaken: Date
    
    init(title: String, remoteUrl: URL, photoID: String, dataTaken: Date) {
        self.title = title
        self.remoteUrl = remoteUrl
        self.photoID = photoID
        self.dataTaken = dataTaken
    }
    
}
