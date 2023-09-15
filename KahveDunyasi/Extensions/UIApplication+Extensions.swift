//
//  UIApplication+Extensions.swift
//  KahveDunyasi
//
//  Created by Opendart Yazılım ve Bilişim Hizmetleri on 7.05.2023.
//

import UIKit

extension UIApplication {
  class func changeRoot(with viewController: UIViewController) {
    guard let window = UIApplication.shared.keyWindow else {
      return
    }
    
    guard let rootViewController = window.rootViewController else {
      return
    }
    
    viewController.view.frame = rootViewController.view.frame // kendisine bi viewcontroller geldiğinde gelen controller ı root olarak belirliyor
    viewController.view.layoutIfNeeded()
    
    UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
      window.rootViewController = viewController
    }, completion: nil)
  }
}
