//
//  GlanceController.swift
//  WatchInterface WatchKit Extension
//
//  Created by T. Andrew Binkowski on 5/16/15.
//  Copyright (c) 2015 The University of Chicago. All rights reserved.
//

import WatchKit
import Foundation
import InterfaceKit

class GlanceController: WKInterfaceController {

    /** Store the favorite person in a string.  Set Tim Cook as favorite by default */
    var favorite: String? = LocalDefaultsManager.sharedInstance.currentFavorite() ?? "Tim Cook"
    @IBOutlet weak var nameLabel: WKInterfaceLabel!
    @IBOutlet weak var image: WKInterfaceImage!
    
    // MARK: - Lifecycle
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    }
  
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        // Update the outlets
        self.image.setImageNamed(favorite)
        self.nameLabel.setText(favorite)
        
        // Configure for handoff support to Watch App
        updateUserActivity("mobi.uhicago.interfaces.glance", userInfo: ["current Favorite" : favorite!], webpageURL: nil)
        
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
      }


}
