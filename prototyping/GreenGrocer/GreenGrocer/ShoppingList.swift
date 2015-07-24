//
//  ShoppingList.swift
//  GreenGrocer
//
//  Created by Sam Davies on 23/07/2015.
//  Copyright © 2015 Razeware. All rights reserved.
//

import Foundation

private let idKey = "id"
private let nameKey = "name"
private let dateKey = "date"
private let productsKey = "products"

typealias ShoppingListID = NSUUID

struct ShoppingList {
  let id: ShoppingListID
  let name: String
  let date: NSDate
  let products: [Product]
}

extension ShoppingList {
  static var productList = [Product]()
}

extension ShoppingList {
  init(name: String, date: NSDate, products: [Product]) {
    self.init(id: NSUUID(), name: name, date: date, products: products)
  }
}

extension ShoppingList : Serializable {
  init?(dict: [String : AnyObject]) {
    guard let idString = dict[idKey] as? String,
      let id = NSUUID(UUIDString: idString),
      let name = dict[nameKey] as? String,
      let date = dict[dateKey] as? NSDate,
      let productIDList = dict[productsKey] as? [String],
      let products = mapProductIDListToProductList(productIDList) else {
        return nil
    }
    
    self.init(id: id, name: name, date: date, products: products)
  }
  
  var dictRepresentation : [String : AnyObject] {
    return [
      idKey       : id.UUIDString,
      nameKey     : name,
      dateKey     : date,
      productsKey : products.map { $0.id.UUIDString }
    ]
  }
}

// Equatable
extension ShoppingList : Equatable {
  
}

func ==(lhs: ShoppingList, rhs: ShoppingList) -> Bool {
  return lhs.id.isEqual(rhs.id)
}

private func mapProductIDListToProductList(productIDList: [String]) -> [Product]? {
  let products = productIDList.map(findProductForIDString).filter{ $0 != nil }.map{ $0! }
  if products.count == productIDList.count {
    return products
  } else {
    return nil
  }
}

private func findProductForIDString(productID: String) -> Product? {
  let uuid = NSUUID(UUIDString: productID)!
  let products = ShoppingList.productList.filter{ $0.id.isEqual(uuid) }
  if products.count == 1 {
    return products.first!
  } else {
    return nil
  }
}