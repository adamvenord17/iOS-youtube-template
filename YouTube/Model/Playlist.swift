//
//  Playlist.swift
//  YouTube
//
//  Created by Adam Venord on 7/11/16.
//  Copyright © 2016 Adam Venord. All rights reserved.
//

import Foundation
import UIKit

class Playlist {
    
    //MARK: Properties
    let pic: UIImage
    let title: String
    let numberOfVideos: Int
    
    //MARK: inits
    init(pic: UIImage, title: String, numberOfVideos: Int) {
        self.pic = pic
        self.title = title
        self.numberOfVideos = numberOfVideos
    }
}
