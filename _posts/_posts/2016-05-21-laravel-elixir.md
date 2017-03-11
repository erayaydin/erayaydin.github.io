---
layout: post
title:  "Laravel - Elixir"
description: Laravel **Elixir**, Gulp görevlerinizi kolay bir şekilde yönetmenizi sağlar. CSS ve Javascript derleyicileriyle birlikte test araçlarını da kullanmanıza imkan verir. Eğer daha önce Gulp ve asset yönetimi yaptıysanız Elixir işinize çok yarayacaktır.
date: 2016-05-21 19:22:00
tags:
  - laravel
  - php
categories:
  - laravel
  - php
slug: laravel-elixir
---

Laravel **Elixir**, Gulp görevlerinizi kolay bir şekilde yönetmenizi sağlar. CSS ve Javascript derleyicileriyle birlikte test araçlarını da kullanmanıza imkan verir. Eğer daha önce Gulp ve asset yönetimi yaptıysanız Elixir işinize çok yarayacaktır.

## Kurulum

### Node Kurulumu

Elixir'i kullanmak için geliştirme yaptığınız sistemde **Node.js**'nin kurulu olması gerekmektedir.

Node.js'nin kurulu olup olmadığını görmek için aşağıdaki komutla versiyon kontrolü yapabilirsiniz.

```bash
node -v
```

Windows ve OS X için Node.js kurulumunu [nodejs.org](https://nodejs.org/en/download/) adresinden yapabilirsiniz.

Arch Linux kullanıcıları da `pacman -S nodejs` ile kurulum yapabilir.

### Gulp

NodeJS kurulumundan sonra **Gulp** kurulumu yapmamız gerekiyor.

```bash
npm install -g gulp
```

### Laravel Elixir

Gulp ve NodeJS kurulumundan sonra geriye kalan Elixir kurulumunu yapmak. Bunun için Laravel projenizin olduğu klasöre ulaşıp `package.json` dosyasındaki NPM paketlerini kurmanız gerekiyor.

```bash
npm install
```

## Çalıştırma

Elixir'i çalıştırmak için özel bir komuta ihtiyacınız yok. Normal bir şekilde `gulp` çalıştırmanız yeterli. **Production** ortamında `--production` parametresi ekleyerek Elixir'in CSS ve JS dosyalarını küçültmesini isteyebilirsiniz.

```bash
# Tüm gulp görevlerini çalıştır
gulp

# Tüm gulp görevlerini çalıştır ve CSS/JS dosyalarını küçült
gulp --production
```

**Dosya Değişimlerini Kontrol Etmek**

Her değişiklikten sonra `gulp` komutunu çalıştırmak zor olacaktır. Bu nedenle dosya değişikliğinde otomatik olarak `gulp` çalışmasını istiyorsanız `watch` görevini çalıştırabilirsiniz.

```bash
gulp watch
```

## Stil Dosyalarıyla Çalışmak

`gulpfile.js` dosyası yazdığınız tüm Elixir görevlerini barındırmaktadır. Bu dosya üzerinden elixir işlemlerini belirteceğiz.

### Less

[Less](http://lesscss.org/) dosyalarını CSS olarak derlemek için `less` metodunu kullanacağız. `less` metodu parametre olarak derlemek istediğiniz less dosyasının yerini istemektedir. Varsayılan olarak, derlenen CSS `public/css/app.css` olarak çıktı verecektir.

```js
elixir(function(mix){
	mix.less('app.less');
});
```

Dilerseniz birden çok Less dosyasını tek bir CSS dosyası da yapabilirsiniz.

```js
elixir(function(mix){
	mix.less([
    	'app.less',
        'arayuz.less'
    ]);
});
```

Eğer `public/css/app.css` yerine farklı bir dizine farklı dosya adı ile kaydetmek istiyorsanız ikinci parametre olarak verebilirsiniz.

```js
elixir(function(mix){
	mix.less('app.less', 'public/stylesheets'); // public/stylesheets/app.css çıktısı verecektir
});

elixir(function(mix){
	mix.less('app.less', 'public/stylesheets/style.css'); // public/stylesheets/style.css çıktısı verecektir
});
```

### Sass

`sass` metodu ile [Sass](http://sass-lang.com/) dosyalarınızı CSS'e derleyebilirsiniz. Sass dosyaları `resources/assets/sass` klasöründe yer almalıdır.

```js
elixir(function(mix){
	mix.sass('app.scss');
});
```

`less` metoduna benzer olarak birden çok Sass dosyasını tek bir CSS dosyası yapabilirsiniz.

```js
elixir(function(mix){
	mix.sass([
    	'app.scss',
        'arayuz.scss'
    ], 'public/assets/css');
});
```

### Düz CSS

Birden çok CSS dosyasını tek bir CSS dosyası yapmak istiyorsanız `styles` metodunu kullanabilirsiniz. Belirttiğiniz CSS dosyası isimleri `resources/assets/css` klasöründe aranacaktır.

```js
elixir(function(mix){
	mix.styles([
    	'normalize.css',
        'main.css'
    ]);
});
```

Sass ve Less'te olduğu gibi çıktı dizinini ikinci parametre ile değiştirebilirsiniz.

### Kaynak Haritası

**Source Map** dosyaları derleme işlemi hakkında bilgileri saklamaktadır. Tarayıcılar bu sayede debugta hangi satırın nerede olduğunu gösterebilmektedir.

Eğer **source maps** dosyalarının derlenmesini istemiyorsanız bunu Elixir'e belirtebilirsiniz.

```js
elixir.config.sourcemaps = false;

elixir(function(mix) {
    mix.sass('app.scss');
});
```

## Script Dosyalarıyla Çalışmak

Elixir ayrıca Javascript çalışmalarınız için de birçok fonksiyon sağlamakta. ECMAScript 6 derlemesi, Coffeescript, Browserify, küçültme(minify) ve basit concat işlemi yapmak gibi.

### CoffeeScript

`coffee` metodu ile [CoffeeScript](http://coffeescript.org/) dosyalarınızı JS'ye derleyebilirsiniz. `coffee` metodu ilk parametre olarak CoffeeScript dosyalarının  yollarını alır. Çıktıyı `app.js` olarak `public/js` klasörüne oluşturur.

```js
elixir(function(mix){
	mix.coffee(['app.coffee', 'arayuz.coffee']);
});
```

### Browserify

`browserify` metodu ile **require** işlemi, **JSX** ve **ECMAScript 6** kullanımı  gibi özellikler sağlar.

`browserify`'da script dosyaları `resources/assets/js` içerisinde aranır ve çıktı olarak `public/js/main.js` çıktısı verir. Dilerseniz ikinci parametre ile çıktı dizinini değiştirebilirsiniz.

```js
elixir(function(mix){
	mix.browserify('main.js');
});

elixir(function(mix){
	mix.browserify('main.js', 'public/javascripts/main.js');
});
```

### Babel

`babel` metodu Javascript'te [ECMAScript 6 ve 7](https://babeljs.io/docs/learn-es2015/) ve [JSX](https://facebook.github.io/react/docs/jsx-in-depth.html) kullanmanızı sağlar. İlk parametre olarak `resources/assets/js` klasöründe yer alan dosya listesini ister ve çıktı olarak `public/js/all.js` çıktısı verir.

```js
elixir(function(mix){
	mix.babel([
    	'odeme.js',
        'urun.js',
        'react-component.jsx'
    ]);
});
```

Çıktı dizinini ve dosya ismini değiştirmek için ikinci parametre ile belirtmeniz yeterlidir.

### Scriptler

Birden çok JS dosyanız var ve bunları tek bir JS dosyası yapmak istiyorsanız `scripts` metodunu kullanabilirsiniz.

`scripts` metodu ilk parametre olarak `resources/assets/js` içerisindeki dosya isimlerini alır, çıktı olarak `public/js/all.js` verir.

```js
elixir(function(mix) {
    mix.scripts([
        'jquery.js',
        'app.js'
    ]);
});
```

Eğer bir klasör içerisindeki tüm JS dosyaları için bu işlemi yapmak istiyorsanız `scriptsIn` metodunu kullanabilirsiniz.

```js
elixir(function(mix) {
    mix.scriptsIn('public/js/klasor/yolu');
});
```

## Dosyaları & Klasörleri Kopyalama

`copy` metodu ile belirli dosya ve klasörleri istediğiniz yere kopyalayabilirsiniz. Bu metotda verdiğiniz yollar projenin ana dizinine göre çalışır.

```js
elixir(function(mix) {
    mix.copy('vendor/foo/bar.css', 'public/css/bar.css');
});

elixir(function(mix) {
    mix.copy('bower_components/font-awesome/icons', 'public/icons');
});
```

## Versiyonlama

Birçok geliştirici derlediği assetlerin tarayıcıda önbelleğe takılmaması için benzersiz bir kodla veya tarih ile asset dosyalarını çağırır. Bu işlemi Elixir `version` metodu ile yapabilirsiniz.

`version` metodu ilk parametre olarak `public` içerisindeki dosyanın ismini alır. Sonuna benzersiz bir kod koyarak versiyonlama yapmanızı sağlar. Örneğin `all-16d570a7.css` gibi.

```js
elixir(function(mix) {
    mix.version('css/all.css');
});
```

Versiyonlamadan sonra bu CSS dosyasını ön tarafta çağırmanız için PHP `elixir` yardımcı fonksiyonunu kullanmanız gerekiyor. `elixir` fonksiyonu otomatik olarak kodlu dosyanın ismini getirecektir.

```html
{% raw %}
<link rel="stylesheet" href="{{ elixir('css/all.css') }}">
{% endraw %}
```

Dilerseniz elixir'e dizi olarak değer gönderip çoklu dosya versiyonlaması yapabilirsiniz.

```js
elixir(function(mix) {
    mix.version(['css/all.css', 'js/app.js']);
});
```

## BrowserSync

BrowserSync, frontenddeki yaptığınız değişikliklerde web tarayıcısının otomatik yenilenmesini sağlar. `browserSync` metodu ile **BrowserSync** sunucusu çalıştırabilirsiniz.

```js
elixir(function(mix) {
    mix.browserSync();
});
```

`gulp watch` komutu çalıştırdığınızda **3000** portu üzerinden web uygulamanıza bağlantıyı sağlayabilirsiniz. [http://homestead.app:3000] adresinden BrowserSync'e ulaşabileceksiniz. Fakat **homestead.app** dışında bir domain üzerinden geliştirme yapıyorsanız bunu da değiştirebilirsiniz.

```js
elixir(function(mix) {
    mix.browserSync({
        proxy: 'proje.app'
    });
});
```