//
//  ProductTableViewCell.swift
//  GreenGrocer
//
//  Created by Sam Davies on 23/07/2015.
//  Copyright © 2015 Razeware. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

  @IBOutlet weak var productImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  
  var product : Product? {
    didSet {
      if let product = product {
        nameLabel?.text = product.name
        productImageView?.image = UIImage(named: "\(product.photoName)_thumb")
      }
    }
  }
  
}
