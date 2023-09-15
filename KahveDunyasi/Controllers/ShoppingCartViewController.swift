//
//  ShoppingCartViewController.swift
//  KahveDunyasi
//
//  Created by Opendart Yazılım ve Bilişim Hizmetleri on 7.05.2023.
//

import UIKit
import RxSwift
import RxCocoa

class ShoppingCartViewController: BaseViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var totalPriceLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
      super.viewDidLoad()
      
      configureTableView()
      // total cost sağ altta yazan sepetteki ürünlerin toplam fiyatı
      // Rx - Setup
      ShoppingCart.shared.getCartItems() // ShoppingCart sepetteki ürünleri gösterdiğimiz ve ilgili cell leri oluşturduğumuz kısım
        .bind(to: tableView.rx
          .items(cellIdentifier: "cartCoffeeCell", cellType: CartCoffeeCell.self)) { row, element, cell in
            cell.configure(with: element)
        }
        .disposed(by: disposeBag)
      
      ShoppingCart.shared.getTotalCost()
        .subscribe(onNext: { [weak self] totalCost in
          self?.totalPriceLabel.text = CurrencyFormatter.turkishLirasFormatter.string(from: totalCost) // tl ye çevrilmiş haliyle göstericek
        })
        .disposed(by: disposeBag)
      
      tableView.rx
        .modelDeleted(CartItem.self) // 1. burada sola kaydırınca silme işlemi yapılıyor
        .subscribe(onNext: { cartItem in // 2
          ShoppingCart.shared.removeCoffee(cartItem.coffee) // 3
        })
        .disposed(by: disposeBag) // buraya kadarki kısım sepetteki ürünleri gösterdiğimiz ve ilgili cell leri oluşturduğumuz kısım
    }
    
    private func configureTableView() {
      tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude))
      tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude))
      tableView.rowHeight = 104
    }
}
