//
//  Box.swift
//  Session2-UIKitDynamics
//
//  Created by T. Andrew Binkowski on 4/6/15.
//  Copyright (c) 2015 Department of Computer Science, The University of Chicago. All rights reserved.
//

import Foundation
import UIKit

class Box : UIView {
    let color: UIColor = {
        let red = CGFloat(CGFloat(arc4random()%100000)/100000)
        let green = CGFloat(CGFloat(arc4random()%100000)/100000)
        let blue = CGFloat(CGFloat(arc4random()%100000)/100000)
        
        return UIColor(red: red, green: green, blue: blue, alpha: 0.85)
    }()
    var myFrame: CGRect?    // CGRect? - Optional set to nil
                            // CGRect! - Implicit optional so that it can be nil at initialization
    
    let maxX : CGFloat = 100;
    let maxY : CGFloat = 100;
    let boxSize : CGFloat = 30.0

    var bounced : Bool = false // Tell us if it bounced
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        // Variables of the subclass
        super.init(frame: frame)
        // Variables of the superclass
        //backgroundColor = color
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(number: Int) {
        self.init(frame:CGRectZero)
        tag = number
        commonInit()
    }
    
    func commonInit() {
        //color = randomColor()
        myFrame = randomFrame()
        self.backgroundColor = color
        if let unwrappedFrame = myFrame {
            self.frame = unwrappedFrame
        }
        // Alternate ways to get frame
        // self.frame = unwrappedFrame
    }
    
    // MARK: - Helpers
    func randomFrame() -> CGRect {
        let guessX = CGFloat(arc4random()) % maxX
        let guessY = CGFloat(arc4random()) % maxY;
        return CGRectMake(guessX, guessY, boxSize, boxSize);
    }
}