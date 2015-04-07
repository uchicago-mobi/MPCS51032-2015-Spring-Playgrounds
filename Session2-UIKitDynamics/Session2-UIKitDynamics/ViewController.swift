//
//  ViewController.swift
//  Session2-UIKitDynamics
//
//  Created by T. Andrew Binkowski on 4/5/15.
//  Copyright (c) 2015 Department of Computer Science, The University of Chicago. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollisionBehaviorDelegate {
   
    // MARK: - Property Declarations
    // Why are they implicitly unwrapped? 
    // http://stackoverflow.com/questions/24006975/why-create-implicitly-unwrapped-optionals
    
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    var itemBehavior: UIDynamicItemBehavior!
    var snap: UISnapBehavior!
    
    var square: Box!            // A box we will throw around
    var boxes: [Box] = [Box]()  // Keep a collection of our boxes
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //: MARK - Methods
    func setup() {
        
        let barrier = UIView(frame: CGRect(x: 0, y: 300, width: 130, height: 20))
        barrier.backgroundColor = UIColor.blackColor()
        view.addSubview(barrier)
        
        animator = UIDynamicAnimator(referenceView: view)

        // Gravity
        gravity = UIGravityBehavior()
        gravity.gravityDirection = CGVectorMake(0, 0.2)
        animator.addBehavior(gravity)
        
        // Collision
        collision = UICollisionBehavior()
        collision.collisionDelegate = self
        collision.addBoundaryWithIdentifier("barrier", forPath: UIBezierPath(rect: barrier.frame))
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)

        // Items Behavior
        itemBehavior = UIDynamicItemBehavior()
        itemBehavior.elasticity = 0.9
        itemBehavior.friction = 0.1
        
        square = Box(number: 100)
        view.addSubview(square)
        collision.addItem(square)
    }
    
    override func viewDidAppear(animated: Bool) {
        createBoxes()
    }
    
    //: MARK - Box Methods
    func createBoxes() {
        for idx in 1...10 {
            let box = Box(number: idx)
            view.addSubview(box)
            makeBoxDynamic(box)
            boxes.append(box)
        }
    }
    
    func makeBoxDynamic(box: UIView) {
        gravity.addItem(box)
        collision.addItem(box)
        itemBehavior.addItem(box)
    }
    
    //: MARK - UICollisionBehavior Delegate Methods
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying, atPoint p: CGPoint) {
        println("Item: \(item) hit point: \(p)")
        
        let collidingView = item as! Box
        collidingView.backgroundColor = UIColor.yellowColor()
        UIView.animateWithDuration(0.3) {
            collidingView.backgroundColor = collidingView.color
        }
        if collidingView.tag == 9 {
            gravity.gravityDirection = CGVectorMake(0, 0.0)
        }
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        if (snap != nil) {
            animator.removeBehavior(snap)
        }
        
        let touch = touches.first as! UITouch
        snap = UISnapBehavior(item: square, snapToPoint: touch.locationInView(view))
        animator.addBehavior(snap)
    }
}

