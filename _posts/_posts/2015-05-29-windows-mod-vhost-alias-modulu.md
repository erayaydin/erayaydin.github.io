---
layout: post
title:  "Windows için Virtual Host Alias Modülü"
description: Daha önce paylaştığımız mod_vhost_alias'ın Windows ile ilgili ayarlaması.
date: 2015-05-29 16:34:00
tags:
  - apache
  - windows
categories:
  - apache
  - windows
slug: otomatik-apache-sanal-sunucu
---

Daha önce paylaştığımız mod_vhost_alias'ın Windows ile ilgili ayarlaması.

> Windows 8.1 üzerinde test edilmiştir.

Öncelikle modülü aktifleştirmek için `C:/Localhost/Apache/conf/httpd.conf` dosyasını düzenliyoruz.

~~~
#LoadModule vhost_alias_module modules/mod_vhost_alias.so
~~~

satırındaki `#` işaretini kaldırarak modülü aktifleştiriyoruz.

---

Modülü aktifleştirdiğimize göre ayarlamasını yapabiliriz. Bunun için `c:/Localhost/Apache/conf/alias.conf` dosyası oluşturup düzenliyoruz. İçerisine aşağıdaki kod bloğunu giriyoruz.

~~~
<Virtualhost *:80>
    VirtualDocumentRoot "c:/Webserver/%-2+/public"
    ServerName vhosts.dev
    ServerAlias *.dev
    UseCanonicalName Off
    LogFormat "%V %h %l %u %t '%r' %s %b" common
    ErrorLog "c:/Webserver/vhosts-error_log"
    <Directory "c:/Webserver/*">
        Options Indexes FollowSymLinks MultiViews
        AllowOverride All
        Order allow,deny
        Allow from all
    </Directory>
</Virtualhost>
~~~

Bu ayar dosyamızın çalışması için `httpd.conf` dosyasının en altına

~~~
# vHost Alias
Include conf/alias.conf
~~~

ekliyoruz.

## Test

Test etmek için `c:/Webserver` içerisine `deneme` ve `deneme/public` klasörlerini oluşturuyoruz. Henüz Windows'a gerekli ayarı yapmadığımız için `deneme.dev` bağlantısını `127.0.0.1` adresine yönlendirmemiz gerekiyor. Bunun için de `%windir%/system32/drivers/etc/hosts` dosyasını düzenliyoruz ve en alt satıra aşağıdakini ekliyoruz.

~~~
127.0.0.1 deneme.dev
~~~

Test etmek için [http://deneme.dev](http://deneme.dev) adresini kullanacağız.

## DNS Server

Linux ve Mac için aslında bu işlem oldukça kolay ve rahat.

Local DNS Server olarak [Acrylic](http://sourceforge.net/projects/acrylic/) programını kullanacağız. Kurulumu yaptıktan sonra `AcrylicHosts.txt` dosyasını düzenlememiz gerekiyor. Dosyayı `C:\Program Files (x86)\Acrylic DNS Proxy` dizininde bulabilirsiniz.

En alt satıra

~~~
127.0.0.1 *.dev
~~~

ekliyoruz.

**Denetim Masası** > **Ağ Ve İnternet** > **Ağ Bağlantıları** kısmından bağdaştırıcınıza sağ tıklayın ve **Özellikler** kısmına girin. **Internet Protokolü sürüm 4(TCP/IPv4)**'e tıklayın ve **Özellikler** deyin.

**Aşağıdaki DNS sunucu adreslerini kullan** kısmına `127.0.0.1` adresini girin.

Artık local bir DNS Proxy sunucunuz oluştu.

Size önerim `Acrylic` hizmetini sadece geliştirme yaparken açmanız. Diğer zamanlarda DNS cache yüzünden sorunlar yaşayabilirsiniz.