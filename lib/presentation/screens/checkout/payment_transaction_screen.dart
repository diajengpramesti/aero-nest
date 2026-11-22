import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/interactive_scale_button.dart';
import '../../../core/widgets/qr_code_painter.dart';
import '../../../core/widgets/soft_3d_card.dart';
import '../../controllers/booking_controller.dart';
import '../boarding_pass/boarding_pass_screen.dart';

class PaymentTransactionScreen extends StatefulWidget {
  final BookingController controller;
  final String passengerName;
  final String passengerEmail;
  final String passengerPhone;
  final String passportNumber;

  const PaymentTransactionScreen({
    super.key,
    required this.controller,
    required this.passengerName,
    required this.passengerEmail,
    required this.passengerPhone,
    required this.passportNumber,
  });

  @override
  State<PaymentTransactionScreen> createState() => _PaymentTransactionScreenState();
}

class _PaymentTransactionScreenState extends State<PaymentTransactionScreen> {
  final _promoController = TextEditingController(text: 'AEROGENZ');
  bool _isProcessing = false;
  String? _promoMessage;

  @override
  void initState() {
    super.initState();
    // Pre-apply default promo
    widget.controller.applyPromo('AEROGENZ');
  }

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  void _applyPromo() {
    final code = _promoController.text.trim();
    final ok = widget.controller.applyPromo(code);
    setState(() {
      _promoMessage = ok ? 'Kupon AEROGENZ berhasil digunakan (-Rp 250.000) 🎉' : 'Kode promo tidak valid';
    });
  }

  void _processPayment() {
    setState(() => _isProcessing = true);

    // Simulate real-time payment gateway handshake
    Timer(const Duration(milliseconds: 1600), () {
      if (!mounted) return;
      final booking = widget.controller.confirmBooking(
        fullName: widget.passengerName,
        email: widget.passengerEmail,
        phone: widget.passengerPhone,
        passport: widget.passportNumber,
      );

      setState(() => _isProcessing = false);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (ctx) => BoardingPassScreen(
            booking: booking,
            isNewlyBooked: true,
          ),
        ),
        (route) => route.isFirst,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final f = widget.controller.selectedFlight;
    final seat = widget.controller.selectedSeat;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded,
              size: 20, color: isDark ? Colors.white : AppColors.midnight),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Pembayaran & Transaksi',
          style: AppTypography.headingMedium.copyWith(
            color: isDark ? Colors.white : AppColors.midnight,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 140),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Countdown Timer Header
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.orangeCream,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.orangePastel),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.timer_outlined, color: AppColors.orangePrimary, size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Selesaikan transaksi dalam 14:59 agar kursi tidak hangus',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: isDark ? AppColors.midnight : AppColors.orangePrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Section 1: Payment Method Selector
                Text('PILIH METODE PEMBAYARAN', style: AppTypography.bodySmall),
                const SizedBox(height: 12),

                // Method 1: QRIS
                _buildPaymentTile(
                  method: PaymentMethodType.qris,
                  icon: Icons.qr_code_scanner_rounded,
                  title: 'QRIS Real-Time',
                  desc: 'BCA, GoPay, OVO, ShopeePay, Dana, Bank Mandiri',
                  badge: 'INSTANT SCAN',
                  isDark: isDark,
                  extraContent: widget.controller.selectedPaymentMethod == PaymentMethodType.qris
                      ? Center(
                          child: Container(
                            margin: const EdgeInsets.only(top: 14),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: AppShadows.soft3D(elevation: 4, blurRadius: 10),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 140,
                                  height: 140,
                                  child: CustomPaint(
                                    painter: QRCodePainter(primaryColor: AppColors.midnight),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Scan menggunakan aplikasi e-wallet atau m-Banking Anda',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.slateMuted),
                                ),
                              ],
                            ),
                          ),
                        )
                      : null,
                ),

                const SizedBox(height: 12),

                // Method 2: Virtual Account
                _buildPaymentTile(
                  method: PaymentMethodType.virtualAccount,
                  icon: Icons.account_balance_rounded,
                  title: 'Virtual Account (VA Otomatis)',
                  desc: 'BCA, Bank Mandiri, BNI, BRI, Permata',
                  badge: 'VERIFIKASI 5 DETIK',
                  isDark: isDark,
                  extraContent: widget.controller.selectedPaymentMethod == PaymentMethodType.virtualAccount
                      ? Container(
                          margin: const EdgeInsets.only(top: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF22203E) : AppColors.surfaceSoft,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Nomor VA BCA:', style: TextStyle(fontSize: 11, color: AppColors.slateMuted)),
                                  Text('8801 9824 1009 2311',
                                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.orangePrimary)),
                                ],
                              ),
                              InteractiveScaleButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Nomor Virtual Account disalin ke clipboard! 📋')),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: AppColors.orangePrimary,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Text('Salin',
                                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white)),
                                ),
                              ),
                            ],
                          ),
                        )
                      : null,
                ),

                const SizedBox(height: 12),

                // Method 3: Credit / Debit Card (Visa/Mastercard)
                _buildPaymentTile(
                  method: PaymentMethodType.creditCard,
                  icon: Icons.credit_card_rounded,
                  title: 'Kartu Kredit / Debit Online',
                  desc: 'Visa, Mastercard, JCB, American Express',
                  badge: 'CICILAN 0%',
                  isDark: isDark,
                  extraContent: widget.controller.selectedPaymentMethod == PaymentMethodType.creditCard
                      ? Container(
                          margin: const EdgeInsets.only(top: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF201D38), Color(0xFF0F0E20)],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 14, offset: const Offset(0, 6)),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('💳 AeroBlack World Elite',
                                      style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w700)),
                                  Text('VISA',
                                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900)),
                                ],
                              ),
                              const SizedBox(height: 16),
                              const Text('•••• •••• •••• 4242',
                                  style: TextStyle(color: Colors.white, fontSize: 18, letterSpacing: 2, fontWeight: FontWeight.w800)),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(widget.passengerName.toUpperCase(),
                                      style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w700)),
                                  const Text('EXP 12/29',
                                      style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w700)),
                                ],
                              ),
                            ],
                          ),
                        )
                      : null,
                ),

                const SizedBox(height: 24),

                // Section 2: Promo Coupon Code
                Text('KODE PROMO & VOUCHER', style: AppTypography.bodySmall),
                const SizedBox(height: 10),
                Soft3DCard(
                  baseColor: isDark ? const Color(0xFF16152B) : Colors.white,
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14),
                              decoration: BoxDecoration(
                                color: isDark ? const Color(0xFF22203E) : AppColors.surfaceSoft,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: TextField(
                                controller: _promoController,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: isDark ? Colors.white : AppColors.midnight,
                                ),
                                decoration: const InputDecoration(
                                  hintText: 'Masukkan kode promo',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          InteractiveScaleButton(
                            onPressed: _applyPromo,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              decoration: BoxDecoration(
                                gradient: AppColors.sunsetOrangeGradient,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: const Text('Terapkan',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12)),
                            ),
                          ),
                        ],
                      ),
                      if (_promoMessage != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          _promoMessage!,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: widget.controller.appliedPromoCode != null ? AppColors.mintSuccess : AppColors.coralAlert,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Section 3: Cost Breakdown
                Text('RINCIAN PEMBAYARAN', style: AppTypography.bodySmall),
                const SizedBox(height: 10),
                Soft3DCard(
                  baseColor: isDark ? const Color(0xFF16152B) : Colors.white,
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      _buildPriceRow('Tarif Tiket Penerbangan (${widget.controller.totalPassengers} pax)',
                          Formatters.formatRupiah((f?.basePrice ?? 1500000) * widget.controller.totalPassengers), isDark),
                      if (seat != null && seat.extraPrice > 0)
                        _buildPriceRow('Pilihan Kursi Spesial (${seat.code})',
                            Formatters.formatRupiah(seat.extraPrice), isDark),
                      if (widget.controller.extraBaggageKg > 0)
                        _buildPriceRow('Ekstra Bagasi (+${widget.controller.extraBaggageKg} kg)',
                            Formatters.formatRupiah(widget.controller.extraBaggageKg * 45000), isDark),
                      if (widget.controller.hasTravelInsurance)
                        _buildPriceRow('Asuransi AeroProtect™',
                            Formatters.formatRupiah(75000 * widget.controller.totalPassengers), isDark),
                      _buildPriceRow('Pajak Bandara & Pelayanan (PPN 11%)', 'Termasuk', isDark, isFree: true),
                      if (widget.controller.discountAmount > 0)
                        _buildPriceRow('Diskon Kupon (${widget.controller.appliedPromoCode})',
                            '- ${Formatters.formatRupiah(widget.controller.discountAmount)}', isDark, isDiscount: true),
                      Divider(height: 24, color: isDark ? const Color(0xFF29274C) : AppColors.borderLight),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('TOTAL BAYAR',
                              style: AppTypography.headingLarge.copyWith(
                                  fontSize: 16, color: isDark ? Colors.white : AppColors.midnight)),
                          Text(
                            Formatters.formatRupiah(widget.controller.checkoutTotalPrice),
                            style: AppTypography.headingLarge.copyWith(
                              fontSize: 22,
                              color: AppColors.orangePrimary,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1B1832) : const Color(0xFFFFF9F5),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.orangePrimary.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.verified_user_outlined, color: AppColors.mintSuccess, size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Pemesanan terlindungi oleh Enkripsi 256-bit SSL. E-Tiket & Boarding Pass resmi terbit instan setelah pembayaran terkonfirmasi.',
                          style: TextStyle(
                            fontSize: 10.5,
                            color: isDark ? const Color(0xFFC7C5DC) : const Color(0xFF555273),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Loading overlay during transaction
          if (_isProcessing)
            Container(
              color: Colors.black.withValues(alpha: 0.65),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1C1A36) : Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: AppShadows.soft3D(elevation: 12, blurRadius: 30),
                  ),
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(color: AppColors.orangePrimary),
                      SizedBox(height: 18),
                      Text(
                        'Memproses Pembayaran...',
                        style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Menghubungkan ke Gateway Tiket Resmi',
                        style: TextStyle(fontSize: 12, color: AppColors.slateMuted),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),

      // Bottom Bar
      bottomSheet: Container(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF16152B) : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, -6),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Total Pembayaran', style: TextStyle(fontSize: 11, color: AppColors.slateMuted)),
                  Text(
                    Formatters.formatRupiah(widget.controller.checkoutTotalPrice),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: AppColors.orangePrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: InteractiveScaleButton(
                  onPressed: _isProcessing ? null : _processPayment,
                  child: Container(
                    height: 52,
                    decoration: BoxDecoration(
                      gradient: AppColors.sunsetOrangeGradient,
                      borderRadius: BorderRadius.circular(26),
                      boxShadow: AppShadows.orangeGlow,
                    ),
                    alignment: Alignment.center,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.lock_rounded, color: Colors.white, size: 18),
                        SizedBox(width: 8),
                        Text(
                          'Bayar Sekarang & Cetak',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentTile({
    required PaymentMethodType method,
    required IconData icon,
    required String title,
    required String desc,
    required String badge,
    required bool isDark,
    Widget? extraContent,
  }) {
    final isSelected = widget.controller.selectedPaymentMethod == method;

    return GestureDetector(
      onTap: () => widget.controller.setPaymentMethod(method),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? const Color(0xFF221F3F) : AppColors.orangeCream)
              : (isDark ? const Color(0xFF16152B) : Colors.white),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: isSelected ? AppColors.orangePrimary : (isDark ? const Color(0xFF29274C) : AppColors.borderLight),
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: isSelected ? AppShadows.soft3D(elevation: 4, blurRadius: 10) : null,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.orangePrimary : (isDark ? const Color(0xFF29274C) : AppColors.surfaceSoft),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(icon, color: isSelected ? Colors.white : AppColors.orangePrimary, size: 22),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(title,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: isDark ? Colors.white : AppColors.midnight)),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.mintSoft,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(badge,
                                style: const TextStyle(
                                    fontSize: 8, fontWeight: FontWeight.w800, color: AppColors.mintSuccess)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(desc, style: const TextStyle(fontSize: 11, color: AppColors.slateMuted)),
                    ],
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? AppColors.orangePrimary : Colors.transparent,
                    border: Border.all(
                      color: isSelected
                          ? AppColors.orangePrimary
                          : (isDark ? AppColors.darkBorder : const Color(0xFFD0D7E2)),
                      width: 2,
                    ),
                    boxShadow: isSelected ? AppShadows.orangeGlow : null,
                  ),
                  child: isSelected
                      ? const Center(
                          child: Icon(Icons.check, size: 13, color: Colors.white),
                        )
                      : null,
                ),
              ],
            ),
            if (extraContent != null) extraContent,
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, bool isDark, {bool isFree = false, bool isDiscount = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(label, style: TextStyle(fontSize: 12, color: isDark ? const Color(0xFF9E9BAC) : AppColors.slateMuted)),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: isDiscount
                  ? AppColors.mintSuccess
                  : isFree
                      ? AppColors.mintSuccess
                      : (isDark ? Colors.white : AppColors.midnight),
            ),
          ),
        ],
      ),
    );
  }
}
