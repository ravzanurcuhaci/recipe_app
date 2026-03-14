# 🍳 Recipe Recommendation App (Flutter & Machine Learning)

Flutter ile geliştirilmiş, makine öğrenmesi destekli yemek öneri uygulamasıdır. Kullanıcının girdiği malzemelere göre en uygun yemek tariflerini öneren bir sistem içerir. Projede Kaggle’dan alınan yemek veri seti kullanılarak Google Colab ortamında bir model eğitilmiş ve Flask API aracılığıyla servis edilmiştir. Flutter uygulaması ise bu API’ye bağlanarak kullanıcıya dinamik yemek önerileri sunar.

Uygulama, klasik tarif listeleme yaklaşımının ötesine geçerek malzeme bazlı akıllı öneri sistemi sunmayı amaçlar.

#  🚀 Özellikler

🍅 Malzemeye Göre Öneri: Kullanıcının girdiği malzemelere göre uygun yemek tarifleri önerilir.

🤖 Makine Öğrenmesi Entegrasyonu: Kaggle veri seti ile eğitilmiş model kullanılarak içerik tabanlı öneri sistemi oluşturulmuştur.

📡 API Tabanlı İletişim: Flutter uygulaması, Flask ile oluşturulan API’ye HTTP istekleri göndererek öneri alır.

🌍 ngrok Entegrasyonu: Google Colab üzerinde çalışan Flask API, ngrok aracılığıyla public bağlantıya açılmıştır.

📋 Tarif Listeleme: Veri setinde bulunan yemek tarifleri uygulama içerisinde görüntülenebilir.

🎨 Modern Arayüz: Flutter Material Design bileşenleri kullanılarak sade ve kullanıcı dostu bir arayüz tasarlanmıştır.

# 🔍 Mimari ve Çalışma Mantığı

Bu projede mobil uygulama ile makine öğrenmesi modeli birbirinden bağımsız ancak entegre şekilde çalışmaktadır:

Flutter Uygulaması: Kullanıcıdan malzeme bilgisi alır ve öneri isteğini API’ye gönderir.

Flask API: Google Colab üzerinde çalışan model için servis katmanı görevi görür ve /suggest endpoint’i üzerinden önerileri JSON formatında döndürür.

Machine Learning Modeli: Kaggle veri seti kullanılarak eğitilmiş ve girilen malzemelere göre benzer tarifleri öneren bir sistem oluşturulmuştur.

ngrok: Colab üzerinde çalışan Flask API’nin internet üzerinden erişilebilir olmasını sağlar.

Dataset: Kaggle’dan alınan yemek veri seti kullanılarak model eğitilmiştir.

# 🛠️ Kullanılan Teknolojiler

Framework: Flutter (Dart)

Machine Learning: Python, Scikit-learn, LogisticRegression

Backend / API: Flask

API Tunneling: ngrok (pyngrok)

Environment: Google Colab

Dataset: Kaggle Recipe Dataset

# 📂 Mimari Yapı
lib/
 ├─ model/        # Tarif ve öneri veri modelleri
 ├─ service/      # API iletişimi ve veri işlemleri
 ├─ view/         # UI sayfaları
 ├─ viewmodel/
 ├─ widgets/       # Tekrar kullanılabilir UI bileşenleri
 ├─ utils/         # Sabitler ve yardımcı yapılar
 └─ main.dart      # Uygulama giriş noktası


# Model ve API tarafı (Colab):

Kaggle veri setinin işlenmesi

Malzeme bazlı öneri modelinin eğitilmesi

Flask ile /suggest endpoint oluşturulması

ngrok ile API’nin public bağlantıya açılması


# 🎯 Amaç

Bu proje;

Kaggle veri seti kullanarak malzeme bazlı yemek öneri sistemi geliştirmek,

Google Colab ortamında makine öğrenmesi modeli eğitmek ve API olarak servis etmek,

Flutter ile Python tabanlı bir öneri motorunu mobil uygulamaya entegre etmek,

Mobil uygulamalarda akıllı öneri sistemlerinin nasıl çalıştığını göstermek

amacıyla geliştirilmiştir.
