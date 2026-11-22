# ✈️ AeroNest — Next-Gen 3D Soft-Realism Flight Booking Experience

AeroNest adalah sistem pemesanan tiket pesawat modern yang dibangun secara penuh menggunakan **Flutter**, menghadirkan visual **3D Soft Realism** (claymorphic tactile depth, organic ambient shadows, bevel specular highlights) dipadukan dengan palet warna **Pastel Orange / Peach Sunset** dan kontras **Celestial Midnight Slate & Lilac Glow**, **Gen-Z Floating Glassy Dock Navigation**, **Sistem Autentikasi (Login & Register)**, **Multi-Language (5 Bahasa)**, serta **Mode Gelap & Terang (Dark / Light Mode)**.

---

## 🎨 Fitur-Fitur Baru yang Ditambahkan

### 1. 🔐 Alur Autentikasi Lengkap (Login & Register)
- **Halaman Login 3D Soft-Realism** (`login_screen.dart`):
  - Kartu taktil dengan efek bevel dan glow warna peach.
  - Input email & password interaktif dengan toggle *show/hide password*.
  - Opsi login sosial cepat (Google, Apple).
  - Tautan lupa sandi dan beralih ke registrasi.
- **Halaman Register Akun Baru** (`register_screen.dart`):
  - Form Nama Lengkap (sesuai Paspor/KTP), Email, Kata Sandi, dan Konfirmasi Kata Sandi.
  - Tombol aksi bercahaya oranye yang responsif dengan *spring physics*.

### 2. 🌍 Multi-Language / Subtitle (5 Bahasa)
Tersedia pengubah bahasa instan yang dapat diakses dari tombol *language pill* di halaman Login, Beranda, maupun menu Profil:
- 🇮🇩 **Bahasa Indonesia**
- 🇬🇧 **English**
- 🇨🇳 **中文 (Mandarin)**
- 🇯🇵 **日本語 (Japanese)**
- 🇫🇷 **Français (French)**

### 3. 🌗 Mode Tampilan Gelap & Terang (Dark & Light Mode)
- **Mode Terang (*Light Mode*)**: Nuansa hangat pastel peach (`#FF7A45`), kartu frosted glass putih bersih, dan canvas creamy velvet (`#F7F8FC`).
- **Mode Gelap (*Dark Mode*)**: Nuansa ruang angkasa obsidian (`#0C0B18`), kartu slate gelap (`#16152B`), aksen neon peach glow, dan kontras teks perak yang nyaman di mata pada malam hari.
- Sakelar toggle instan tersedia di pojok atas layar Login, header Explore, serta menu pengaturan Profil Paspor.

---

## 🏛️ Arsitektur & Struktur Proyek

```
lib/
├── core/
│   ├── localization/
│   │   ├── app_locale.dart         # Kamus terjemahan 5 bahasa (ID, EN, ZH, JA, FR)
│   │   └── locale_controller.dart  # State pengubah bahasa aktif
│   ├── theme/
│   │   ├── app_colors.dart         # Palet warna pastel orange & celestial dark
│   │   ├── app_shadows.dart        # Shadow 3D soft-realism & ambient depth
│   │   ├── app_typography.dart     # Tipografi Google Fonts dengan fallback offline
│   │   ├── app_theme.dart          # Tema Material 3 Light & Dark mode
│   │   └── theme_controller.dart   # State pengubah tema gelap/terang
│   ├── widgets/
│   │   ├── soft_3d_card.dart       # Komponen container 3D dengan pencahayaan taktil
│   │   ├── glassy_container.dart   # Frosted glass blur container
│   │   ├── interactive_scale_button.dart # Sentuhan pegas (spring micro-interaction)
│   │   ├── perforated_ticket_painter.dart # Notch klip & garis perforasi tiket
│   │   ├── barcode_painter.dart    # Custom painter barcode
│   │   └── qr_code_painter.dart     # Custom painter matriks QR code
│   └── utils/
│       └── formatters.dart         # Format Rupiah, kalender & durasi mandiri anti-crash
├── data/
│   ├── models/
│   │   ├── airport_model.dart      # Entitas bandara & kode IATA
│   │   ├── flight_model.dart       # Entitas jadwal pesawat, armada & harga
│   │   ├── seat_model.dart         # Entitas kursi kabin & fasilitas
│   │   └── booking_model.dart      # Model penumpang, PNR, tiket & status
│   └── mock/
│       └── mock_flight_data.dart   # Data penerbangan realistis
├── presentation/
│   ├── controllers/
│   │   ├── auth_controller.dart    # State login & registrasi pengguna
│   │   └── booking_controller.dart # State pemesanan tiket, filter & kursi
│   ├── navigation/
│   │   └── gen_z_glassy_dock.dart  # Dock kaca melayang dengan morphing pill
│   ├── widgets/
│   │   └── language_selector_sheet.dart # Modal bottom sheet pemilih 5 bahasa
│   └── screens/
│       ├── auth/                   # LoginScreen & RegisterScreen
│       ├── main_shell_screen.dart  # Shell induk pengatur halaman & dock
│       ├── explore/                # Pencarian tiket & carousel viral
│       ├── search_results/         # Hasil pencarian tiket 3D
│       ├── seat_selection/         # Pemilihan kursi kabin pesawat
│       ├── checkout/               # Form penumpang & add-ons
│       ├── boarding_pass/          # Tiket boarding pass 3D yang dapat dibalik
│       ├── trips/                  # Tiket aktif & riwayat perjalanan
│       ├── radar/                  # Radar diskon & flash sale
│       └── profile/                # Paspor digital Gen-Z, bahasa & tema
└── main.dart                       # Entry point aplikasi
```

---

## 🚀 Cara Menjalankan

```bash
# Menjalankan di Chrome (Mode Cepat & Stabil):
flutter run -d chrome --release

# Menjalankan di Microsoft Edge:
flutter run -d edge

# Menjalankan di Android Emulator:
flutter emulators --launch Medium_Phone_API_36.0
flutter run
```
