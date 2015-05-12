//
//  GameScene.swift
//  DropInTheBucket
//
//  Created by T. Andrew Binkowski on 5/6/15.
//  Copyright (c) 2015 BabyBinks. All rights reserved.
//

import SpriteKit

/** The "names" of the nodes */
enum Category: String {
    case RainDropCategoryName = "RainDrop"
    case BallCategoryName = "Ball"
    case SpoonCategoryName = "Spoon"
    case HoleCategoryName = "Hole"
}

/** 
    Each physics body identifies a category that it belongs to.  You can use
    literals values but they need to be squares.  Check out this SO answer
    http://stackoverflow.com/questions/24069703/how-to-define-category-bit-mask-enumeration-for-spritekit-in-swift
*/
struct PhysicsCategory {
    static let Edge: UInt32 = 0 //0x1 << 0
    static let Ball: UInt32 = 1 //0x1 << 1
    static let Spoon: UInt32 = 2 //0x1 << 2
    static let Hole: UInt32 = 4 //0x1 << 3
    static let RainDrop: UInt32 = 8//0x1 << 4
    static let GravityField: UInt32 = 16 //0x1 << 5
    static let Floor: UInt32 = 32 //0x1 << 6
}


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    override func didMoveToView(view: SKView) {

        // Setup your scene here
        self.physicsWorld.contactDelegate = self

        // Bounding edge of the screen in the physics simulation
        // This is commented out so you can see how the floor only interacts with
        // the green balls, not the blue rain drops
        /*
        let borderBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        borderBody.friction = 0
        self.physicsBody = borderBody
        */
        
        // Add the spood node
        let spoon = Spoon(position:CGPointMake(100, 100))
        addChild(spoon)
        
        // Add the orange floor so that the rain has something to bounce against
        let floor = createFloor()
        addChild(floor)
        
        // Add a gesture recognizer to the scene so a double tap makes it rain
        let doubleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("doubleTap:"))
        doubleTap.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTap)

        /*
        let gravityField1 = SKFieldNode.radialGravityField()
        gravityField1.enabled = true;
        gravityField1.position = cheat.position
        gravityField1.strength = Float(1.0)
        gravityField1.categoryBitMask = PhysicsCategory.GravityField
        addChild(gravityField1)
        */
    }
    
    // MARK: - Touch Handling
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        // If the touch is >500, then add a new green ball
        if let touch = touches.first as? UITouch {
            let location = touch.locationInNode(self)
            println("Location:\(location)")
            if location.y > 500 {
                let ball: Ball = Ball.init(position: location)
                self.addChild(ball)
            }
        }
    }
    
    // MARK: - Game Loop
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        self.enumerateChildNodesWithName(Category.RainDropCategoryName.rawValue, usingBlock: {
            node, stop in
            println(node)
            if node.position.y < 0 {
                node.removeFromParent()
            }
        })
    }
    

    // MARK: - Contact Delegate
    func didBeginContact(contact: SKPhysicsContact) {
        // Create local variables for two physics bodies
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        // Assign the two physics bodies so that the one with the lower category is always stored in firstBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        println("Contact between \(firstBody.node?.name) and \(secondBody.node?.name)")
        
        // react to the contact between ball and bottom
        if firstBody.categoryBitMask == PhysicsCategory.Ball && secondBody.categoryBitMask == PhysicsCategory.Hole {
            //TODO: Replace the log statement with display of Game Over Scene
            println("Hit bottom. First contact has been made.")
            let ball: Ball = (firstBody.node as? Ball)!
            ball.removeWithActions()
        }
    }
    

    // MARK: - Rainfall
    func doubleTap(sender: UITapGestureRecognizer) {
        rain()
    }
    
    // MARK: - Nodes and Effects
    
    func createFloor() -> SKShapeNode {
        let floor = SKShapeNode(rect: CGRectMake(0, 0, 375, 10))
        floor.fillColor = UIColor.orangeColor()
        floor.physicsBody = SKPhysicsBody(edgeLoopFromRect: floor.frame)
        floor.physicsBody!.categoryBitMask = PhysicsCategory.Floor
        floor.physicsBody!.collisionBitMask = PhysicsCategory.Ball
        return floor
    }
    
    
    /**
        Drop a bunch of dots
    */
    func rain() {
        // let's create 300 bouncing cubes
        for i in 1..<100 {
            let randomX: CGFloat = CGFloat(arc4random_uniform(375))
            let randomY: CGFloat = CGFloat(600+i)
            let shape = SKShapeNode(circleOfRadius: 10)
            
            shape.name = Category.RainDropCategoryName.rawValue
            shape.fillColor = UIColor.blueColor()
            shape.lineWidth = 10
            shape.position = CGPoint(x: randomX, y: randomY)
            println("\(i) position:\(shape.position.x) \(shape.position.y)")
            
            shape.physicsBody = SKPhysicsBody(circleOfRadius: shape.frame.size.width/2)
            shape.physicsBody!.dynamic = true

            // Allow the balls to bounce off eachother 
            // to see how the collision bit mask works uncomment PhysicsCategory.Floor
            shape.physicsBody!.collisionBitMask = PhysicsCategory.RainDrop //| PhysicsCategory.Floor
            shape.physicsBody!.categoryBitMask = PhysicsCategory.RainDrop
            shape.physicsBody!.contactTestBitMask = 0 // Don't report any collisions to the delegate

            self.addChild(shape)
        }
    }
    
}
