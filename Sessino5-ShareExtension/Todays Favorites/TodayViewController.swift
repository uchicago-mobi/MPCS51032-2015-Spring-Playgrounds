//
//  TodayViewController.swift
//  Todays Favorites
//
//  Created by T. Andrew Binkowski on 4/22/15.
//  Copyright (c) 2015 The University of Chicago. All rights reserved.
//

import UIKit
import NotificationCenter
import ExtensionKit

class TodayViewController: UIViewController, NCWidgetProviding {

    /** Array to hold all the shared items loaded from NSUserDefaults */
    var sharedItems: NSMutableArray = []
    /** Table view UI */
    @IBOutlet weak var tableView: UITableView!
    
    // -------------------------------------------------------------------------
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        sharedItems = LocalDefaultsManager.sharedInstance.currentList()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.
        self.preferredContentSize = CGSizeMake(320,400)
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
    // -------------------------------------------------------------------------
    // MARK: - Table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sharedItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        let sharedItemDictionary: NSDictionary = sharedItems[indexPath.row] as! NSDictionary
        
        cell.textLabel!.text = sharedItemDictionary["contentText"] as? String
        cell.detailTextLabel!.text = (sharedItemDictionary["date"] as? NSDate)!.description
        
        return cell
    }
    
    // -------------------------------------------------------------------------
    // MARK: - Table view data delegate methods
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let row = indexPath.row

        // We are using a custom URL to pass the index of the tapped cell
        // You can use this to customize the launch of the container application
        let launchString = "mobiuchicagoshare://indexPathRow=\(row)"
        self.extensionContext?.openURL(NSURL(string: launchString)!, completionHandler:nil)
    }
}
