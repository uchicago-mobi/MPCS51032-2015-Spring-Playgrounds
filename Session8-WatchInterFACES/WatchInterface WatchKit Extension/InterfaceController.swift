//
//  InterfaceController.swift
//  WatchInterface WatchKit Extension
//
//  Created by T. Andrew Binkowski on 5/16/15.
//  Copyright (c) 2015 The University of Chicago. All rights reserved.
//

import WatchKit
import Foundation
import InterfaceKit

class InterfaceController: WKInterfaceController {

    /** Array of Face objects */
    var faces = [Face]()
    
    // MARK: - Outlets and Actions
    @IBOutlet weak var headerLabel: WKInterfaceLabel!
    @IBOutlet weak var table: WKInterfaceTable!

    /** 
        From a force touch, reset the favorite
    */
    @IBAction func tapMenuTrash() {
        LocalDefaultsManager.sharedInstance.reset()
    }

    // MARK: - Lifecycle
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Pull our famous Apple faces into a local array
        let f: Faces = Faces()
        faces = f.list
        
        // Configure interface objects here
        self.headerLabel.setText("Apple Executives")
        
        // Send work to parent.  This is just to show how to do it, we aren't 
        // actually doing any work related to our app's function
        parentDoWork()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        // Load up the table
        reloadTable()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    // MARK: - Notifications
    override func handleActionWithIdentifier(identifier: String?, forRemoteNotification remoteNotification: [NSObject : AnyObject]) {
        if let notificationIdentifier = identifier {
            if notificationIdentifier == "firstButtonAction" {
                println("You tapped the first button on the notificaiton and passed  it to the watch")
            }
        }
    }
    
    // MARK: - Handoff Support
    /**
        This gets called when the Watch App gets launched from a Glance 
        interface
    */
    override func handleUserActivity(userInfo: [NSObject : AnyObject]?) {
        println("Handoff Launch: \(userInfo)")
    }

    // MARK: - Table Support
    func reloadTable() {
        table.setNumberOfRows(faces.count, withRowType: "FaceRow")

        // Go through our array of people and fill in the table
        for (index, face) in enumerate(faces) {
            if let row = table.rowControllerAtIndex(index) as? FaceRow {
                // Get the current face from the index
                let currentFace = faces[index]
                
                // Set the interface objects
                row.titleLabel.setText(currentFace.title)
                row.nameLabel.setText(currentFace.name)
                row.image.setImageNamed(currentFace.imageName)
            }
        }
    }

    // MARK: - Segue
    override func contextForSegueWithIdentifier(segueIdentifier: String, inTable table: WKInterfaceTable, rowIndex: Int) -> AnyObject? {
        // Validate which segue we are triggering
        if segueIdentifier == "FaceDetailSegue" {
            // Get face from row index and return (to be used as context in
            // segue
            let name = faces[rowIndex].name
            return name
        }
        // Return nil as a fallback
        return nil
    }
 
    // MARK: - Parent Work
    /** 
        This function is an example of how you would request the parent app to 
        do some work and return a reply.  This is not used for 
    */
    func parentDoWork() {
            WKInterfaceController.openParentApplication(["request": "refreshData"], reply: { (replyInfo, error) -> Void in
                if let newData = replyInfo["executiveData"] as? String {
                    println("New Data: \(newData)")
                }
        })
    }
}
