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

extension TabBarViewController : RestorableActivity {
  override func restoreUserActivityState(activity: NSUserActivity) {
    let compatibleVCs = viewControllers?.filter {
      vc in
      guard let vc = vc as? RestorableActivity else {
        return false
      }
      return vc.restorableActivities.contains(activity.activityType)
    }
    if let vcToSelect = compatibleVCs?.first {
      selectedViewController = vcToSelect
      vcToSelect.restoreUserActivityState(activity)
    }
    
    super.restoreUserActivityState(activity)
  }
}
