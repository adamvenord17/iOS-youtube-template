//
//  suggestedVideo.swift
//  YouTube
//
//  Created by Adam Venord on 8/3/16.
//  Copyright © 2016 Adam Venord. All rights reserved.
//

import Foundation
import UIKit

class SuggestedVideo {
    
    //MARK: Properties
    let title: String
    let name: String
    let thumbnail: UIImage
    
    //MARK: Init
    init(title: String, name:String, thumbnail: UIImage) {
        self.title = title
        self.name = name
        self.thumbnail = thumbnail
    }
}
