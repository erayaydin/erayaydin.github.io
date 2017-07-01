---
layout: post
title:  "Geliştirme Ortamım"
description: Hazırladığım geliştirme ortamı ile olabildiğince hafif ve hızlı bir ortam sağladım.
date: 2016-05-21 19:22:00
tags:
  - linux
categories:
  - linux
  - arch-linux
slug: linux-gelistirme-ortamim
---

Bu yazıda hazırladığım geliştirme ortamını araçlar ve dağıtımla birlikte anlattım.

![Empty Screen](/assets/images/posts/arch-linux-empty-screen.jpg)

## TL;DR

![ranger-irssi-mutt](/assets/images/posts/arch-linux-ranger-irssi-mutt.jpg)

Eğer bütün yazıyı okumaya üşendiyseniz aşağıda özetlenmiş bir tablosu bulunmakta.

| Dağıtım | **Arch Linux** |
| Dosya Yöneticisi | **ranger** |
| Display Manager | **lightdm** |
| Window Manager | **i3** |
| Bar | **polybar** |
| Metin Editörü | **vim**, **sublime text** |
| IRC İstemcisi | **irssi** |
| E-Posta İstemcisi | **mutt** |
| Tarayıcı | **elinks**, **chromium** |
| Video Oynatıcı | **vlc** |
| CD/DVD Aracı | **brasero** |
| Disk Kullanım Analizi | **baobab** |
| Disk Temizleme Aracı | **bleachbit** |
| Sistem Kullanımı Aracı | **htop** |
| Ofis Araçları | **LibreOffice** |
| Terminal | **terminator** |
| Sanallaştırma | **virtualbox** |
| Markdown Editör | **remarkable** |
| Torrent İstemcisi | **transmission** |
| Yayın | **OBS** |
| Resim Görüntüleyici | **feh** |
| Müzik Oynatıcı | **cmus** |
| Ekran Yönetimi | **arandr** |
| FTP | **filezilla** |
| Webserver | **LAMP Stack** |
| API Test Aracı | **postman** |
| PHP IDE | **PHPStorm** |
| C/C++ IDE | **CLion** |
| Python IDE | **PyCharm** |

## İşletim Sistemi

Geliştirme ortamımda işletim sistemi olarak **GNU/Linux** ve **Arch Linux** dağıtımını kullandım. Arch Linux dağıtımını
seçmemdeki sebepler şu şekilde.

- **Lightweight** - Olabildiğince hafifletilmiş bir halde. Gereksiz paket ve program bolluğu yok.
- **Topluluk ve Wiki** - Her türlü sorunda kolayca çözüm bulabileceğiniz bir wikiye sahip ve IRC/Mailing ile diğer
geliştiricilere ulaşıp sorununuzun çözümü hakkında yardım alabiliyorsunuz.
- **AUR** - Resmi depolarda paket bulunmadığı zaman diğer kullanıcıların oluşturduğu _PKGBUILD_ üzerinden programların
kurulumunu sağlayabiliyorsunuz. NPM veya Pip gibi paketleri de içerisinde bulundurduğu için tek sistem üzerinden tüm
paketlerinizi güncelleyebiliyorsunuz.
- **Trusted User** - _AUR_ üzerinden sizin açtığınız paketler yeterli kullanıma ulaştığında resmi depolara da
ulaşabiliyor ve dağıtımın geliştirilmesine katkı sağlayabiliyorsunuz. Bu da yükselme imkanı demek oluyor.
- **Rolling Release** - Full Rolling olarak dağıtımını gerçekleştiren _Arch Linux_, paketlerin dağıtımını ikiye
ayırmadan ufak düzenlemeler dahi olsa sürekli güncel tutmanızı sağlıyor.

## Grafiksel Arayüz

İstenilen masaüstü veya pencere yönetim sistemi kullanılabiliyor. Benim tercihim **Window Manager** oldu. Tamamen klavye
ile yönetilebilir olması ve kat kat **lightweight** olması işlerimi kolaylaştırıyor.

Window Manager olarak _2bwm_, _openbox_, _awesome_ ve _i3_ kullandım. Bunlardan **i3** benim daha çok hoşuma
gitti. Ayarlamaların tamamen kullanıcı tarafından olması ve ayar dosyasının olabildiğince yalın olması bu tercihe itti.

Display Manager olarak **lightdm** tercihi yaptım. Yakın bir zamanda **CLI** bir display manager kullanmayı düşünüyorum.

### Bar

Çalışma ortamlarını, sistem değerlerini ve _tray_ ikonları görmek için bir bar yazılımı seçmem gerekti. Daha önce
_xfce4 bar_, _polybar_, _i3bar_ ve _i3blocks_ kullanmıştım. Tercihim ilk başta i3bar olmuştu fakat yeterli
 gelmediği için daha sonra **polybar** kullanımına geçtim. Olabildiğince renkli ve özelleştirilebilir bir yapısı var.

### Ağ

Komut satırından ağa bağlanmayı sevmediğim için **Network Manager** tercih ettim. Polybar üzerinden erişebilmek için
kendi _applet_ ini kullanıyorum.

## Araçlar

### Dosya Yöneticisi

Dosya yöneticisi olarak **ranger** kullanıyorum. Kullanımı _vim_ benzeri olduğu için işlem yapmak ve gezinmek oldukça
kolay.

### Metin Editörü

Konsoldan yapacağım işler için **vim** kullanıyorum. Eğer yapacağım iş çoklu dosyalarda hakimiyet istiyorsa
**sublime text** tercih ediyorum.

### IRC Client

IRC sunucularına ve odalarına bağlanmak için **irssi** kullanıyorum. Hafiflik konusunda gerçekten çok iyi.

### Mail Client

E-Postalarımı kontrol etmek için **mutt** kullanıyorum.

### Tarayıcı

Bu konuda malesef lightweight tercihi yapamıyorum. İş gereği webkit bir tarayıcı kullanmam gerekiyor. Bu sebeple
**chromium** kullanıyorum. Fakat terminalden webe erişmek istediğim durumlar için **elinks** kullanıyorum.

### Video Oynatıcı

Bu konuda da lightweight tercih yapılmasının saçma olduğunu düşünüyorum. Bu sebeple **vlc** kullanıyorum.

### DVD/CD Aracı

Disk işlemleri için **Brasero** kullanıyorum.

### Disk Kullanım Analizi

Disk kullanımının analizini yapmak için **baobab** kullanıyorum.

### Sistem Kullanımı

Sistem kullanımının analizi için **htop** kullanıyorum.

### Ofis Araçları

Döküman ve tablolar için **LibreOffice** kullanıyorum.

### Sanallaştırma

Aktif olarak kullandığım bir başka sanal makine yok fakat gerektiğinde kullanmak için **VirtualBox** tercih ediyorum.

### Yayın

Broadcast işlemi için **OBS** kullanıyorum.

### Markdown Editor

Markdown yazıları için **Remarkable** kullanıyorum.

### Terminal

Terminal aracı olarak **terminator** kullanıyorum. Program içerisinde pencere ayırma fonksiyonu oldukça işime yarıyor.

### Torrent İstemci

Torrent client olarak **Transmission** kullanıyorum.

### Resim Görüntüleyici

Resim görüntüleyici olarak **feh** kullanıyorum.

### Müzik Oynatıcı

Müzik oynatıcı olarak **cmus** kullanıyorum. vim benzeri bir kullanımı olması rahatlık veriyor.

### Diğer Araçlar

Ekstra ekranların yönetimi için **arandr**, gereksiz dosyaların temizleme işlemini otomatikleştirmek için **bleachbit**,

## Geliştirici Araçları

### PHP IDE

PHP IDE olarak **PHPStorm** kullanıyorum.

### C/C++ IDE

C ve C++ geliştirmeleri için **CLion** kullanıyorum.

### Python IDE

Python geliştirmeleri için **PyCharm** kullanıyorum.

### FTP

FTP için **Filezilla** kullanıyorum. Yakın bir zamanda daha lightweight bir araç tercih edeceğim.

### Webserver

Web server olarak **LAMP Stack** kullanıyorum.

### API

API'leri test etmek için **postman** kullanıyorum.
