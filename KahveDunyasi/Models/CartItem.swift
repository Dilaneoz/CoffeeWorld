//
//  CartItem.swift
//  KahveDunyasi
//
//  Created by Opendart Yazılım ve Bilişim Hizmetleri on 7.05.2023.
//

import Foundation
struct CartItem {
  let coffee: Coffee
  let count: Int
  let totalPrice: Float
  
  init(coffee: Coffee, count: Int) {
    self.coffee = coffee
    self.count = count
    self.totalPrice = Float(count) * coffee.price
  }
}
