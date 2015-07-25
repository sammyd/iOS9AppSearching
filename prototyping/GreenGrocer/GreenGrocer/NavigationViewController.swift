//
//  NavigationViewController.swift
//  GreenGrocer
//
//  Created by Sam Davies on 23/07/2015.
//  Copyright © 2015 Razeware. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController, DataStoreOwner {
  
  var dataStore : DataStore? {
    didSet {
      passDataStoreToChildren()
    }
  }
}

extension NavigationViewController : RestorableActivity {
  override func restoreUserActivityState(activity: NSUserActivity) {
    let compatibleVCs = viewControllers.reverse().filter {
      vc in
      guard let vc = vc as? RestorableActivity else {
        return false
      }
      return vc.restorableActivities.contains(activity.activityType)
    }
    if let vcToSelect = compatibleVCs.first {
      popToViewController(vcToSelect, animated: false)
      vcToSelect.restoreUserActivityState(activity)
    }
    
    super.restoreUserActivityState(activity)
  }
}
