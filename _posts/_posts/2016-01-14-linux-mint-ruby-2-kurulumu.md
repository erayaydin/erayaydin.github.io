---
layout: post
title:  "Linux Mint - Ruby 2 Kurulumu"
description: Linux Mint dağıtımı için Ruby 2 kurulumu
date: 2016-01-14 02:26:00
tags:
  - linux
  - linux-mint
  - ruby
categories:
  - linux
  - linux-mint
  - ruby
slug: linux-mint-ruby-2-kurulum
---

> Kurulumdan önce, sisteminizdeki ruby paketini kaldırın.

Öncelikle Ruby için gerekli bağımlılıkları kuralım.

```bash
sudo apt-get update
sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev
```

Ardından `rbenv` ve `ruby-build` kurulumlarını yapalım.

```bash
cd
git clone git://github.com/sstephenson/rbenv.git .rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL

git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
exec $SHELL

git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash

rbenv install 2.2.3
rbenv global 2.2.3
ruby -v
```

Eğer `rbenv install 2.2.3` sırasında hata alıyorsanız, ilgili log dosyasını kontrol edin.

**SSLv3_method undeclared** hatası için aşağıdaki şekilde rbenv install kurulumu yapın.

```bash
curl -fsSL https://gist.github.com/mislav/055441129184a1512bb5.txt | rbenv install --patch 2.2.3
```

RubyGems'e dökümanları indirmemesi gerektiğini söyleyip, `Bundler` kurulumu yapalım.

```bash
echo "gem: --no-ri --no-rdoc" > ~/.gemrc
gem install bundler
```