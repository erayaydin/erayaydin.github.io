+++
title = "Pass ile Kendinize Özel Parola Yöneticinizi Yapın"
description = "Pass ile GnuPG ve Git kullanarak kendinize özel parola yöneticisi yapın"
date = "2018-02-09 09:00:00"
slug = "pass-kendinize-ozel-parola-yoneticisi"
[taxonomies]
tags = ["linux", "arch-linux"]
categories = ["linux", "arch-linux"]
+++
# Pass Nedir?

`pass` yazılımı komut arayüzünde çalışan basit bir parola yöneticisidir. `git` 
ve `tree` araçlarını kullanarak yazılmış bir `shell` kodlamasıdır. Bu sebeple 
kullanımı ve geliştirilmesi oldukça kolaydır.

Bu yazı içerisinde **Arch Linux**, **Android** ve **Windows** ortamlarında 
nasıl kurulumu yapıldığını ek olarak **Chromium**, **Chrome** ve **Firefox** 
üzerinde nasıl entegrasyonu yapılabileceğini örnekledim.

# Arch Linux Üzerinde Pass Kurulumu

Arch Linux üzerinde kurulumu yapmak için `pass` paketini yüklemeniz yeterlidir.

```bash
$ pacman -Sy pass
```

Ek olarak, grafik arayüzü istiyorsanız `qtpass` paketini de yükleyebilirsiniz.

# Kullanımı

Bir parola yöneticisi kullanacağımız için güvenliğinin sağlanması gerekiyor. Bu
sebeple **GnuPG** ile kendinize bir anahtar dizisi oluşturmanız gerekli.

## GnuPG Kurulumu

Arch Linux üzerinde `gnupg` paketini yüklemeniz gereklidir.

```bash
$ pacman -Sy gnupg
```

Ardından kendinize bir anahtar dizisi oluşturmalısınız.

```bash
$ gpg --full-gen-key
```

## Password Store Oluşturulması

Arch Linux üzerinde `pass` kullanarak kendimize ait bir dizin oluşturacağız.

```bash
$ pass init <gpg-id>
```

Artık `pass` üzerinde parolalarımızı tutabiliriz.

## Yeni Bir Parola Kayıt Etme

Burada hali hazırda olan bir parolayı kayıt olarak eklemek için kullanıyoruz. 
Yani program otomatik olarak parola üretmek yerine sizden parola girişi 
bekleyecektir.

Bir kayıt girerken hiyerarşik olarak isimlendirme yapmalısınız. Örneğin 
gmail.com üzerinde pass@gmail.com isimli bir kayıt oluşturacaksınız. Bu kayıtın 
ismi `gmail.com/pass@gmail.com` olmalıdır.

```bash
$ pass insert gmail.com/pass@gmail.com
```

## Yeni Bir Parola Oluşturma

Burada ise parola `pass` tarafından otomatik oluşturulacaktır.

```bash
$ pass generate gmail.com/pass2@gmail.com
The generated password for pass2@gmail.com is:
0iV1!?{4u"8I#F&8=34!JS{S]
```

Otomatik parola oluştururken dilerseniz uzunluk da verebilirsiniz. Bunun için 
kayıt isminden sonra sayıyı girmeniz yeterli.

```bash
$ pass generate gmail.com/pass3@gmail.com 6
The generated password for gmail.com/pass3@gmail.com is:
D0/+qh
```

Ek olarak, bazı website ve yazılımlarda semboller kabul edilmemekte. Bu 
sebeple oluştururken dilerseniz sembol kullanmamasını isteyebilirsiniz.

```bash
$ pass generate --no-symbols gmail.com/pass4@gmail.com
The generated password for gmail.com/pass4@gmail.com is:
zyT0XpJkmA0k7KfmdN4gVorY5
```

## Kayıtlı Parola Listesini Görüntüleme

Kayıtlı parolarınızı görüntülemek için **GPG** anahtarınızı girmenize gerek 
yoktur. Lakin bu kayıttaki parolayı görmek için bu anahtara ihtiyacımız olacak. 
Bu konu bir sonraki başlıkta.

```bash
$ pass
Password Store
└── gmail.com
    └── pass@gmail.com
```

## Bir Kayıttaki Parolayı Alma

Kayıttaki parolayı almak için kayıt ismini girmeniz yeterli. Komut sonrası 
sizden **GnuPG** parola isteyecektir.

```bash
$ pass gmail.com/pass@gmail.com
0iV1!?{4u"8I#F&8=34!JS{S]
```

Bu parolayı komut kısmından almak yerine `xclip` yüklüyse direk kopyalanmış 
olarak alabilirsiniz.

```bash
$ pass -c gmail.com/pass@gmail.com
Copied gmail.com/pass@gmail.com to clipboard. Will clear in 45 seconds.
```

## Kayıt Menüsü

Sisteminizde `dmenu` kuruluysa kayıtlara ekranda menü aracılığıyla da 
ulaşabilirsiniz. Bunun için `passmenu` çalıştırmanız yeterlidir.

```bash
$ passmenu
```

## Git Entegrasyonu

Parola kayıtlarınızı diğer cihazlarınızla paylaşmak için ve versiyon kontrolü 
ile güvenli bir şekilde tutmak için **git** kullanabilirsiniz. `pass git` 
komutundan sonra verdiğiniz tüm komutlar `git` ile `pass` ın bulunduğu dizinde 
gerçekleşecektir.

Öncelike depoyu oluşturalım.

```bash
$ pass git init
```

Ardından oluşturduğumuz bir `git` deposunu origin olarak ekleyelim.

```bash
$ pass git remote add origin <git-adres>
```

Sistemdeki değişiklikleri iletmek istediğinizde de `push` yapmanız yeterli.

```bash
$ git push -u --all
```

Başka bir sistemde yaptığınız ve gönderdiğiniz değişiklikleri `pull` ile 
alabilirsiniz.

```bash
$ git pull
```

# Android Cihazınızda Kayıtlara Erişin

## OpenKeychain

Android cihazınızda parolalara erişmek için öncelikle **GnuPG** anahtarınızı 
kullanabiliyor olmanız gerekiyor. Bunun için [**OpenKeychain**](https://play.google.com/store/apps/details?id=org.sufficientlysecure.keychain&hl=en) isimli Android 
programını kullanabilirsiniz.

**OpenKeychain** uygulamasına ekleyeceğiniz **GPG** anahtarını aşağıdaki komut 
ile kurulumu yaptığınız sistem üzerinde alabilirsiniz.

```
$ gpg --export-secret-key <gpg-id> > keys.asc
```

Ardından bu dosyayı **android** cihazınıza taşıyarak **OpenKeychain** üzerinde 
ekleyin.

## Password Store

Password Store android uygulamasına dilerseniz _play store_ üzerinden 
erişebilirsiniz lakin **F-Droid** üzerinden kurulum daha sağlıklı ve güncel 
olacaktır.

[F-Droid](https://f-droid.org/FDroid.apk) apk dosyasını android cihazınıza 
yükleyin. Ardından **F-Droid** üzerinden **Password Store** uygulamasını 
yükleyin.

Dilerseniz [buradan](https://f-droid.org/repo/com.zeapo.pwdstore_93.apk) da 
direk Password Store apk dosyasını indirebilirsiniz.

Password Store uygulamasında ayarlar kısmında **Select OpenPGP Provider** bölümünde **OpenKeychain**'in seçili olduğundan emin olun.

Password Store uygulamasındaki ayarlar kısmından öncelike **Generate SSH key pair** ile bir SSH anahtarı üretmeniz gerekmekte. Ardından yine aynı menüde bulunan **View generated public SSH key** ile oluşturduğunuz anahtarın public anahtarını alın. Bu anahtarı **git** sunucunuzda yetki vermek için kullanmalısınız.

Son olarak **git server settings** kısmından git sunucunuzu tanımlayın ve senkronizasyon işlemi yapın.

Artık uygulama üzerinde `pull` ve `push` yapabilirsiniz. Yani iki ortamda da 
kayıtlara erişebilir ve yeni kayıt ekleyebilirsiniz.

## Firefox Üzerinde Pass

Firefox tarayıcısını kullanmadığım için detaylı bilgim yok. İşlemi yapan arkadaşlar yazıyı **github** üzerinde düzenleyerek **pull request** gönderirse sevinirim.

Kullanılması gereken **extension** [burada](https://github.com/jvenant/passff#readme)

## Chrome / Chromium

Chromium üzerinde parolanıza erişmek için `browserpass` eklentisini kullanabilirsiniz. 

Arch Linux üzerinde kurulumu için aşağıdaki komutu kullanabilirsiniz.

```bash
$ yaourt -Sy browserpass
```

OSX,Linux ve Windows ortamları için [buradan](https://github.com/dannyvankooten/browserpass/releases) indirebilirsiniz.

Chrome eklentisine [buradan](https://chrome.google.com/webstore/detail/browserpass/naepdomgkenhinolocfifgehidddafch) ulaşabilirsiniz.

Bulunduğunuz sitede otomatik doldurmasını istediğinizde `Ctrl+Shift+L` yapabilirsiniz yada tarayıcıda eklenen kilit ikonunu kullanabilirsiniz.

## Windows

Windows ortamında kurulumunu yapmadım. Yapan arkadaşlar anlatımını yapıp bu yazıyı düzenlerse sevinirim.

Kullanılabilecek programa [buradan](https://github.com/mbos/Pass4Win#readme) ulaşabilirsiniz.

# Contributors

- [Eray Aydın](https://erayaydin.github.io)
