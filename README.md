# Rush Runner - Endless Runner Game

🏃‍♂️ Temple Run tarzı endless runner oyunu - Flutter ve Flame ile geliştirilmiş

## 📱 Proje Hakkında

Rush Runner, Flutter ve Flame game engine kullanılarak geliştirilmiş Temple Run tarzı bir endless runner oyunudur. 
Oyun 3 şeritli bir koşu sistemi ile oynanır ve swipe hareketleri ile kontrol edilir.

## 🎮 Özellikler

- ✅ 60 FPS hedefli oyun döngüsü
- ✅ 3 şeritli koşu sistemi
- ✅ Swipe ile kontrol (sağa-sola)
- ✅ Sonsuz scrolling zemin ve parallax arkaplan
- ✅ Dinamik hız artışı
- ✅ Skor sistemi ve high score kaydetme
- ✅ Pause/Resume özellikleri
- ✅ Temiz ve modüler kod yapısı

## 🛠️ Teknolojiler

- Flutter 3.0+
- Flame 1.15.0 (Game engine)
- Flame Audio 2.1.0
- Shared Preferences (High score kaydetme)
- Provider (State management)

## 📁 Proje Yapısı

```
lib/
├── main.dart                          # Ana giriş noktası
├── game/
│   ├── rush_runner_game.dart         # Ana Flame game class
│   ├── components/
│   │   ├── player.dart               # Oyuncu komponenti (3-lane system)
│   │   ├── ground.dart               # Hareket eden zemin
│   │   └── background.dart           # Parallax arkaplan
│   ├── managers/
│   │   ├── game_manager.dart         # Oyun durumu yönetimi
│   │   └── score_manager.dart        # Skor ve high score yönetimi
│   └── utils/
│       └── constants.dart            # Oyun sabitleri ve ayarları
├── screens/
│   ├── main_menu_screen.dart         # Ana menü ekranı
│   └── game_screen.dart              # Oyun ekranı
└── widgets/
    └── game_button.dart              # Özel buton widget'ı

assets/
├── images/                            # Görseller (ileride eklenecek)
└── audio/                             # Ses dosyaları (ileride eklenecek)
```

## 🚀 Kurulum

1. Flutter'ın sisteminizde kurulu olduğundan emin olun:
```bash
flutter doctor
```

2. Bağımlılıkları yükleyin:
```bash
flutter pub get
```

3. Uygulamayı çalıştırın:
```bash
flutter run
```

## 🎯 Nasıl Oynanır

- **← Sağa/Sola Kaydırma**: Şerit değiştir
- **↑ Yukarı Kaydırma**: Zıpla (yakında eklenecek)
- **↓ Aşağı Kaydırma**: Sür (yakında eklenecek)

## 📋 Gereksinimler

- **Minimum SDK**: Android API 21 (Android 5.0)
- **Package name**: com.dertsiz46.rush_runner
- **Target SDK**: Flutter 3.0+

## 🔄 Gelecek Özellikler

- [ ] Zıplama mekanikleri
- [ ] Kayma mekanikleri
- [ ] Engeller (kayalar, ağaçlar vb.)
- [ ] Coin toplama sistemi
- [ ] Power-up'lar
- [ ] Ses efektleri ve müzik
- [ ] Karakter sprite'ları ve animasyonlar
- [ ] Farklı ortamlar ve temalar
- [ ] Liderlik tablosu

## 🏗️ Mimari

Proje modüler ve genişletilebilir bir yapıda tasarlanmıştır:

- **Component-Based**: Flame engine'in component sistemi kullanılır
- **Singleton Managers**: Game ve Score yönetimi için singleton pattern
- **Clean Code**: İyi dokümante edilmiş ve okunabilir kod
- **Separation of Concerns**: UI ve game logic ayrımı

## 📝 Lisans

Bu proje açık kaynak kodludur ve MIT lisansı altında yayınlanmıştır.

## 👨‍💻 Geliştirici

Developed by dertsiz46-creator
