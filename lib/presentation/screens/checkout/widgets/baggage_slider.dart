import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/formatters.dart';

class BaggageSlider extends StatelessWidget {
  final int selectedExtraKg;
  final ValueChanged<int> onWeightChanged;

  const BaggageSlider({
    super.key,
    required this.selectedExtraKg,
    required this.onWeightChanged,
  });

  @override
  Widget build(BuildContext context) {
    final weights = [0, 5, 10, 15, 20];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.luggage_rounded, color: AppColors.orangePrimary, size: 20),
                const SizedBox(width: 8),
                Text('Ekstra Bagasi Terdaftar', style: AppTypography.headingMedium.copyWith(fontSize: 15)),
              ],
            ),
            Text(
              selectedExtraKg == 0 ? 'Standar (20 kg)' : '+ $selectedExtraKg kg',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: selectedExtraKg > 0 ? AppColors.orangePrimary : AppColors.midnight,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Weight pills
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: weights.map((w) {
            final isSelected = selectedExtraKg == w;
            final price = w * 45000;

            return GestureDetector(
              onTap: () => onWeightChanged(w),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.midnight : AppColors.surfaceSoft,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected ? AppColors.midnight : AppColors.borderLight,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      w == 0 ? '0 kg' : '+$w kg',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: isSelected ? Colors.white : AppColors.midnight,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      w == 0 ? 'Gratis' : Formatters.formatRupiah(price),
                      style: TextStyle(
                        fontSize: 9,
                        color: isSelected ? Colors.white70 : AppColors.slateMuted,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
