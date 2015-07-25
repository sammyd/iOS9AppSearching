//
//  DataModel.swift
//  GreenGrocer
//
//  Created by Sam Davies on 23/07/2015.
//  Copyright © 2015 Razeware. All rights reserved.
//

import Foundation


protocol Serializable {
  
  init?(dict: [String : AnyObject])
  static func fromDictArray(array: [[String : AnyObject]]) -> [Self]?
  
  var dictRepresentation : [String : AnyObject] { get }
  
}

extension Serializable {
  static func fromDictArray(array: [[String : AnyObject]]) -> [Self]? {
    return array.flatMap { Self(dict: $0) }
  }
}