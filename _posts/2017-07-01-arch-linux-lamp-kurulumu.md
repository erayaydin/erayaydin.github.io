---
layout: post
title:  "Arch Linux - LAMP Kurulumu"
description: Arch Linux için Apache, MySQL, PHP ve PHPMyAdmin kurulumu.
date: 2017-07-01 21:00:00
tags:
  - linux
  - php
  - mysql
  - apache
  - arch-linux
  - phpmyadmin
categories:
  - linux
  - arch-linux
  - php
slug: arch-linux-lamp-kurulumu
---

## Apache Kurulumu

Öncelike paket yöneticisi yardımı ile `apache` paketinin kurulumunu 
gerçekleştirelim.

```
pacman -S apache
```

### Apache Konfigürasyonu

Gerekli apache ayarlaması yapmak için konfigürasyon dosyasında değişiklik yapacağız. Apache konfigürasyonu `/etc/httpd/conf/httpd.conf` dosyasında yer alıyor.

Ben profesyonel bir web sunucusunda çalışmadığım, geliştirme ortamında 
çalıştığım için Apache'nin kullandığı `user` olarak kendimi belirtiyorum. 
İsterseniz siz de bu şekilde belirtip daha rahat çalışabilirsiniz.

```
User eray
```

Eğer `80` portunu başka bir yazılımda kullanıyorsanız dilerseniz Apache'nin 
portunu değiştirebilirsiniz.

```
Listen 80
```

Dışardan sizin web sunucunuza erişim olmamasını istiyorsanız `Listen` 
parametresini `Listen 127.0.0.1:80` olarak değiştirebilirsiniz.

Varsayılan olarak `/srv/http` klasörü `DocumentRoot` olarak tanımlı. 
Belirttiğiniz klasör web olarak servis edilmekte. Dilerseniz bu klasörü 
değiştirebilirsiniz. Fakat değiştirdikten sonra `<Directory "/srv/http">` 
kısmını da değiştirmeyi unutmayın. Aksi takdirde **403 Hatası** alırsınız.

Ek olarak `DocumentRoot` klasörü olarak belirtiğiniz klasör ve üst 
klasörleri **executable** yani çalıştırılabilir olmalıdır.

Klasörleriniz içerisinde `.htaccess` ile Apache üzerinde klasör bazlı ayar 
yapmak istiyorsanız **AllowOverride** değerini **All** olarak 
değiştirebilirsiniz. Ek olarak bunun çalışması için aşağıdaki satırı bulup 
önündeki yorum satırını kaldırın.

```
#LoadModule rewrite_module modules/mod_rewrite.so
```

```
<Directory "/srv/http">
...
AllowOverride All
...
</Directory>
```

Varsayılan olarak Apache, kullanıcı klasörlerini destekliyor
(`http://localhost/~eray`). Bu klasörü değiştirmek istiyorsanız 
`/etc/httpd/conf/extra/httpd-userdir.conf` dosyasından değiştirebilirsiniz.

```
# Settings for user home directories
#
# Required module: mod_authz_core, mod_authz_host, mod_userdir

#
# UserDir: The name of the directory that is appended onto a user's home
# directory if a ~user request is received.  Note that you must also set
# the default access control for these directories, as in the example 
below.
#
UserDir Webserver

#
# Control access to UserDir directories.  The following is an example
# for a site where these directories are restricted to read-only.
#
<Directory "/home/*/Webserver">
    AllowOverride FileInfo AuthConfig Limit Indexes
    Options MultiViews Indexes SymLinksIfOwnerMatch IncludesNoExec
    Require method GET POST OPTIONS
</Directory>
```

Yukarda da belirttiğim gibi klasörünüzün ve üst klasörlerin 
çalıştırılabilir olması gerekiyor. Bunun için çalıştırma izni vermelisiniz.

```
chmod o+x ~
chmod -R o+x ~/Webserver
```

Değişikliklerin geçerli olması için servisi yeniden başlatalım.

```
systemctl restart httpd
```

### Otomatik Sanal Sunucu

Daha önceden yazdığım [Otomatik Apache Sanal Sunucu](https://erayaydin.github.io/linux/apache/otomatik-apache-sanal-sunucu/) adımlarını takip ederek klasör klasör sanal sunucu oluşturabilirsiniz.

## PHP Kurulumu

Paket yöneticisi yardımı ile `php` ve `php-apache` paketlerini sisteme 
yükleyeceğiz.

```
pacman -S php php-apache
```

Apache tarafında `mpm_event` modülü yerine `mpm_prefork` modülünü 
aktifleştirmemiz gerekiyor. Bu sebeple `/etc/httpd/conf/httpd.conf` 
dosyasındaki **mpm_event** modülünü yorum satırı yapıyoruz.

```
#LoadModule mpm_event_module modules/mod_mpm_event.so
```

Ardından **mpm_prefork** modülünün yorum satırını kaldırıyoruz.

```
LoadModule mpm_prefork_module modules/mod_mpm_prefork.so
```

Dilerseniz `mpm_prefork` yerine de `proxy_fcgi` kullanabilirsiniz.

PHP'yi aktif etmek için `/etc/httpd/conf/httpd.conf` içerisindeki 
`LoadModule` listesinin sonuna aşağıdakini ekliyoruz.

```
LoadModule php7_module modules/libphp7.so
AddHandler php7-script php
```

Aynı şekilde `Include` listesinin sonuna da aşağıdakini ekliyoruz.

```
Include conf/extra/php7_module.conf
```

Servisi yeniden başlatıyoruz.

```
systemctl restart httpd
```

PHP kurulumunu test etmek için aşağıdaki gibi `test.php` isminde bir dosya 
oluşturabilirsiniz.

```
<?php phpinfo();
```

### PHP Konfigürasyonu

PHP ile ilgili ayarlamaları `/etc/php/php.ini` dosyası üzerinden yapacağız.

#### Maksimum Çalıştırma Süresi

Her scriptin saniye olarak belirli bir **timeout** yani zaman aşımı süresi 
vardır. Dilerseniz bunu değiştirebilir hatta limitsiz yapabilirsiniz.

```
; CLI kullanımlarında 0 değeri otomatik olarak verilmektedir. Yani zaman aşımı yoktur
max_execution_time = 60
```

#### Hafıza Limiti

Bir scriptin çalıştırılmasında harcanabilecek maksimum hafıza 
miktarıdır. Varsayılan olarak 128MB seçili bunu dilerseniz 
arttırabilirsiniz.

```
memory_limit = 1024M
```

#### Hataları Gösterme

Geliştirme ortamında çalışanlar için hataları görmek önemlidir. Bu sebeple 
`error_reporting` değerini belirttiğiniz hata türlerine göre 
değiştirebilirsiniz.

```
error_reporting = E_ALL
```

Ek olarak, hata mesajlarını ekrana yazdırmak için de `display_errors` 
değerini kullanabilirsiniz. Geliştirme ortamında bu değeri `On` yapmanız 
yararlı olacaktır.

```
display_errors = On
```

#### Açılış Hata Mesajları

PHP'nin kendisini çalıştırmaya başladığınızda çıkan sorunlardır. Genellikle 
konfigürasyonla ilgili hatalar olduğunda çıkar. Bunların bastırılmaması ve 
ekranda gözükmesi için `On` değerini verebilirsiniz. Tabi ki sadece 
geliştirme ortamında kullanmanız gerekiyor.

```
display_startup_errors = On
```

#### Hataları İzleme

`track_errors` değerini aktif hale getirerek script içerisinde 
`$php_errormsg` değişkeni ile son hata mesajını alabilirsiniz. 
Kullandığınız çalışma ortamında gerekli olabilir.

```
track_errors = On
```

#### Maksimum POST Büyüklüğü

PHP'nin kabul edeceği maksimum POST veri büyüklüğüdür. Dilerseniz **0** 
değeri vererek limiti kaldırabilirsiniz.

```
post_max_size = 50M
```

#### Maksimum Dosya Büyüklüğü

Yüklenebilecek dosyalar için maksimum dosya boyutudur. Varsayılan olarak 
`2M` yer alıyor.

```
upload_max_filesize = 200M
```

#### Maksimum Dosya Adeti

Bir request içerisinde yüklenebilecek maksimum dosya adetidir. Varsayılan 
olarak `20` yer alıyor.

```
max_file_uploads = 200
```

#### Timezone

Geçerli bölgenizi ayarlamak için `date.timezone` değerini 
değiştirebilirsiniz. Önündeki yorum satırını kaldırmayı unutmayınız.

```
date.timezone = Europe/Istanbul
```

### PHP Modülleri

Çeşitli php eklentilerini aktif etmek için öncelikle paket yöneticisi 
yardımı ile eklentiyi yüklemeli ardından `php.ini` dosyasında yüklediğiniz 
eklentiyi aktif hale getirmelisiniz. Bunun için basşındaki yorum satırını 
kaldırabilirsiniz.

#### BZ2 (Bzip2)

Script içerisinde Bzip fonksiyonlarını(bzclose, bzcompress, bzdecompress, 
bzopen, bzread, bzwrite vs.) kullanmak için aktif edebilirsiniz. Aktif hale 
getirmek için `php.ini` dosyasında ilgili satırın başındaki noktalı virgülü 
kaldırmanız yeterli.

```
extension=bz2.so
```

#### FTP

Script içerisinde FTP işlemleri yapmak için bu modülü aktif hale 
getirebilirsiniz.

```
extension=ftp.so
```

#### GD Kütüphanesi

Resim işleme ve oluşturma yapıyorsanız bu modülü aktif hale 
getirebilirsiniz.

```
extension=gd.so
```

Ek olarak paketi kurmayı unutmayın.

```
pacman -S gd php-gd
```

#### Gettext

Genellikle dil desteği amaçlı kullanılan gettext kütüphanesini aktif 
edebilirsiniz.

```
extension=gettext.so
```

#### IMAP, POP3 ve NNTP

Imap fonksiyonlarını kullanmak için aktif hale getirebilirsiniz.

```
extension=imap.so
```

Ek olarak paketi kurmayı unutmayın.

```
pacman -S php-imap
```

#### MCrypt

Çeşitli kütüphaneler tarafından da kullanılan **mcrypt_** fonksiyonlarına 
erişmek için aktif hale getirebilirsiniz.

```
extension=mcrypt.so
```

Ek olarak paketini de kurun.

```
pacman -S php-mcrypt
```

#### MySQLi

MySQLi fonksiyonlarını kullanmak istiyorsanız aktif hale getirebilirsiniz.

```
extension=mysqli.so
```

#### PDO MySQL, ODBC, DBLib, PostgreSQL, SQLite

PDO ile belirtilen veritabanı yönetim sistemlerini kullanmak için eklentiyi 
aktif hale getirebilirsiniz. Seçtiğiniz veritabanı sistemini de 
bilgisayarınıza kurmayı unutmayın.

```
extension=pdo_dblib.so
extension=pdo_mysql.so
extension=php_odbc.so
extension=php_pgsql.so
extension=php_sqlite.so
```
#### Imagemagick

Resim işleme için kullanabileceğiniz bir paket.  AUR deposundan 
indirebilirsiniz.

```
yaourt -S php-imagick
```

`/etc/php/conf.d/` klasörü içerisine kendisi dosya attığı için otomatik 
olarak aktif hale geliyor. `php.ini` üzerinde değişiklik yapmanıza gerek 
yok.

#### Modül Kontrolü

Kurduğunuz PHP modüllerini test etmek için aşağıdaki komutu 
kullanabilirsiniz.

```
php -m
```

Sonuç olarak size eklenen modülleri döndürecektir.

```
[PHP Modules]
bz2
Core
ctype
curl
date
dom
fileinfo
filter
ftp
gd
gettext
hash
imap
json
libxml
mbstring
mcrypt
mysqli
mysqlnd
openssl
pcntl
pcre
PDO
pdo_mysql
pdo_sqlite
Phar
posix
readline
Reflection
session
SimpleXML
SPL
standard
tokenizer
xml
xmlreader
xmlwriter
zip
zlib
```

## MySQL (MariaDB) Kurulumu

MariaDB, Arch Linux'un varsayılan MySQL implementasyonudur. Oracle 
firmasının MySQL'ini kullanmak için AUR'u kullanabilirsiniz fakat 
MariaDB'yi öneririm.

Paket yöneticisinden `mariadb` paketini yükleyelim.

```
pacman -S mariadb
```

MariaDB servisini başlatmadan önce birkaç ayarlama yapacak olan 
`mysql_install_db`'yi çalıştırıyoruz. Kurulum yerini dilerseniz 
değiştirebilirsiniz fakat `/home` `/root` ve `/run/user` klasörlerini 
tercih etmeyin. Çünkü `ProtectHome=true` değeri bulunduğu için bu 
klasörlere MariaDB tarafından erişim sağlanamıyor. Ek olarak `datadir` 
klasör değişimini `/etc/mysql/my.cnf` içerisinde de yapmalısınız.

```
mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
```

Artık servisi başlatabilirsiniz.

```
systemctl start mysqld
```

### Güvenlik Ayarlaması

Veritabanı katmanında birkaç güvenlik önlemi almak ve `root` parolasını da 
değiştirmek için aşağıdaki scripti çalıştırabilirsiniz.

```
mysql_secure_installation
```

Çalıştırma sırasında sorulan sorular şu şekilde:

- **Set root password?** `root` parolasını değiştirmek istiyorsanız `Y` 
seçeneğini seçin.
- **Remove anonymous users?** Genellikle test amaçlı olarak gizli 
kullanıcılara izin veriliyor Dilerseniz bunları silebilirsiniz.
- **Disallow root login remotely?** `root` kullanıcısına `localhost` 
haricinde erğişimi kapatmak için `Y` seçeneğini seçebilirsiniz.
- **Remove test database and access to it?** Test veritabanını ve ona 
erişimi kaldırmak istiyorsanız `Y` seçeneğini seçebilirsiniz.
- **Reload privilege tables now?** Değişikliklerin hemen geçerli olmasını 
istiyorsanız `Y` seçebilirsiniz.

### Dışardan Erişimi İptal Etmek

Varsayılan olarak MySQL dışardan erişime açıktır. Dışardan erişimleri 
engellemek için `/etc/mysql/my.cnf` dosyasındaki aşağıdaki satırın 
başındaki yorum simgesini kaldırmanız yeterli.

```
skip-networking
```

Dışardan erişim kapatılsa dahi **localhost** üzerinden giriş 
yapabilirsiniz.

### UTF8MB4 Kullanımı

**UTF-8** yerine **UTF8MB4** kullanmanızı tavsiye ederim. Tam anlamıyla 
Unicode desteği sağlamış olursunuz. Bunun için `/etc/mysql/my.cnf` 
içerisine aşağıdaki satırları eklemeniz yeterli.

```
[client]
default-character-set = utf8mb4

[mysqld]
collation_server = utf8mb4_unicode_ci
character_set_client = utf8mb4
character_set_server = utf8mb4
skip-character-set-client-handshake

[mysql]
default-character-set = utf8mb4
```

## PHPMyAdmin Kurulumu

Web tabanlı olarak MySQL veritabanlarını yönetmek için kullanabilirsiniz.

Öncelikle `phpmyadmin` paketini sistemimize kuralım.

```
pacman -S phpmyadmin
```

PHP tarafında `mysqli` modülünü aktif etmemiz gerekiyor, bunu PHP kısmında 
anlattık.

Ek olarak `bz2` ve `zip` modüllerini de aktif hale getirerek sıkıştırılmış 
dosya desteği de ekleyebilirsiniz.

### PHPMyAdmin-Apache Ayarlaması

Apache tarafında `.../phpmyadmin` olarak girildiğinde PHPMyAdmin gözükmesi 
için birkaç ayarlama yapmamız gerekiyor. Bunun için 
`/etc/httpd/conf/extra/phpmyadmin.conf` dosyası oluşturup içerisine 
aşağıdakileri ekleyelim.

```
Alias /phpmyadmin "/usr/share/webapps/phpMyAdmin"
<Directory "/usr/share/webapps/phpMyAdmin">
    DirectoryIndex index.php
    AllowOverride All
    Options FollowSymlinks
    Require all granted
</Directory>
```

Ardından bunu `/etc/httpd/conf/httpd.conf` dosyası içerisinde dahil edelim.

```
# PHPMyAdmin
Include conf/extra/phpmyadmin.conf
```

### PHPMyAdmin Dışardan Erişimi Kapatma

Varsayılan olarak web servis dosyalarımızı görebilen herkes PHPMyAdmin 
arayüzüne de erişebilmekte. Bunu devredışı bırakmak için 
`/etc/httpd/conf/extra/phpmyadmin.conf` dosyasında yer alan `Require all 
granted` parametresini `Require local` olarak değiştirmemiz yeterli.

### Otomatik Giriş

PHPMyAdmin kısmında veritabanı kullanıcı bilgilerini girmenize gerek 
kalmadan otomatik olarak giriş yapmak için 
`/etc/webapps/phpmyadmin/config.inc.php` 
dosyasındaki `auth_type` değerini `config` olarak değiştirin.

```php
$cfg['Servers'][$i]['auth_type'] = 'config';
```

Ardından alt satıra aşağıdaki eklemeleri yapın.

```php
$cfg['Servers'][$i]['user'] = 'root';
$cfg['Servers'][$i]['password'] = 'mysql_parolasi'; 
```

## Bitiş

**LAMP Stack** kurulumunu tamamladık. Dilerseniz geliştirme ortamınızı daha 
da iyi hale getirebilirsiniz. Makalede hata veya eksik varsa özür dilerim, 
bunları bana iletirseniz gerekli eklemeleri yapacağım. Teşekkürler.
