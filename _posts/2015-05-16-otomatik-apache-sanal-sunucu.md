---
layout: post
title:  "Otomatik Apache Sanal Sunucu"
description: LAMP ortamında çalışırken sizin vaktinizi çalan en büyük şeylerden biri sanal sunucular. Hatta sırf bu işlemden kurtulmak için yazdığım scriptler de bulunmakta fakat dağıtımdan dağıtıma scripti düzenlemem gerekiyordu. Bu sorundan kurtulmak için ufak bir araştırma yaptım ve [şöyle](http://akrabat.com/automatic-apache-vhosts/) bir yararlı döküman buldum. Dökümanda Apache'nin  `mod_vhost_alias` modülünden bahsediliyor.
date: 2015-05-16 03:47:00
tags:
  - linux
  - apache
categories:
  - linux
  - apache
slug: otomatik-apache-sanal-sunucu
---

LAMP ortamında çalışırken sizin vaktinizi çalan en büyük şeylerden biri sanal sunucular. Hatta sırf bu işlemden kurtulmak için yazdığım scriptler de bulunmakta fakat dağıtımdan dağıtıma scripti düzenlemem gerekiyordu. Bu sorundan kurtulmak için ufak bir araştırma yaptım ve [şöyle](http://akrabat.com/automatic-apache-vhosts/) bir yararlı döküman buldum. Dökümanda Apache'nin  `mod_vhost_alias` modülünden bahsediliyor.

> Dökümanda işlemleri `Arch Linux`'a göre yaptım. Gerekli değişiklikleri kendi dağıtımınıza göre yapmalısınız.

## Vhost Alias Modülünün Aktifleştirilmesi
Vhost alias modülünü aktifleştirmek için Apache'nin konfigürasyon dosyasında değişiklik yapmamız gerekiyor. Bunun için `/etc/httpd/conf/httpd.conf` dosyasını düzenliyoruz. Dosya içerisinde yer alan `mod_vhost_alias` modülünün satırını bulup başındaki yorum satırı(**#**) işaretini kaldırıyoruz. Artık Apache başlangıçta modülü aktifleştirecektir.

## Modül Ayarlamaları
Modülü aktifleştirdik fakat henüz ayarlamalarını yapmadık. Bunun için `/etc/httpd/conf/mod_vhost_alias.conf` isminde bir dosya oluşturun. Dosya içeriğini aşağıdan bulabilirsiniz. İsteğinize göre yolları düzenleyebilirsiniz.

```
<Virtualhost *:80>
    VirtualDocumentRoot "/srv/http/%-2+/public"
    ServerName vhosts.dev
    ServerAlias *.dev
    UseCanonicalName Off
    ErrorLog "/srv/http/vhosts-error_log"
    <Directory "/srv/http/*">
        Options Indexes FollowSymLinks MultiViews
        AllowOverride All
        Order allow,deny
        Allow from all
    </Directory>
</Virtualhost>
```

Bu dosyanın Apache tarafından kullanılması için `httpd.conf` dosyasının en alt satırına aşağıdaki metni girebilirsiniz.

```
# Dynamic Virtual Hosts
Include conf/mod_vhost_alias.conf
```

-----------------

Artık `/srv/http` klasörü içerisindeki her açtığımız klasör bir sanal sunucu olmuş olacak. Denemek amaçlı `/srv/http/deneme` ve `/srv/http/deneme/public` klasörlerini oluşturalım.

Tarayıcınızdan `deneme.dev` şeklinde girdiğinizde istediğiniz şekilde sonuçlanmadığını göreceksiniz. Bunun sebebi henüz makinemiz sonu **.dev** ile biten domainleri **127.0.0.1** adresine yönlendirmemesi.

## Yerel Makineye Yönlendirme

Bu yönlendirme işlemi için 2 seçeneğimiz var.

- Yerel DNS Server
- PAC dosyası

Bu dökümanda Yerel DNS Server yöntemi ile yerel makineye yönlendirme yapacağız.

> Eğer yerel DNS server yüklemek istemiyor veya PAC dosyası ile de uğraşmak istemiyorsanız `etc/hosts` dosyasını her sanal sunucu için düzenleyerek kullanadabilirsiniz fakat bu da yorucu olacak ve tam bir otomatiklik söz konusu olmayacaktır.

Yerel DNS server için `dnsmasq` programını kullanacağız. Paket yönetim sisteminden kurulumunu gerçekleştirebilirsiniz.

```bash
yaourt -S dnsmasq
```

Kurulumdan sonra `etc/dnsmasq.conf` dosyasını düzenleyin ve en alt satıra aşağıdaki metni girin.

```bash
listen-address=127.0.0.1
address=/.dev/127.0.0.1
```

Son olarak makinenizin sizin DNS sunucunuzu kullanması için DNS ayarlarınızı 127.0.0.1 adresine yollamanız gerekiyor.

## Test

Öncelikle DNS sunucunuzun doğru çalışıp çalışmadığını deneyelim.

```bash
host deneme.dev
```

Eğer sonuç 127.0.x.x şeklinde geliyorsa DNS sunucumuz çalışıyor demektir.

`Apache`'yi yeniden başlatıp oluşturduğumuz `deneme.dev` adresine tarayıcınızdan ulaşmayı deneyin.