//
//  TabBarViewController.swift
//  GreenGrocer
//
//  Created by Sam Davies on 23/07/2015.
//  Copyright © 2015 Razeware. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController, DataStoreOwner {
  var dataStore : DataStore? {
    didSet {
      passDataStoreToChildren()
    }
  }
}

extension TabBarViewController : RestorableActivityContainer {
  override func restoreUserActivityState(activity: NSUserActivity) {
    if let vcToSelect = primaryRestorableResponderForActivityType(activity.activityType) as? UIViewController {
      selectedViewController = vcToSelect
      vcToSelect.restoreUserActivityState(activity)
    }
    
    super.restoreUserActivityState(activity)
  }
}
