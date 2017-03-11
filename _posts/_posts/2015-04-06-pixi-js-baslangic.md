---
layout: post
title:  "Pixi.js - Başlangıç"
description: Bu makale serisinde Pixi.js ile ilgili anlatımlar yer alacaktır.
date:   2015-04-06 12:00:00
tags:
  - javascript
  - game-development
categories:
  - javascript
  - game-development
slug: pixi-js-baslangic
---

Bu makale serisinde Pixi.js ile ilgili anlatımlar yer alacaktır.

## Ortamın Hazırlanması

Öncelikle Pixi.js'yi indirmemiz gerekiyor. Bunun için github'ı kullanacağız. `git` kurulumunuzu yaptığınızı varsayarak devam ediyorum.

```bash
git clone https://github.com/GoodBoyDigital/pixi.js.git
```

Bize aslında gereken `bin` klasörü içerisindeki `pixi.js` dosyası fakat kaynak kodlarını da indirmemiz avantajımıza olacaktır.

Hemen bir index.html dosyası oluşturalım ve bu `pixi.js` kütüphanemizi dosyaya ekleyelim.

Daha sonra karışma olmaması için `uygulama` isminde bir klasör oluşturuyoruz ve içerisine bu `index.html` dosyamızı oluşturalım.

```
<!doctype html>
<html lang="en">
<head>
	<meta charset="utf-8">

	<title>Pixi.js</title>

	<!--[if lt IE 9]>
	<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->
</head>
<body>

<!-- Pixi.js -->
<script src="../bin/pixi.js"></script>
</body>
</html>
```

## Stage

**Stage**, görünümün ana kısmıdır. Her nesne **stage**'e bağlanmakta ve görüntülenmektedir. Yani nesnelerimizi, sahnemizi ve bütün ortamı
**stage** kullanarak yerleştireceğiz.

```javascript
// PIXI.Stage(backgroundColor);
var stage = new PIXI.Stage(0xFFFFFF); // Beyaz arkaplan
```

## Renderer

**Renderer**, Stage'i ve stage içerisindeki tüm nesneleri ekrana çizer. WebGL ve Canvas seçiminize göre bu çizim işlemi yapılır.

```javascript
/*
 * Canvas Renderer
 * PIXI.CanvasRenderer(uzunluk=800], [yukseklik=600], [ozellikler]);
 */
var canvasRenderer = new PIXI.CanvasRenderer(800, 600);

/*
 * WebGL Renderer
 * PIXI.WebGLRenderer([uzunluk=0], [yukseklik=0], [ozellikler]);
 *
 */
 var webGLRenderer = new PIXI.WebGLRenderer(800, 600);

/*
 * Auto Detect Renderer
 * Otomatik olarak uygun olan render seçimini yapar.
 * PIXI.autoDetectRenderer([uzunluk=0], [yukseklik=0], [ozellikler]);
 */
 var autoDetectRenderer = new PIXI.autoDetectRenderer(800, 600);
```

**Auto Detect Renderer** kullanmak daha iyi olacaktır. Eğer tarayıcı WebGL çalıştırıyorsa WebGL, çalıştırmıyorsa Canvas kullanacaktır.

## Frame

Çizimin her karede yapılması gerekiyor, öbür türlü ilk frameden sonra bir çizim gerçekleşmeyecektir. Bunun için bir döngü oluşturacağız ve
sürekli çizim yapılmasını sağlayacağız.

```javascript
document.body.appendChild(renderer.view);
requestAnimFrame(cizimYap);
function cizimYap() {
	requestAnimFrame(cizimYap);
	renderer.render(stage);
}
```

Farkettiyseniz bizim **renderer** isminde bir değişkenimiz yok. Bu değişkeni seçtiğiniz **renderer**'a göre ayarlamanız gerekiyor.

Şimdi sonuç olarak oluşturduğumuz script:

```javascript
var stage = new PIXI.Stage(0xFFFFFF);
var renderer = new PIXI.autoDetectRenderer(400, 300);

document.body.appendChild(renderer.view);
requestAnimFrame(cizimYap);
function cizimYap() {
	requestAnimFrame(cizimYap);
	renderer.render(stage);
}
```

Çalışıp çalışmadığını kontrol etmek isterseniz isterseniz arkaplanı kırmızı yapabilirsiniz.

> `0xFF0303` renk kodunu kullanabilirsiniz.

## Texture

**Texture** ile resim dosyalarını hafızada tutacağız. Bu sayede **sprite**'da resim kullanmamız gerektiğinde bu **texture** nesnesini
kullanacağız. Bu sayede resimler tekrar ve tekrar yüklenmeyecek, sadece 1 defa çekilecektir.

```javascript
// PIXI.Texture.fromImage(dosyaYolu, orjin, olcek);
var texture = PIXI.Texture.fromImage("resim.png");
```

## Sprite

Sprite'lar sahnemizdeki nesnelerimiz olacaktır.

```javascript
// PIXI.Sprite(PIXI.Texture texture);
var sprite = new PIXI.Sprite(texture);
```

### Anchor

Nesnelerimizin orjin noktası olacaktır. Texture resmi de orjin noktasına göre çizilecektir. Bu sayede objenin tam olarak orta noktasının
neresi olacağını belirliyoruz.

```javascript
/* 0-0     => Sol Üst
 * 0.5-0.5 => Ortala
 * 1-1     => Sağ Alt
 */
sprite.anchor.x = 0.5;
sprite.anchor.y = 0.5;
```

### Position

Sprite nesnesinin sahnede bulunacağı koordinatlardır.

```javascript
sprite.position.x = 200;
sprite.position.y = 150;
```

### Rotation

Sprite nesnesini orjin etrafında döndürmenizi sağlar.

```javascript
sprite.rotation += 0.1;
```

> Döndürme kodunu çizim döngüsü dışında yaparsanız sadece 1 seferlik +0.1 artış yapacaktır. Sürekli dönmesi için döngü içerisinde bu kodu
kullanmanız gerekiyor.

### Sahneye Ekleme

Sprite nesnemizi artık sahneye ekleyelim.

```javascript
stage.addChild(sprite);
```

## Tüm Kaynak

Ders içerisindeki bilgilerle yapılan tüm script kodu

```javascript

var stage = new PIXI.Stage(0xFFFFFF);
var renderer = new PIXI.autoDetectRenderer(400, 300);

var texture = PIXI.Texture.fromImage("resim.png");
var sprite  = new PIXI.Sprite(texture);

sprite.anchor.x = 0.5;
sprite.anchor.y = 0.5;

sprite.position.x = 200;
sprite.position.y = 150;

stage.addChild(sprite);

document.body.appendChild(renderer.view);
requestAnimFrame(cizimYap);
function cizimYap() {
	requestAnimFrame(cizimYap);

	sprite.rotation += 0.1;

	renderer.render(stage);
}

```