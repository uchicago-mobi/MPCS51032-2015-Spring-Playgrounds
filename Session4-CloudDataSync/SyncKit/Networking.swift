//
//  Networking.swift
//  SwiftMarks
//
//  Created by T. Andrew Binkowski on 4/13/15.
//  Copyright (c) 2015 Department of Computer Science, The University of Chicago. All rights reserved.
//

import Foundation

/**
    Networking class that can be accessed from extensions and from container
    app.  This follows the singleton pattern described here: 
    https://github.com/hpique/SwiftSingleton
    
    “static” methods and properties are now allowed in classes (as an alias for
    “class final”). You are now allowed to declare static stored properties in 
    classes, which have global storage and are lazily initialized on first 
    access (like global variables).
*/
public class Networking {
    
    public static let sharedInstance = Networking()
    
    let name = "name"
    
    // MARK: - Initilization
    init() {
        println("Initializing Singleton");
    }
    
    

    // MARK: - Post
    
    // MARK: - Request
    /**
        Creates a request for the specified method, URL string, parameters, and parameter encoding.

        :param: method The HTTP method.
        :param: URLString The URL string.
        :param: parameters The parameters. `nil` by default.
        :param: encoding The parameter encoding. `.URL` by default.
        
        :returns: The created request.
    */
    public func get(request: NSURLRequest!, callback: (String, String?) -> Void) {

        var session = NSURLSession.sharedSession()
        var task = session.dataTaskWithRequest(request){
            (data, response, error) -> Void in
            if error != nil {
                callback("", error.localizedDescription)
            } else {
                var result = NSString(data: data, encoding: NSASCIIStringEncoding)!
                callback(result as String, nil)
            }
        }
        task.resume()
    }
    
    
}