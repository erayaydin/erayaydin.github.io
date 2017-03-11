---
layout: post
title:  "Linux Oxygine C++ Game Framework Kurulumu"
description: Linux ortamı için Oxygine C++ Game Framework'un kurulumu ile ilgili bir makaledir. Kurulum adımlarını takip ederek bir geliştirme ortamına sahip olacağız.
date: 2015-04-08 12:00:00
tags:
  - C++
  - game-development
categories:
  - C++
  - game-development
slug: oxygine-framework
---

Linux ortamı için Oxygine C++ Game Framework'un kurulumu ile ilgili bir makaledir. Kurulum adımlarını takip ederek bir geliştirme ortamına
sahip olacağız.

## Proje Dizinini Oluşturma

Öncelikle kendimize bir çalışma ortamı oluşturmamız gerekiyor. İstediğiniz bir dizinde uygulama klasörü açın. Makalede bu oluşturduğunuz dizine
`root` diyeceğiz.

## Oxygine Framework İndirme

C++ ile 2D oyun geliştirirken kullanacağımız Oxygine Framework'u [buradan](http://oxygine.org/download.php) indirebilirsiniz.

> Sayfada bize lazım olacak link `Download stable snaphot. Oxygine framework only.` kısmıdır. Yani sadece framework'u indirseniz yeterli. Diğer
linklerde önceden derlenmiş `binary` dosyaları bulunur. Bunlara ihtiyacımız yok.

İndirdiğiniz sıkıştırılmış dosyayı açın. `oxygine-framework` klasörünü `root` klasörü içerisine yapıştırın.

Yeni klasör yapımız şu şekilde oldu.

```bash
├─root
├─└ oxygine-framework
├───└ 3rdPartyTools
├───└ cmake
├───└ libs
├───└ ...
```

## SDL Kurulumu

Oxygine, **SDL** kütüphanesini kullandığı için mecburen onu da yüklememiz gerekiyor.

SDL'in [yükleme sayfasında](http://libsdl.org/hg.php) en alt kısmında bulunan `.tar.gz` uzantılı sıkıştırılmış dosya işimize yarayacaktır.

İndirdiğiniz sıkıştırılmış dosyayı açın ve `SDL-X.X.X-XXXX` isimli klasörü `root` klasörü içerisine yapıştırın. Klasör ismini `SDL` olarak
değiştirin.

Terminal ile `root/SDL` klasörüne erişin ve şu komutları gerçekleştirin.

```bash
./configure
mkdir build
cd build
cmake ../
make
sudo make install
```

## Oxygine Framework'a SDL Entegre Etme

Oxygine Framework'un SDL'i kullanabilmesi için kütüphane dosyalarını Oxygine Framework içerisine yerleştirmemiz gerekiyor.

`root/SDL/build` içerisindeki

- libSDL2-2.0.so
- libSDL2-2.0.so.0
- libSDL2-2.0.so.0.4.0
- libSDL2.so

dosyalarını `root/oxygine-framework/libs` klasörüne taşıyın/kopyalayın.


## Kurulum Testi

Kurulumu başarıyla yapıp yapmadığımızı kontrol etmek için `root/oxygine-framework/examples/Demo/proj.cmake/` klasörüne gelin ve şu komutu
çalıştırın.

```bash
sudo chmod +x run.sh
sudo ./run.sh
```