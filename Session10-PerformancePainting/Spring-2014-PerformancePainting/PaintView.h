//
//  PaintView.h
//  Paint
//
//  Created by T. Andrew Binkowski on 4/30/13.
//  Copyright (c) 2013 T. Andrew Binkowski. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PaintView;

////////////////////////////////////////////////////////////////////////////////
@protocol PaintViewDelegate <NSObject>
@required
- (void)paintView:(PaintView*)paintView finishedTrackingPath:(CGPathRef)path inRect:(CGRect)painted;
@end

////////////////////////////////////////////////////////////////////////////////
@interface PaintView : UIView

/** Delegate **/
@property (nonatomic, assign) id <PaintViewDelegate> delegate;

///-----------------------------------------------------------------------------
/// @name Drawing
///-----------------------------------------------------------------------------

/** The CGRect where drawing took place */
@property CGRect trackingDirty;

/** Eye candy **/
@property CGSize  shadowSize;
@property CGFloat shadowBlur;

/** Width of the drawn line */
@property CGFloat lineWidth;

///-----------------------------------------------------------------------------
/// @name Colors
///-----------------------------------------------------------------------------
@property (strong, nonatomic) UIColor *lineColor;
@property (strong, nonatomic) NSMutableArray *previousColors;

///-----------------------------------------------------------------------------
/// @name Path and Strokes
///-----------------------------------------------------------------------------
@property (strong, nonatomic) NSMutableArray *strokes;
@property (strong, nonatomic) NSMutableArray *previousPaths;
@property CGMutablePathRef trackingPath;
@property (strong, nonatomic) UIBezierPath *path;


///-----------------------------------------------------------------------------
/// @name Methods
///-----------------------------------------------------------------------------

/**
 * Erase the view by clearing the save strokes and redrawing the view
 */
- (void)erase;

@end
