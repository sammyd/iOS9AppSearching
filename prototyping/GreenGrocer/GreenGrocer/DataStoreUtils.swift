//
//  DataStoreUtils.swift
//  GreenGrocer
//
//  Created by Sam Davies on 23/07/2015.
//  Copyright © 2015 Razeware. All rights reserved.
//

import UIKit

protocol DataStoreOwner {
  var dataStore : DataStore? { get set }
  
  func passDataStoreToChildren()
}


extension DataStoreOwner where Self : UIViewController {
  func passDataStoreToChildren() {
    for vc in childViewControllers {
      var dso = vc as? DataStoreOwner
      dso?.dataStore = dataStore
    }
  }
}