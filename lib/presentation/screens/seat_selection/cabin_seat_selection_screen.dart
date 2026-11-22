import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/glassy_container.dart';
import '../../../core/widgets/interactive_scale_button.dart';
import '../../../data/models/seat_model.dart';
import '../../../data/mock/mock_flight_data.dart';
import '../../controllers/booking_controller.dart';
import '../checkout/passenger_addons_screen.dart';

class CabinSeatSelectionScreen extends StatefulWidget {
  final BookingController controller;

  const CabinSeatSelectionScreen({
    super.key,
    required this.controller,
  });

  @override
  State<CabinSeatSelectionScreen> createState() => _CabinSeatSelectionScreenState();
}

class _CabinSeatSelectionScreenState extends State<CabinSeatSelectionScreen> {
  late List<Seat> _cabinSeats;
  Seat? _tempSelectedSeat;

  @override
  void initState() {
    super.initState();
    _cabinSeats = MockFlightData.generateCabinSeats();
    // Default to currently selected seat in controller or 12A
    _tempSelectedSeat = widget.controller.selectedSeat ??
        _cabinSeats.firstWhere(
          (s) => s.code == '12A' && !s.isBooked,
          orElse: () => _cabinSeats.firstWhere((s) => !s.isBooked),
        );
  }

  void _onSeatTap(Seat seat) {
    if (seat.isBooked) return;
    setState(() {
      _tempSelectedSeat = seat;
    });
  }

  @override
  Widget build(BuildContext context) {
    final flight = widget.controller.selectedFlight;

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
            Text('Pilih Kursi Kamu', style: AppTypography.headingMedium),
            Text(
              '${flight?.airlineName ?? "Flight"} • ${flight?.aircraftType ?? "Boeing 787"}',
              style: AppTypography.bodySmall,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Scrollable Cabin Plane Body
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 220),
            child: Column(
              children: [
                // Seat Legend
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: AppShadows.soft3D(elevation: 4, blurRadius: 10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildLegendItem(AppColors.orangePrimary, 'Pilihanmu'),
                      _buildLegendItem(AppColors.surfaceSoft, 'Tersedia', borderColor: AppColors.borderLight),
                      _buildLegendItem(const Color(0xFFD4D8E3), 'Terisi'),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Fuselage Plane with Seats inside
                Center(
                  child: Container(
                    width: 340,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(44),
                      border: Border.all(color: AppColors.borderLight, width: 2),
                      boxShadow: AppShadows.soft3D(
                        elevation: 10,
                        blurRadius: 32,
                        shadowColor: const Color(0x1014132A),
                      ),
                    ),
                    child: Column(
                      children: [
                        // Airplane Nose Header
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            children: [
                              const Icon(Icons.navigation_rounded,
                                  size: 28, color: AppColors.orangePastel),
                              const SizedBox(height: 4),
                              Text('DEPAN KABIN (KOKPIT)', style: AppTypography.bodySmall),
                            ],
                          ),
                        ),

                        // Section 1: First Class (Rows 1-2)
                        _buildCabinSectionTitle('FIRST CLASS SUITES', AppColors.lilacAccent),
                        _buildSeatMatrix(
                          rows: [1, 2],
                          columns: ['A', 'C', 'D', 'F'],
                          isFirstClass: true,
                        ),

                        const SizedBox(height: 16),
                        _buildCabinDivider('Galley & Restroom 🚻'),
                        const SizedBox(height: 16),

                        // Section 2: Business Class (Rows 3-6)
                        _buildCabinSectionTitle('BUSINESS CLASS', AppColors.orangePrimary),
                        _buildSeatMatrix(
                          rows: [3, 4, 5, 6],
                          columns: ['A', 'C', 'D', 'F'],
                        ),

                        const SizedBox(height: 16),
                        _buildCabinDivider('Pintu Darurat & Sayap ✈️'),
                        const SizedBox(height: 16),

                        // Section 3: Economy Class (Rows 7-18)
                        _buildCabinSectionTitle('ECONOMY CLASS', AppColors.slateMuted),
                        _buildSeatMatrix(
                          rows: [7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18],
                          columns: ['A', 'B', 'C', 'D', 'E', 'F'],
                        ),

                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom Floating 3D Selected Seat Detail Sheet
          if (_tempSelectedSeat != null)
            Positioned(
              left: 16,
              right: 16,
              bottom: 18,
              child: GlassyContainer(
                borderRadius: 28,
                blur: 24,
                padding: const EdgeInsets.all(18),
                shadows: [
                  BoxShadow(
                    color: AppColors.midnight.withValues(alpha: 0.14),
                    blurRadius: 30,
                    offset: const Offset(0, 12),
                  ),
                ],
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        // Seat 3D Avatar
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            gradient: AppColors.sunsetOrangeGradient,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: AppShadows.orangeGlow,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            _tempSelectedSeat!.code,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),

                        // Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Kursi ${_tempSelectedSeat!.code}',
                                    style: AppTypography.headingMedium,
                                  ),
                                  const SizedBox(width: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: AppColors.orangeCream,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      _tempSelectedSeat!.cabinClass.name.toUpperCase(),
                                      style: const TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.orangePrimary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _tempSelectedSeat!.perks.take(2).join(' • '),
                                style: AppTypography.bodySmall.copyWith(
                                  color: AppColors.slateMuted,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Price bump
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              _tempSelectedSeat!.extraPrice == 0
                                  ? 'Termasuk'
                                  : '+${Formatters.formatRupiah(_tempSelectedSeat!.extraPrice)}',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: _tempSelectedSeat!.extraPrice == 0
                                    ? AppColors.mintSuccess
                                    : AppColors.orangePrimary,
                              ),
                            ),
                            Text('pilihan kursi', style: AppTypography.bodySmall),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Confirm Seat Button
                    InteractiveScaleButton(
                      onPressed: () {
                        widget.controller.selectSeat(_tempSelectedSeat!);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => PassengerAddonsScreen(
                              controller: widget.controller,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: AppColors.sunsetOrangeGradient,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: AppShadows.orangeGlow,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Pilih Kursi ${_tempSelectedSeat!.code} & Lanjut',
                          style: AppTypography.headingMedium.copyWith(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label, {Color? borderColor}) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
            border: borderColor != null ? Border.all(color: borderColor) : null,
          ),
        ),
        const SizedBox(width: 6),
        Text(label, style: AppTypography.bodySmall),
      ],
    );
  }

  Widget _buildCabinSectionTitle(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w800,
          color: color,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildCabinDivider(String text) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surfaceSoft,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 10, color: AppColors.slateMuted, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildSeatMatrix({
    required List<int> rows,
    required List<String> columns,
    bool isFirstClass = false,
  }) {
    return Column(
      children: rows.map((r) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Row Number indicator
              SizedBox(
                width: 24,
                child: Text(
                  '$r',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.slateLight,
                  ),
                ),
              ),

              // Seats
              ...columns.map((col) {
                final isAisleSpace = columns.length == 6
                    ? (col == 'C') // Economy aisle between C and D
                    : (col == 'A' && isFirstClass) || (col == 'C' && !isFirstClass);

                final seat = _cabinSeats.firstWhere(
                  (s) => s.row == r && s.column == col,
                  orElse: () => Seat(
                    code: '$r$col',
                    row: r,
                    column: col,
                    cabinClass: SeatCabinClass.economy,
                  ),
                );

                final isSelected = _tempSelectedSeat?.code == seat.code;

                return Row(
                  children: [
                    _buildSeatPill(seat, isSelected),
                    if (isAisleSpace) const SizedBox(width: 20),
                  ],
                );
              }),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSeatPill(Seat seat, bool isSelected) {
    Color bg;
    Color textColor;
    Border? border;

    if (seat.isBooked) {
      bg = const Color(0xFFE5E7EB);
      textColor = const Color(0xFF9CA3AF);
    } else if (isSelected) {
      bg = AppColors.orangePrimary;
      textColor = Colors.white;
    } else {
      bg = AppColors.surfaceSoft;
      textColor = AppColors.midnight;
      border = Border.all(color: AppColors.borderLight, width: 1);
    }

    return GestureDetector(
      onTap: () => _onSeatTap(seat),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        width: 36,
        height: 38,
        margin: const EdgeInsets.symmetric(horizontal: 2.5),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(10),
          border: border,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.orangePrimary.withValues(alpha: 0.45),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ]
              : null,
        ),
        alignment: Alignment.center,
        child: Text(
          seat.column,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
