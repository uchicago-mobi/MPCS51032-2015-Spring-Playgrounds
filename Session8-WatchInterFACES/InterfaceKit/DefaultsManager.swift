//
//  DefaultsManager.swift
//  WatchInterface
//
//  Created by T. Andrew Binkowski on 5/18/15.
//  Copyright (c) 2015 The University of Chicago. All rights reserved.
//

import Foundation

/** To enable extension data sharing, we need to use an app group */
let sharedAppGroup: String = "group.mobi.uchicago.watchinterface"

/** The key for our defaults storage */
let favoritesKey: String = "Favorite"


public class LocalDefaultsManager {
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
    
    public func currentFavorite() -> String? {
        var current: NSMutableArray = currentList()
        return current.lastObject as? String
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

