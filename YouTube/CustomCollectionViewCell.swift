//
//  CustomCollectionViewCell.swift
//  YouTube
//
//  Created by Adam Venord on 6/23/16.
//  Copyright © 2016 Adam Venord. All rights reserved.
//

import UIKit

    class CustomCollectionViewCell: UICollectionViewCell {
    
        
    //MARK: Properties
        
    
    @IBOutlet weak var channelPic: UIButton!
    @IBOutlet weak var videoPic: UIImageView!
    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var videoDescription: UILabel!
    @IBOutlet weak var videoDuration: UILabel!
    @IBOutlet weak var separatorView: UIView!
       
    
   //MARK: Methods
        
    func customization()  {
        self.channelPic.layer.cornerRadius = 24
        self.channelPic.clipsToBounds  = true
        self.videoDuration.backgroundColor = UIColor.black().withAlphaComponent(0.5)
        self.videoDuration.layer.borderWidth = 0.5
        self.videoDuration.layer.borderColor = UIColor.white().cgColor
        self.videoDuration.sizeToFit()
    }
        
    //MARK: Methods
        
        func resetCell()  {
            self.separatorView.isHidden = false
            self.videoPic.image = UIImage.init(named: "emptyTumbnail")
            self.videoTitle.text = ""
            self.channelPic.setImage(UIImage(), for: [])
            self.videoDuration.text = ""
            self.videoDescription.text = ""
        }
        
    //MARK: Inits
        
    override func awakeFromNib() {
        super.awakeFromNib()
        customization()
        
    }
   
        
    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            
    }
        
  }
