+++
draft = true
title = "Eloquent ORM İlişkiler"
description = "Eloquent ORM ile tanımlanan ilişki türleri hakkında şematik açıklama"
date = "2018-04-01 19:00:00"
tags = ["laravel", "php", "eloquent"]
categories = ["laravel", "php"]
slug = "eloquent-orm-relationships"
+++

Laravel ile tanıdığımız *Eloquent ORM*'nin *5.5* versiyonu için _kopya kağıdı_ 
niteliğinde hazırlanan 
[Mahmoud Zalt](https://hackernoon.com/@Mahmoud_Zalt?source=erayaydin.github.io) 
tarafından yazılmış [yazının](https://hackernoon.com/eloquent-relationships-cheat-sheet-5155498c209) 
*Türkçe* ve düzenlenmiş halidir.

![Diagram](https://github.com/erayaydin/erayaydin.github.io/blob/master/assets/images/posts/eloquent-orm-relationships.png)

## One To One Relationship (1-1 İlişki)

### Kurallar

- Kişinin **sadece bir** arabası olabilir.
- Araba **sadece bir** kişiye ait olabilir.

### Şema

![OneToOne](https://github.com/erayaydin/erayaydin.github.io/blob/master/assets/images/posts/eloquent-orm-relationships-one-to-one.png)

### Modeller

```php
<?php
// Models/Kisi.php
class Kisi
{
    public function araba() {
        return $this->hasOne(Araba::class);
    }
}

// Models/Araba.php
class Araba
{
    public function kisi() {
        return $this->belongsTo(Kisi::class);
    }
}
```

### Migrasyonlar

```php
<?php
// 0000_00_00_000000_create_kisiler_table.php
Schema::create('kisiler', function(Blueprint $table){
    $table->increments('id');
    $table->string('isim');
});

// 0000_00_00_000000_create_arabalar_table.php
Schema::create('arabalar', function(Blueprint $table){
    $table->increments('id');
    $table->string('isim');

    $table->integer('kisi_id')->unsigned()->index()->nullable();
    $table->foreign('kisi_id')
          ->references('id')->on('kisiler');
});
```

### Kayıt Ekleme

```php
<?php

// Kisi modeline Araba ilişkisi ekleme
$kisi->araba()->save($araba);

// Araba modeline Kişi ilişkisi ekleme
$araba->kisi()->associate($kisi)->save();
```

### Kayıt Getirme

```php
<?php

// Kişinin Arabasını getirme
$kisi->araba;

// Arabanın Kişisini getirme
$araba->kisi;
```

---

## One To Many Relationship (1-N İlişki)

### Kurallar

- Hırsız **birden çok** araba çabilir.
- Araba **sadece bir** hırsız tarafından çalınabilir.

### Şema

![OneToMany](https://github.com/erayaydin/erayaydin.github.io/blob/master/assets/images/posts/eloquent-orm-relationships-one-to-many.png)

### Modeller

```php
<?php
// Models/Hirsiz.php
class Hirsiz
{
    public function arabalar() {
        return $this->hasMany(Araba::class);
    }
}

// Models/Araba.php
class Araba
{
    public function hirsiz() {
        return $this->belongsTo(Hirsiz::class);
    }
}
```

### Migrasyonlar

```php
<?php
// 0000_00_00_000000_create_hirsizlar_table.php
Schema::create('hirsizlar', function(Blueprint $table){
    $table->increments('id');
    $table->string('isim');
});

// 0000_00_00_000000_create_arabalar_table.php
Schema::create('arabalar', function(Blueprint $table){
    $table->increments('id');
    $table->string('isim');

    $table->integer('hirsiz_id')->unsigned()->index()->nullable();
    $table->foreign('hirsiz_id')
          ->references('id')->on('hirsizlar');
});
```

### Kayıt Ekleme

```php
<?php

// Hırsız'a Araba ilişkilerini ekleme
$hirsiz->arabalar()->saveMany([$araba1, $araba2]);
// İsterseniz teker teker de ekleyebilirsiniz
$hirsiz->arabalar()->save($araba1);
$hirsiz->arabalar()->save($araba2);

// Arabaya Hırsız ilişkisini ekleme
$araba->hirsiz()->associate($hirsiz)->save();
```

### Kayıt Getirme

```php
<?php

// Hırsızın arabalarını getirme
$hirsiz->arabalar;

// Arabanın hırsızını getirme
$araba->hirsiz;
```

---

## Polymorphic One To Many Relationship (Polimorfik 1-N İlişki)

### Kurallar

- Kişi **birden çok** araba alabilir.
- Firma **birden çok** araba alabilir.
- Araba **sadece bir** tür tarafından alınabilir. (Kişi veya Firma)

### Şema

![PolymorphicOneToMany](https://github.com/erayaydin/erayaydin.github.io/blob/master/assets/images/posts/eloquent-orm-relationships-polymorphic-one-to-many.png)

### Modeller

```php
<?php
// Models/Kisi.php
class Kisi
{
    public function arabalar() {
        return $this->morphMany(Araba::class, 'alici');
    }
}

// Models/Firma.php
class Firma
{
    public function arabalar() {
        return $this->morphMany(Araba::class, 'alici');
    }
}

// Models/Araba.php
class Araba
{
    public function alici() {
        return $this->morphTo();
    }
}
```

### Migrasyonlar

```php
<?php
// 0000_00_00_000000_create_kisiler_table.php
Schema::create('kisiler', function(Blueprint $table){
    $table->increments('id');
    $table->string('isim');
});

// 0000_00_00_000000_create_firmalar_table.php
Schema::create('firmalar', function(Blueprint $table){
    $table->increments('id');
    $table->string('isim');
});

// 0000_00_00_000000_create_arabalar_table.php
Schema::create('arabalar', function(Blueprint $table){
    $table->increments('id');
    $table->string('isim');

    $table->integer('alici_id')->unsigned()->index()->nullable();
    $table->string('alici_type')->nullable();
    // bu ikisi yerine $table->morphs('alici'); kullanabilirsiniz
});
```

### Kayıt Ekleme

```php
<?php

// Alıcı ve Araba arasında ilişki kurma
$kisi->arabalar()->saveMany([$araba1, $araba2]);
$firma->arabalar()->saveMany([$araba1, $araba2]);
// Teker teker save() de kullanabilirsiniz.
$kisi->arabalar()->save($araba1);
$firma->arabalar()->save($araba2);

// Araba ve Alıcı arasında ilişki kurma
$araba1->alici()->associate($kisi)->save();
$araba2->alici()->associate($firma)->save();
```

### Kayıt Getirme

```php
<?php

// Alıcının arabalarını getirme
$kisi->arabalar;
$firma->arabalar;

// Arabanın alıcısını getirme
$araba->alici;
```

