//
//  ContainerViewController.m
//  2014-Spring-DrawerWithViewControllerContainment
//
//  Created by T. Andrew Binkowski on 3/30/14.
//  Copyright (c) 2014 The University of Chicago, Department of Computer Science. All rights reserved.
//

#import "ContainerViewController.h"
#import "CenterViewController.h"
#import "LeftViewController.h"

@interface ContainerViewController ()
@property (nonatomic, assign) BOOL showPanel;
@end

@implementation ContainerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Create and add the left view controller (i.e. the drawer)
    self.leftViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LeftViewController"];
    [self.view addSubview:self.leftViewController.view];
    [self addChildViewController:_leftViewController];
    [_leftViewController didMoveToParentViewController:self];
    // Redundant since the view will take the frame of the parent unless specified
    //_leftViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    // Create and add the center view controller (on top of the drawer)
    self.centerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CenterViewController"];
    self.centerViewController.delegate = self;
    [self.view addSubview:self.centerViewController.view];
    [self addChildViewController:_centerViewController];
    [_centerViewController didMoveToParentViewController:self];

    /*
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(swipeToReveal:)];
    panRecognizer.delegate = self;
    [self.centerViewController.view addGestureRecognizer:panRecognizer];
     */
}

//------------------------------------------------------------------------------
#pragma mark - CenterViewController Delegate Methods
//------------------------------------------------------------------------------
- (void)showLeftViewController:(BOOL)show
{
    
    CGRect frame;
    if (show)
        frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    else
        frame = CGRectMake(self.view.frame.size.width -60, 0, self.view.frame.size.width, self.view.frame.size.height);

    [[UIApplication sharedApplication] beginIgnoringInteractionEvents]; // (14)
 	[UIView animateWithDuration:0.3f delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                      	 self.centerViewController.view.frame = frame;
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             NSLog(@"Done moving");
                             self.centerViewController.isOnscreen = !show;
                             [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                             [self styleCenterViewController:self.centerViewController.isOnscreen];
                             

                         }
                     }];
}

- (void)styleCenterViewController:(BOOL)offScreen
{
    float cornerRadius = (!offScreen) ? 0 : 5;
    
    self.centerViewController.view.layer.masksToBounds = offScreen;
    [self.centerViewController.view.layer setCornerRadius:cornerRadius];
    [self.centerViewController.view.layer setShadowColor:[UIColor blackColor].CGColor];
    [self.centerViewController.view.layer setShadowOpacity:0.2];
    [self.centerViewController.view.layer setShadowOffset:CGSizeMake(-10,0)];
    [self.centerViewController.view.layer setShadowPath:[[UIBezierPath bezierPathWithRect:self.centerViewController.view.bounds] CGPath]];
}

//------------------------------------------------------------------------------
#pragma mark - Gesture Recognizer Delegate Methods
//------------------------------------------------------------------------------
/*
-(void)swipeToReveal:(id)sender
{
	[[[(UITapGestureRecognizer*)sender view] layer] removeAllAnimations];
    
	CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:self.view];
	CGPoint velocity = [(UIPanGestureRecognizer*)sender velocityInView:[sender view]];

	if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        NSLog(@"Begin to pan");
    }
    
	if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        [self showLeftViewController:_showPanel];
	}
    
	if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateChanged) {
        if(velocity.x > 0) {
            NSLog(@"gesture went right");
            // Test for half way
            _showPanel = abs([sender view].center.x - _centerViewController.view.frame.size.width/2) > _centerViewController.view.frame.size.width/2;
            
        } else {
            NSLog(@"gesture went left");
            _showPanel = abs([sender view].center.x - _centerViewController.view.frame.size.width/2) < _centerViewController.view.frame.size.width/2;
        }
        
        // Limit coordinate updating to X direction
        [sender view].center = CGPointMake([sender view].center.x + translatedPoint.x, [sender view].center.y);
        [(UIPanGestureRecognizer*)sender setTranslation:CGPointMake(0,0) inView:self.view];
    }
}
*/

@end
