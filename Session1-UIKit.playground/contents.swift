//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

println("HI")

/*
let redView2 = UIView(frame: CGRectMake(0, 0, 50, 50))
redView2.backgroundColor = UIColor.greenColor()
XCPShowView("Red View", redView2)
*/


//: Create a container view that represents a "screen".  Best practice to create this and add subviews to this view
let containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0))
XCPShowView("Container View", containerView)

// Create a UIView
let redView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 50.0, height: 50.0))
redView.backgroundColor = UIColor.redColor()
containerView.addSubview(redView)

// UIView Animations
UIView.animateWithDuration(2.0, animations: { () -> Void in
    let rotationTransform = CGAffineTransformMakeRotation(3.14)
    redView.transform = rotationTransform
})

/*

let circle = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 50.0, height: 50.0))
circle.center = containerView.center
circle.layer.cornerRadius = 25.0

let startingColor = UIColor.orangeColor()
circle.backgroundColor = startingColor

// Add the view to the containerView
containerView.addSubview(circle);

let rectangle = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 50.0, height: 50.0))
rectangle.center = containerView.center
rectangle.layer.cornerRadius = 5.0

rectangle.backgroundColor = UIColor.whiteColor()

containerView.addSubview(rectangle)

UIView.animateWithDuration(2.0, animations: { () -> Void in
let endingColor = UIColor.greenColor()
circle.backgroundColor = endingColor

let scaleTransform = CGAffineTransformMakeScale(5.0, 5.0)

circle.transform = scaleTransform

let rotationTransform = CGAffineTransformMakeRotation(3.14)

rectangle.transform = rotationTransform
})

*/
