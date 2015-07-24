//
//  ProductViewController.swift
//  GreenGrocer
//
//  Created by Sam Davies on 23/07/2015.
//  Copyright © 2015 Razeware. All rights reserved.
//

import UIKit
import CoreSpotlight

class ProductViewController: UIViewController {
  
  @IBOutlet weak var productImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var detailsLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  
  var product : Product? {
    didSet {
      updateViewForProduct()
      userActivity?.needsSave = true
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    userActivity = prepareUserActivity()
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


extension ProductViewController {
  override func updateUserActivityState(activity: NSUserActivity) {
    if let product = product {
      activity.contentAttributeSet = searchAttributeSetForProduct(product)
      activity.title = product.name
      activity.addUserInfoEntriesFromDictionary(["id" : product.id.UUIDString])
      activity.keywords = Set([product.name, "fruit"])
    }
  }
  
  private func prepareUserActivity() -> NSUserActivity {
    let activity = NSUserActivity(activityType: productActivityName)
    activity.eligibleForHandoff = true
    activity.eligibleForPublicIndexing = true
    activity.eligibleForSearch = true
    return activity
  }
  
  private func searchAttributeSetForProduct(product: Product) -> CSSearchableItemAttributeSet {
    let attributeSet = CSSearchableItemAttributeSet()
    attributeSet.contentDescription = product.details
    attributeSet.title = product.name
    attributeSet.displayName = product.name
    attributeSet.keywords = [product.name, "fruit", "shopping", "greengrocer"]
    if let thumbnail = UIImage(named: "\(product.photoName)_thumb") {
      attributeSet.thumbnailData = UIImageJPEGRepresentation(thumbnail, 0.7)
    }
    return attributeSet
  }
}

