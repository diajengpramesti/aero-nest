import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/interactive_scale_button.dart';
import '../../../../data/models/seat_model.dart';
import '../../../controllers/booking_controller.dart';

class DatePassengerPickerModal extends StatefulWidget {
  final BookingController controller;
  final bool initialFocusDate;

  const DatePassengerPickerModal({
    super.key,
    required this.controller,
    this.initialFocusDate = true,
  });

  static Future<void> show(
    BuildContext context, {
    required BookingController controller,
    bool initialFocusDate = true,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => DatePassengerPickerModal(
        controller: controller,
        initialFocusDate: initialFocusDate,
      ),
    );
  }

  @override
  State<DatePassengerPickerModal> createState() => _DatePassengerPickerModalState();
}

class _DatePassengerPickerModalState extends State<DatePassengerPickerModal> {
  late DateTime _selectedDep;
  late DateTime _selectedRet;
  late int _adults;
  late int _children;
  late SeatCabinClass _cabin;

  @override
  void initState() {
    super.initState();
    _selectedDep = widget.controller.departureDate;
    _selectedRet = widget.controller.returnDate;
    _adults = widget.controller.adultPassengers;
    _children = widget.controller.childPassengers;
    _cabin = widget.controller.preferredCabin;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 48,
              height: 5,
              decoration: BoxDecoration(
                color: AppColors.borderLight,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 20),

          Text(
            'Sesuaikan Perjalananmu',
            style: AppTypography.headingLarge,
          ),
          const SizedBox(height: 6),
          Text(
            'Pilih tanggal keberangkatan dan jumlah kursi',
            style: AppTypography.bodyMedium,
          ),
          const SizedBox(height: 24),

          // Quick Date Pills
          Text('PILIHAN TANGGAL TERDEKAT', style: AppTypography.bodySmall),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(7, (index) {
                final date = DateTime.now().add(Duration(days: index + 1));
                final isSelected = _selectedDep.day == date.day &&
                    _selectedDep.month == date.month;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDep = date;
                      if (_selectedRet.isBefore(_selectedDep)) {
                        _selectedRet = _selectedDep.add(const Duration(days: 3));
                      }
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.orangePrimary : AppColors.surfaceSoft,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: isSelected ? AppColors.orangePrimary : AppColors.borderLight,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          Formatters.formatDateShort(date),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : AppColors.midnight,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Mulai 1.1jt',
                          style: TextStyle(
                            fontSize: 10,
                            color: isSelected ? Colors.white70 : AppColors.slateMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),

          const SizedBox(height: 24),

          // Passenger Counters
          Text('JUMLAH PENUMPANG', style: AppTypography.bodySmall),
          const SizedBox(height: 12),
          _buildCounterRow(
            title: 'Dewasa',
            subtitle: 'Usia 12 tahun ke atas',
            count: _adults,
            onDecrease: () {
              if (_adults > 1) setState(() => _adults--);
            },
            onIncrease: () {
              if (_adults < 9) setState(() => _adults++);
            },
          ),
          const SizedBox(height: 8),
          _buildCounterRow(
            title: 'Anak-anak',
            subtitle: 'Usia 2 - 11 tahun',
            count: _children,
            onDecrease: () {
              if (_children > 0) setState(() => _children--);
            },
            onIncrease: () {
              if (_children < 5) setState(() => _children++);
            },
          ),

          const SizedBox(height: 20),

          // Cabin Class
          Text('KELAS KABIN', style: AppTypography.bodySmall),
          const SizedBox(height: 10),
          Row(
            children: [
              _buildCabinPill('Economy', SeatCabinClass.economy),
              const SizedBox(width: 8),
              _buildCabinPill('Business', SeatCabinClass.business),
              const SizedBox(width: 8),
              _buildCabinPill('First Suite', SeatCabinClass.firstClass),
            ],
          ),

          const SizedBox(height: 28),

          // Apply Button
          InteractiveScaleButton(
            onPressed: () {
              widget.controller.setDates(_selectedDep, _selectedRet);
              widget.controller.updatePassengers(adults: _adults, children: _children);
              widget.controller.setCabinClass(_cabin);
              Navigator.pop(context);
            },
            child: Container(
              height: 52,
              decoration: BoxDecoration(
                gradient: AppColors.sunsetOrangeGradient,
                borderRadius: BorderRadius.circular(26),
              ),
              alignment: Alignment.center,
              child: Text(
                'Terapkan Pilihan',
                style: AppTypography.headingMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCounterRow({
    required String title,
    required String subtitle,
    required int count,
    required VoidCallback onDecrease,
    required VoidCallback onIncrease,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surfaceSoft,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.w700)),
              Text(subtitle, style: AppTypography.bodySmall),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline, color: AppColors.slateMuted),
                onPressed: onDecrease,
              ),
              SizedBox(
                width: 28,
                child: Text(
                  '$count',
                  textAlign: TextAlign.center,
                  style: AppTypography.headingMedium,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle, color: AppColors.orangePrimary),
                onPressed: onIncrease,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCabinPill(String title, SeatCabinClass cabinClass) {
    final isSelected = _cabin == cabinClass;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _cabin = cabinClass),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.midnight : AppColors.surfaceSoft,
            borderRadius: BorderRadius.circular(14),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: isSelected ? Colors.white : AppColors.midnight,
            ),
          ),
        ),
      ),
    );
  }
}
