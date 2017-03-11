---
layout: post
title:  "Windows'a Apache, Mysql, PHP ve PHPMyAdmin Kurulumu"
description: Apache, Mysql ve PHP'yi manuel olarak kurmak için bu makaleyi inceleyebilirsiniz.
date: 2015-05-29 16:30:00
tags:
  - apache
  - windows
  - mysql
  - php
categories:
  - apache
  - windows
  - mysql
  - php
slug: otomatik-apache-sanal-sunucu
---

Apache, Mysql ve PHP'yi manuel olarak kurmak için bu makaleyi inceleyebilirsiniz.

> Windows 8.1 üzerinde test edilmiştir.

## Apache Kurulumu

Apache kurulumu için, Windows XP ve 2003 kullanıcıları [VC10_x64](http://www.microsoft.com/download/en/details.aspx?id=13523)/[VC10_x86](http://www.microsoft.com/download/en/details.aspx?id=8328)  kurmalı, diğer versiyonlar için [VC11](http://www.microsoft.com/en-us/download/details.aspx?id=30679) kurulmalıdır.

Apache kurulumu için [Apache Lounge](http://www.apachelounge.com/) sitesini kullanacağız.

Visual C++ Redistributable for Visual Studio 2012 kurulumunu yaptıysanız  [Download](http://www.apachelounge.com/download/) kısmından bize uygun olan versiyon ve sistemi indirin.

x64 bir sistem kullandığım için `httpd-2.4.12-win64-VC11.zip` dosyasını indireceğim.

İndirdiğimiz **zip** dosyasını `C:/Localhost/Apache` klasörüne çıkartın.

Artık tek yapmamız gereken ayar dosyasını düzenlemek. Bunun için `C:/Localhost/Apache/conf/httpd.conf` dosyasını editör ile açıyoruz.

**ServerRoot** parametresine **c:/Localhost/Apache** değerini veriyoruz. Port olarak **80** kullanacağımız için **Listen** parametresini değiştirmemize gerek yok. Eğer başka bir porttan kullanmak istiyorsanız bu parametreyi değiştirebilirsiniz.

**LoadModule** listesinde yer alan `LoadModule rewrite_module modules/mod_rewrite.so` satırının başındaki `#` yorum satırını kaldırıyoruz. Bu sayede .htaccess ile apache'ye yeniden yazım işlemi tanımlayabileceğiz.

**DocumentRoot** parametresine de sunucu dosyalarımızı tutacağımız dizini tanımlayacağız. Çalışma amaçlı ben `C:/Webserver` dizinini kullanacağım. Aynı şekilde **<Directory "">** parametresini de düzenliyoruz.

Dosyayı kaydedip, konfigürasyon dosyamızı test etmek için `C:/Localhost/Apache/bin/httpd.exe` dosyasını **cmd.exe** ile açıyoruz. Eğer herhangi bir hata alıp **httpd.exe** kapatılmamışsa sorunumuz yok demektir. Ctrl+C ile httpd.exe'yi sonlandırabilirsiniz.

## PHP Kurulumu

PHP kurulumu için de [PHP Windows](http://windows.php.net) sitesini kullanacağız. [Download](http://windows.php.net/download/) kısmından VC ve sistemimize uygun PHP'yi indiriyoruz. VC11 ve x64 kullandığım için **VC11 x64 Thread Safe** seçtim. Apache modulü olarak kurulum yapacağımız için **Thread Safe** olanları indirmeniz gerekiyor.

İndirdiğiniz php **zip** dosyasını `C:/PHP/` içerisine çıkartıyoruz. Ayarlamaları yapmak için de `php.ini-development` dosyasını `php.ini` olarak değiştirip açıyoruz.

**max_execution_time** parametresini isteğinize göre arttırın. PHP dosyalarınızın maksimum çalıştırma süresini bu sayede arttırabilirsiniz. Ben 30'dan 60 saniyeye arttırdım.

**memory_limit** parametresini de sahip olduğunuz RAM'e göre arttırabilirsiniz. Varsayılan olarak **128MB** seçilidir. **512**'nin ideal olacağını düşünüyorum.

**post_max_size** parametresini de **0** olarak değiştirebilirsiniz. Bu sayede POST değerlerinin maksimum büyüklüğünü kaldırabilirsiniz.

Yorum halinde bulunan **extension_dir** parametresine de `C:/Localhost/PHP/ext` yolunu veriyoruz.

**upload_max_filesize** parametresini de **2M**'den **20M**'a çıkartabiliriz. Bu sayede daha büyük boyutlu dosyaları yükleyebiliriz.

**Dynamic Extensions** bölümünde aşağıda yer alan modüllerin başlarındaki yorum satırlarını kaldırarak aktif edebilirsiniz.

* php_bz2
* php_curl
* php_fileinfo
* php_gd2
* php_gettext
* php_imap
* php_mbstring
* php_mysql
* php_mysqli
* php_pdo_mysql


Gerekli düzenlemeleri yaptığımıza göre kaydedebiliriz. Test etmek amaçlı `C:/Localhost/PHP` dizininde `php.exe -i` komutunu çalıştırabilirsiniz.

## Apache - PHP Entegresi

Apache'ye modül olarak PHP eklemek için birkaç ayar yapmamız gerekiyor. `C:/Localhost/Apache/conf/httpd.conf` dosyasını düzenlemek için açıyoruz.

En alt satıra aşağıdaki kodları giriyoruz.

~~~
#PHP5
LoadModule php5_module "C:/Localhost/PHP/php5apache2_4.dll"
PHPIniDir "C:/Localhost/PHP"
~~~

> **php5apache2_4.dll** dosyasının olup olmadığını kontrol etmekte yarar var.

`<IfModule mime_module>` kısmının içinde yer alan **AddType** listesine aşağıdaki eklemeleri yapıyoruz.

~~~
AddType application/x-httpd-php .php
AddType application/x-httpd-php-source .phps
~~~

Dizinde şuan **index.html** dosyası ilk olarak açılıyor. Buna ayrıca **index.php** eklemek için, **DirectoryIndex** parametresine `index.php` ekliyoruz.

## Apache'nin Servis Olarak Eklenmesi

Windows başlatıldığında ayrıca Apache de başlatılması için **Apache**'yi hizmet olarak eklememiz gerekiyor. `cmd.exe`'yi yönetici haklarıyla çalıştırın. `C:/Localhost/Apache/bin` klasörüne ulaşarak ``httpd.exe -k install` komutunu gerçekleştirin.

Görev Yöneticisini açarak Hizmetler kısmından Apache'yi çalıştırın.

## PHP Test

PHP'yi test etmek için `C:/Webserver/phpinfo.php` dosyası oluşturun ve içerisine `<?php phpinfo();` ekleyin. Denemek için [http://localhost/phpinfo.php](http://localhost/phpinfo.php) bağlantısını kullanabilirsiniz.

## MySQL Kurulumu

MySQL kurulum işlemi için [Mysql Installer](https://dev.mysql.com/downloads/installer/) kullanacağız. Daha hızlı bir kurulum için **web installer**(mysql-installer-web-community-X.Y.Z.T.msi) indirebilirsiniz.

Sözleşme kurallarını kabul ettikten sonra kurulum türünü seçmemiz gerekiyor. Sadece **Server** bizim için yeterli. **Server Only** seçerek devam ediyoruz. İndirme işleminden sonraki ayar kısmında **Development Machine** seçimiyle geliştirme ortamını seçmiş oluyoruz. **Show Advanced Options** kısmını seçiyoruz ve ilerliyoruz.

**MySQL Root Password** kısmında mysql için kullanacağımız şifreyi tanımlıyoruz.

Diğer kısımları varsayılan bırakıp son aşamaya geçiyoruz ve ayarları uyguluyoruz.

## PHPMyAdmin Kurulumu

PHPMyAdmin kurulumda varsayılandan farklı olarak **Alias** kurulumu yapacağız. Bu sayede ileride oluşturacağımız **sanal sunucularda** da rahatlıkla PHPMyAdmin kullanabileceğiniz.

[PHPMyAdmin](http://www.phpmyadmin.net/home_page/index.php) sitesinden son versiyonu indiriyoruz ve `c:/Localhost/PHPMyAdmin` içerisine çıkartıyoruz.

`config.sample.inc.php` dosyasının ismini `config.inc.php` olarak değiştirip açıyoruz. İçindekileri silip aşağıdaki kodu kullanabilir veya gerekli düzenlemeleri teker teker yapabilirsiniz.

```php
<?php

$i = 0;

/*
* First server
*/
$i++;
/* Authentication type */
$cfg['Servers'][$i]['auth_type'] = 'config';
/* Server parameters */
$cfg['Servers'][$i]['host'] = 'localhost';
$cfg['Servers'][$i]['port'] = '3306';
$cfg['Servers'][$i]['connect_type'] = 'tcp';
$cfg['Servers'][$i]['compress'] = false;
/* Select mysqli if your server has it */
$cfg['Servers'][$i]['extension'] = 'mysqli';
/* User for advanced features */
$cfg['Servers'][$i]['user'] = 'root';
$cfg['Servers'][$i]['password'] = 'MYSQLSIFRE';

?>
```

Buradaki **MYSQLSIFRE** alanına MySQL kurulumu yaparken girdiğiniz şifreyi girmeniz gerekiyor.

PHPMyAdmin için gerekli ayarlamaları yaptık. Dosyayı kaydedip `c:/Localhost/Apache/conf/httpd.conf` dosyasına geçiyoruz. En alt satıra aşağıdaki kodları giriyoruz.

~~~
#PHPMyAdmin
Alias /phpmyadmin "c:/Localhost/PHPMyAdmin"
<Directory "c:/Localhost/PHPMyAdmin">
    Options Indexes FollowSymLinks
    AllowOverride All
    Require all granted
</Directory>
~~~

Hangi sunucu olursa olsun sonuna `/phpmyadmin` eklendiğinde `c:/Localhost/PHPMyAdmin` çalışacak şekilde ayarladık.

PHPMyAdmin ve MySQL testi için [http://localhost/phpmyadmin](http://localhost/phpmyadmin) deneyebilirsiniz.