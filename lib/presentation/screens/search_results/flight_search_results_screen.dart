import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/interactive_scale_button.dart';
import '../../controllers/booking_controller.dart';
import 'widgets/flight_card_3d.dart';
import '../seat_selection/cabin_seat_selection_screen.dart';

class FlightSearchResultsScreen extends StatelessWidget {
  final BookingController controller;

  const FlightSearchResultsScreen({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final flights = controller.filteredFlights;

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
            title: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      controller.departureAirport.code,
                      style: AppTypography.headingMedium.copyWith(fontSize: 16),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Icon(Icons.arrow_forward_rounded,
                          size: 14, color: AppColors.orangePrimary),
                    ),
                    Text(
                      controller.arrivalAirport.code,
                      style: AppTypography.headingMedium.copyWith(fontSize: 16),
                    ),
                  ],
                ),
                Text(
                  '${Formatters.formatDateShort(controller.departureDate)} • ${controller.totalPassengers} Traveler',
                  style: AppTypography.bodySmall,
                ),
              ],
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.tune_rounded, color: AppColors.midnight),
                onPressed: () => _showFilterBottomSheet(context),
              ),
            ],
          ),
          body: Column(
            children: [
              // Filter Chips Strip
              Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildSortChip(
                        label: 'Termurah',
                        icon: Icons.sell_outlined,
                        sort: FlightSortBy.cheapest,
                      ),
                      const SizedBox(width: 8),
                      _buildSortChip(
                        label: 'Tercepat',
                        icon: Icons.speed_rounded,
                        sort: FlightSortBy.fastest,
                      ),
                      const SizedBox(width: 8),
                      _buildSortChip(
                        label: 'Paling Pagi',
                        icon: Icons.wb_sunny_outlined,
                        sort: FlightSortBy.earliest,
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => controller.toggleDirectFlightsOnly(!controller.directFlightsOnly),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: controller.directFlightsOnly
                                ? AppColors.orangeCream
                                : AppColors.surfaceSoft,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: controller.directFlightsOnly
                                  ? AppColors.orangePrimary
                                  : AppColors.borderLight,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.flight_land_rounded,
                                size: 14,
                                color: controller.directFlightsOnly
                                    ? AppColors.orangePrimary
                                    : AppColors.slateMuted,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Langsung Saja',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: controller.directFlightsOnly
                                      ? AppColors.orangePrimary
                                      : AppColors.midnight,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Available Flights Count
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ditemukan ${flights.length} Penerbangan',
                      style: AppTypography.headingMedium.copyWith(fontSize: 14),
                    ),
                    Text(
                      'Harga sudah termasuk pajak',
                      style: AppTypography.bodySmall,
                    ),
                  ],
                ),
              ),

              // Flight List
              Expanded(
                child: flights.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.flight_outlined, size: 64, color: AppColors.slateLight),
                            const SizedBox(height: 12),
                            Text('Tidak ada penerbangan sesuai filter', style: AppTypography.headingMedium),
                            const SizedBox(height: 6),
                            Text('Coba reset filter atau pilih tanggal lain', style: AppTypography.bodyMedium),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        itemCount: flights.length,
                        itemBuilder: (context, index) {
                          final flight = flights[index];
                          return FlightCard3D(
                            flight: flight,
                            onSelect: () {
                              controller.selectFlight(flight);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (ctx) => CabinSeatSelectionScreen(
                                    controller: controller,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSortChip({
    required String label,
    required IconData icon,
    required FlightSortBy sort,
  }) {
    final isSelected = controller.sortBy == sort;

    return GestureDetector(
      onTap: () => controller.setSortBy(sort),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.midnight : AppColors.surfaceSoft,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, size: 14, color: isSelected ? Colors.white : AppColors.slateMuted),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? Colors.white : AppColors.midnight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 44,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.borderLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text('Filter Penerbangan', style: AppTypography.headingLarge),
              const SizedBox(height: 16),
              Text('Maksimum Harga: ${Formatters.formatRupiah(controller.maxPrice)}',
                  style: AppTypography.bodyMedium),
              Slider(
                value: controller.maxPrice,
                min: 1000000,
                max: 15000000,
                divisions: 14,
                activeColor: AppColors.orangePrimary,
                inactiveColor: AppColors.surfaceSoft,
                onChanged: (val) => controller.setMaxPrice(val),
              ),
              const SizedBox(height: 20),
              InteractiveScaleButton(
                onPressed: () => Navigator.pop(context),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: AppColors.sunsetOrangeGradient,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Terapkan',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
