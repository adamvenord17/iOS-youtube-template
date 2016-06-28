//
//  SeparatorView.swift
//  YouTube
//
//  Created by Adam Venord on 6/23/16.
//  Copyright © 2016 Adam Venord. All rights reserved.
//

import UIKit

class SeparatorView: UIView {

    
    
    override func draw(_ rect: CGRect) {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0, y: self.bounds.height))
        bezierPath.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height))
        UIColor.gray().setStroke()
        bezierPath.lineWidth = 1
        bezierPath.stroke()

    }
    

}
