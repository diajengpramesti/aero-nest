enum AppLanguage {
  id, // Indonesian
  en, // English
  zh, // Mandarin
  ja, // Japanese
  fr, // French
}

class AppLocale {
  static const Map<AppLanguage, Map<String, String>> _translations = {
    AppLanguage.id: {
      // Auth
      'app_name': 'AeroNest',
      'tagline': 'Pengalaman Tiket Pesawat 3D Soft-Realism',
      'welcome_back': 'Selamat Datang Kembali! ✨',
      'login_subtitle': 'Masuk untuk mengelola tiket & poin perjalananmu',
      'email': 'Email',
      'email_hint': 'nama@email.com',
      'password': 'Kata Sandi',
      'password_hint': 'Minimal 8 karakter',
      'full_name': 'Nama Lengkap',
      'full_name_hint': 'Sesuai KTP / Paspor',
      'confirm_password': 'Konfirmasi Kata Sandi',
      'login': 'Masuk ke Akun',
      'register': 'Daftar Akun Baru',
      'create_account': 'Buat Akun AeroNest',
      'dont_have_account': 'Belum punya akun? ',
      'already_have_account': 'Sudah punya akun? ',
      'signup_now': 'Daftar Sekarang',
      'signin_now': 'Masuk di Sini',
      'or_continue': 'atau lanjutkan dengan',
      'forgot_password': 'Lupa Sandi?',

      // Navigation & Shell
      'nav_explore': 'Jelajah',
      'nav_trips': 'Tiket Saya',
      'nav_radar': 'Radar Promo',
      'nav_passport': 'Paspor Digital',

      // Explore
      'greeting': 'Halo, Traveler! ✨',
      'sub_greeting': 'Mau terbang ke mana hari ini?',
      'pro_badge': 'MEMBER',
      'round_trip': 'Pulang-Pergi',
      'one_way': 'Sekali Jalan',
      'multi_city': 'Multi-Kota',
      'from': 'DARI',
      'to': 'KE',
      'date': 'TANGGAL',
      'passengers': 'PENUMPANG',
      'find_flights': 'Cari Penerbangan Terbaik',
      'viral_destinations': 'Destinasi Viral Gen-Z 🔥',
      'viral_sub': 'Paling banyak dipesan minggu ini',
      'see_all': 'Lihat Semua',
      'start_from': 'Mulai dari',
      'perk_carbon': '-25% Karbon',
      'perk_carbon_sub': 'Armada ramah lingkungan',
      'perk_fast': 'Fast-Track',
      'perk_fast_sub': 'Check-in instan 1 tap',
      'perk_wifi': 'Free Starlink',
      'perk_wifi_sub': 'Koneksi 35.000 kaki',

      // Search & Booking
      'flight_found': 'Ditemukan Penerbangan',
      'tax_included': 'Harga sudah termasuk pajak',
      'cheapest': 'Termurah',
      'fastest': 'Tercepat',
      'earliest': 'Paling Pagi',
      'direct_only': 'Langsung Saja',
      'select': 'Pilih',
      'direct': 'Langsung',
      'transit': 'Transit',

      // Seats & Addons
      'pick_seat': 'Pilih Kursi Kamu',
      'confirm_seat': 'Pilih Kursi & Lanjut',
      'addons_title': 'Data & Layanan Tambahan',
      'passenger_data': 'DATA PENUMPANG UTAMA',
      'meal_selection': 'PILIHAN MAKANAN DI PESAWAT',
      'extra_baggage': 'Ekstra Bagasi Terdaftar',
      'free': 'Gratis',
      'total_payment': 'Total Pembayaran',
      'issue_ticket': 'Terbitkan E-Ticket',

      // Boarding Pass
      'boarding_pass_title': 'Boarding Pass Digital',
      'booking_success': 'Pemesanan Berhasil & Tiket Terbit! 🎉',
      'scan_autogate': 'SCAN DI AUTOGATE KABIN',
      'tap_to_flip': 'Ketuk tiket untuk melihat perks & terminal map',
      'save_wallet': 'Simpan ke Apple / Google Wallet',
      'back_home': 'Kembali ke Beranda',

      // Profile & Settings
      'passport_title': 'Paspor Digital ✈️',
      'passport_sub': 'Status keanggotaan & histori petualangan',
      'miles_flown': 'JARAK TERBANG',
      'countries': 'NEGARA',
      'co2_offset': 'OFFSET CO₂',
      'traveler_badges': 'LENCANA PETUALANG GEN-Z 🏆',
      'settings': 'PENGATURAN & PREFERENSI',
      'theme_mode': 'Mode Tampilan',
      'dark_mode': 'Mode Gelap',
      'light_mode': 'Mode Terang',
      'language': 'Bahasa / Language',
      'logout': 'Keluar Akun',
      'guest_mode': 'Mode Tamu',
      'guest_badge': 'TAMU',
      'guest_login_btn': 'Masuk sebagai Tamu (Mode Tamu)',
      'guest_login_sub': 'Jelajahi tiket tanpa mendaftar',
      'guest_banner_title': 'Mode Tamu Aktif 👤',
      'guest_banner_desc': 'Daftar/Masuk untuk simpan tiket permanen & klaim diskon Rp 250rb!',
      'guest_upgrade_btn': 'Daftar / Masuk Akun',
      'guide_title': 'Petunjuk Akses Aplikasi',
      'guide_member_perks': 'Keuntungan Punya Akun:',
      'guide_guest_perks': 'Batasan Mode Tamu:',
      'guest_passport_title': 'Paspor Tamu Sementara',
      'guest_passport_desc': 'Miles & tiket belum tersimpan ke Cloud AeroNest',
      'guest_upgrade_card_title': 'Buka Akses Penuh Paspor Penjelajah',
      'guest_upgrade_card_desc': 'Daftar sekarang untuk sinkronisasi tiket, klaim bonus 1.200 Miles, dan voucher diskon Rp 250.000.',
    },

    AppLanguage.en: {
      // Auth
      'app_name': 'AeroNest',
      'tagline': '3D Soft-Realism Flight Experience',
      'welcome_back': 'Welcome Back! ✨',
      'login_subtitle': 'Sign in to manage your flight tickets & miles',
      'email': 'Email',
      'email_hint': 'name@email.com',
      'password': 'Password',
      'password_hint': 'At least 8 characters',
      'full_name': 'Full Name',
      'full_name_hint': 'As on Passport / ID',
      'confirm_password': 'Confirm Password',
      'login': 'Sign In',
      'register': 'Sign Up',
      'create_account': 'Create AeroNest Account',
      'dont_have_account': "Don't have an account? ",
      'already_have_account': 'Already have an account? ',
      'signup_now': 'Register Now',
      'signin_now': 'Sign In Here',
      'or_continue': 'or continue with',
      'forgot_password': 'Forgot Password?',

      // Navigation & Shell
      'nav_explore': 'Explore',
      'nav_trips': 'My Trips',
      'nav_radar': 'Radar Deals',
      'nav_passport': 'Passport',

      // Explore
      'greeting': 'Hello, Traveler! ✨',
      'sub_greeting': 'Where would you like to fly today?',
      'pro_badge': 'MEMBER',
      'round_trip': 'Round-Trip',
      'one_way': 'One-Way',
      'multi_city': 'Multi-City',
      'from': 'FROM',
      'to': 'TO',
      'date': 'DATE',
      'passengers': 'PASSENGERS',
      'find_flights': 'Find Best Flights',
      'viral_destinations': 'Viral Gen-Z Escapes 🔥',
      'viral_sub': 'Most booked flights this week',
      'see_all': 'See All',
      'start_from': 'Starting from',
      'perk_carbon': '-25% Carbon',
      'perk_carbon_sub': 'Eco-friendly modern fleet',
      'perk_fast': 'Fast-Track',
      'perk_fast_sub': '1-tap instant check-in',
      'perk_wifi': 'Free Starlink',
      'perk_wifi_sub': 'Fast speed at 35,000 ft',

      // Search & Booking
      'flight_found': 'Flights Found',
      'tax_included': 'Taxes & fees included',
      'cheapest': 'Cheapest',
      'fastest': 'Fastest',
      'earliest': 'Earliest',
      'direct_only': 'Direct Only',
      'select': 'Select',
      'direct': 'Direct',
      'transit': 'Stop',

      // Seats & Addons
      'pick_seat': 'Choose Your Seat',
      'confirm_seat': 'Select Seat & Continue',
      'addons_title': 'Passenger & Add-on Services',
      'passenger_data': 'PRIMARY PASSENGER INFO',
      'meal_selection': 'IN-FLIGHT GOURMET DINING',
      'extra_baggage': 'Checked Baggage Add-on',
      'free': 'Included',
      'total_payment': 'Total Payment',
      'issue_ticket': 'Issue E-Ticket',

      // Boarding Pass
      'boarding_pass_title': 'Digital Boarding Pass',
      'booking_success': 'Booking Confirmed & Ticket Issued! 🎉',
      'scan_autogate': 'SCAN AT CABIN AUTOGATE',
      'tap_to_flip': 'Tap ticket to view perks & terminal map',
      'save_wallet': 'Save to Apple / Google Wallet',
      'back_home': 'Back to Home',

      // Profile & Settings
      'passport_title': 'Digital Passport ✈️',
      'passport_sub': 'Travel statistics & adventure history',
      'miles_flown': 'MILES FLOWN',
      'countries': 'COUNTRIES',
      'co2_offset': 'CO₂ OFFSET',
      'traveler_badges': 'GEN-Z EXPLORER BADGES 🏆',
      'settings': 'SETTINGS & PREFERENCES',
      'theme_mode': 'Theme Display',
      'dark_mode': 'Dark Mode',
      'light_mode': 'Light Mode',
      'language': 'Language',
      'logout': 'Sign Out',
      'guest_mode': 'Guest Mode',
      'guest_badge': 'GUEST',
      'guest_login_btn': 'Continue as Guest',
      'guest_login_sub': 'Explore flights without an account',
      'guest_banner_title': 'Guest Mode Active 👤',
      'guest_banner_desc': 'Sign up/in to save tickets permanently & claim Rp 250k voucher!',
      'guest_upgrade_btn': 'Sign In / Register',
      'guide_title': 'App Access Guide',
      'guide_member_perks': 'Member Account Perks:',
      'guide_guest_perks': 'Guest Limitations:',
      'guest_passport_title': 'Temporary Guest Passport',
      'guest_passport_desc': 'Miles & bookings not synced to AeroNest Cloud',
      'guest_upgrade_card_title': 'Unlock Full Explorer Passport',
      'guest_upgrade_card_desc': 'Sign up now to sync bookings, claim 1,200 bonus Miles, and Rp 250k discount voucher.',
    },

    AppLanguage.zh: {
      // Auth
      'app_name': 'AeroNest 航空',
      'tagline': '3D 拟物感机票预订体验',
      'welcome_back': '欢迎回来！✨',
      'login_subtitle': '登录以管理您的机票与飞行里程',
      'email': '电子邮箱',
      'email_hint': 'name@email.com',
      'password': '密码',
      'password_hint': '至少8个字符',
      'full_name': '姓名（护照英文）',
      'full_name_hint': '与护照或身份证一致',
      'confirm_password': '确认密码',
      'login': '立即登录',
      'register': '注册新账户',
      'create_account': '创建 AeroNest 账户',
      'dont_have_account': '还没有账号？',
      'already_have_account': '已有账号？',
      'signup_now': '立即注册',
      'signin_now': '在此登录',
      'or_continue': '或通过第三方登录',
      'forgot_password': '忘记密码？',

      // Navigation & Shell
      'nav_explore': '探索',
      'nav_trips': '我的行程',
      'nav_radar': '特惠雷达',
      'nav_passport': '电子护照',

      // Explore
      'greeting': '你好，旅行家！✨',
      'sub_greeting': '今天想飞往哪里？',
      'pro_badge': '钻石会员',
      'round_trip': '往返',
      'one_way': '单程',
      'multi_city': '多程',
      'from': '出发地',
      'to': '目的地',
      'date': '日期',
      'passengers': '乘客人数',
      'find_flights': '搜索特惠航班',
      'viral_destinations': '热门度假胜地 🔥',
      'viral_sub': '本周年轻旅客最爱榜',
      'see_all': '查看全部',
      'start_from': '起价',
      'perk_carbon': '-25% 碳排放',
      'perk_carbon_sub': '新一代低碳环保机队',
      'perk_fast': '快速通关',
      'perk_fast_sub': '一键极速值机',
      'perk_wifi': '免费星链网络',
      'perk_wifi_sub': '万米高空极速冲浪',

      // Search & Booking
      'flight_found': '找到的航班',
      'tax_included': '已含所有税费',
      'cheapest': '价格最低',
      'fastest': '飞行最短',
      'earliest': '最早出发',
      'direct_only': '仅看直飞',
      'select': '选择',
      'direct': '直飞',
      'transit': '中转',

      // Seats & Addons
      'pick_seat': '挑选您的机上座位',
      'confirm_seat': '确认座位并继续',
      'addons_title': '乘机人信息与附加服务',
      'passenger_data': '主要乘客信息',
      'meal_selection': '机上尊享主厨美馔',
      'extra_baggage': '购买额外托运行李',
      'free': '已包含',
      'total_payment': '应付总金额',
      'issue_ticket': '即刻出票',

      // Boarding Pass
      'boarding_pass_title': '电子登机牌',
      'booking_success': '出票成功！祝您旅途愉快 🎉',
      'scan_autogate': '请在登机闸机前出示二维码扫码',
      'tap_to_flip': '轻触卡片查看行李转盘与航站楼指引',
      'save_wallet': '添加至 Apple / Google 钱包',
      'back_home': '返回首页',

      // Profile & Settings
      'passport_title': '数字旅行护照 ✈️',
      'passport_sub': '会员等级与足迹记录',
      'miles_flown': '总飞行里程',
      'countries': '打卡国家',
      'co2_offset': '碳减排量',
      'traveler_badges': '潮玩探险勋章 🏆',
      'settings': '系统设置与偏好',
      'theme_mode': '主题风格',
      'dark_mode': '暗黑模式',
      'light_mode': '亮色模式',
      'language': '语言选择 / Language',
      'logout': '退出登录',
      'guest_mode': '访客模式',
      'guest_badge': '访客',
      'guest_login_btn': '以访客身份继续',
      'guest_login_sub': '无需注册即可浏览航班',
      'guest_banner_title': '访客模式已激活 👤',
      'guest_banner_desc': '注册/登录以永久保存机票并领取 250,000 印尼盾优惠券！',
      'guest_upgrade_btn': '注册 / 登录',
      'guide_title': '应用访问指南',
      'guide_member_perks': '会员特权：',
      'guide_guest_perks': '访客限制：',
      'guest_passport_title': '临时访客护照',
      'guest_passport_desc': '里程与订单未同步至 AeroNest 云端',
      'guest_upgrade_card_title': '解锁完整探索者护照',
      'guest_upgrade_card_desc': '立即注册以同步订单、领取 1,200 奖励里程及 250,000 印尼盾优惠券。',
    },

    AppLanguage.ja: {
      // Auth
      'app_name': 'AeroNest 航空',
      'tagline': '3Dソフトリアリズム航空券予約',
      'welcome_back': 'おかえりなさい！✨',
      'login_subtitle': 'ログインしてフライトとマイルを管理',
      'email': 'メールアドレス',
      'email_hint': 'name@email.com',
      'password': 'パスワード',
      'password_hint': '8文字以上',
      'full_name': '氏名（ローマ字）',
      'full_name_hint': 'パスポートと同一表記',
      'confirm_password': 'パスワード再確認',
      'login': 'ログイン',
      'register': '新規会員登録',
      'create_account': 'AeroNest アカウント作成',
      'dont_have_account': 'アカウントをお持ちでない方 ',
      'already_have_account': 'すでに登録済みの方 ',
      'signup_now': '今すぐ登録',
      'signin_now': 'こちらからログイン',
      'or_continue': 'または他の方法でログイン',
      'forgot_password': 'パスワードをお忘れですか？',

      // Navigation & Shell
      'nav_explore': '検索・探す',
      'nav_trips': '予約確認',
      'nav_radar': 'セール速報',
      'nav_passport': 'パスポート',

      // Explore
      'greeting': 'こんにちは、トラベラー！✨',
      'sub_greeting': '今日はどちらへフライトしますか？',
      'pro_badge': '会員',
      'round_trip': '往復',
      'one_way': '片道',
      'multi_city': '複数都市',
      'from': '出発地',
      'to': '目的地',
      'date': '出発日',
      'passengers': '搭乗者数',
      'find_flights': '最安フライトを検索',
      'viral_destinations': '今話題の注目スポット 🔥',
      'viral_sub': '今週最も予約された人気ルート',
      'see_all': 'すべて見る',
      'start_from': '最安',
      'perk_carbon': '-25% CO₂削減',
      'perk_carbon_sub': '環境に配慮した最新鋭機',
      'perk_fast': 'ファストパス',
      'perk_fast_sub': 'ワンタップ即時チェックイン',
      'perk_wifi': '無料Starlink Wi-Fi',
      'perk_wifi_sub': '上空1万メートルでも超高速',

      // Search & Booking
      'flight_found': '件のフライトが見つかりました',
      'tax_included': '諸税・燃油サーチャージ込み',
      'cheapest': '最安順',
      'fastest': '最短所要時間',
      'earliest': '早朝発順',
      'direct_only': '直行便のみ',
      'select': '選択',
      'direct': '直行便',
      'transit': '経由便',

      // Seats & Addons
      'pick_seat': '座席をお選びください',
      'confirm_seat': '座席を確定して次へ',
      'addons_title': 'ご搭乗者情報・追加オプション',
      'passenger_data': 'ご搭乗者基本情報',
      'meal_selection': '機内スペシャルミール',
      'extra_baggage': '受託手荷物追加',
      'free': '無料含む',
      'total_payment': 'お支払い合計金額',
      'issue_ticket': 'チケットを発券する',

      // Boarding Pass
      'boarding_pass_title': 'デジタル搭乗券',
      'booking_success': '予約完了＆発券されました！🎉',
      'scan_autogate': '搭乗ゲートのリーダーにかざしてください',
      'tap_to_flip': 'タップして荷物受取ターンテーブルと空港マップを表示',
      'save_wallet': 'Apple / Google ウォレットに保存',
      'back_home': 'ホームへ戻る',

      // Profile & Settings
      'passport_title': 'デジタルパスポート ✈️',
      'passport_sub': 'フライト履歴＆ステータス',
      'miles_flown': '総飛行マイル',
      'countries': '訪れた国',
      'co2_offset': 'CO₂オフセット量',
      'traveler_badges': 'アドベンチャーバッジ 🏆',
      'settings': '設定と環境設定',
      'theme_mode': 'テーマ表示',
      'dark_mode': 'ダークモード',
      'light_mode': 'ライトモード',
      'language': '言語切り替え / Language',
      'logout': 'ログアウト',
      'guest_mode': 'ゲストモード',
      'guest_badge': 'ゲスト',
      'guest_login_btn': 'ゲストとして続行',
      'guest_login_sub': 'アカウントなしでフライトを検索',
      'guest_banner_title': 'ゲストモード中 👤',
      'guest_banner_desc': '登録/ログインしてチケットを永続保存＆25万ルピア割引獲得！',
      'guest_upgrade_btn': '登録 / ログイン',
      'guide_title': 'アプリ利用案内',
      'guide_member_perks': '会員特典：',
      'guide_guest_perks': 'ゲストの制限：',
      'guest_passport_title': '一時ゲストパスポート',
      'guest_passport_desc': 'マイルと予約はクラウドに保存されていません',
      'guest_upgrade_card_title': 'エクスプローラーパスポートを解放',
      'guest_upgrade_card_desc': '今すぐ登録して予約を同期し、1,200ボーナスマイルと25万ルピアクーポンを獲得。',
    },

    AppLanguage.fr: {
      // Auth
      'app_name': 'AeroNest',
      'tagline': 'Réservation de Vol 3D Soft-Réalisme',
      'welcome_back': 'Bon retour ! ✨',
      'login_subtitle': 'Connectez-vous pour gérer vos billets et miles',
      'email': 'Adresse e-mail',
      'email_hint': 'nom@email.com',
      'password': 'Mot de passe',
      'password_hint': 'Au moins 8 caractères',
      'full_name': 'Nom complet',
      'full_name_hint': 'Identique au passeport',
      'confirm_password': 'Confirmer le mot de passe',
      'login': 'Se Connecter',
      'register': 'Créer un Compte',
      'create_account': 'Rejoindre AeroNest',
      'dont_have_account': 'Pas encore de compte ? ',
      'already_have_account': 'Déjà un compte ? ',
      'signup_now': "S'inscrire",
      'signin_now': 'Se connecter',
      'or_continue': 'ou continuer avec',
      'forgot_password': 'Mot de passe oublié ?',

      // Navigation & Shell
      'nav_explore': 'Explorer',
      'nav_trips': 'Mes Vols',
      'nav_radar': 'Bons Plans',
      'nav_passport': 'Passeport',

      // Explore
      'greeting': 'Bonjour, Voyageur ! ✨',
      'sub_greeting': 'Où souhaitez-vous décoller aujourd’hui ?',
      'pro_badge': 'MEMBRE',
      'round_trip': 'Aller-Retour',
      'one_way': 'Aller Simple',
      'multi_city': 'Multi-Destinations',
      'from': 'DÉPART',
      'to': 'ARRIVÉE',
      'date': 'DATE',
      'passengers': 'PASSAGERS',
      'find_flights': 'Trouver les Meilleurs Vols',
      'viral_destinations': 'Destinations Tendances 🔥',
      'viral_sub': 'Les plus réservées cette semaine',
      'see_all': 'Voir Tout',
      'start_from': 'À partir de',
      'perk_carbon': '-25% Carbone',
      'perk_carbon_sub': 'Flotte moderne et éco-responsable',
      'perk_fast': 'Accès Rapide',
      'perk_fast_sub': 'Enregistrement en 1 clic',
      'perk_wifi': 'Starlink Inclus',
      'perk_wifi_sub': 'Connexion rapide à 10 000 m',

      // Search & Booking
      'flight_found': 'Vols Trouvés',
      'tax_included': 'Taxes et frais inclus',
      'cheapest': 'Moins Cher',
      'fastest': 'Plus Rapide',
      'earliest': 'Plus Tôt',
      'direct_only': 'Direct Uniquement',
      'select': 'Choisir',
      'direct': 'Direct',
      'transit': 'Escale',

      // Seats & Addons
      'pick_seat': 'Choisissez Votre Siège',
      'confirm_seat': 'Valider le Siège & Continuer',
      'addons_title': 'Informations & Services à Bord',
      'passenger_data': 'INFOS PASSAGER PRINCIPAL',
      'meal_selection': 'REPAS GASTRONOMIQUE À BORD',
      'extra_baggage': 'Bagage en Soute Supplémentaire',
      'free': 'Inclus',
      'total_payment': 'Montant Total',
      'issue_ticket': 'Émettre le Billet',

      // Boarding Pass
      'boarding_pass_title': 'Carte d’Embarquement',
      'booking_success': 'Réservation Réussie ! Bon voyage 🎉',
      'scan_autogate': 'SCANNEZ AUX PORTES D’EMBARQUEMENT',
      'tap_to_flip': 'Touchez le billet pour voir le tapis bagages et terminal',
      'save_wallet': 'Enregistrer dans Apple / Google Wallet',
      'back_home': 'Retour à l’Accueil',

      // Profile & Settings
      'passport_title': 'Passeport Numérique ✈️',
      'passport_sub': 'Statistiques de voyage et historique',
      'miles_flown': 'MILES PARCOURUS',
      'countries': 'PAYS VISITÉS',
      'co2_offset': 'CO₂ COMPENSÉ',
      'traveler_badges': 'BADGES AVENTURIER 🏆',
      'settings': 'PARAMÈTRES & PRÉFÉRENCES',
      'theme_mode': 'Thème d’affichage',
      'dark_mode': 'Mode Sombre',
      'light_mode': 'Mode Clair',
      'language': 'Langue / Language',
      'logout': 'Se Déconnecter',
      'guest_mode': 'Mode Invité',
      'guest_badge': 'INVITÉ',
      'guest_login_btn': 'Continuer en invité',
      'guest_login_sub': 'Explorer les vols sans compte',
      'guest_banner_title': 'Mode Invité Actif 👤',
      'guest_banner_desc': 'Connectez-vous pour sauvegarder vos billets & débloquer 250 000 Rp !',
      'guest_upgrade_btn': 'S\'inscrire / Connexion',
      'guide_title': 'Guide d\'accès',
      'guide_member_perks': 'Avantages Membre :',
      'guide_guest_perks': 'Limitations Invité :',
      'guest_passport_title': 'Passeport Invité Temporaire',
      'guest_passport_desc': 'Miles et billets non synchronisés sur le Cloud',
      'guest_upgrade_card_title': 'Débloquez le Passeport Complet',
      'guest_upgrade_card_desc': 'Inscrivez-vous pour synchroniser vos vols, obtenir 1 200 miles bonus et un bon de 250 000 Rp.',
    },
  };

  static String getText(AppLanguage lang, String key) {
    return _translations[lang]?[key] ?? _translations[AppLanguage.id]?[key] ?? key;
  }

  static String getLanguageLabel(AppLanguage lang) {
    switch (lang) {
      case AppLanguage.id:
        return '🇮🇩 Bahasa Indonesia';
      case AppLanguage.en:
        return '🇬🇧 English';
      case AppLanguage.zh:
        return '🇨🇳 中文 (Mandarin)';
      case AppLanguage.ja:
        return '🇯🇵 日本語 (Japanese)';
      case AppLanguage.fr:
        return '🇫🇷 Français (French)';
    }
  }

  static String getLanguageShort(AppLanguage lang) {
    switch (lang) {
      case AppLanguage.id:
        return 'ID';
      case AppLanguage.en:
        return 'EN';
      case AppLanguage.zh:
        return 'ZH';
      case AppLanguage.ja:
        return 'JA';
      case AppLanguage.fr:
        return 'FR';
    }
  }
}
