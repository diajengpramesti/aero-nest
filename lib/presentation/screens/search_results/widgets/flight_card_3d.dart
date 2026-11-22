import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/interactive_scale_button.dart';
import '../../../../data/models/flight_model.dart';

class FlightCard3D extends StatelessWidget {
  final Flight flight;
  final VoidCallback onSelect;

  const FlightCard3D({
    super.key,
    required this.flight,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.9),
          width: 1.5,
        ),
        boxShadow: AppShadows.soft3D(
          shadowColor: const Color(0x1214132A),
          elevation: 6,
          blurRadius: 22,
        ),
      ),
      child: Column(
        children: [
          // Upper section: Airline, Flight No, Aircraft type
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Color(flight.airlineColorHex).withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Color(flight.airlineColorHex).withValues(alpha: 0.3),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        flight.airlineCode,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: Color(flight.airlineColorHex),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          flight.airlineName,
                          style: AppTypography.headingMedium.copyWith(fontSize: 15),
                        ),
                        Text(
                          '${flight.flightNumber} • ${flight.aircraftType}',
                          style: AppTypography.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),

                // Eco badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.mintSoft,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.eco_rounded, size: 12, color: AppColors.mintSuccess),
                      const SizedBox(width: 4),
                      Text(
                        '-${flight.co2SavedPercentage}% CO₂',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: AppColors.mintSuccess,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Flight Timeline Segment
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                // Departure Time & Code
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Formatters.formatTime(flight.departureTime),
                      style: AppTypography.headingLarge.copyWith(fontSize: 20),
                    ),
                    Text(
                      flight.departure.code,
                      style: AppTypography.headingMedium.copyWith(
                        color: AppColors.slateMuted,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(flight.departure.city, style: AppTypography.bodySmall),
                  ],
                ),

                // Middle Route Graphic
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Column(
                      children: [
                        Text(
                          Formatters.formatDuration(flight.duration),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.slateMuted,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: 2,
                              color: AppColors.borderLight,
                            ),
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(color: AppColors.orangePastel),
                              ),
                              child: const Icon(
                                Icons.flight_takeoff_rounded,
                                size: 14,
                                color: AppColors.orangePrimary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          flight.isDirect ? 'Langsung' : '1 Transit (${flight.transitCity ?? "Hub"})',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: flight.isDirect ? AppColors.mintSuccess : AppColors.orangePrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Arrival Time & Code
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      Formatters.formatTime(flight.arrivalTime),
                      style: AppTypography.headingLarge.copyWith(fontSize: 20),
                    ),
                    Text(
                      flight.arrival.code,
                      style: AppTypography.headingMedium.copyWith(
                        color: AppColors.slateMuted,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(flight.arrival.city, style: AppTypography.bodySmall),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),
          Divider(height: 1, color: AppColors.borderLight.withValues(alpha: 0.7)),

          // Bottom Bar: Amenities & Price + Select Action
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Amenities Row
                Row(
                  children: [
                    _buildAmenityBadge(Icons.luggage_outlined, '${flight.baggageKg}kg'),
                    const SizedBox(width: 8),
                    if (flight.hasMeal)
                      _buildAmenityBadge(Icons.restaurant_rounded, 'Makan'),
                    const SizedBox(width: 8),
                    if (flight.hasWifi)
                      _buildAmenityBadge(Icons.wifi_rounded, 'Wi-Fi'),
                  ],
                ),

                // Price and Select Button
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          Formatters.formatRupiah(flight.basePrice),
                          style: AppTypography.headingMedium.copyWith(
                            color: AppColors.orangePrimary,
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '/pax',
                          style: AppTypography.bodySmall.copyWith(fontSize: 10),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    InteractiveScaleButton(
                      onPressed: onSelect,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          gradient: AppColors.sunsetOrangeGradient,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.orangePrimary.withValues(alpha: 0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Text(
                          'Pilih',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmenityBadge(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surfaceSoft,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 12, color: AppColors.slateMuted),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: AppColors.slateMuted,
            ),
          ),
        ],
      ),
    );
  }
}
