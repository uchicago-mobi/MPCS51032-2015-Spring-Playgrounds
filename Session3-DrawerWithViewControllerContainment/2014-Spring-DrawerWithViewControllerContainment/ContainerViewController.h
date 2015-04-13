//
//  ContainerViewController.h
//  2014-Spring-DrawerWithViewControllerContainment
//
//  Created by T. Andrew Binkowski on 3/30/14.
//  Copyright (c) 2014 The University of Chicago, Department of Computer Science. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CenterViewController.h"

@class CenterViewController,LeftViewController;


@interface ContainerViewController : UIViewController <UIGestureRecognizerDelegate,CenterViewControllerDelegate>

//------------------------------------------------------------------------------
/// @name Properties
//------------------------------------------------------------------------------

/** The "main" view controller (assuming the "drawer" is on the left); the one we first see */
@property (strong,nonatomic) CenterViewController *centerViewController;

/** The "drawer" view controller on the left, any UINavigationController can be passed */
@property (strong,nonatomic) LeftViewController *leftViewController;

//------------------------------------------------------------------------------
/// @name Methods
//------------------------------------------------------------------------------

/** 
 Add a drop shadow and slight radius to the center view controller when its partially offscreen

 @param offScreen A BOOL indicating the position of the center view controller
 */
- (void)styleCenterViewController:(BOOL)offScreen;
@end
