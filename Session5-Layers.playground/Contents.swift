//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

let containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0))
XCPShowView("Container View", containerView)

// Create a UIView
let redView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 50.0, height: 50.0))
redView.backgroundColor = UIColor.redColor()
redView.layer.borderWidth = 100.0
redView.layer.borderColor = UIColor.redColor().CGColor
redView.layer.shadowOpacity = 0.7
redView.layer.shadowRadius = 10.0
containerView.addSubview(redView)

// Create a rounded view
let bView = UIView(frame: CGRect(x: 0.0, y: 100.0, width: 50.0, height: 50.0))
bView.backgroundColor = UIColor.blueColor()
bView.layer.borderColor = UIColor.yellowColor().CGColor
bView.layer.cornerRadius = 10.0
containerView.addSubview(bView)


// Create a rounded view
let cView = UIView(frame: CGRect(x: 0.0, y: 200.0, width: 100.0, height: 100.0))
redView.layer.borderWidth = 5.0
redView.layer.borderColor = UIColor.redColor().CGColor
cView.backgroundColor = UIColor.blueColor()
cView.layer.borderColor = UIColor.yellowColor().CGColor
cView.layer.cornerRadius = 10.0
containerView.addSubview(cView)