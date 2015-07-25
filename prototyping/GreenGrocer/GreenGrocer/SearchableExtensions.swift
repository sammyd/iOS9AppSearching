//
//  SearchableExtensions.swift
//  GreenGrocer
//
//  Created by Sam Davies on 25/07/2015.
//  Copyright © 2015 Razeware. All rights reserved.
//

import UIKit
import CoreSpotlight
import MobileCoreServices

extension Product {
  var searchableAttributeSet : CSSearchableItemAttributeSet {
    let attributeSet = CSSearchableItemAttributeSet()
    attributeSet.contentDescription = details
    attributeSet.title = name
    attributeSet.displayName = name
    attributeSet.keywords = [name, "fruit", "shopping", "greengrocer"]
    if let thumbnail = UIImage(named: "\(photoName)_thumb") {
      attributeSet.thumbnailData = UIImageJPEGRepresentation(thumbnail, 0.7)
    }
    return attributeSet
  }
}

private var dateFormatter : NSDateFormatter = {
  let df = NSDateFormatter()
  df.dateStyle = .ShortStyle
  return df
}()

extension ShoppingList {
  var searchableAttributeSet : CSSearchableItemAttributeSet {
    let attributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeContent as String)
    attributeSet.contentDescription = "A shopping list created for \(dateFormatter.stringFromDate(date))"
    attributeSet.contentCreationDate = date
    attributeSet.displayName = name
    attributeSet.keywords = products.map { $0.name } + ["shopping list", "greengrocer"]
    if let thumbnail = UIImage(named: "fruit_basket") {
      attributeSet.thumbnailData = UIImageJPEGRepresentation(thumbnail, 0.7)
    }
    return attributeSet
  }
  
  var searchableItem : CSSearchableItem {
    let item = CSSearchableItem(uniqueIdentifier: id.UUIDString, domainIdentifier: shoppingListDomainID, attributeSet: searchableAttributeSet)
    return item
  }
}

extension DataStore {
  func indexAllShoppingLists() {
    indexShoppingLists(shoppingLists)
  }
  
  func indexShoppingLists(shoppingLists: [ShoppingList]) {
    let shoppingListItems = shoppingLists.map { $0.searchableItem }
    CSSearchableIndex.defaultSearchableIndex().indexSearchableItems(shoppingListItems) {
      error in
      if let error = error {
        print("Error indexing shopping lists: \(error.localizedDescription)")
      } else {
        print("Indexing shopping lists successful")
      }
    }

  }
  
  func removeShoppingListIndex() {
    CSSearchableIndex.defaultSearchableIndex().deleteSearchableItemsWithDomainIdentifiers([shoppingListDomainID]) {
      error in
      if let error = error {
        print("Error destrying index: \(error.localizedDescription)")
      } else {
        print("Successfully removed shopping list index")
      }
    }
  }
}
