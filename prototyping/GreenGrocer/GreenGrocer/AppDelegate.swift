//
//  AppDelegate.swift
//  GreenGrocer
//
//  Created by Sam Davies on 23/07/2015.
//  Copyright © 2015 Razeware. All rights reserved.
//

import UIKit

let productActivityName = "com.razeware.GreenGrocer.product"
let shoppingListDomainID = "com.razeware.GreenGrocer.shoppingList"


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var dataStore: DataStore?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch.
    dataStore = loadDataStore("GreenGrocerSeed")
    
    var dso = window?.rootViewController as? DataStoreOwner
    dso?.dataStore = dataStore
    
    // Perform the Core Spotlight indexing
    dataStore?.indexAllShoppingLists()
    
    return true
  }
}

extension AppDelegate {
  private func loadDataStore(seedPlistName: String) -> DataStore? {
    if DataStore.defaultDataStorePresentOnDisk {
      return DataStore()
    } else {
      // Locate seed data
      let seedURL = NSBundle.mainBundle().URLForResource(seedPlistName, withExtension: "plist")!
      let ds = DataStore(plistURL: seedURL)
      // Save seed data to the documents directory
      ds.save()
      return ds
    }
  }
}


extension AppDelegate {
  func application(application: UIApplication, continueUserActivity userActivity: NSUserActivity, restorationHandler: ([AnyObject]?) -> Void) -> Bool {
    if let rootVC = window?.rootViewController,
      let restorable = rootVC as? RestorableActivity
      where restorable.restorableActivities.contains(userActivity.activityType) {
        restorationHandler([rootVC])
        return true
    } else {
      return false
    }
  }
}
