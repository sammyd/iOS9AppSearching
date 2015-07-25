//
//  AppAppearance.swift
//  GreenGrocer
//
//  Created by Sam Davies on 25/07/2015.
//  Copyright © 2015 Razeware. All rights reserved.
//

import UIKit

extension UIColor {
  static var ggGreen : UIColor {
    return UIColor(red: 127/255.0, green: 148/255.0, blue: 49/255.0, alpha: 1.0)
  }
  
  static var ggDarkGreen : UIColor {
    return UIColor(red: 48/255.0, green: 56/255.0, blue: 19/255.0, alpha: 1.0)
  }
}


func applyAppAppearance() {
  styleNavBar()
  styleTabBar()
  styleTintColor()
}


private func styleNavBar() {
  let appearanceProxy = UINavigationBar.appearance()
  appearanceProxy.barTintColor = UIColor.ggDarkGreen
  let font = UIFont.systemFontOfSize(30, weight: UIFontWeightThin)
  
  appearanceProxy.titleTextAttributes = [
    NSForegroundColorAttributeName : UIColor.whiteColor(),
    NSFontAttributeName            : font
  ]
}

private func styleTabBar() {
  let appearanceProxy = UITabBar.appearance()
  appearanceProxy.barTintColor = UIColor.ggDarkGreen
}

private func styleTintColor() {
  let appearanceProxy = UIView.appearance()
  appearanceProxy.tintColor = UIColor.ggGreen
}
