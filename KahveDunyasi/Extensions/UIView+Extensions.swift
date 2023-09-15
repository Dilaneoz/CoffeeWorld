//
//  UIView+Extensions.swift
//  KahveDunyasi
//
//  Created by Opendart Yazılım ve Bilişim Hizmetleri on 7.05.2023.
//

import UIKit

extension UIView {
  @IBInspectable // normalde bi view ın kenarlarını yuvarlak yapmak vs istediğimizde ilgili view ı mainde(sağda kart gibi gözüken butonun altındaki "user defined runtime attributes" kısmında artıya basarak) düzenlemek gerekiyor. @IBInspectable bunu kodla yapabilmemizi sağlar
  var cornerRadius: CGFloat {
    get {
      return layer.cornerRadius
    }
    set {
      layer.cornerRadius = newValue
      layer.masksToBounds = newValue > 0
    }
  }
  
  @IBInspectable
  var borderWidth: CGFloat {
    get {
      return layer.borderWidth
    }
    set {
      layer.borderWidth = newValue
    }
  }
  
  @IBInspectable
  var borderColor: UIColor? {
    get {
      let color = UIColor(cgColor: layer.borderColor!)
      return color
    }
    set {
      layer.borderColor = newValue?.cgColor
    }
  }
}
