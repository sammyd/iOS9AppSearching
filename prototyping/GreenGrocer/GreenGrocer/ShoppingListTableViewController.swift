//
//  ShoppingListTableViewController.swift
//  GreenGrocer
//
//  Created by Sam Davies on 23/07/2015.
//  Copyright © 2015 Razeware. All rights reserved.
//

import UIKit
import CoreSpotlight

class ShoppingListTableViewController: UITableViewController, DataStoreOwner {
  
  var dataStore : DataStore?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 70
  }

  // MARK: - Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataStore?.shoppingLists.count ?? 0
  }
  

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("ShoppingListCell", forIndexPath: indexPath)
  
    if let cell = cell as? ShoppingListTableViewCell {
      cell.shoppingList = dataStore?.shoppingLists[indexPath.row]
    }
  
    return cell
  }
  
  // MARK: - Table view delegate
  override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    return true
  }
  
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
      if let shoppingList = dataStore?.shoppingLists[indexPath.row] {
        dataStore?.removeShoppingList(shoppingList)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
      }
    }
  }

  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if let destVC = segue.destinationViewController as? ShoppingListViewController {
      let selectedRowIndex = tableView.indexPathForSelectedRow
      destVC.shoppingList = dataStore?.shoppingLists[selectedRowIndex?.row ?? 0]
      destVC.dataStore = dataStore
    } else if let destVC = segue.destinationViewController as? CreateShoppingListViewController {
      destVC.dataStore = dataStore
    }
  }
  
}


extension ShoppingListTableViewController {
  @IBAction func unwindToShoppingListTableVC(unwindSegue: UIStoryboardSegue) {
    tableView.reloadData()
  }
}


extension ShoppingListTableViewController : RestorableActivity {
  override func restoreUserActivityState(activity: NSUserActivity) {
    switch activity.activityType {
    case CSSearchableItemActionType:
      if let id = activity.userInfo?[CSSearchableItemActivityIdentifier] as? String {
        displayVCForShoppingListWithId(id)
      }
    default:
      break
    }
    
    super.restoreUserActivityState(activity)
  }
  
  var restorableActivities : Set<String> {
    return Set([CSSearchableItemActionType])
  }
  
  private func displayVCForShoppingListWithId(id: String) {
    guard let id = NSUUID(UUIDString: id),
      let shoppingListIndex = dataStore?.shoppingLists.indexOf({ $0.id.isEqual(id) }) else {
        return
    }
    tableView.selectRowAtIndexPath(NSIndexPath(forRow: shoppingListIndex, inSection: 0), animated: false, scrollPosition: .Middle)
    performSegueWithIdentifier("DisplayShoppingList", sender: self)
  }
}

