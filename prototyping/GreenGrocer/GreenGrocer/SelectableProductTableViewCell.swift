//
//  SelectableProductTableViewCell.swift
//  GreenGrocer
//
//  Created by Sam Davies on 24/07/2015.
//  Copyright © 2015 Razeware. All rights reserved.
//

import UIKit

class SelectableProductTableViewCell: UITableViewCell {
  
  @IBOutlet weak var checkBoxLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  
  
  var product : Product? {
    didSet {
      nameLabel?.text = product?.name
    }
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
    checkBoxLabel?.text = selected ? "✅" : " "
  }
  
}
