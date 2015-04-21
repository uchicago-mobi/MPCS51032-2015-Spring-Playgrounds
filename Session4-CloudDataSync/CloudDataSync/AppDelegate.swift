//
//  AppDelegate.swift
//  CloudDataSync
//
//  Created by T. Andrew Binkowski on 4/19/15.
//  Copyright (c) 2015 The University of Chicago. All rights reserved.
//

import UIKit
import CoreData
import DataKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
        CoreDataManager.sharedInstance.observeCloudActions(persistentStoreCoordinator: CoreDataManager.sharedInstance.persistentStoreCoordinator)

        // Test our networking class
        /*
        var request = NSMutableURLRequest(URL: NSURL(string: "http://www.google.com")!)
        Networking.sharedInstance.get(request){
            (data, error) -> Void in
            if error != nil {
                println(error)
            } else {
                println(data)
            }
        }
    */
        /*
        // Test our wishlist class
        var list: Wishlist = Wishlist()
        list.URL = "http://google.com"
        
        if let listURL = list.URL {
            println("Wishlist \(listURL))")
        }
    }*/
        
        LocalDefaultsManager.sharedInstance.add(object: NSDate())
        println("Current List: \(CloudKitManager.sharedInstance.currentList())")
       
        CloudKitManager.sharedInstance.add(object: "Recap")
        CloudKitManager.sharedInstance.sync { (results) -> Void in
            println("CloudKit Results: \(results)")
        }
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        CoreDataManager.sharedInstance.saveContext()
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        CoreDataManager.sharedInstance.saveContext()
    }
    
 
    
    
}

