//
//  ProductViewController.swift
//  GreenGrocer
//
//  Created by Sam Davies on 23/07/2015.
//  Copyright © 2015 Razeware. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {
  
  @IBOutlet weak var productImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var detailsLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  
  var product : Product? {
    didSet {
      updateViewForProduct()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    updateViewForProduct()
  }

  
  private func updateViewForProduct() {
    if let product = product {
      productImageView?.image = UIImage(named: product.photoName)
      nameLabel?.text = product.name
      detailsLabel?.text = product.details
      priceLabel?.text = "$\(product.price)"
    }
  }
}
