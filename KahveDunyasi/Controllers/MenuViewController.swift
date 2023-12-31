//
//  MenuViewController.swift
//  KahveDunyasi
//
//  Created by Opendart Yazılım ve Bilişim Hizmetleri on 7.05.2023.
//

import UIKit
import RxSwift
import RxCocoa

class MenuViewController: BaseViewController {
  
  @IBOutlet private weak var tableView: UITableView!
  
  private let disposeBag = DisposeBag()
  
  private lazy var shoppingCartButton: BadgeBarButtonItem = { // BadgeBarButtonItem ile kendimiz özel custom bi buton oluştururuz. sağ üst köşede kalp ikonu falan mesela bi BadgeBarButtonItem. ikonun üzerine gelicek label ı burada ekleyebiliyoruz. sepetin üstünde kullanıcı kaç ürün eklediyse o kadar sayı gözükecek. label la ilgili işlemleri BadgeBarButton+Extensions kısmında yazıyoruz
    let button = BadgeBarButtonItem(image: "cart_menu_icon", badgeText: nil, target: self, action: #selector(shoppingCartButtonPressed))
    
    button!.badgeButton!.tintColor = Colors.brown
    
    return button!
  }()
  
  private lazy var coffees: Observable<[Coffee]> = { // her coffee nin constructor ına kahvenin adı ikonu ve fiyatını yazdığımız içine kahve tipinde veri alan gözlemlenebilir bir array
    let espresso = Coffee(name: "Espresso", icon: "espresso", price: 4.5)
    let cappuccino = Coffee(name: "Cappuccino", icon: "cappuccino", price: 11)
    let macciato = Coffee(name: "Macciato", icon: "macciato", price: 13)
    let mocha = Coffee(name: "Mocha", icon: "mocha", price: 8.5)
    let latte = Coffee(name: "Latte", icon: "latte", price: 7.5)
    
    return .just([espresso, cappuccino, macciato, mocha, latte])
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.rightBarButtonItem = shoppingCartButton
    
    configureTableView()
    
    // Rx - Setup
    
    // 1
    // normalde her cell de ne gözükecek ne yazacak söylemek için delegate ları kullanırdık, reactive programlamayla bunlara gerek kalmadan aşağıdaki kodlarla hallediyoruz
    coffees
      .bind(to: tableView // normalde reactive programlama ile alamofire dan ya da bi array den verileri çek diyoduk. burada da coffees array indeki verileri tableview e bind et yani doldur diyoruz, doldururken cell in adına coffeeCell adını veriyoruz
        .rx // 2
        .items(cellIdentifier: "coffeeCell", cellType: CoffeeCell.self)) { row, element, cell in // 3. identifier ı coffeeCell olan cell e, "row, element, cell"  yani bi döngüyle sana gelen eleman kadar çizdir
        cell.configure(with: element) // 4
      }
      .disposed(by: disposeBag) // 5. burayaki kadarki kodlarla delegate lere gerek kalmadan hallediyoruz. yani bu kadar kodla gelen verilerle cell i doldurabiliyoruz
    
    tableView
      .rx // 1
      .modelSelected(Coffee.self) // 2
      .subscribe(onNext: { [weak self] coffee in // 3
        self?.performSegue(withIdentifier: "OrderCofeeSegue", sender: coffee) // 4
        
        if let selectedRowIndexPath = self?.tableView.indexPathForSelectedRow { // 5
          self?.tableView.deselectRow(at: selectedRowIndexPath, animated: true)
        }
      })
      .disposed(by: disposeBag) // 6
    
    ShoppingCart.shared.getTotalCount()
      .subscribe(onNext: { [weak self] totalOrderCount in
        self?.shoppingCartButton.badgeText = totalOrderCount != 0 ? "\(totalOrderCount)" : nil
      })
      .disposed(by: disposeBag)
  }
  
  private func configureTableView() {
    tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude))
    tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude))
    tableView.rowHeight = 104
  }
  
  @objc private func shoppingCartButtonPressed() {
    performSegue(withIdentifier: "ShowCartSegue", sender: nil)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let coffee = sender as? Coffee else { return }
    
    if segue.identifier == "OrderCofeeSegue" {
      if let viewController = segue.destination as? OrderCoffeeViewController {
        viewController.coffee = coffee
        viewController.title = coffee.name
      }
    }
  }
}
