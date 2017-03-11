---
layout: post
title:  "Linux - Screenfetch Kurulumu"
description: Linux dağıtımlarının tümü için Screenfetch kurulumu
date: 2016-01-28 16:04:00
tags:
  - linux
categories:
  - linux
slug: linux-screenfetch-kurulumu
---

Screenfetch'i indirin.

```bash
wget -O screenfetch 'https://raw.github.com/KittyKatt/screenFetch/master/screenfetch-dev'
```

Çalıştırılabilir dosya olarak belirtin.

```bash
chmod +x screenfetch
```

Genel kullanım için `/usr/bin`'e taşıyın.

```bash
sudo mv screenfetch /usr/bin/
```

Terminal açılınca otomatik çalıştırmak için `~/.bashrc` dosyasını açın.

```bash
nano ~/.bashrc
```

Dosyaya `screenfetch` programını ekleyin.

```bash
screenfetch
```