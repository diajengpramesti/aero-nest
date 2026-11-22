import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/interactive_scale_button.dart';
import '../../../data/models/booking_model.dart';
import '../../widgets/ticket_print_preview_modal.dart';
import 'widgets/flippable_3d_ticket.dart';

class BoardingPassScreen extends StatelessWidget {
  final Booking booking;
  final bool isNewlyBooked;

  const BoardingPassScreen({
    super.key,
    required this.booking,
    this.isNewlyBooked = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded,
              size: 20, color: isDark ? Colors.white : AppColors.midnight),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Boarding Pass Digital',
          style: AppTypography.headingMedium.copyWith(
            color: isDark ? Colors.white : AppColors.midnight,
          ),
        ),
        centerTitle: true,
        actions: [
          // Print Action
          IconButton(
            icon: Icon(Icons.print_outlined, color: isDark ? Colors.white : AppColors.midnight),
            onPressed: () => TicketPrintPreviewModal.show(context, booking: booking),
          ),
          // Share Action
          IconButton(
            icon: Icon(Icons.share_outlined, color: isDark ? Colors.white : AppColors.midnight),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Tautan Boarding Pass berhasil disalin! 📋')),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              if (isNewlyBooked) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.mintSoft,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle_rounded, color: AppColors.mintSuccess, size: 18),
                      SizedBox(width: 8),
                      Text(
                        'Transaksi Berhasil & Tiket Terbit! 🎉',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.mintSuccess,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // 3D Flippable Ticket
              SizedBox(
                height: 520,
                child: Flippable3DTicket(booking: booking),
              ),

              const SizedBox(height: 24),

              // Button 1: Cetak Dokumen Tiket / PDF
              InteractiveScaleButton(
                onPressed: () => TicketPrintPreviewModal.show(context, booking: booking),
                child: Container(
                  height: 52,
                  decoration: BoxDecoration(
                    gradient: AppColors.sunsetOrangeGradient,
                    borderRadius: BorderRadius.circular(26),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.orangePrimary.withValues(alpha: 0.35),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.print_rounded, color: Colors.white, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Cetak Tiket Fisik / Simpan PDF',
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

              const SizedBox(height: 12),

              // Button 2: Apple / Google Wallet
              InteractiveScaleButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Tiket ditambahkan ke Google / Apple Wallet! 🎟️')),
                  );
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1E1C38) : AppColors.midnight,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  alignment: Alignment.center,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.wallet_rounded, color: Colors.white, size: 18),
                      SizedBox(width: 8),
                      Text(
                        'Simpan ke Apple / Google Wallet',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Button 3: Kembali ke Beranda
              InteractiveScaleButton(
                onPressed: () => Navigator.pop(context),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF16152B) : Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: isDark ? const Color(0xFF29274C) : AppColors.borderLight,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Kembali ke Beranda',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : AppColors.midnight,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
