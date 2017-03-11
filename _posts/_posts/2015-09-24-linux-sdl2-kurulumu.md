---
layout: post
title:  "Linux - SDL2 Kurulumu"
description: Linux ortamında çeşitli paket yönetim sistemleri ve kaynaktan derleme için SDL2 kurulumu.
date: 2015-09-24 01:00:00
tags:
  - linux
  - sdl2
  - game-development
categories:
  - linux
  - sdl2
  - game-development
slug: linux-sdl2-kurulumu
---

### Yum Paket Yöneticisi ile Kurulum

```bash
yum install SDL2-devel
```

### Apt Paket Yöneticisi ile Kurulum

```bash
apt-get install libsdl2-dev
```

### Pacman Paket Yöneticisi ile Kurulum

```bash
pacman -S sdl2
```

### Kaynaktan Derleme

> Kaynaktan derlemek için `base-devel` paketinin yüklü olduğundan emin olunuz.

Kaynak kodu tar.gz olarak [buradan](https://www.libsdl.org/download-2.0.php) indirin.

İndirdiğiniz tar.gz dosyasını açın.

```bash
tar -xf SDL2-X.x.x.tar.gz
```

Açılan klasörün içeriğine gidelim. (`cd SDL2-X.x.x`)

```bash
./configure
make
make install
```