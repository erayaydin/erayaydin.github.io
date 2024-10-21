+++
title = "Kotlin ve jMonkeyEngine ile Oyun Geliştirme - Tanımlar"
description = "Bu serinin ilk yazısında, Kotlin ve jMonkeyEngine ile oyun geliştirmeye başlamadan önce tanmlara göz atacağız"
date = "2020-03-22 05:01:53"
slug = "kotlin-jmonkeyengine-oyun-gelistirme-tanimlar"
tags = ["game-development", "kotlin", "java", "jmonkeyengine"]
categories = ["game-development", "kotlin", "java", "jmonkeyengine"]
+++
# Kotlin ve jMonkeyEngine ile Oyun Geliştirme - Tanımlar
Merhaba,
Bu yazı serisi içerisinde **Kotlin** ve **jMonkeyEngine** ile oyun geliştirme yöntemine bakacağız. Seri içerisinde sorunuz olursa sormaktan çekinmeyin. Sorularınızı issue olarak Github üzerinden açabilirsiniz.

> Not: **Kotlin** tecrübem hiç denecek kadar azdır, bu sebeple hata yaptığım noktalar olursa şimdiden özür dilerim. Hataları Git reposunda düzelterek PR oluşturabilirsiniz :)

Şimdi **kısaca** jMonkeyEngine, Kotlin, Gradle, Graphic Pipeline ve Scene Graph kavramlarına bakacağız.

## Kotlin Nedir?

Kotlin; statik, nesneye yönelimli özgür bir fonksiyonel programlama dilidir. Java ile birlikte çalışacak şekilde geliştirilmiştir lakin çok daha "hoş" bir syntax yapısı ile geliştirme yapmanıza olanak sağlamakta. Konsept olarak JVM için kullanılmakta olsa da artık LLVM ile mobil native ve JS için de geliştirmede kullanılmakta. Birden çok platformu desteklemesine rağmen jMonkeyEngine ile oyun geliştirirken bu seride Kotlin JVM'i kullanarak ilerleyeceğiz bu sebeple Kotlin ile gelen cross-platform özelliğini kullanmayacağız. JVM ile çalıştırdığımız için JVM'in cross-platform özelliği seri içerisinde devam etmekte.

Yararlanabileceğiniz kaynaklar:
- [Kotlin Website](https://kotlinlang.org/)
- [Python tecrübesi olanlar için resmi Kotlin dersleri](https://kotlinlang.org/docs/tutorials/kotlin-for-py/introduction.html)
- [Halil Özel'den Kotlin Nedir?](https://medium.com/@halilozel1903/kotlin-nedir-43e312d2dca6)
- [Mobil Hanem - Kotlin Eğitimi](https://www.mobilhanem.com/kotlin-egitimleri/)

## jMonkeyEngine Nedir?

jMonkeyEngine, Java ile yazılmış bir modern 3D geliştirme sağlayan bir oyun motorudur. Varsayılan olarak _LWJGL(Lightweight Java Game Library)_ renderer paketini kullanmaktadır. Elbetteki kendi renderer paketinizi veya birbaşka 3. parti renderer paketini de kolayca enjekte edebilirsiniz. _LWJGL_ ile OpenGL2+ sürümleri desteklenmektedir. Bu da oldukça geniş bir yelpaze demek. Alt başlıklar halinde; _jMonkeyEngineSDK_,  _LWJGL_, _Bullet Physics_, _NiftyGUI_ parçalarını inceleyeceğiz.

- [jMonkeyEngine sürümleri ve indirme](https://github.com/jMonkeyEngine/jmonkeyengine/releases) (İndirme yapmanıza gerek yok, jMonkeyEngine 3 SDK ile devam edecekseniz zaten kurulu gelecektir. Bir sonraki yazıda Gradle ile inşa mekanizmasını hazırlarken de jMonkeyEngine paketini indirteceğiz.)

Yararlanabileceğiniz kaynaklar:
- [jMonkeyEngine Website](https://jmonkeyengine.org/)
- [jMonkeyEngine Wiki](https://wiki.jmonkeyengine.org/)
- [JavaDoc](https://javadoc.jmonkeyengine.org/v3.x/index.html)
- [Forum](https://hub.jmonkeyengine.org/)

### jMonkeyEngine 3 SDK (jMonkeyPlatform)

jMonkeyEngine 3 sürümü ile gelen `jMonkeyEngine 3 SDK`, Netbeans tabanlı olan bu geliştirme ortamı eklenti desteği ve grafiksel geliştirme sağlamaktadır. İçerisinde, Sahne Editörü (Scene Editor), Materyal Editörü (Material Editor), Filtreleme Editörü (Filter Editor), dahili Blender ve dahili JDK bulunmaktadır.

Seri içerisinde olabildiğince `Intellij IDEA` ve `jMonkeyEngine 3 SDK` için anlatım yapmaya çalışacağım lakin sorun oluşturabilecek noktalarda `Intellij IDEA` üzerinden geliştirmeye devam edeceğim. Bu seri içerisindeki anlatımları bu IDE'lerden birinden veya beğendiğiniz başka bir IDE veya metin editörü ile uygulayabilirsiniz.

- [SDK Versiyonları ve İndirme (GNU/Linux, Windows, OSX ve Kaynak](https://github.com/jMonkeyEngine/sdk/releases/)

### LWJGL (Lightweight Java Game Library)

LWJGL, Java ile yazılmış bir oyun kütüphanesidir. Cross-platform olarak grafik (OpenGL, Vulkan), ses(OpenAL) ve paralel hesaplama(OpenCL) uygulamaları geliştirmenize yardımcı olmaktadır.

Dilerseniz geliştirmenizi LWJGL ve 3. parti yardımcı olacak paketlerle (GUI, Physic paketleri, Networking paketleri vs) yaparak daha low-level devam edebilirsiniz. Bu seri içerisindeki anlatımlar jMonkeyEngine odaklı olacağı için pek faydası olmayacaktır lakin göz atıp fikir almak da faydalı olur elbette :)

- [Website](https://www.lwjgl.org/)
- [Guide](https://www.lwjgl.org/guide)
- [Örnekler](https://github.com/LWJGL/lwjgl3/tree/master/modules/samples/src/test/java/org/lwjgl/demo)

### Bullet Physics

Bullet, C&C++ ile geliştirilmiş bir fizik motorudur. Çarpışma hesaplama (collision detection), hareket ve diğer fizik işlemlerini sağlayan bir pakettir.

jMonkeyEngine, jBullet (Bullet'in Java'ya göre yazılmış hali) kullanarak fizik mekaniği sağlamaktadır.

- [Bullet Physics SDK](https://github.com/bulletphysics/bullet3)
- [jBullet](http://jbullet.advel.cz/)

### Nifty GUI

Nifty GUI, Java ile yazılmış bir GUI geliştirme paketidir. Çizim kısmında OpenGL kullanmaktadır lakin elbette bu render kısmına müdahale edip başka bir renderer wrapper yazarak injekte edebilirsiniz.

- [Git Depo](https://github.com/nifty-gui/nifty-gui)

## Gradle

Java, Groovy ve Kotlin ile yazılmış bir build mekanizmasıdır. Maven'deki gibi XML yazım biçimi yerine Groovy tarzında build otomasyonu oluşturmanızı sağlar. Paketlerimizi Gradle ile belirleyip, inşa mekanizmasını kullanacağız.

- [Website](https://gradle.org/)
- [Git Depo](https://github.com/gradle/gradle)

## Graphic Pipeline

3 Boyutlu bir ortamın, 2 boyutlu ekrana getirilmesindeki süreci özetleyen kavrama "Graphic Pipeline" denmektedir. Oyunumuzu 3 boyutlu ortamda geliştireceğimiz için, grafiğin hazırlanma süreci hakkında bilgi sahibi olmak da önemlidir. Özellikle daha düşük seviyeli ortamlarda (LWJGL veya direk bir grafik API kullanarak) geliştirme yapanların muhakkak bilgi sahibi olması gereken bir kavramdır. Hem yazılımsal hem de donanımsal bir süreç gerektiren bu yolculuk için herkes tarafından benimsenmiş bir yol bulunmamaktadır. Lakin, Direct3D ve OpenGL gibi grafik kütüphaneleri, donanım hızlandırması sağlamak amaçlı bu süreçlerdeki benzer adımları ortaklaştırmıştır. Yani, geliştiricinin grafik hızlandırmayı kullanması için donanıma direk müdahalesi yerine bunu soyutlayarak kullanmasını amaçlamaktadır.

Bu konuda, şu videoyu izlemenizi tavsiye ederim: [thebennybox - Intro to Modern OpenGL Tutorial: Graphics Pipeline](https://www.youtube.com/watch?v=bgckX62f4EA)

### Genel Yapı

Genel yapıda çizimin oluşması ve ekrana gelmesi için 3 adım bulunmaktadır:

1. Application (Uygulama)
2. Geometry (Geometri)
3. Rasterization (Pikselleştirme)

#### 1. Application (Uygulama)

Uygulama tarafından hesaplanan çizimin (bütün collision hesaplaması, çizilecek nesnelerin noktası, üçgenleri vs) belirlenip pipeline'da bir sonraki adıma iletilmesidir.

#### 2. Geometry (Geometri)

Geometri adımında, Model & Camera'nin yerleştirilmesi, ışıklandırmanın hesaplanması, projeksiyonun hesaplanması, clipping (uzak/yakın) ve pencereye göre konumlandırılması adımları yer almaktadır.

#### 3. Rasterization (Pikselleştirme)

Piksel içerisindeki rengi belirleyen adımdır. Çizilecek nesnenin her bir noktası için bu pikselleştirme yapılmaktadır (eğer varsa; Fragment Shader bu adım içerisinde devreye alınmaktadır).

#### OpenGL Rendering Pipeline

Örnek olarak, OpenGL'in Rendering Pipeline'ı açıklamak gerekirse;

1. Vertex Spec (OpenGL)
2. Vertex Shader (Programcı tarafından müdahale edilebilir)
3. Tessellation (Opsiyonel olarak, programcı tarafından müdahale edilebilir)
4. Geometry Shader (Opsiyonel olarak, programcı tarafından müdahale edilebilir)
5. Vertex Post-Processing (OpenGL)
6. Primitive Assembly (OpenGL)
7. Rasterization (OpenGL)
8. Fragment Shader (Opsiyonel olarak, programcı tarafından müdahale edilebilir)
9. Per-Sample Ops (OpenGL)

Burada programcının çizimin donanımsal hızlandırma kullanması için müdahale etmesini sağlamaktadır. Vertex Shader, Geometry Shader ve Fragment Shader'ı GLSL dili ile yazarak donanıma yapması gereken işlevi söyleme işidir.

> Bu konuda, şu videoyu izlemenizi tavsiye ederim: [thebennybox - Intro to Modern OpenGL Tutorial: Graphics Pipeline](https://www.youtube.com/watch?v=bgckX62f4EA)

## Scene Graph

jMonkeyEngine ile oyun geliştirirken bu kavramı sıkça duyacağız.  Oyunumuzu geliştirirken kurguladığımız sanal ortama **scene graph** denmektedir. Bu sanal sahnemizdeki her bir objemize de **Spatial** diyeceğiz. Bu _spatial_ nesnelerimizin her birinde de **translation**(konum), **rotation**(baktığı yön) ve **scale**(büyüklük) bilgisi bulunacaktır. Buradaki **translation** konum, 3 boyuttan aşina olduğumuz X,Y ve Z kavramları ile belirtilmektedir.

Bu sahnemizi kurgularken farklı obje türüne ihtiyacımız olacaktır. Tahmin edebileceğiniz gibi, sahnemiz içerisinde görünmesini istediğimiz objeler olacağı gibi görünmesini istemediğimiz ve konum/baktığı yön/büyüklük gibi değerlerini kullanacağımız objeler de yer alacaktır. Varsayılan olarak oluşturduğumuz bi **spatial** nesneler görünmez durumdadır ve sadece bu bahsettiğim bilgileri tutmaktadır. Lakin **Geometry** türünde olan **spatial** nesneler ise, şekli olan ve görülebilir nesnelerdir. Şekillerini **mesh** ler belirtmekte ve **material** ler ile de görüntüsünü almaktadır.

Bir diğer husus da **spatial** nesnelerin yönetimi. Kurgu hazırladığımız için bir süre sonra bu nesnelerin yönetiminde zorlanabiliriz. Bu sebeple, **node** türündeki **spatial** ları kullanacağız. Hatırlarsanız, **spatial** ların belirli bir konumu oluyordu, diğer nesnelerimizi bu **node** lara yerleştireceğiz. **node** spatial'ları nested özelliğine sahip yani **parent** ve **child** node lar tanımlayabilirsiniz. Varsayılan olarak bu kurgumuzda **base node** üzerine diğer node ları ve spatial ları ekleyeceğiz.

Örnek vermek gerekirse;

- rootNode
	- playerNode
		- aimNode
		- armNode
	- envNode
		- houseNode
		- marketNode

Bu konuda hazırlanan şu slayt da oldukça bilgi verici: [3D Scene Graph for Dummies](https://wiki.jmonkeyengine.org/tutorials/scenegraph/assets/fallback/index.html)
