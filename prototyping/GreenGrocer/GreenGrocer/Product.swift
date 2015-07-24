//
//  Product.swift
//  GreenGrocer
//
//  Created by Sam Davies on 23/07/2015.
//  Copyright © 2015 Razeware. All rights reserved.
//

import UIKit

private let idKey = "id"
private let nameKey = "name"
private let priceKey = "price"
private let detailsKey = "details"
private let photoNameKey = "photoName"


typealias ProductID = NSUUID

final class Product {
  let id: ProductID
  let name: String
  let price: Int
  let details: String
  let photoName: String
  
  init(id: ProductID, name: String, price: Int, details: String, photoName: String) {
    self.id = id
    self.name = name
    self.price = price
    self.details = details
    self.photoName = photoName
  }
}

extension Product {
  convenience init(name: String, price: Int, details: String, photoName: String) {
    self.init(id: NSUUID(), name: name, price: price, details: details, photoName: photoName)
  }
}

extension Product : Serializable {
  convenience init?(dict: [String : AnyObject]) {
    guard let idString = dict[idKey] as? String,
      let id = NSUUID(UUIDString: idString),
      let name = dict[nameKey] as? String,
      let price = dict[priceKey] as? Int,
      let details = dict[detailsKey] as? String,
      let photoName = dict[photoNameKey] as? String else {
        return nil
    }
    self.init(id: id, name: name, price: price, details: details, photoName: photoName)
  }
  
  var dictRepresentation : [String : AnyObject] {
    return [
      idKey            : id.UUIDString,
      nameKey          : name,
      priceKey         : price,
      detailsKey       : details,
      photoNameKey     : photoName,
    ]
  }
}

extension Product : Equatable {
  // Free function below
}

func ==(lhs: Product, rhs: Product) -> Bool {
  return lhs.id.isEqual(rhs.id)
}

extension Product : Hashable {
  var hashValue : Int {
    return id.UUIDString.hashValue
  }
}