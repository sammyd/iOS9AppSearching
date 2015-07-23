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
