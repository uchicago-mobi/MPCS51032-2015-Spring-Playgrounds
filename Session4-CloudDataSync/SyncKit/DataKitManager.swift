//
//  DataKitManager.swift
//  CloudDataSync
//
//  Created by T. Andrew Binkowski on 4/19/15.
//  Copyright (c) 2015 The University of Chicago. All rights reserved.
//

import Foundation
import CloudKit

/** To enable extension data sharing, we need to use an app group */
let sharedAppGroup: String = "group.mobi.uchicago.cloudDataSync"

/** The key for our defaults storage */
let favoritesKey: String = "Favorites"

// -----------------------------------------------------------------------------
// MARK: - DataKitManagerProtocol
/** 
    DataKitManager

    A protocol that all our data storage methods will conform to so that we can
    use a consistent API when accessing our data
*/
protocol DataKitManager {
    func add(object anObject: NSObject)
    func reset()
    func currentList() -> NSMutableArray
}


// -----------------------------------------------------------------------------
// MARK: - Local DefaultsManager
/**
    LocalDefaultsManager

    Store NSUserDefaults in local defaults in app group suite
*/
public class LocalDefaultsManager: DataKitManager {
    public static let sharedInstance = LocalDefaultsManager()
    
    let sharedDefaults: NSUserDefaults?
    var favorites: NSMutableArray?
    
    init() {
        sharedDefaults = NSUserDefaults(suiteName: sharedAppGroup)
        println(sharedDefaults?.dictionaryRepresentation())
    }
    
    public func add(object anObject: NSObject) {
        var current: NSMutableArray = currentList()
        current.addObject(anObject)
        sharedDefaults?.setObject(current, forKey: favoritesKey)
        sharedDefaults?.synchronize()
    }
    
    public func currentList() -> NSMutableArray {
        var current: NSMutableArray = []
        if let tempNames: NSArray = sharedDefaults?.arrayForKey(favoritesKey) {
            current = tempNames.mutableCopy() as! NSMutableArray
        }
        return current
    }
    
    public func reset() {
        sharedDefaults?.setObject(NSMutableArray(), forKey: favoritesKey)
        sharedDefaults?.synchronize()
    }
}

// -----------------------------------------------------------------------------
// MARK: - UbiquityDefaultsManager
/** 
    iCloudDefaultsManager
    Store in iCloud Key-Value Storage
*/
public class UbiquityDefaultsManager: DataKitManager {
    
    public func add(object anObject: NSObject) {}
    public func currentList() -> NSMutableArray { return NSMutableArray()}
    public func reset() {}
}

// -----------------------------------------------------------------------------
// MARK: - ClouldKitManager
/**
    CloudKitManager
    Store in CloudKit and sync with NSUserDefauls in app group
*/
public class CloudKitManager: DataKitManager {
    public static let sharedInstance = CloudKitManager()


    let sharedDefaults: NSUserDefaults?
    var favorites: NSMutableArray?

    var container : CKContainer
    var publicDB : CKDatabase
    let privateDB : CKDatabase
    
    init() {
        sharedDefaults = NSUserDefaults(suiteName: sharedAppGroup)
        println(sharedDefaults?.dictionaryRepresentation())
        // Cloud Kit
        container = CKContainer.defaultContainer()
        publicDB = container.publicCloudDatabase
        privateDB = container.privateCloudDatabase
    }

    public func add(object anObject: NSObject) {
        // Update local list in user defaults
        var current: NSMutableArray = currentList()
        current.addObject(anObject)
        sharedDefaults?.setObject(current, forKey: favoritesKey)
        sharedDefaults?.synchronize()
        
        // Save to ClouldKit
        let record = CKRecord(recordType: "Favorite")
        record.setValue(anObject, forKey: "Name")
        publicDB.saveRecord(record, completionHandler: { (record, error) -> Void in
                NSLog("Saved to cloud kit")
            })
    }

    public func currentList() -> NSMutableArray {
        var current: NSMutableArray = []
        if let tempNames: NSArray = sharedDefaults?.arrayForKey(favoritesKey) {
            current = tempNames.mutableCopy() as! NSMutableArray
        }
        return current
    }
    
    public func reset() {
        sharedDefaults?.setObject(NSMutableArray(), forKey: favoritesKey)
        sharedDefaults?.synchronize()
    }

    public func sync(completion: (results: NSArray) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Favorite", predicate: predicate)
    
        publicDB.performQuery(query, inZoneWithID: nil) {
            results, error in
            
            if error != nil {
                println("There is an error:\(error)")
            } else {
                dispatch_async(dispatch_get_main_queue()) {
                    let resultsArray = results as NSArray
                    // Copy these results to NSUserDefaults and then send back the completion handler
                    // We will always read the NSUserDefaults as the "true" data
                    completion(results: resultsArray)
                }
            }
        }
    }
}
