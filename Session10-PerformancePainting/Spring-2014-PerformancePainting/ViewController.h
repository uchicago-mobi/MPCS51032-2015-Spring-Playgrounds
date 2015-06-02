//
//  ViewController.h
//  PerformancePaint
//
//  Created by T. Andrew Binkowski on 5/1/13.
//  Copyright (c) 2013 UChicago Mobi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaintView.h"

@interface ViewController : UIViewController <PaintViewDelegate>

- (IBAction)tapReplayButton:(id)sender;


/** 
 * A UIView subclass that can be drawn on by using touches
 * @param paintView A PaintView instance
 * @param path A CGPathRef that represents the trace of the users finger
 * @param painted A CGRect that bounds the drawn on area with a rectangle
 */
- (void)paintView:(PaintView*)paintView finishedTrackingPath:(CGPathRef)path inRect:(CGRect)painted;

@end
