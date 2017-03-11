---
layout: post
title:  "Arch Linux - Ruby ve Jekyll Kurulumu"
description: Arch Linux dağıtımı için Ruby ve Jekyll kurulumu
date: 2015-09-24 01:58:00
tags:
  - linux
  - arch-linux
categories:
  - linux
  - arch-linux
slug: arch-linux-ruby-jekyll-kurulumu
---

## Ruby Kurulumu

Ruby ile birlikte artık RubyGems de kuruluyor. O yüzden ayrıca bir RubyGems kurulumu
yapmayacağız.

```bash
pacman -S ruby
```

## RubyGems Ayarlaması

RubyGems kurulu fakat gemlerin içerisindeki çalıştırılabilir dosyaları direk
çalıştıramıyoruz. Tam yol belirtmemiz gerekiyor. Bu sorunu çözmek için PATH dizinine
RubyGems yolunu ekleyeceğiz. `~/.bashrc` dosyasına şu eklemeyi yapalım.

```bash
PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
```

**Kurulu gemleri göster**mek için

```bash
gem list
```

**Bir gem ile ilgili bilgi al**mak için

```bash
gem spec gem_adi
```

Şu ana kadar yaptığımız komutların hepsi `--local` değeri ile çalışıyor. Yani bizim
sistemimizdeki **gem**leri tarıyor/inceliyor. Eğer uzak sunucudaki gemleri incelemek
istiyorsak `--remote` değeri eklememiz yeterli.

```bash
gem spec mysql --remote
```

MySQL **gem**i yüklü olmasada uzak sunucudan bilgisini getirecektir.

**Gem yükle**mek için

```bash
gem install mysql
```

Bu komutla beraber **mysql** gem yüklenecektir fakat dökümantasyonları da indirecek.
Eğer **production** ortamında kurulum yapıyorsanız dökümantasyona ihtiyacınız
olmayabilir. Dökümantasyon olmadan kurulum yapmak için `--no-document` yapmanız
yeterli.

```bash
gem install mysql --no-document
```

**Yüklü gemleri güncelleştir**mek için

```bash
gem update
```

## Bundler Kurulumu

**Bundler**, **Ruby**'nin paket yönetim amaçlı oluşturulmuş bir **gem**idir.

```bash
gem install bundler
```

## Jekyll Kurulumu

**Ruby** ve **RubyGems** kurulumu yaptığımıza göre **Jekyll** kurulumu yapabiliriz.

Kurulumdan önce **gem**leri güncelleyelim.

```bash
gem update
```

`jekyll` **gem**i kuralım.

```bash
gem install jekyll
```

## Jekyll Başlangıç Projesi Oluşturma

`jekyll` **gem**i ile birlikte  `jekyll`  komutumuz geliyor. Örnek bir proje oluşturmak
için şu komutu kullanmamız yeterli.

```bash
jekyll new proje_ismi
```

## Jekyll Projesini Çalıştırma

Oluşturduğumuz projenin dizinine ulaşarak şu komutla jekyll'i çalıştırabiliriz.

```bash
jekyll serve
```

`http://127.0.0.1:4000` adresinden Jekyll projemizi inceleyebiliriz.

## Github Pages Gemlerini Yükleme

Jekyll projemizi Github Pages'e göre yapmamız için Github Pages'ın kullandığı
**gem**leri kullanmamız gerekiyor. (Tabi ki localde oluşturup _site klasörünü
yükleyebiliriz fakat saçma olmaz mı?)

Projenin ana dizininde `Gemfile` isminde bir dosya oluşturun ve içeriğini şu şekilde
düzenleyin.

```bash
source 'https://rubygems.org'
gem 'github-pages'
```

`bundle install` komutu ile gerekli gemlerin yüklenmesini sağlayın.

## Ekstra: safe_yaml Psych sorunu

Eğer `uninitialized constant Psych::Nodes (NameError)` şeklinde bir hata alıyorsanız
bunun sebebi Github-Pages'in belirli bir Psych versiyonu ile çalışmasından
kaynaklanıyor. Eski bir psych versiyonunu kullanmanız gerekiyor.

Github Pages projenizi şu komut ile çalıştırırsanız bir sorun oluşmayacaktır.

```bash
gem cleanup
bundle exec jekyll serve
```