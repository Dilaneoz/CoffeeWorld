//
//  CurrencyFormatter.swift
//  KahveDunyasi
//
//  Created by Opendart Yazılım ve Bilişim Hizmetleri on 7.05.2023.
//

import Foundation

enum CurrencyFormatter { // CurrencyFormatter sepetteki ürünleri, fiyatlarını formatlayarak bize getiricek
  static let turkishLirasFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.locale = Locale(identifier: "tr_TR")
    return formatter
  }()
}

extension NumberFormatter {
  func string(from float: Float) -> String? {
    return self.string(from: NSNumber(value: float))
  }
  
  func string(from int: Int) -> String? {
    return self.string(from: NSNumber(value: int))
  }
}
