//
//  xButton.swift
//  Lecture5
//
//  Created by Ryan Kalla on 7/6/16.
//  Copyright © 2016 RyanKalla. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

@IBDesignable class xButton: UIButton{
    
    @IBInspectable var fillColor = UIColor.blueColor()
    
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath(ovalInRect: rect)
        fillColor.setFill()
        path.fill()
        
        let plusPath = UIBezierPath()
        plusPath.lineWidth = bounds.width*bounds.height*CGFloat(0.08)
        

    }
    
}

