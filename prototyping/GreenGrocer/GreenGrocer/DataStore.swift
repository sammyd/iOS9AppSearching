//
//  DataStore.swift
//  GreenGrocer
//
//  Created by Sam Davies on 23/07/2015.
//  Copyright © 2015 Razeware. All rights reserved.
//

import Foundation


private let defaultPlistName = "GreenGrocer"
private let productsKey = "products"
private let shoppingListsKey = "shoppingLists"

final class DataStore {
  // MARK:- Storage
  var products = [Product]()
  var shoppingLists = [ShoppingList]()
  
  init(products: [Product], shoppingLists: [ShoppingList]) {
    self.products = products
    self.shoppingLists = shoppingLists
  }
}

// MARK:- Reading from disc
extension DataStore {
  convenience init(plistURL: NSURL) {
    guard let rawDict = DataStore.loadPlistFromURL(plistURL),
      let productArray = rawDict[productsKey] as? [[String : AnyObject]],
      let shoppingListArray = rawDict[shoppingListsKey] as? [[String : AnyObject]],
      let products = Product.fromDictArray(productArray) else {
        self.init(products: [Product](), shoppingLists: [ShoppingList]())
        return
    }
    
    // Nasty and hacky :)
    ShoppingList.productList = products
    guard let shoppingLists = ShoppingList.fromDictArray(shoppingListArray) else {
      self.init(products: products, shoppingLists: [ShoppingList]())
      return
    }
    
    self.init(products: products, shoppingLists: shoppingLists)
  }
  
  convenience init(plistName: String) {
    let fileURL = NSURL.urlForFileInDocumentsDirectory(plistName, fileExtension: "plist")
    self.init(plistURL: fileURL)
  }
  
  convenience init() {
    self.init(plistName: defaultPlistName)
  }
  
  private static func loadPlistFromURL(plistURL: NSURL) -> [String : AnyObject]? {
    let rawDict = NSDictionary(contentsOfURL: plistURL)
    return rawDict as? [String : AnyObject]
  }
  
  static var defaultDataStorePresentOnDisk : Bool {
    guard let storePath = NSURL.urlForFileInDocumentsDirectory(defaultPlistName, fileExtension: "plist").path else {
      return false
    }
    return NSFileManager.defaultManager().fileExistsAtPath(storePath)
  }
}

// MARK:- Persisting
extension DataStore {
  func save(plistName plistName: String) {
    let serialisedData = [
      productsKey : products.map { $0.dictRepresentation },
      shoppingListsKey : shoppingLists.map { $0.dictRepresentation }
    ] as NSDictionary
    serialisedData.writeToURL(NSURL.urlForFileInDocumentsDirectory(plistName, fileExtension: "plist"), atomically: true)
  }
  
  func save() {
    save(plistName: defaultPlistName)
  }
}

// MARK:- NSURL Util methods
extension NSURL {
  private static var documentsDirectory : NSURL {
    return NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
  }
  
  private static func urlForFileInDocumentsDirectory(fileName: String, fileExtension: String) -> NSURL {
    return NSURL.documentsDirectory.URLByAppendingPathComponent(fileName).URLByAppendingPathExtension(fileExtension)
  }
}


// MARK:- Managing shopping lists
extension DataStore {
  func addShoppingList(shoppingList: ShoppingList) {
    shoppingLists.append(shoppingList)
    indexShoppingLists([shoppingList])
    save()
  }
  
  func removeShoppingList(shoppingList: ShoppingList) {
    if let index = shoppingLists.indexOf(shoppingList) {
      shoppingLists.removeAtIndex(index)
    }
  }
}
