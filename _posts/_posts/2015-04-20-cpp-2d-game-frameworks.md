---
layout: post
title:  "C++ 2D Game Frameworks"
description: Bu yazıda C++ 2D oyun kütüphaneleri hakkında bilgiler vereceğim. Avantajlarını ve eksikliklerini, artı ve eksi yönlerini öğrenebilirsiniz.
date: 2015-04-20 12:00:00
tags:
  - cpp
  - game-development
categories:
  - cpp
  - game-development
slug: cpp-2d-game-frameworks
---

Bu yazıda C++ 2D oyun kütüphaneleri hakkında bilgiler vereceğim. Avantajlarını ve eksikliklerini, artı ve eksi yönlerini öğrenebilirsiniz.

## Oxygine

- Açık kaynak
- Çoklu-platform (MacOSX, iOS, Android, Windows, Linux, HTML5-Web-WebGL)
- Saf C++ (Basit API desteği ile yazımı çok rahat, jQuery sloganı gibi `do more with less code`)
- Hata ayıklama modu, FPS ve performans kontrolü
- SDL2 (Çok rahat olduğunu söyleyebilirim)
- Yetersiz döküman, sadece API bilgisi

## Angel2D

- Açık kaynak
- Çoklu-platform (Mac, iOS, Windows, Linux)
- Oxygine'e göre daha zorlu bir yazımı var API desteği çok yeterli değil fakat öğrendikten sonra sistemleri hazırlamak daha kolay. (low-level)
- OpenGL (SDL2'ye göre biraz daha zor elbette)
- Yetersiz döküman, sadece API bilgisi

## Torque 2D

- Açık kaynak
- Çoklu-platform (Mac, Windows, iOS, Linux, Android)
- OOP'a yatkın olanlar için çok iyi bir yazımı var.
- End-user tarzı bir kütüphane
- OpenGL (Angel2D'de belirttiğim gibi...)
- Büyük döküman kaynağı

## Poly Code

- Açık kaynak
- Saf C++
- LUA desteği (çok büyük bir artı)
- Sloganı Oxygine ile aynı `do more with less code`
- IDE desteği var (end-user)
- Kolay yayınlama (GUI ile platformlara çıkış)
- 2D/3D desteği

## Sonuç

Eğer mobil merkezli bir oyun yapmayı düşünüyorsanız hiç durmayın `Oxygine` kullanın.

Eğer platform bağımsız ve işi tabandan almak istiyorsanız `Torque2D` kullanın.

Eğer kolay ve hızlı bir şekilde bir projeyi çıkarmak, rahat olmak istiyorsanız `Poly Code` kullanın.

Angel2D ve Oxygine kullandım ve pek yeterli bulduğumu söyleyemem. **Poly Code** ile şansımızı deneyelim :)