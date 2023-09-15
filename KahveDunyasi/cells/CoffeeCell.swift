//
//  CoffeeCell.swift
//  KahveDunyasi
//
//  Created by Opendart Yazılım ve Bilişim Hizmetleri on 7.05.2023.
//

import UIKit
// reactive programlamayla rxswift kütüphanesini kullanarak kodla daha hızlı ve verimli işler yapabiliyoruz
// observer design pattern de bi objeyi gözlemleyenler vardı o objede değişiklik olduğunda gözlemleyenlere bakın bende bu değişiklik oldu size bunu bildiricem gibi bi yapı vardı. reactive programming de de böyle bi durum var
// reactive programlama veri akışları ve değişikliklerin sisteme yayılması(propagation of change) ile ilgilenen declarative bir programlama paradigmasıdır. rxswift slaytında detaylar var
// ana uygulama bi görevi yürütürken donma gibi yavaşlamaları kullanıcıya yansıtmadan sorunsuz bi kullanıcı deneyimi sunmayı sağlar. uzun süren bir işlem farklı bir iş parçacığında yapılır ve tamamlandığında ana iş parçacığına bildirilir. bu iş parçacıkları thread lerle ilgili. her ekranımızın bağlı olduğu bi main thread i(iş parçacığı) vardır. bu iş parçacığınun içerisinde farklı iş parçacıkları açıp o sayfada birden fazla işlemi başlatabiliyoruz.
// slaytta rxswift in ikinci sayfası - buradaki next fonksiyonu kendisine abone olan observerlar için bi veri sunar. yani bi array in içindeki elemanları hesaplama yapmak istediğimiz zaman observable ı observer larla önce subscribe oluyoruz. next fonksiyonu da kendisine abone olan observerlar için bi veri sunuyo. complete fonksiyonu ise artık veri akışının sonlandığını bildirir ve aynı return deyimi gibi kendinden sonra gelecek ifadeleri çalıştırmadan fonksiyondan çıkar. her bir observer ın ise next, error ve complete fonksiyonları bulunabilir. yani bi sonraki yapıcağım iş ne bi sonraki yapıcağım iş ne gibi bi akış var. yapamadığı zaman bi error bittiği zaman complete değerlerini alır
// dispose bag rxswift in arc ve bellek yönetimi ile başa çıkmasına yardımcı olan ek bi araçtır. yani bütün bu işlemler belli bi sırada asenkron yapılıyor dolayısıyla kullandığımız nesneler, ram de yönetilmesi, işlemler bittiğinde ram in temizlenmesiyle ilgili dispose bag dediğimiz nesne üzerinden deinit() fonksiyonu çağırıldığında observerlardan da düzgün bi şekilde kurtulmak için dispose bag aracını kullanırız. mesela bir tane thread de yapılacak işlem var onu yönetebiliyosunuz ama 10 tane işlem başladığında bunların sağı solu belli olmayabilir yani işlem devam ediyo olabilir onun bitip bitmediğini algılayamayabiliriz. dispose bag de bu aracı kullanarak belleğin normal hale gelmesini sağlıyor
// backend tarafında microservice dediğimiz şeyler var. bi ön gözümüz var, veritabanı katmanımız var, o veritabanından verileri çeken business katmanımız var. yani 3 katmanlı mimariler var. her yeni talep geldiğinde bu sisteme yük getiriyo bi sorun olduğunda çözmek çok zor o yüzden microservice dediğimiz mimariyle her şeyi stonik? prensiplerine göre ayırma yaklaşımı ortaya çıktı. netflix gibi büyük şirketler microservice i kullanıyor ama prime video diye de bi şey var. o da diyo ki ben microservice lerden vazgeçtim moletik? yapıya geçtim, maliyetimi de %90 düşürdüm diyor. şimdi de acaba her şey tekrar moletik e mi dönücek diye şeyler var, yani her şey bi anda asenkrondan senkron programlamaya da dönebilir diye anlattı bunu hoca. asenkronları yönetemiyoruz biz artık vs her şey bi anda değişebilir yazılım dünyasında
// infoplist e launch screen interface file base name i ekleyip yanına LaunchScreen ve main stoaryboard file base name i ekleyip yanına Authorization yazıyoruz. stoaryboard name kısmını da info dan siliyoruz. bunları yapınca uygulama açılırken önce launchscreen görünecek
class CoffeeCell: UITableViewCell {
  @IBOutlet weak var iconImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  
  func configure(with coffee: Coffee) {
    iconImageView.image = UIImage(named: coffee.icon)
    nameLabel.text = coffee.name
  }
}
