//
//  ProductTableViewController.swift
//  GreenGrocer
//
//  Created by Sam Davies on 23/07/2015.
//  Copyright © 2015 Razeware. All rights reserved.
//

import UIKit

class ProductTableViewController: UITableViewController, DataStoreOwner {
  
  var dataStore : DataStore? {
    didSet {
      tableView.reloadData()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 120
  }
  
  // MARK: - Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataStore?.products.count ?? 0
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("ProductCell", forIndexPath: indexPath)
    
    if let cell = cell as? ProductTableViewCell {
      cell.product = dataStore?.products[indexPath.row]
    }
    
    return cell
  }
  
    
  // MARK: - Navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if let destVC = segue.destinationViewController as? ProductViewController {
      let selectedRow = tableView.indexPathForSelectedRow?.row ?? 0
      destVC.product = dataStore?.products[selectedRow]
    }
  }
  
}


extension ProductTableViewController : RestorableActivity {
  override func restoreUserActivityState(activity: NSUserActivity) {
    switch activity.activityType {
    case productActivityName:
      if let id = activity.userInfo?["id"] as? String {
        displayVCForProductWithId(id)
      }
    default:
      break
    }
    
    super.restoreUserActivityState(activity)
  }
  
  var restorableActivities : Set<String> {
    return Set([productActivityName])
  }
  
  private func displayVCForProductWithId(id: String) {
    guard let id = NSUUID(UUIDString: id),
      let productIndex = dataStore?.products.indexOf({ $0.id.isEqual(id) }) else {
        return
    }
    tableView.selectRowAtIndexPath(NSIndexPath(forRow: productIndex, inSection: 0), animated: false, scrollPosition: .Middle)
    performSegueWithIdentifier("DisplayProduct", sender: self)
  }
}
