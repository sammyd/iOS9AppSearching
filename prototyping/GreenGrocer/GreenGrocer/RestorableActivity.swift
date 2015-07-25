//
//  RestorableActivity.swift
//  GreenGrocer
//
//  Created by Sam Davies on 25/07/2015.
//  Copyright © 2015 Razeware. All rights reserved.
//

import UIKit

protocol RestorableActivity {
  var restorableActivities : Set<String> { get }
}


extension RestorableActivity where Self : UIViewController {
  var restorableActivities : Set<String> {
    var activities = Set<String>()
    for vc in childViewControllers {
      if let ra = vc as? RestorableActivity {
        activities = activities.union(ra.restorableActivities)
      }
    }
    return activities
  }
}

