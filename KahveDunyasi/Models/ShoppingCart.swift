//
//  ShoppingCart.swift
//  KahveDunyasi
//
//  Created by Opendart Yazılım ve Bilişim Hizmetleri on 7.05.2023.
//

import Foundation
import RxSwift
import RxCocoa

class ShoppingCart { // ShoppingCart class ını singleton olarak tanımlıyoruz
  
  static let shared = ShoppingCart()
  
  var coffees: BehaviorRelay<[Coffee: Int]> = .init(value: [:]) // 1. BehaviorRelay gözlemlediğimiz şey. sepetteki bir ürünün değeri arttığında, yeni bi ürün eklendiğinde, buradaki değişiklikleri ona abone olanlara da bildirmek için BehaviorRelay ile bunu kontrol ediyoruz
  
  private init() {}
  
  func addCoffee(_ coffee: Coffee, withCount count: Int) {
    var tempCoffees = coffees.value // 2
    
    if let currentCount = tempCoffees[coffee] {
      tempCoffees[coffee] = currentCount + count
    } else {
      tempCoffees[coffee] = count
    }
      
    // sepete eklediğimizde coffee array ine o anki gelen objeyi ekliycez çıkar dediğimiz zaman çıkarıcaz
      
    coffees.accept(tempCoffees) // 3
  }
  
  func removeCoffee(_ coffee: Coffee) {
    var tempCoffees = coffees.value // 4
    tempCoffees[coffee] = nil
    
    coffees.accept(tempCoffees) // 5
  }
  // reduce un görevi azaltmak değil burada, sonucu dönüyor aslında. yani kümülatif olarak hesaplamak
  // sepetteki ürünlerin toplam ne kadar toplam fiyatı varsa o anki ürünün fiyatıyla çarpıp değerini bize <Observable<Float> şeklinde geri dönücek
  func getTotalCost() -> Observable<Float> { // 6. burada fiyatıyla adedini çarpıyor toplam fiyatını yapıyor
    return coffees.map { $0.reduce(Float(0)) { $0 + ($1.key.price * Float($1.value)) }} // 7
  } // key.price değerini hesaplar
    
  // sepetteki ürünlerin toplam adedi
  func getTotalCount() -> Observable<Int> { // 8
    return coffees.map { $0.reduce(0) { $0 + $1.value }} // 9
  }
    
  // sepetteki ürünlerin item ını veriyor
  func getCartItems() -> Observable<[CartItem]> { // 10
    return coffees.map { $0.map { CartItem(coffee: $0.key, count: $0.value) }} // 11
  }
}
