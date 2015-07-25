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

extension NavigationViewController : RestorableActivityContainer {
  override func restoreUserActivityState(activity: NSUserActivity) {
    if let vcToSelect = primaryRestorableResponderForActivityType(activity.activityType) as? UIViewController {
      popToViewController(vcToSelect, animated: false)
      vcToSelect.restoreUserActivityState(activity)
    }
    
    super.restoreUserActivityState(activity)
  }
}
