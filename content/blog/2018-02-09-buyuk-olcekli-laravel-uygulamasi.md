+++
title = "Büyük Ölçekli Projelerde Laravel Uygulaması"
description = "Büyük ölçekli projerlerde Laravel üzerinde neler yapılabilir"
date = "2018-02-09 11:00:00"
slug = "buyuk-olcekli-projelerde-laravel-uygulamasi"
tags = ["php", "laravel"]
categories = ["php", "laravel"]
+++
Laravel Framework ile birçok proje geliştiriyoruz. Lakin büyük çaplı yani 
kalabalık projelerde Laravel üzerine geliştirmeler yapılması oldukça zor.

Birçok kesimden şu sözü duymuşsunuzdur: "**Laravel kendi yapınızı uygulamanıza 
imkan vermiyor**". Lakin durum o şekilde değil. Tasarım desenleri ile 
profesyonel bir sistem geliştirdiğinizde **Laravel**'in aksine daha büyük 
imkan sağladığını görüyorsunuz. Diğer bir şekilde ifade etmek gerekirse, 
**spagetti** kodlamayla zaten **tasarım desenlerine sahip** bir yapı üzerine 
kendi yapınızı inşa etmek mümkün değil.

Lafı daha fazla uzatmadan konuya geçmek istiyorum yalnız şu hatırlatmayı 
yapmamda yarar var. Burada bahsedilen **büyük ölçek** 60-70'ten fazla _model_ 
sınıflarının olması ve yapının bir çok küçük parçadan oluşmasıdır. Yaptığınız 
proje eğer **küçük** veya **orta** ölçekli ise Laravel'in kendi yapısının 
üzerine çıkmanıza gerek yok. Bu sizin **üretkenliğinizi** oldukça düşürecektir.

# Laravel'in Kendi Yapısı

Büyük ölçekli yapıda kullanabileceğimiz desenlere geçmeden önce Laravel'in 
kendi yapısını tekrar gözden geçirelim. Aşağıdaki yapı **Laravel 5.6** 
sürümünden. Bu yapı hakkında kafanıza takılan bir kısım yoksa diğer konu 
başlığına hızlıca geçiş yapabilirsiniz.

```bash
.
├── app
│   ├── Broadcasting
│   ├── Console
│   ├── Events
│   ├── Exceptions
│   ├── Http
│   ├── Jobs
│   ├── Listeners
│   ├── Mail
│   ├── Notifications
│   ├── Policies
│   ├── Providers
│   ├── Rules
│   └── User.php
├── bootstrap
│   ├── app.php
│   └── cache
├── config
├── database
│   ├── factories
│   ├── migrations
│   └── seeds
├── public
├── resources
│   ├── assets
│   ├── lang
│   └── views
├── routes
│   ├── api.php
│   ├── channels.php
│   ├── console.php
│   └── web.php
├── storage
├── vendor 
└── tests
```

**/app Dizini**

Burada belirtilen `app` klasörü uygulama kodlarımızın bulunduğu dizindir.

**/bootstrap Dizini**

Çatımızın asıl başlangıç noktasıdır. Laravel Framework'ün kendi yapısını 
başlattığı ve _cache_ klasörünü oluşturduğu kısımdır.

**/config Dizini**

İsminden de anlaşıldığı gibi ayarların tutulduğu dizindir. Ayar bilgileri bu 
dizindeki dosyalardan elde edilmektedir. Gizli(Secret) bilgileri de `dotenv` 
aracılığıyla burada sisteme dahil edilmektedir.

**/database Dizini**

Veritabanı yapısı ile ilgili işlemlerin tutulduğu dizindir. **migrations**, 
**factories** ve **seeds** burada bulunmaktadır.

**/public Dizini**

Dış isteklerin yapıldığı başlangıç noktasıdır. Ek olarak isteklerde servis 
edilecek **asset** dosyaları (hazırlanmış _css_, _js_, _resim_ dosyaları gibi) 
burada tutuyoruz.

**/resources Dizini**

`resources` dizini **presentation** yani ön tarafta kullanıcıya göstereceğimiz 
verileri hazırladığımız kısımdır. **views**, **derlenecek asset dosyaları** ve 
dil dosyaları örneğin burada tutulur.

**/routes Dizini**

`routes` dizini içerisinde herhangi bir ortamdan gelen isteğin nerede 
karşılık bulunduracağını belirtiriz. Burada ortamdan kasıt, **web** isteği 
olabildiği gibi **websocket** istekleri de olabilir.

**/storage Dizini**

`storage` dizini içerisinde isminden de anlaşılabildiği gibi saklamak 
istediğimiz dosyaları tutmaktayız. Bunların içerisinde **framework** tarafından 
hazırlanan dosyalar(örneğin _log_) olduğu gibi kendimizin de tutmak istediği 
dosyalar(örneğin bir müzik sitesi için _müzik dosyaları_) da olabilir.

**/tests Dizini**

PHPUnit ile çalıştırmak istediğimiz testleri bu dizin içerisinde oluşturuyoruz.

**/vendor Dizini**

Composer bağımlılıklarımızın tutulduğu dizin.

**/app/Broadcasting Dizini**

Örneğin **Websocket** üzerinden yaptığımız gerçek zamanlı istekler/etkinlikler 
burada kontrol altında tutulmaktadır. 

**/app/Console Dizini**

Artisan için oluşturduğunuz komutların tutulduğu dizindir. Bu komutlar tek 
seferlik işlemlerde kullanılabileceği gibi **schedule** hazırladığınız zamanlı 
görevler de olabilir.

**/app/Events Dizini**

Herhangi bir olay durumunda yaptırmak istediğiniz işlemleri tanımladığınız 
sınıfları tutan dizindir.

**/app/Exceptions Dizini**

Uygulamaya özel oluşturduğunuz hata sınıflarını oluşturduğunuz dizindir.

**/app/Http Dizini**

HTTP istekleriyle ilgili yapılması gerekenleri tutan dizindir. **Controller**, 
**Middleware** ve **Requests** burada tutulur.

**/app/Jobs Dizini**

Senkron veya Asenkron olarak tanımladığımız **iş**leri burada tutmaktayız.

**/app/Listeners Dizini**

Oluşturduğunuz **Event**ler sonucunda yapılması gereken işlemleri burada 
tanımlamaktasınız. Örneğin `UserLicenseFinished` etkinliği(event) sonucunda 
`TerminateUser` ve `SendTerminatedUserEmail` listenerlarını burada 
oluşturabilirsiniz.

**/app/Mail Dizini**

Uygulama tarafından gönderilecek e-postaları inşa edecek sınıfları bu dizinde 
tutmaktayız.

**/app/Notifications Dizini**

Çeşitli bildirim gönderme ortamları(SMS, E-Posta ve Slack gibi) için 
bildirimleri inşa ettiğimiz sınıfları oluşturduğumuz dizindir.

**/app/Policies Dizini**

Herhangi bir işlem için (Örneğin giriş veya api isteği) izin kontrol 
sınıflarını oluşturduğunuz dizindir.

**/app/Providers Dizini**

**ServiceProvider**ları tanımladığınız dizindir.

**/app/Rules Dizini**

Validate etmek istediğiniz veriler için oluşturduğunuz sınıfları tutan 
dizindir.

# Biraz Daha Serbest

Orta ölçekli bir projede bu yapının üzerine ufak değişiklikler elbetteki 
yapıyoruz. Örneğin **Models** isminde bir **namespace** üzerinde model 
sınıfları ayrı bir şekilde tutuyoruz. Ek olarak **Repositories** ve 
**Services** de ekliyoruz. 

**Repository Pattern**

Repository desenini tek bir makalede incelemek haksızlık olacaktır. Temel 
anlamda **veri üzerinde işlem yapan kısım** ile **veriye erişen kısmın** 
ayrılması diyebiliriz.

Buradaki **Services** kısmı ise **Repository** ile haberleşen kısmın da 
**uygulama katmanından** ayıran kısımdır. Bir örnek ile ilerlemek daha iyi 
olacaktır.

```php
namespace App/Repositories;

interface UserInterface {
  public function getUserById($userId);

  public function getUserByUsername($username);
}
```

```php
namespace App/Repositories;

class UserRepository implements UserInterface {
  protected $model;

  public function __construct(Model $model) {
    $this->model = $model;
  }

  public function getUserById($userId) {
    return $this->model->find($userId);
  }
  
  public function getUserByUsername($username) {
    return $this->model->where('username', strtolower($username))->first();
  }
}
```

```php
namespace App/Services;

class UserService {
  protected $repository;

  public function __construct(UserInterface $repository){
    $this->repository = $repository;
  }

  public function getUser($user) {
    if(is_numeric($user))
       return $this->repository->getUserById($user);
    else
       return $this->repository->getUserByUsername($user); 
  }
}
```

Bu örnek yapıda **Service** ve **Repository** kullanmış olduk. (Yapının 
çalışması için iki yapı için de **ServiceProvider** sınıflarını hazırlamanız 
gerekmektedir.)

Bu yapıda hiçbir sorun yok. Oldukça organize ve güzel bir yapı çıkmış oluyor. 
Lakin belirttiğim gibi **orta** ölçekli proje için uygun olacaktır. **Büyük** 
ölçekli projede bu yapı hayat kurtarmayacaktır.

Örneğin bu yapının sonunda **Models** dizinimize bakalım:

```bash
.
├── AklimaBaskaModelGelmedi.php
├── AnotherAnotherModel.php
├── AnotherModel.php
├── Comment.php
├── Gallery.php
├── Like.php
├── Note.php
├── Photo.php
├── Profile.php
├── Transaction.php
└── User.php
```

Uygulamamız üzerine eklediğimiz modüllerle bu Models dizini oldukça 
büyüyecektir. Bir alternatif olarak bu modülleri ayrı **namespace** üzerinde 
tutabilirsiniz. Lakin bir süre sonra bu da kurtarmayacaktır.

# Aklıma Bir Şeyler Geliyor Ama?

Bu aşamada aklınıza gelen yol büyük ihtimal, "**Hadi o zaman projeyi 
microservislere ayıralım**" olacaktır. Lakin bu iş o kadar kolay değil. 
Oluşturduğumuz büyük ölçekli yapıyı küçük küçük parçalara ayırmak oldukça 
zahmetli olacaktır. Temel olarak uygulayacağınız yol şu olur büyük ihtimal; 
Bir parçayı al ufak bir mikroservis uygulaması haline getir (apayrı bir proje 
olmuş oldu) ve uygulama üzerindeki projede gelen isteği bu mikroservise 
yönlendir. Bütün bu uğraş sonucunda da kazandığınız (!) sorunlar:

- Herhangi bir değişiklikte hata yapmanız muhtemel
- Yeni bir geliştirici anlamakta çok fazla zorlanacak ve ayrı ayrı parçalara 
bakmak zorunda kalacak.
- Çok fazla dosya
- Yeniden bir çözüm arayışı

# Bir Seçenek Daha Var O da "Domain Driven Design" Mı Dersin?

Elbette tek bir çözüm yolu yok. Yukarda bahsettiğim yapıları daha da 
geliştirebilir veya **HMVC** yapısına geçiş yapabilirsiniz. Her desenin 
**+** ve **-** leri var.

DDD'yi özetlemek gerekirse:

- **Application** yani uygulama: Controller, Middleware, Route
- **Domain** yani ana işi yapan işlev: Model, Repository, Policy vs.
- **Infrastructure** yani servisler: Email, Notification, Logging vs.
- **Interface** yani görünüş, gözüken kısım: Views, Lang, Assets nam-ı diğer 
Resources

Peki bu yapıda örnek Laravel dizini nasıl olabilir:

```bash
.
├── app 
│   ├── Account (Domain)
│   │   ├── AccessControlLists.php
│   │   ├── Auth.php
│   │   ├── Console
│   │   ├── Jobs
│   │   ├── Listeners
│   │   ├── Repositories
│   │   ├── Models
│   │   └── Validators
│   ├── Http (Application)
│   ├── Infrastructure
│   │   ├── Events
│   │   └── Exceptions
│   ├── Gallery (Domain)
│   └── Post (Domain)
├── bootstrap
│   ├── app.php
│   └── cache
├── config
├── database
│   ├── factories
│   ├── migrations
│   └── seeds
├── public
├── resources (Interface) 
│   ├── assets
│   ├── lang
│   └── views
├── routes
│   ├── api.php
│   ├── channels.php
│   ├── console.php
│   └── web.php
├── storage
├── vendor 
└── tests
```

Fark edebileceğiniz üzere DDD'de sadece **namespace** eklemekten başka bir 
durum yok.

# Sen Pala Vere Bırak Sonuç Göster

Sonuç yapıyı göstermek istersek şöyle bir yapı uygun olacaktır:

```bash
.
├── app
│   ├── Account
│   │   ├── AccessControlLists.php
│   │   ├── Auth.php
│   │   ├── Console
│   │   ├── Events
│   │   ├── Exceptions
│   │   ├── Jobs
│   │   ├── Listeners
│   │   ├── Models
│   │   ├── Repositories
│   │   └── Validators
│   ├── Gallery
│   ├── Http
│   │   ├── Controllers
│   │   └── Middleware
│   ├── Post
│   └── Providers
├── bootstrap
│   ├── app.php
│   └── cache
├── config
├── database
│   ├── factories
│   ├── migrations
│   └── seeds
├── public
├── resources
│   ├── assets
│   ├── lang
│   └── views
├── routes
│   ├── api.php
│   ├── channels.php
│   ├── console.php
│   └── web.php
├── storage
├── vendor 
└── tests
```

Elbette çok büyük ölçekte bir Laravel Uygulamasında bu yapı da yeterli 
olmayacaktır. 

Şimdi bir senaryo kuralım. Projemizde **Authentication** kısmı _mikroservis_ 
yapılması gerektiği ile ilgili bir karar alındı. Bu durumda bu yapıdaki bir 
projede tek yapılması gereken `Account` (domain) dizininin mikroservis olarak 
ayrılması. Komple bir değişiklik yapmaya gerek kalmadan sadece o modülü 
mikroservis çok rahat yapabiliriz. Çünkü domain dışındaki diğer tüm sınıflar 
`AccessControlLists` ve `Auth` sınıflarını biliyor ve kullanıyor. Bunları 
tutmak yeterli olacaktır. Mikroservisi hazırladıktan sonra ana projemizdeki 
dizin yapısı şu şekilde olacaktır:

```bash
.
├── app
│   ├── Account
│   │   ├── AccessControlLists.php
│   │   └── Auth.php
│   ├── Gallery
│   ├── Http
│   │   ├── Controllers
│   │   └── Middleware
│   ├── Post
│   └── Providers
├── bootstrap
│   ├── app.php
│   └── cache
├── config
├── database
│   ├── factories
│   ├── migrations
│   └── seeds
├── public
├── resources
│   ├── assets
│   ├── lang
│   └── views
├── routes
│   ├── api.php
│   ├── channels.php
│   ├── console.php
│   └── web.php
├── storage
├── vendor 
└── tests
```

Gördüğünüz gibi **uygulama kodlarımız** içerisinde bir değişiklik yapmadan 
modül olarak ayırmış ve mikroservis haline getirmiş olduk. Buradaki 
`AccessControlLists` ve `Auth` mikroservisimizle haberleşecektir.

Dikkat edilmesi gereken kısım ise, bu gibi senaryolara sahip olabileceğimiz 
için **Domain** içerisindeki haberleşen `Service` sınıflarımızın temel veri 
türlerini kullanması gerektiğidir. Örneğin, `array`, `string`, `int` ve 
`boolean` gibi. Herhangi bir sınıf belirtmeniz ayırma işlemi sonucunda sorun 
çıkartacaktır. Çünkü o sınıfı tanımıyor ve bilmiyor olacaktır.

# Bitiş

Yazı içerisinde elbetteki yanlışlarım olmuş olabilir. Yazıyı düzenleyerek 
hataları gidererek daha iyi bir makale haline getirebiliriz. Eklenmesini 
istediğiniz kısımları da yine aynı şekilde düzenleyerek **pull request** 
atabilirsiniz.
