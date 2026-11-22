import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/interactive_scale_button.dart';
import '../../../../data/models/airport_model.dart';
import '../../../../data/mock/mock_flight_data.dart';
import '../../../controllers/booking_controller.dart';

class TrendingDestinationsCarousel extends StatelessWidget {
  final BookingController controller;
  final VoidCallback onDestinationTapped;

  const TrendingDestinationsCarousel({
    super.key,
    required this.controller,
    required this.onDestinationTapped,
  });

  @override
  Widget build(BuildContext context) {
    final destinations = [
      {
        'airport': MockFlightData.airports[1], // DPS
        'tag': '🔥 Viral Gen-Z',
        'title': 'Bali Paradise Escape',
        'price': 1150000,
        'rating': '4.95',
        'duration': '1j 50m',
        'gradient': const [Color(0xFFFF9E6C), Color(0xFFFF6433)],
      },
      {
        'airport': MockFlightData.airports[2], // SIN
        'tag': '✨ Shopping Fest',
        'title': 'Singapore Urban Jewel',
        'price': 940000,
        'rating': '4.88',
        'duration': '1j 45m',
        'gradient': const [Color(0xFF7E72F2), Color(0xFF5B4DE3)],
      },
      {
        'airport': MockFlightData.airports[3], // HND
        'tag': '🌸 Sakura Season',
        'title': 'Tokyo Neon & Blossom',
        'price': 8920000,
        'rating': '4.98',
        'duration': '7j 35m',
        'gradient': const [Color(0xFF14132A), Color(0xFF2C2852)],
      },
      {
        'airport': MockFlightData.airports[5], // JOG
        'tag': '☕ Heritage & Culture',
        'title': 'Yogyakarta Artistry',
        'price': 780000,
        'rating': '4.91',
        'duration': '1j 10m',
        'gradient': const [Color(0xFF10B981), Color(0xFF059669)],
      },
    ];

    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: destinations.length,
        itemBuilder: (context, index) {
          final item = destinations[index];
          final airport = item['airport'] as Airport;
          final colors = item['gradient'] as List<Color>;

          return InteractiveScaleButton(
            onPressed: () {
              controller.setAirports(controller.departureAirport, airport);
              onDestinationTapped();
            },
            child: Container(
              width: 220,
              margin: const EdgeInsets.only(right: 16, bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: colors,
                ),
                boxShadow: [
                  BoxShadow(
                    color: colors.first.withValues(alpha: 0.35),
                    blurRadius: 18,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Subtle geometric decorative wave
                  Positioned(
                    right: -25,
                    bottom: -25,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.12),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Tag pill
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.22),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            item['tag'] as String,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const Spacer(),

                        // Airport code & City
                        Text(
                          airport.city,
                          style: AppTypography.headingLarge.copyWith(
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${airport.code} • ${item['duration']}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withValues(alpha: 0.85),
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Price and Explore icon
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Mulai dari',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white.withValues(alpha: 0.75),
                                    ),
                                  ),
                                  Text(
                                    Formatters.formatRupiah(item['price'] as num),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 32,
                              height: 32,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.arrow_outward_rounded,
                                size: 16,
                                color: AppColors.midnight,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
