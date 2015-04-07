//
//  ViewController.h
//  2014-Spring-ReadToMe
//
//  Created by T. Andrew Binkowski on 4/4/14.
//  Copyright (c) 2014 The University of Chicago, Department of Computer Science. All rights reserved.
//

@import AVFoundation.AVSpeechSynthesis;

@interface SpeechSynthesisViewController : UIViewController <AVSpeechSynthesizerDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
- (IBAction)tapSpeak:(id)sender;
@end
