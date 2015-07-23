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
  
    
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
  */
  
}
