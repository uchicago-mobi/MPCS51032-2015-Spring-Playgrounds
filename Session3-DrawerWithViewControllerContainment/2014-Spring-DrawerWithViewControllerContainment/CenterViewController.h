//
//  CenterViewController.h
//  2014-Spring-DrawerWithViewControllerContainment
//
//  Created by T. Andrew Binkowski on 3/30/14.
//  Copyright (c) 2014 The University of Chicago, Department of Computer Science. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 
 */
@protocol CenterViewControllerDelegate <NSObject>

/** 
 Let the container view controller keep track of the drawer state and animations
 
 @param show A BOOL indication where to show or !show (hide)
 */
- (void)showLeftViewController:(BOOL)show;
@end

/**

 */
@interface CenterViewController : UIViewController

/// ----------------------------------------------------------------------------
/// @name Properties
/// ----------------------------------------------------------------------------

/** Track the state of the drawer */
@property BOOL isOnscreen;

/** Delegate */
@property (nonatomic, assign) id<CenterViewControllerDelegate> delegate;


///-----------------------------------------------------------------------------
/// @name Buttons
///-----------------------------------------------------------------------------

- (IBAction)tapDrawerButton:(id)sender;

@end
