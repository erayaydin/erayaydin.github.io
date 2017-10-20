---
published: true
layout: post
title:  "Django Kurulumu"
description: Django kurulumu ve geliştirme ortamının hazırlanması.
date: 2017-10-20 20:33:00
tags:
  - linux
  - django
  - python
categories:
  - python
  - django
slug: python-django-kurulumu
---

# Django Kurulum

Bu makale, `Django` kurulumu ve çalıştırılmasını kapsar.

## Python Kurulumu

Django'nun bir **Python Web Framework** olmasından dolayı; Django, Python'un kurulu olmasını ister. Bildiğiniz gibi Python'un bir çok versiyonu var. Aktif olarak 
hem **Python 2** hem de **Python 3** kullanılıyor.

### Hangi Python Versiyonu?

Her Django versiyonu her sürümü desteklemiyor. Bu sebeple, kullanacağınız **Python** ve **Django** sürümüne göre aşağıdaki tablodan karar verebilirsiniz.

| Django Versiyon | Python Versiyon |
| --- | --- |
| 1.8 | 2.7, 3.3, 3.4, 3.5 |
| 1.9, 1.10 | 2.7, 3.4, 3.5 |
| 1.11 | 2.7, 3.4, 3.5, 3.6 |
| 2.0 | 3.4, 3.5, 3.6 |
| 2.1 | 3.5, 3.6, 3.7 |

### Python'ın Kurulması

Kurulacak **Python** sürümünü belirledikten sonra artık python kurulumuna geçelim.

#### Windows

Windows :( ortamı için kurulum gerçekleştireceksiniz [Python Releases for Windows](https://www.python.org/downloads/windows/) sayfasından kurmak istediğiniz Python sürümüne göre kurulum sihirbazını indirebilirsiniz.

#### Linux/UNIX

##### Arch Linux

Arch Linux dağıtımında kurulum işlemini `pacman` paket yöneticisi ile yapabilirsiniz.

Python 3 son sürümü kurmak için

```
pacman -Sy python
```

Python 2 son sürümü kurmak için

```
pacman -Sy python2
```

Eski sürümleri kullanacaksanız **AUR** kullanarak aşağıdaki sürümler için kurulum yapabilirsiniz.

| Python Versiyon | AUR Paket Adı |
| --- | --- |
| Python 3.5 | [python35](https://aur.archlinux.org/packages/python35/) |
| Python 3.4 | [python34](https://aur.archlinux.org/packages/python34/) |
| Python 3.3 | [python33](https://aur.archlinux.org/packages/python33/) |
| Python 3.2 | [python32](https://aur.archlinux.org/packages/python32/) |
| Python 3.0 | [python30](https://aur.archlinux.org/packages/python30/) |
| Python 2.6 | [python26](https://aur.archlinux.org/packages/python26/) |
| Python 2.5 | [python25](https://aur.archlinux.org/packages/python25/) |
| Python 1.5 | [python15](https://aur.archlinux.org/packages/python15/) |

```
yaourt -Sy python35
```

##### Ubuntu

Ubuntu 16.04 ile Python 3 ve Python 2 kurulu olarak gelmektedir.

Eski versiyonları yüklemek için _deadsnakes_' isimli PPA depoyu aktif edip eski versiyonları yükleyebilirsiniz.

```
add-apt-repository ppa:fkrull/deadsnakes
apt-get update
```

Kurulum işlemi için de aşağıdaki gibi versiyon adını yazarak yükleyebilirsiniz.

```
apt-get install python2.6 python3.3
```

##### Fedora

Fedora ile Python 3 ve Python 2 kurulu olarak gelmektedir.

### Python Kurulumunun Test Edilmesi

Python'ın kurulumunu test etmek ve kurulu olan versiyon sürümünü öğrenmek için `python` çalıştırabilirsiniz.


```bash
python --version
```

## Pip Kurulumu

### Ubuntu

Python 2 için **pip** kurulumu

```
apt-get install python-pip
```

Python 3 için **pip** kurulumu

```
apt-get install python3-pip
```

### CentOS ve RHEL

CentOS ve Red Hat Enterprise Linux için pip kurulumu

```
yum install epel-release
yum install python-pip
```

### Fedora

Python 2 için **pip** kurulumu

```
dnf install python-pip
```

Python 3 için **pip** kurulumu

```
dnf install python3-pip
```

### Arch Linux

Python 2 için **pip** kurulumu

```
pacman -S python2-pip
```

Python 3 için **pip** kurulumu

```
pacman -S python-pip
```

### openSUSE

Python 2 için **pip** kurulumu

```
zypper install python-pip
```

Python 3 için **pip** kurulumu

```
zypper install python3-pip
```

### Kurulumun Test Edilmesi

Pip kurulumunu test etmek ve versiyonu öğrenmek için aşağıdaki komutu çalıştırabilirsiniz.

```
pip --version
```

## Django'nun Pip Yardımıyla Kurulumu

Pip yardımıyla Django paketini artık sisteme kurabiliriz.

```
pip install Django
```

Eski sürüm bir Django kurulumu için de şunu kullanabilirsiniz.

```
pip install Django==1.0.4
```
