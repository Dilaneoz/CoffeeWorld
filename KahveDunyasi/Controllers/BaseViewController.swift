//
//  BaseViewController.swift
//  KahveDunyasi
//
//  Created by Opendart Yazılım ve Bilişim Hizmetleri on 7.05.2023.
//

import Foundation
import UIKit
class BaseViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupNavigationBar()
  }
  
  private func setupNavigationBar() {
    if let navController = navigationController { // navigationController ı kodla ekliyoruz
      
      // Set Navigation Bar
      navController.navigationBar.setBackgroundImage(UIImage(), for: .default)
       navController.navigationBar.shadowImage = UIImage(color: Colors.lightGray)
      navController.navigationBar.isTranslucent = false
      navController.navigationBar.titleTextAttributes = [
        .font: UIFont.systemFont(ofSize: 22, weight: .semibold),
        .foregroundColor: Colors.brown
      ]
    }
  }
}
