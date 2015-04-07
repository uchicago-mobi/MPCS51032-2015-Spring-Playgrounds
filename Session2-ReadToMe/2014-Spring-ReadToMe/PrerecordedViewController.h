//
//  PrerecordedViewController.h
//  2014-Spring-ReadToMe
//
//  Created by T. Andrew Binkowski on 4/7/14.
//  Copyright (c) 2014 The University of Chicago, Department of Computer Science. All rights reserved.
//

@import AVFoundation;

@interface PrerecordedViewController : UIViewController

/* The text view holding the sentence */
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic,retain) NSDate *timeZero;
@property int wordIndex;
@property (nonatomic,retain) AVAudioPlayer *audioPlayer;
@property (retain, nonatomic) NSMutableAttributedString *attributedString;

- (IBAction)tapSpeakToMe:(id)sender;

@end
