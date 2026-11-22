import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/interactive_scale_button.dart';
import '../../../../data/models/seat_model.dart';
import '../../../controllers/booking_controller.dart';
import '../../../widgets/country_airport_picker_modal.dart';
import 'trip_type_selector.dart';

class SearchFlightCard extends StatefulWidget {
  final BookingController controller;
  final VoidCallback onSearch;
  final VoidCallback onOpenDatePicker;
  final VoidCallback onOpenPassengerPicker;

  const SearchFlightCard({
    super.key,
    required this.controller,
    required this.onSearch,
    required this.onOpenDatePicker,
    required this.onOpenPassengerPicker,
  });

  @override
  State<SearchFlightCard> createState() => _SearchFlightCardState();
}

class _SearchFlightCardState extends State<SearchFlightCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _swapAnimController;
  late Animation<double> _swapRotation;

  @override
  void initState() {
    super.initState();
    _swapAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _swapRotation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _swapAnimController, curve: Curves.easeInOutBack),
    );
  }

  @override
  void dispose() {
    _swapAnimController.dispose();
    super.dispose();
  }

  void _handleSwap() {
    _swapAnimController.forward(from: 0);
    widget.controller.swapAirports();
  }

  void _openOriginPicker() {
    CountryAirportPickerModal.show(
      context,
      isSelectingOrigin: true,
      onAirportSelected: (selected) {
        widget.controller.setAirports(selected, widget.controller.arrivalAirport);
      },
    );
  }

  void _openDestinationPicker() {
    CountryAirportPickerModal.show(
      context,
      isSelectingOrigin: false,
      onAirportSelected: (selected) {
        widget.controller.setAirports(widget.controller.departureAirport, selected);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final dep = widget.controller.departureAirport;
    final arr = widget.controller.arrivalAirport;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF16152B) : Colors.white,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: isDark ? const Color(0xFF29274C) : Colors.white.withValues(alpha: 0.9),
          width: 1.5,
        ),
        boxShadow: AppShadows.soft3D(
          shadowColor: const Color(0x14FF7A45),
          blurRadius: 30,
          offset: const Offset(0, 14),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Trip type selector
          TripTypeSelector(
            selectedType: widget.controller.tripType,
            onTypeChanged: (type) => widget.controller.setTripType(type),
          ),
          const SizedBox(height: 20),

          // Airport Origin & Destination 3D Block
          Stack(
            alignment: Alignment.centerRight,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF201D38) : AppColors.surfaceSoft,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: isDark ? const Color(0xFF2F2C50) : AppColors.borderLight,
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    // Origin Picker Tile
                    GestureDetector(
                      onTap: _openOriginPicker,
                      behavior: HitTestBehavior.opaque,
                      child: _buildAirportTile(
                        label: 'DARI',
                        code: dep.code,
                        city: dep.city,
                        country: dep.country,
                        flag: dep.flagEmoji,
                        airportName: dep.name,
                        isTop: true,
                        isDark: isDark,
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: isDark
                          ? const Color(0xFF2F2C50)
                          : AppColors.borderLight.withValues(alpha: 0.6),
                    ),
                    // Destination Picker Tile
                    GestureDetector(
                      onTap: _openDestinationPicker,
                      behavior: HitTestBehavior.opaque,
                      child: _buildAirportTile(
                        label: 'KE',
                        code: arr.code,
                        city: arr.city,
                        country: arr.country,
                        flag: arr.flagEmoji,
                        airportName: arr.name,
                        isTop: false,
                        isDark: isDark,
                      ),
                    ),
                  ],
                ),
              ),

              // Swap Button with 3D Flip
              Positioned(
                right: 20,
                child: RotationTransition(
                  turns: _swapRotation,
                  child: InteractiveScaleButton(
                    onPressed: _handleSwap,
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        gradient: AppColors.sunsetOrangeGradient,
                        shape: BoxShape.circle,
                        boxShadow: AppShadows.orangeGlow,
                        border: Border.all(color: Colors.white, width: 2.5),
                      ),
                      child: const Icon(
                        Icons.swap_vert_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Date & Passengers Row
          Row(
            children: [
              // Departure / Return Date
              Expanded(
                child: GestureDetector(
                  onTap: widget.onOpenDatePicker,
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF201D38) : AppColors.surfaceSoft,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isDark ? const Color(0xFF2F2C50) : AppColors.borderLight,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.calendar_today_rounded,
                                size: 13, color: AppColors.orangePrimary),
                            const SizedBox(width: 5),
                            Text('TANGGAL', style: AppTypography.bodySmall),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          Formatters.formatDateShort(widget.controller.departureDate),
                          style: AppTypography.headingMedium.copyWith(
                            fontSize: 15,
                            color: isDark ? Colors.white : AppColors.midnight,
                          ),
                        ),
                        Text(
                          widget.controller.tripType == TripType.roundTrip
                              ? 'Pulang: ${Formatters.formatDateShort(widget.controller.returnDate)}'
                              : 'Sekali Jalan',
                          style: AppTypography.bodySmall.copyWith(
                            color: isDark ? const Color(0xFF8E8CD8) : AppColors.slateMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Passengers & Cabin Class
              Expanded(
                child: GestureDetector(
                  onTap: widget.onOpenPassengerPicker,
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF201D38) : AppColors.surfaceSoft,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isDark ? const Color(0xFF2F2C50) : AppColors.borderLight,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.airline_seat_recline_extra_rounded,
                                size: 14, color: AppColors.lilacAccent),
                            const SizedBox(width: 5),
                            Text('PENUMPANG', style: AppTypography.bodySmall),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${widget.controller.totalPassengers} Traveler',
                          style: AppTypography.headingMedium.copyWith(
                            fontSize: 15,
                            color: isDark ? Colors.white : AppColors.midnight,
                          ),
                        ),
                        Text(
                          widget.controller.preferredCabin == SeatCabinClass.business
                              ? 'Business Class'
                              : widget.controller.preferredCabin == SeatCabinClass.firstClass
                                  ? 'First Suite'
                                  : 'Economy Class',
                          style: AppTypography.bodySmall.copyWith(
                            color: isDark ? const Color(0xFF8E8CD8) : AppColors.slateMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Search Flights Glowing Pill Button
          InteractiveScaleButton(
            onPressed: widget.onSearch,
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                gradient: AppColors.sunsetOrangeGradient,
                borderRadius: BorderRadius.circular(28),
                boxShadow: AppShadows.orangeGlow,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.35),
                  width: 1.5,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.flight_takeoff_rounded, color: Colors.white, size: 22),
                  const SizedBox(width: 10),
                  Text(
                    'Cari Penerbangan Terbaik',
                    style: AppTypography.headingMedium.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAirportTile({
    required String label,
    required String code,
    required String city,
    required String country,
    required String flag,
    required String airportName,
    required bool isTop,
    required bool isDark,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isTop
                  ? AppColors.orangePastel.withValues(alpha: 0.15)
                  : AppColors.lilacAccent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: isTop ? AppColors.orangePrimary : AppColors.lilacAccent,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      flag,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      code,
                      style: AppTypography.headingLarge.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: 22,
                        letterSpacing: 0.5,
                        color: isDark ? Colors.white : AppColors.midnight,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '$city ($country)',
                      style: AppTypography.bodyLarge.copyWith(
                        fontWeight: FontWeight.w600,
                        color: isDark ? const Color(0xFFB4B2C8) : AppColors.slateMuted,
                      ),
                    ),
                  ],
                ),
                Text(
                  airportName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.bodySmall.copyWith(
                    color: isDark ? const Color(0xFF7A7790) : AppColors.slateLight,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.orangePrimary,
            size: 20,
          ),
          const SizedBox(width: 32),
        ],
      ),
    );
  }
}
