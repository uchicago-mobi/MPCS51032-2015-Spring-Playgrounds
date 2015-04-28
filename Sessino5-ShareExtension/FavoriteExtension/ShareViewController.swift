//
//  ShareViewController.swift
//  FavoriteExtension
//
//  Created by T. Andrew Binkowski on 4/21/15.
//  Copyright (c) 2015 The University of Chicago. All rights reserved.
//

import UIKit
import Social
import ExtensionKit


class ShareViewController: SLComposeServiceViewController {

    var attachedImage: UIImage?
    
    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }
    
    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of 
        // contentText and/or NSExtensionContext attachments.
        let sharedItem: NSDictionary = ["date": NSDate(),
            "contentText": self.contentText]
        LocalDefaultsManager.sharedInstance.add(object: sharedItem)
        
        // Inform the host that we're done, so it un-blocks its UI. 
        // Note: Alternatively you could call super's -didSelectPost, which will
        // similarly complete the extension context.
        self.extensionContext!.completeRequestReturningItems([], completionHandler: nil)
    }

    override func configurationItems() -> [AnyObject]! {
        // To add configuration options via table cells at the bottom of the sheet, 
        // return an array of SLComposeSheetConfigurationItem here.
        return []
    }


}
