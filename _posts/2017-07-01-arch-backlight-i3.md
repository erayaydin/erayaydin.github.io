---
published: true
layout: post
description: Arch Linux ve i3 için Backlight ayarlaması
date: 2017-07-01T04:30:00.000Z
tags:
  - linux
  - php
  - mysql
  - apache
  - arch-linux
  - phpmyadmin
  - i3
categories:
  - linux
  - arch-linux
  - php
slug: arch-backlight-i3
---
## ACPI Test
Backlight ayarlamasından önce backlightı kontrol eden driverı öğrenmeliyiz. Bunun için `/sys/class/backlight` klasöründen yararlanacağız.

```bash
$ ls /sys/class/backlight
intel_backlight
```

Benim çıktıda görüldüğü üzere `intel_backlight` tarafından kullanılıyormuş. Bu klasörün içerisindekileri kontrol edelim.

```bash
$ ls /sys/class/backlight/intel_backlight
actual_brightness
brightness
max_brightness
subsystem
uevent
bl_power
device
power
type
```

Burada yer alan dosyaları ve klasörleri açıklayalım.

- **actual_brightness** - Donanımsal olarak gerçek aydınlatma miktarını alır.
- **brightness** - Aydınlatma miktarını belirler. 0 ile **maksimum aydınlık** miktarı arasında bir değer alır. Driver tarafındaki aydınlatma miktarını da gösterir. (Donanımsal olarak gerçek aydınlatma miktarı olmayabilir, actual_brightness bu yüzden var)
- **max_brightness** - Maksimum tanımlanabilecek aydınlatma miktarıdır.
- **subsystem** - Hangi sisteme ait olduğunu gösterir.  (`/sys/class/backlight`)
- **uevent** - Her sistem dosyasında (`/sys/devices`) bulunan bir dosyadır.`udev` için tanımlanacak _ekleme_, _silme_ veya diğer işlemleri tanımlamanızı sağlar.
- **bl_power** - Aydınlatma gücünü kontrol etmenizi sağlar. *FB_BLANK_UNBLANK* veya *FB_BLANK_POWERDOWN* değerlerinden birini alır. İlki gücü açar, ikincisi gücü kapatır(karanlık).
- **device** - Genellikle geriye dönük uyum için kullanılmakta. Cihazın hangi karta ait olduğunu gösterir.
- **power** - Her cihaz için güç tüketimi ile ilgili ayarların bulunduğu klasördür.
- **type** - Arka ışığın hangi arayüz türü ile kontrol edildiğini belirler. *firmware* (standart arayüz kütüphanesi), *platform* (platform tarafından belirli arayüz) ve *raw* (direk donanımsal kayıtları kullanarak) değerlerini alabilir.

Yukarda açıkladığımız dosyalardan **max_brightness**'ı inceleyelim.

```bash
$ cat max_brightness
937
```

Gördüğümüz gibi maksimum verebileceğimiz ışık değeri **937**

Bir de tanımlanan ışık değerini **brightness** dosyası ile inceleyelim.

```bash
$ cat brightness
700
```

Bu dosyayı değiştirerek parlaklığı da değiştirebiliriz.

```bash
$ echo 600 > brightness
```

Tabi ki parlaklığı ayarlamak için sürekli bu dosyayı değiştirmekle uğraşmayacağız.

## XBacklight

Xorg tarafından hazırlanan `xbacklight` ile parlaklığı ayarlayabiliriz.

> **Not:** Xbacklight sadece `intel` ile çalışmaktadır ve **modesetting** sürücüsü ile çalışmamaktadır. Yani Xorg'unuz **modesetting** driverını kullanıyorsa `xbacklight` çalışmayacaktır.

**Pacman ile xbacklight kurulumu**

```bash
pacman -S xorg-xbacklight
```

**Belirli bir % değeri ile parlaklığı belirlemek için**

```bash
# %50 tanımlamak için
xbacklight -set 50
```

**Belirli bir % değeri ile parlaklığı arttırmak için**

```bash
# %10 arttırmak için
xbacklight -inc 10
```

**Belirli bir % değeri ile parlaklığı kısmak için**

```bash
# %10 azaltmak için
xbacklight -dec 10
```

## Light

`xbacklight` yazılımının çalışmaması durumlarında kullanabileceğiniz bir başka yardımcı yazılım. _LightScript_'in C ile yazılmış hali. Malesef resmi depoda bulunmuyor bu sebeple AUR üzerinden kurmanız gerekiyor.

```bash
yaourt -S --noconfirm light
```

**Şuanki parlaklığı almak için**

```bash
light -G
```

**Belirli bir % değeri ile parlaklığı tanımlamak için**

```bash
# Parlaklığı %50 yap
light -S 50
```

**Belirli bir % değeri ile parlaklığı arttırmak için**

```bash
# %5 arttırmak için
light -A 5
```

**Belirli bir % değeri ile parlaklığı azaltmak için**

```bash
# % 5 azaltmak için
light -U 5
```

## i3 Klavye Kısayol

`i3` üzerinde klavye kısayol belirlemek için `~/.config/i3/config` dosyasına aşağıdaki kısayolu ekleyeceğiz.

```bash
bindsym XF86MonBrightnessDown exec light -U 5
bindsym XF86MonBrightnessUp exec light -A 5
```

tabi ki dilerseniz buradaki **XF86MonBrightnessDown** ve **XF86MonBrightnessUp** değerini değiştirerek başka bir kısayol atayabilirsiniz.

> Bu işlemi kullandığınız DE/WM'deki kısayol ayarlamasını uygulayarak da tanımlayabilirsiniz.
