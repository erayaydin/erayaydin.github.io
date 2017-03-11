---
layout: post
title:  "Arch Linux - Yaourt Kurulumu"
description: Arch User Repository-diğer adıyla AUR- binlerce paketi barındırmaktadır (Steam da dahil). AUR’dan paket kurulumu oldukça basit. Yaourt ile çok daha kolay paket kurulumu yapabilirsiniz.
date: 2015-10-08 16:46:00
tags:
  - linux
  - arch-linux
categories:
  - linux
  - arch-linux
slug: arch-linux-yaourt-kurulumu
---

Arch User Repository-diğer adıyla AUR- binlerce paketi barındırmaktadır (Steam da
dahil). AUR’dan paket kurulumu oldukça basit. Yaourt ile çok daha kolay paket kurulumu
yapabilirsiniz.

**pacman.conf** dosyasını açın

```bash
nano /etc/pacman.conf
```

En alt satıra alttaki depoyu ekleyin.

```bash
[archlinuxfr]
SigLevel = Never
Server = http://repo.archlinux.fr/$arch
```

Depoları güncelleyin ve yaourt paketini kurun.

```bash
pacman -Sy
pacman -S yaourt
```

Yaourt kurulumunu kontrol edin.

```bash
yaourt --version
```