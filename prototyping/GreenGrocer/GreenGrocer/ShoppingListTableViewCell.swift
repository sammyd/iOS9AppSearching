//
//  ShoppingListTableViewCell.swift
//  GreenGrocer
//
//  Created by Sam Davies on 24/07/2015.
//  Copyright © 2015 Razeware. All rights reserved.
//

import UIKit

class ShoppingListTableViewCell: UITableViewCell {
  
  @IBOutlet weak var nameLabel: MultilineLabelThatWorks!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var itemCountLabel: UILabel!
  
  private static var dateFormatter : NSDateFormatter = {
    let df = NSDateFormatter()
    df.dateStyle = .ShortStyle
    return df
  }()
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    nameLabel.layoutMargins = UIEdgeInsetsZero
    dateLabel.layoutMargins = UIEdgeInsetsMake(0, 10, 0, 0)
  }
  
  var shoppingList : ShoppingList? {
    didSet {
      if let shoppingList = shoppingList {
        nameLabel?.text = shoppingList.name
        itemCountLabel?.text = "\(shoppingList.products.count) items"
        dateLabel?.text = self.dynamicType.dateFormatter.stringFromDate(shoppingList.date)
      }
    }
  }
}
