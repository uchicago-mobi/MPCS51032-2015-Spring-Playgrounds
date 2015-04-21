//
//  Application.swift
//  CloudDataSync
//
//  Created by T. Andrew Binkowski on 4/19/15.
//  Copyright (c) 2015 The University of Chicago. All rights reserved.
//

import Foundation
import CoreData

class Application: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var timeStamp: NSDate
    @NSManaged var price: NSDecimalNumber
    @NSManaged var color: AnyObject

}
