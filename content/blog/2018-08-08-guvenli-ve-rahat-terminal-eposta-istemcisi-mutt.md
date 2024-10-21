+++
draft = true
title = "Mutt - Güvenli ve Rahat Terminal E-Posta İstemcisi"
description = "Terminal eposta istemcilerinden Mutt paketini tanittim ve pass ile konfigürasyonunu yaptık"
date = 2018-08-08 20:18:00
slug = "mutt-terminal-eposta-istemcisi-pass"
[taxonomies]
tags = ["linux", "arch-linux"]
categories = ["linux", "arch-linux"]
+++

# Mutt Nedir?

Mutt, yazı tabanlı ve gelişmiş özelliklere sahip bir e-posta istemcisidir. 
Terminal ile programlarını kullanmak isteyen geliştiriciler için çok iyi bir 
e-posta istemcisi olduğunu düşünüyorum.

Mutt'un asıl odaklandığı alan **Mail User Agent(MUA)** olmaktır yani ilk 
yazılma amacı e-posta görüntülemektir. Daha sonraki implementasyonlarla 
e-posta görüntüleyicisinden çok filtreleme/alma ve gönderme özellikleri ile 
gelişmiş e-posta istemcileri araında yerini almıştır. Birçok yan özelliği 
olmasına rağmen biz bu yazıda **IMAP**, **POP3** ve **SMTP** konularında 
mutt kullanıma odaklanacağız.

Yazı içerisinde sadece kurulum adımında **Arch Linux** ortamını baz aldım. 
Kurulumu istediğiniz ortam için yapabilir ve konfigürasyon konusunda bu yazıyı 
takip edebilirsiniz.

## Arch Linux Mutt Kurulumu

Arch Linux ortamında mutt kurulumu için `mutt` paketini kurmanız yeterlidir.

```sh
$ pacman -Sy mutt
```

Bu paketle birlikte, kullanmak istediğiniz **IMAP**/**POP3** seçeneğine göre 
ek paketler kurmanız gerekecektir. (`libsasl`, `cyrus-sasl`, `getmail`, 
`fetchmail` gibi...)

## Konfigürasyon

Mutt konfigürasyonunu kullanıcı bazlı olarak yapmak istediğinizde, mutt iki 
dosyaya bakacaktır. Bunlar, `~/.muttrc` ve `./.mutt/muttrc` dosyalarıdır. Bu 
dosyalardan herhangi birini konfigürasyon olarak kullanmanız yeterli.

> Konfigürasyona girmeden önce bir hatırlatma: konfigürasyon içerisinde 
> kendinize özel bir değişken yaratmak istediğinizde **my_** ön yazısı ile 
> başlatmanız **zorunludur**
> `set my_default_account = "Google"`

### IMAP

Mutt birçok dağıtımın paket deposunda **IMAP** desteği ile inşa(built) 
edilmiştir. Bu sebeple ekstra bir paket gereksinimi olmayacaktır.

IMAP bağlantısında e-posta kullanıcı adınızı belirtmek için aşağıdaki 
konfigürasyon satırını kullanabilirsiniz.

```
set imap_user=KULLANICI_ADI
```

> Gmail kullanıcılarının tam e-posta yazması gerektiğini unutmayınız. Google 
> e-posta girişinde kullanıcı adlarını tam e-posta şeklinde tutmaktadır.

---

Kullanıcı adını belirttiğimize göre bir de parola belirtelim. (**Parola 
belirtmediğiniz durumlarda mutt uygulama içerisinde parolanızı soracaktır**)

```
set imap_pass=PAROLA
```

> Gmail kullanıcıları eğer 2 aşamalı doğrulama kullanıyorlarsa, uygulamaya özel 
> belirttikleri e-postayı buraya yazmalılar (kendi parolalarını değil!)

---

Giriş bilgilerimizi belirttik yalnız nereye bağlanacağımızı belirtmedik. 
Hangi e-posta kutusuna bağlanacağımızı belirtelim.

```
set folder=imaps://imap.sunucu.uzanti:port/dizin/
```

Bu örnekten yola çıkarsak Gmail için şu şekilde bir ayarlama yapabiliriz

```
set folder=imaps://imap.gmail.com/
```

---

Filtrelenmemiş e-postaları alabilmemiz için **spoolfile** direktifini 
uygulamamız gerekiyor.

```
set spoolfile=+INBOX
```

Buradaki `+` değerine dikkat ederseniz, relative olarak imap adresimizdeki 
INBOX dizini olduğunu anlayabilirsiniz.


