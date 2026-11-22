import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/interactive_scale_button.dart';
import '../../../core/widgets/soft_3d_card.dart';
import '../../controllers/booking_controller.dart';
import '../search_results/flight_search_results_screen.dart';

class RadarDealsScreen extends StatelessWidget {
  final BookingController controller;

  const RadarDealsScreen({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final deals = [
      {'route': 'Jakarta (CGK) ➔ Bali (DPS)', 'airline': 'Super Air Jet', 'price': 890000, 'disc': 'DISCOUNT 35%'},
      {'route': 'Surabaya (SUB) ➔ Jakarta (CGK)', 'airline': 'Batik Air', 'price': 650000, 'disc': 'EARLY BIRD'},
      {'route': 'Jakarta (CGK) ➔ Singapura (SIN)', 'airline': 'AirAsia Premier', 'price': 920000, 'disc': 'PROMO WEEKEND'},
      {'route': 'Jakarta (CGK) ➔ Tokyo (HND)', 'airline': 'All Nippon Airways', 'price': 7850000, 'disc': 'HOT DEAL'},
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Radar Diskon & Promo ⚡', style: AppTypography.displayMedium.copyWith(fontSize: 24)),
              Text('Penerbangan termurah dipantau AI real-time', style: AppTypography.bodySmall),

              const SizedBox(height: 20),

              // Hero Flash Sale Banner
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: AppColors.sunsetOrangeGradient,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.orangePrimary.withValues(alpha: 0.35),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.25),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'FLASH DEALS HARI INI',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Diskon Tiket Hingga Rp 500rb!',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Gunakan kode: AEROGENZ saat checkout',
                            style: TextStyle(fontSize: 11, color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                    const Text('⚡', style: TextStyle(fontSize: 42)),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Text('PENAWARAN TERPANAS LIVE', style: AppTypography.bodySmall),
              const SizedBox(height: 12),

              ...deals.map((deal) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Soft3DCard(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.orangeCream,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                deal['disc'] as String,
                                style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: AppColors.orangePrimary),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(deal['route'] as String, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
                            Text(deal['airline'] as String, style: AppTypography.bodySmall),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              Formatters.formatRupiah(deal['price'] as num),
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: AppColors.orangePrimary,
                              ),
                            ),
                            InteractiveScaleButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (ctx) => FlightSearchResultsScreen(controller: controller),
                                  ),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.only(top: 4),
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.midnight,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Text(
                                  'Cek Tiket',
                                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
