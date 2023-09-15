//
//  LoginViewController.swift
//  KahveDunyasi
//
//  Created by Opendart Yazılım ve Bilişim Hizmetleri on 7.05.2023.
//

import UIKit
import RxSwift
import RxCocoa
// reactive programlamayla rxswift kütüphanesini kullanarak ilgili text boş mu değil mi kontrolünü yapıyor.
class LoginViewController: UIViewController {
    @IBOutlet private weak var emailTextfield: UITextField!
    @IBOutlet private weak var passwordTextfield: UITextField!
    @IBOutlet private weak var logInButton: UIButton!

    
    private let disposeBag = DisposeBag() // gözlemi yapılan objelerin ram den temizlenmesiyle ilgili
    private let throttleInterval = 0.1 // örneğin search ekranına bişi yazdığımızda sürekli bastığımızda istek gitmesin bir saniye sonra gitsin. yani saniyenin 1/10 unda kontrol etmeye çalışıyoruz
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // throttleInterval email in içine bi değer girildi mi girilmedi mi onun kontrolünü yapar
        let emailValid = emailTextfield
          .rx // rxswift i temsil eder
          .text // 1
          .orEmpty // 2
          .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
          .map { self.validateEmail(with: $0) } // 3
          .debug("emailValid", trimOutput: true) // 4
          .share(replay: 1) // 5
        
        let passwordValid = passwordTextfield.rx.text.orEmpty // password un içindeki değer boş mu değil mi
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
          .map { $0.count >= 6 } // girilen karakter 6 ya büyük eşit mi öyleyse geçerli
          .debug("passwordValid", trimOutput: true)
          .share(replay: 1)
        
        let everythingValid = Observable // burada hem email i hem password u gözlemliyor, onlardaki değişiklikleri takip ediyor
          .combineLatest(emailValid, passwordValid) { $0 && $1 } // 1
          .debug("everythingValid", trimOutput: true)
          .share(replay: 1)
        
        everythingValid
          .bind(to: logInButton.rx.isEnabled) // 1. eğer her şey doğruysa ilgili butonu enable yapıcak
          .disposed(by: disposeBag) // 2. tüm işlemler bittiğinde bunların ram den temizlenmesiyle ilgili
    }
    
    private func validateEmail(with email: String) -> Bool { // geçerli bi email girildi mi kontrol ediyoru<
      let emailPattern = "[A-Z0-9a-z._%+-]+@([A-Za-z0-9.-]{2,64})+\\.[A-Za-z]{2,64}" // bizim istediğimiz pattern e uygun mu. (regular expression deniyor-regex) bu değerler bi email ya da telefon numarasının formata uygun olup olmadığını kontrol eder
      let predicate = NSPredicate(format:"SELF MATCHES %@", emailPattern)
      
      return predicate.evaluate(with: email) // uyuyosa true ya da false şeklinde bi değerle kontrol ediyor
    }
    
    @IBAction private func logInButtonPressed() { // işlem başarılıysa login olunduysa reactive programlamayla kullanıcının geçerli mail adresi girip girmediğini vs kontrol ettiysen kullanıcıyı main e yönlendir diyoruz. reactive programlamayla onun kontrolü yapılıyor
      let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
      let initialViewController = mainStoryboard.instantiateInitialViewController()!
      
      UIApplication.changeRoot(with: initialViewController)
    }

}
