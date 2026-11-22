import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/interactive_scale_button.dart';
import '../../../core/widgets/soft_3d_card.dart';
import '../../controllers/booking_controller.dart';
import '../boarding_pass/boarding_pass_screen.dart';

class MyTripsScreen extends StatefulWidget {
  final BookingController controller;

  const MyTripsScreen({
    super.key,
    required this.controller,
  });

  @override
  State<MyTripsScreen> createState() => _MyTripsScreenState();
}

class _MyTripsScreenState extends State<MyTripsScreen> {
  int _activeTab = 0; // 0 = Akan Datang, 1 = Riwayat

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) {
        final bookings = widget.controller.myBookings;

        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Penerbangan Saya 🎫', style: AppTypography.displayMedium.copyWith(fontSize: 24)),
                          Text('Kelola boarding pass & status live', style: AppTypography.bodySmall),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.orangeCream,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text(
                          '${bookings.length} Tiket Aktif',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: AppColors.orangePrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Pill Tabs
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceSoft,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        _buildTabItem('Akan Datang', 0),
                        _buildTabItem('Riwayat Selesai', 1),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Booking List
                Expanded(
                  child: bookings.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.airplane_ticket_outlined, size: 64, color: AppColors.slateLight),
                              const SizedBox(height: 12),
                              Text('Belum ada tiket aktif', style: AppTypography.headingMedium),
                              const SizedBox(height: 4),
                              Text('Cari dan pesan tiket perjalanan impianmu sekarang', style: AppTypography.bodySmall),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(20, 4, 20, 110),
                          itemCount: bookings.length,
                          itemBuilder: (context, index) {
                            final b = bookings[index];
                            return _buildTripCard(context, b);
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTabItem(String title, int index) {
    final isSelected = _activeTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _activeTab = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.midnight.withValues(alpha: 0.06),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected ? AppColors.midnight : AppColors.slateMuted,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTripCard(BuildContext context, dynamic booking) {
    final f = booking.flight;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: InteractiveScaleButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => BoardingPassScreen(booking: booking),
            ),
          );
        },
        child: Soft3DCard(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.orangeCream,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.flight_takeoff_rounded, color: AppColors.orangePrimary, size: 16),
                      ),
                      const SizedBox(width: 8),
                      Text(f.airlineName, style: AppTypography.headingMedium.copyWith(fontSize: 14)),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.mintSoft,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'BOARDING OPEN',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        color: AppColors.mintSuccess,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(f.departure.code, style: AppTypography.headingLarge.copyWith(fontSize: 22)),
                      Text(f.departure.city, style: AppTypography.bodySmall),
                    ],
                  ),
                  Column(
                    children: [
                      const Icon(Icons.arrow_forward_rounded, color: AppColors.orangePrimary, size: 20),
                      Text(f.flightNumber, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(f.arrival.code, style: AppTypography.headingLarge.copyWith(fontSize: 22)),
                      Text(f.arrival.city, style: AppTypography.bodySmall),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 14),
              Divider(height: 1, color: AppColors.borderLight.withValues(alpha: 0.6)),
              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Kursi: ${booking.seat.code} • Gate ${booking.gate}',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.midnight),
                      ),
                    ],
                  ),
                  const Row(
                    children: [
                      Text(
                        'Lihat Pass',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.orangePrimary),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_forward_ios_rounded, size: 10, color: AppColors.orangePrimary),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
