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
import MobileCoreServices

class ShareViewController: SLComposeServiceViewController {
    
    var urlSession: NSURLSession?
    
    var imageToShare: UIImage?
    var urlToShare: NSURL?

    
    
    override func presentationAnimationDidFinish() {
        let items = extensionContext?.inputItems
        var itemProvider: NSItemProvider?
        
        println("items: \(items)")
        
        if items != nil && items!.isEmpty == false {
            let item = items![0] as! NSExtensionItem
            
            if let attachments = item.attachments {
                //                if !attachments.isEmpty {
                //                    itemProvider = attachments[0] as? NSItemProvider
                //                }
                for attachment in attachments {
                    itemProvider = attachment as? NSItemProvider
                    
                    let imageType = kUTTypeImage as NSString as String
                    let urlType = kUTTypeURL as NSString  as String
                    
                    if itemProvider?.hasItemConformingToTypeIdentifier(urlType) == true {
                        itemProvider?.loadItemForTypeIdentifier(urlType, options: nil) { (item, error) -> Void in
                            if error == nil {
                                if let url = item as? NSURL {
                                    self.urlToShare = url
                                }
                            }
                        }
                        
                    } else if itemProvider?.hasItemConformingToTypeIdentifier(imageType) == true {
                        itemProvider?.loadItemForTypeIdentifier(imageType, options: nil) { (item, error) -> Void in
                            if error == nil {
                                println("Item: \(item)")
                                if let url = item as? NSURL {
                                    if let imageData = NSData(contentsOfURL: url) {

                                        self.imageToShare = UIImage(data: imageData)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
    }
    
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
