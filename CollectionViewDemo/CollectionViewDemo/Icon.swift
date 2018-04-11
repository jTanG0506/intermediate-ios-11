//
//  Icon.swift
//  CollectionViewDemo
//
//  Created by Jonathan Tang on 11/04/2018.
//  Copyright © 2018 jtang0506. All rights reserved.
//

import Foundation

struct Icon {
  
  var name: String = ""
  var price: Double = 0.0
  var isFeatured: Bool = false
  
  init(name: String, price: Double, isFeatured: Bool) {
    self.name = name
    self.price = price
    self.isFeatured = isFeatured
  }
  
}
