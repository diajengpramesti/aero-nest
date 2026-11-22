import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../controllers/booking_controller.dart';

class TripTypeSelector extends StatelessWidget {
  final TripType selectedType;
  final ValueChanged<TripType> onTypeChanged;

  const TripTypeSelector({
    super.key,
    required this.selectedType,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surfaceSoft,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.borderLight,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          _buildItem('Pulang-Pergi', TripType.roundTrip),
          _buildItem('Sekali Jalan', TripType.oneWay),
          _buildItem('Multi-Kota', TripType.multiCity),
        ],
      ),
    );
  }

  Widget _buildItem(String label, TripType type) {
    final isSelected = selectedType == type;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTypeChanged(type),
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.midnight.withValues(alpha: 0.06),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : null,
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected ? AppColors.midnight : AppColors.slateMuted,
            ),
          ),
        ),
      ),
    );
  }
}
