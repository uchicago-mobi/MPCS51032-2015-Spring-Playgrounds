//
//  CenterViewController.m
//  2014-Spring-DrawerWithViewControllerContainment
//
//  Created by T. Andrew Binkowski on 3/30/14.
//  Copyright (c) 2014 The University of Chicago, Department of Computer Science. All rights reserved.
//

#import "CenterViewController.h"

@interface CenterViewController ()

@end

@implementation CenterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapDrawerButton:(id)sender
{    
    NSLog(@"Tap drawer button...");
    [self.delegate showLeftViewController:self.isOnscreen];
}

@end
