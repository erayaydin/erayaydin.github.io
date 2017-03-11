---
layout: post
title:  "Sudo Ayarları"
description: Sudo, yani "kullanıcı yerine yapmak", belirli kullanıcı veya gruplara root yetkisiyle komut gerçekleştirmesini sağlar.
date: 2015-12-13 16:46:00
tags:
  - linux
  - arch-linux
categories:
  - linux
  - arch-linux
slug: sudo-ayarlari
---

Sudo, yani "kullanıcı yerine yapmak", belirli kullanıcı veya gruplara
root yetkisiyle komut gerçekleştirmesini sağlar.

Sudo, `su` nun alternatifi olarak kullanılıyor. `su` dan farklı olarak,
`root shell` açmak yerine tek komutluk `root` yetkisi sağlamaktadır.
Sadece gerektiğinde `root` yetkisi kullanmanızı sağlar.

Sudo ayrıca diğer kullanıcılar gibi komut yazmanıza da olanak sağlar. Ek
olarak kullanılan komutları ve başarısız girişleri kayıt altına
alır(loglar).

## Kurulum

Pacman üzerinden kurulum için `sudo` paketini kurmanız yeterli.

## Kullanım

`sudo` yu kullanmak için öncelikle ayarlamaları yapmalısınız. Aşağıda
ayarlamaları detaylı bir şekilde anlattım.

Örnek olarak, pacman i kullanmak için:

```bash
sudo pacman -Syu
```

Detaylı kullanımı öğrenmek için

```bash
man sudo
```

## Ayarlamalar

### Ayarları Görüntüleme

`sudo -ll` komutu ile şuanki ayarlamaları görebilirsiniz. Bir kullanıcı
için ayarlamaları görmek istiyorsanız komutun sonuna kullanıcı adını
eklemeniz yeterli.

### Visudo Kullanımı

Sudo için ayarlamaları tutan dosya: `/etc/sudoers`. **her zaman**
`visudo` komutu ile bu dosyayı düzenlemeniz gerekiyor. `visudo` komutu
`sudoers` dosyasını kilitleyip, geçici bir dosyaya kaydedip, ayar
dosyasının uygun düzende olup olmadığını kontrol edip `/etc/sudoers`
dosyasına kopyalar.

Visudo için varsayılan editor `vi`dir. Nano ile `visudo` kullanmak
istiyorsanız EDITOR ortam değişkenini güncellemelisiniz.

```bash
EDITOR=nano visudo
```

### Örnek Ayarlar

Bir kullanıcının `sudo` komutu ile `root` yetkisine sahip olmasına izin
vermek için şu satırı eklemelisiniz:

~~~
KULLANICI_ADI ALL=(ALL) ALL
~~~

`wheel` grubundaki tüm kullanıcıların `sudo` erişimi olması için:

~~~
%whell ALL=(ALL) ALL
~~~

`sudo` komutu kullanılırken şifre sormasını istemiyorsanız:

~~~
Defaults:KULLANICI_ADI !authenticate
~~~

Kullanıcının belli başlı komutları kullanabilmesi için:

~~~
KULLANICI_ADI ALL=/usr/bin/halt,/usr/bin/pacman -Syu
~~~

### Sudoers Varsayılan Dosya İzinleri

`sudoers` dosyasının sahibi ve grubu 0 olarak tanımlanmalıdır. Dosya
izinleri 0440 olarak belirtilmelidir. Bu izinler varsayılan olarak
ayarlanır. Eğer bir durumdan dolayı bu izinleri değiştirirseniz,
tekrardan eski haline döndürmelisiniz. Aksi takdirde `sudo`
çalışmayacaktır.

```bash
chown -c root:root /etc/sudoers
chmod -c 0440 /etc/sudoers
```

### Bazı Ortam Değişkenleri Tutmak

`sudo` komutu kullanılırken bazı ortam değişkenlerini tutmak
isteyebilirsiniz. Bunun için `sudoers` dosyasında:

~~~
Defaults env_keep += "ftp_proxy http_proxy https_proxy no_proxy"
~~~

Bu ayarlama ile `ftp_proxy` `http_proxy` `https_proxy` `no_proxy` ortam değişkenleri
duracaktır.