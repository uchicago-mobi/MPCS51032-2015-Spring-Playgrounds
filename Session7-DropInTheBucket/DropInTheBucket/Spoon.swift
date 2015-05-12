//
//  Line.swift
//  DropInTheBucket
//
//  Created by T. Andrew Binkowski on 5/6/15.
//  Copyright (c) 2015 BabyBinks. All rights reserved.
//

import Foundation
import SpriteKit


func DegreesToRadians (value:Double) -> Double {
    return value * M_PI / 180.0
}

class Spoon: SKSpriteNode {
    
    init(position: CGPoint) {
        let texture = SKTexture(imageNamed: "Spoon")
        super.init(texture: texture, color: nil, size: texture.size())
        self.position = position
        self.userInteractionEnabled = true
        self.zRotation = CGFloat(DegreesToRadians(0))

        self.physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        self.physicsBody!.friction = 0.8
        self.physicsBody!.dynamic = false
        self.physicsBody!.categoryBitMask = PhysicsCategory.Spoon
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as? UITouch
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self.parent)
            let touchedNode = nodeAtPoint(location)
            touchedNode.position = location
        }
    }

}