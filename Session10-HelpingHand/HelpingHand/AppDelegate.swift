//
//  AppDelegate.swift
//  HelpingHand
//
//  Created by T. Andrew Binkowski on 5/11/15.
//  Copyright (c) 2015 The University of Chicago. All rights reserved.
//

import UIKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.

        
        
        // Do any additional setup after loading the view, typically from a nib.
        if (UIAccessibilityIsVoiceOverRunning()){
            println("Voice Over is running")
        } else {
            // This doesn't work because Voice Over is not enabled
            // Bug when using QuickTime where this doesn't work.
            //UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification,"Voice Over is not on");
            let string = "Voice over is not enabled"
            println(string)
            
            let utterance = AVSpeechUtterance(string: string)
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
            let synthesizer = AVSpeechSynthesizer()
            synthesizer.speakUtterance(utterance)
            
        }
        
        // This is a localization test (it has nothing to do with accessibility)
        let greeting = NSLocalizedString("GREETING", comment: "This is a greeting that will be displayed as a console message when the application launches.")
        println("Greeting \(greeting)")
        
        
        let age = String(format: NSLocalizedString("AGE", comment: "Comment doesn't do anything useful"),"5")
        println("Age \(age)")
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

