//
//  PaintView.m
//  Paint
//
//  Created by T. Andrew Binkowski on 4/30/13.
//  Copyright (c) 2013 T. Andrew Binkowski. All rights reserved.
//

#import "PaintView.h"
#import "ViewController.h"
@import QuartzCore;


@interface PaintView ()
@end

@implementation PaintView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        // Setup the painting style
        self.lineWidth = 15;
        self.lineColor = [UIColor greenColor];
        self.shadowSize = (CGSize) {10,10},
        self.shadowBlur = 5;
        
        
        // Make the background clear so we can see previous strokes
        self.backgroundColor = [UIColor clearColor];
        _previousPaths = [[NSMutableArray alloc] initWithCapacity:10];
        _strokes = [[NSMutableArray alloc] initWithCapacity:10];
    }

    return self;
}

#pragma mark - Touch Handling Code
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    if (_trackingPath == NULL) {
        _trackingPath = CGPathCreateMutable();
    }
    CGPoint point = [[touches anyObject] locationInView:self];
    CGPathMoveToPoint(_trackingPath, NULL, point.x, point.y);
    
    
#ifdef BEZIER_TYPE
    /*
    ////////////////////////////////////////////////////////////////////////////
    // BezierPath
    UITouch *touch = [touches anyObject];
    
    self.path = [UIBezierPath bezierPath];
	self.path.lineWidth = 10;
    self.path.lineCapStyle = kCGLineCapRound;
    self.path.lineJoinStyle = kCGLineJoinRound;
	[self.path moveToPoint:[touch locationInView:self]];
    
    // Create the arrays to hold the values
    [self.strokes addObject:self.path];
*/
#endif
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Add the new path to the point
    CGPoint point = [[touches anyObject] locationInView:self];
    CGPathAddLineToPoint(_trackingPath, NULL, point.x, point.y);
    
#ifdef OPTIMIZATION0
    [self setNeedsDisplay];
#endif

#ifdef OPTIMIZATION1
    CGPoint prevPoint = CGPathGetCurrentPoint(_trackingPath);
    CGRect dirty = [self segmentBoundsFrom:prevPoint to:point];
    [self setNeedsDisplayInRect:dirty];

    #ifdef OPTIMIZATION2
    // Keep track of the cumulative "dirty" rectangle
    _trackingDirty = CGRectUnion(dirty, _trackingDirty);
    #endif
#endif
    
#ifdef BEZIER_TYPE
    /*
     UITouch *touch = [touches anyObject];
    [[self.strokes lastObject] addLineToPoint:[touch locationInView:self]];
    //[self setNeedsDisplay];
    [self setNeedsDisplayInRect:dirty];
     */
#endif

}

/*******************************************************************************
 * @method          touchesEnded:withEvent
 * @abstract
 * @description         
 *******************************************************************************/
- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_previousPaths addObject:(__bridge id)_trackingPath];
    [_previousColors addObject:self.lineColor];
    CGPathRelease(_trackingPath);
    _trackingPath = NULL;
    
#ifdef OPTIMIZATION1
    [self setNeedsDisplay];
#endif

#ifdef OPTIMIZATION2
    [self.delegate paintView:self finishedTrackingPath:_trackingPath inRect:_trackingDirty];
#endif
    
    
#ifdef BEZIER_TYPE
    /*
	UITouch *touch = [touches anyObject];
    // Update the last one
    [[self.strokes lastObject] addLineToPoint:[touch locationInView:self]];
    [self setNeedsDisplay];
    //[self setNeedsDisplayInRect:CGRectUnion(self.firstTouch,self.lastTouch)];
    [self.delegate paintView:self finishedTrackingPath:_trackingPath inRect:_trackingDirty];
     */
#endif
}

/*******************************************************************************
 * @method          drawRect:
 * @abstract
 * @description      
 *******************************************************************************/
float totalTimeInDrawRect=0.0;
int numberOfDrawRectCalls=0;

- (void)drawRect:(CGRect)rect
 {
     CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
     
     CGContextRef context = UIGraphicsGetCurrentContext();
     CGContextSaveGState(context);  
     NSLog(@"rect:%f %f",rect.size.width,rect.size.height);
     
     [_previousPaths enumerateObjectsUsingBlock:^(id obj,NSUInteger idx, BOOL *stop) {
         [self setPaintStyleInContext:context withColor:[_previousColors objectAtIndex:idx]];
         CGContextAddPath(context, (__bridge CGPathRef)obj);
         CGContextDrawPath(context, kCGPathStroke);
     }];
     
     if (_trackingPath) {
         [self setPaintStyleInContext:context withColor:self.lineColor];
         CGContextAddPath(context, _trackingPath);
         CGContextDrawPath(context, kCGPathStroke);
     }
     
     CGContextRestoreGState(context);
     
    
#ifdef BEZIER_TYPE
     /*
     for (int i=0; i < [self.strokes count]; i++) {
         //for (UIBezierPath *tmp in self.strokes)
         UIBezierPath *tmp = (UIBezierPath*)[self.strokes objectAtIndex:i];
         [[UIColor redColor] set];
         [tmp stroke];
     }
      */
#endif
     
     // Time profiling
     CFAbsoluteTime runTime = 1000.0*(CFAbsoluteTimeGetCurrent() - startTime);
     numberOfDrawRectCalls++;
     totalTimeInDrawRect+= runTime;
     NSLog(@">>> %2.2fms      Average: %2.2f", runTime,totalTimeInDrawRect/numberOfDrawRectCalls);
 }


/*******************************************************************************
 * @method          <# method #>
 * @abstract        <# abstract #>
 * @description     <# description #>
 *******************************************************************************/
- (void)setPaintStyleInContext:(CGContextRef)context withColor:(UIColor*)color
{

    CGContextSetShadowWithColor(context, self.shadowSize, self.shadowBlur, [color CGColor]);
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextSetLineWidth(context, self.lineWidth);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    //}
}

/*******************************************************************************
 * @method          erase
 * @abstract
 * @description
 *******************************************************************************/
- (void)erase {
    [_previousPaths removeAllObjects];
    [_previousColors removeAllObjects];

    if (_trackingPath) {
        CGPathRelease(_trackingPath);
        _trackingPath = NULL;
        _trackingDirty = CGRectNull;
    }

    // Bezier Path 
    /*(
     // Remove all the strokes and clear the arrays
    [self.path removeAllPoints];
    [self.strokes removeAllObjects];
     */
    
    [self setNeedsDisplay];
}

/*******************************************************************************
 * @method          segmentBoundsFrom:to
 * @abstract        Get a rect from the start and end points of a touch
 * @description     Include a buffer of 10
 *******************************************************************************/
- (CGRect)segmentBoundsFrom:(CGPoint)point1 to:(CGPoint)point2
{
    CGRect dirtyPoint1 = CGRectMake(point1.x-20, point1.y-20, 50, 50);
    CGRect dirtyPoint2 = CGRectMake(point2.x-20, point2.y-20, 50, 50);
    return CGRectUnion(dirtyPoint1, dirtyPoint2);
}
@end
