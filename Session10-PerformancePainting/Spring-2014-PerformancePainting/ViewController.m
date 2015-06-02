//
//  ViewController.m
//  PaintPerformance
//
//  Created by T. Andrew Binkowski on 4/30/13.
//  Copyright (c) 2013 UChicago Mobi. All rights reserved.
//


#import "ViewController.h"
#import "PaintView.h"

#import <QuartzCore/QuartzCore.h>

////////////////////////////////////////////////////////////////////////////////
@interface ViewController ()
@property (strong, nonatomic) UIImageView *backgroundView;
@property (strong, nonatomic) PaintView *paintView;
@property (strong, nonatomic) NSMutableArray *localImageCache;
@end

////////////////////////////////////////////////////////////////////////////////
@implementation ViewController

///-----------------------------------------------------------------------------
#pragma mark - Lifecycle
///-----------------------------------------------------------------------------
- (void)viewDidLoad
{
    [super viewDidLoad];
  
    ////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////
    #ifdef OPTIMIZATION2
        _localImageCache = [[NSMutableArray alloc] init];
    #endif
    ////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////
    
}

- (void)viewDidAppear:(BOOL)animated
{

    ////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////
    #ifdef OPTIMIZATION2
    // Create a background view to add image to
        _backgroundView = [[UIImageView alloc] initWithFrame:[self.view.window bounds]];
        _backgroundView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.backgroundView];
    #endif
    ////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////
    
    _paintView = [[PaintView alloc] initWithFrame:self.view.bounds];
    self.paintView.lineColor = [UIColor grayColor];
    self.paintView.delegate = self;
    self.paintView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.paintView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [self.localImageCache removeAllObjects];
}

///-----------------------------------------------------------------------------
#pragma mark - Shake To Erase
///-----------------------------------------------------------------------------
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

// Erase on shake
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventTypeMotion && event.type == UIEventSubtypeMotionShake) {
        self.backgroundView.image = nil;
    }
}

///-----------------------------------------------------------------------------
#pragma mark - PaintView Delegate Methods
///-----------------------------------------------------------------------------
- (void)paintView:(PaintView*)paintView finishedTrackingPath:(CGPathRef)path inRect:(CGRect)painted
{
    ////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////
    #ifdef OPTIMIZATION2
        [self mergePaintToBackgroundView:painted];
    #else
        [self.paintView erase];
    #endif
    ////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////
}

- (void)mergePaintToBackgroundView:(CGRect)painted
{
    NSLog(@"Merging Paint");
    
    // Create a new offscreen buffer that will be the UIImageView's image
    CGRect bounds = self.backgroundView.bounds;
    UIGraphicsBeginImageContextWithOptions(bounds.size, NO, self.backgroundView.contentScaleFactor);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Copy the previous background into that buffer.  Calling CALayer's renderInContext: will redraw the view if necessary
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    [self.backgroundView.layer renderInContext:context];
    
    // Now copy the painted contect from the paint view into our background image
    // and clear the paint view.  as an optimization we set the clip area so that
    //we only copy the area of paint view that was actually painted
    CGContextClipToRect(context, painted);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    [self.paintView.layer renderInContext:context];
    [self.paintView erase];
    
    // Create UIImage from the context
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    self.backgroundView.image = image;
    UIGraphicsEndImageContext();
   
    ////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////
    #ifdef FEATURE_SCREENSHOT
    ////////////////////////////////////////////////////////////////////////////
    /// Optimization - Save in background
    ////////////////////////////////////////////////////////////////////////////
    // Save the image to the photolibrary in the background
    //NSData *data = UIImagePNGRepresentation(image);
    //UIImageWriteToSavedPhotosAlbum([UIImage imageWithData:data], nil, nil, nil);

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = UIImagePNGRepresentation(image);
        UIImageWriteToSavedPhotosAlbum([UIImage imageWithData:data], nil, nil, nil);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"\n>>>>> Done saving in background...");//update UI here
        });
    });
  
    // This is only to show off instruments
    [self.localImageCache addObject:image];
    NSLog(@"local:%@",self.localImageCache);
    #endif
    ////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////
  }

- (IBAction)tapReplayButton:(id)sender
{
    [self.paintView erase];
    self.backgroundView.backgroundColor = [UIColor yellowColor];
    
    UIImage *replay = [UIImage animatedImageWithImages:self.localImageCache duration:0.5];
    self.backgroundView.image = replay;

}
@end