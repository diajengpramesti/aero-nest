import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/barcode_painter.dart';
import '../../../../core/widgets/perforated_ticket_painter.dart';
import '../../../../core/widgets/qr_code_painter.dart';
import '../../../../data/models/booking_model.dart';

class Flippable3DTicket extends StatefulWidget {
  final Booking booking;

  const Flippable3DTicket({
    super.key,
    required this.booking,
  });

  @override
  State<Flippable3DTicket> createState() => _Flippable3DTicketState();
}

class _Flippable3DTicketState extends State<Flippable3DTicket>
    with SingleTickerProviderStateMixin {
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;
  bool _showFront = true;

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );
    _flipAnimation = Tween<double>(begin: 0, end: pi).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOutBack),
    );
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  void _flipCard() {
    if (_showFront) {
      _flipController.forward();
    } else {
      _flipController.reverse();
    }
    setState(() {
      _showFront = !_showFront;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flipCard,
      child: AnimatedBuilder(
        animation: _flipAnimation,
        builder: (context, child) {
          final isBack = _flipAnimation.value > (pi / 2);

          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // 3D perspective depth
              ..rotateY(_flipAnimation.value),
            child: isBack
                ? Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..rotateY(pi),
                    child: _buildBackCard(),
                  )
                : _buildFrontCard(),
          );
        },
      ),
    );
  }

  Widget _buildFrontCard() {
    final b = widget.booking;
    final f = b.flight;

    return ClipPath(
      clipper: PerforatedTicketClipper(punchRadius: 16, punchPositionFraction: 0.68),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
          boxShadow: AppShadows.soft3D(
            shadowColor: const Color(0x1814132A),
            elevation: 12,
            blurRadius: 36,
          ),
        ),
        child: Column(
          children: [
            // Upper Header Airline
            Container(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF22203E), Color(0xFF14132A)],
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.orangePrimary.withValues(alpha: 0.25),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.flight_takeoff_rounded,
                                color: AppColors.orangePastel, size: 20),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                f.airlineName,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                f.aircraftType,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.white.withValues(alpha: 0.7),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.mintSuccess.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.mintSuccess.withValues(alpha: 0.4),
                          ),
                        ),
                        child: const Text(
                          'CONFIRMED',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: AppColors.mintSuccess,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Route CGK ➔ DPS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(f.departure.code, style: AppTypography.monoAirportCode.copyWith(color: Colors.white)),
                          Text(f.departure.city, style: const TextStyle(color: Colors.white70, fontSize: 13)),
                          const SizedBox(height: 4),
                          Text(
                            Formatters.formatTime(f.departureTime),
                            style: const TextStyle(color: AppColors.orangePastel, fontWeight: FontWeight.w800, fontSize: 16),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Icon(Icons.flight_rounded, color: AppColors.orangePastel, size: 24),
                          const SizedBox(height: 4),
                          Text(
                            Formatters.formatDuration(f.duration),
                            style: const TextStyle(color: Colors.white60, fontSize: 11),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(f.arrival.code, style: AppTypography.monoAirportCode.copyWith(color: Colors.white)),
                          Text(f.arrival.city, style: const TextStyle(color: Colors.white70, fontSize: 13)),
                          const SizedBox(height: 4),
                          Text(
                            Formatters.formatTime(f.arrivalTime),
                            style: const TextStyle(color: AppColors.orangePastel, fontWeight: FontWeight.w800, fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Middle Info Grid: Gate, Flight, Seat, Boarding Time
            Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTicketInfoCell('PENUMPANG', b.passenger.fullName),
                      _buildTicketInfoCell('KODE PNR', b.pnr),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTicketInfoCell('GATE', b.gate, isHighlight: true),
                      _buildTicketInfoCell('BOARDING', Formatters.formatTime(b.boardingTime), isHighlight: true),
                      _buildTicketInfoCell('KURSI', b.seat.code, isHighlight: true),
                      _buildTicketInfoCell('GROUP', b.boardingGroup),
                    ],
                  ),
                ],
              ),
            ),

            // Perforated Tear Line
            CustomPaint(
              size: const Size(double.infinity, 16),
              painter: PerforationDividerPainter(),
            ),

            // Bottom Section: Barcode & QR Code
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 16, 22, 24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // QR Code container
                      Container(
                        width: 90,
                        height: 90,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceSoft,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.borderLight),
                        ),
                        child: CustomPaint(
                          painter: QRCodePainter(primaryColor: AppColors.midnight),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Barcode & instructions
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 44,
                              child: CustomPaint(
                                size: const Size(double.infinity, 44),
                                painter: BarcodePainter(seed: b.pnr),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Center(
                              child: Text(
                                'SCAN DI AUTOGATE KABIN',
                                style: AppTypography.bodySmall.copyWith(
                                  letterSpacing: 1.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.sync_rounded, size: 14, color: AppColors.orangePrimary),
                      const SizedBox(width: 6),
                      Text(
                        'Ketuk tiket untuk melihat perks & terminal map',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.orangePrimary,
                          fontWeight: FontWeight.w600,
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
  }

  Widget _buildBackCard() {
    final b = widget.booking;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: AppColors.borderLight, width: 2),
        boxShadow: AppShadows.soft3D(
          shadowColor: const Color(0x1814132A),
          elevation: 12,
          blurRadius: 36,
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Detail & Fasilitas Penerbangan', style: AppTypography.headingLarge.copyWith(fontSize: 18)),
              const Icon(Icons.flip_to_back_rounded, color: AppColors.orangePrimary, size: 22),
            ],
          ),
          const SizedBox(height: 6),
          Text('Informasi penting di bandara tujuan', style: AppTypography.bodySmall),

          const SizedBox(height: 20),

          // Baggage Claim Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.orangeCream,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.luggage_rounded, color: AppColors.orangePrimary, size: 28),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Baggage Claim: Carousel 04',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.midnight,
                        ),
                      ),
                      Text(
                        'Total Bagasi: ${b.flight.baggageKg + b.passenger.extraBaggageKg} kg (Label Tag: ${b.pnr})',
                        style: AppTypography.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Weather at Destination
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surfaceSoft,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Text('☀️', style: TextStyle(fontSize: 26)),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cuaca ${b.flight.arrival.city}: 29°C Cerah',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.midnight,
                        ),
                      ),
                      Text('Waktu Lokal: GMT+8 (WITA)', style: AppTypography.bodySmall),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Included Perks
          Text('FASILITAS TIKET ANDA', style: AppTypography.bodySmall),
          const SizedBox(height: 10),
          _buildPerkRow(Icons.restaurant_menu_rounded, 'Makanan Pilihan', b.passenger.selectedMeal),
          _buildPerkRow(Icons.wifi_rounded, 'Wi-Fi Onboard', 'SSID: AeroGuest • Pass: FLY2026'),
          _buildPerkRow(Icons.airline_seat_recline_extra_rounded, 'Kursi', '${b.seat.code} (${b.seat.perks.firstOrNull ?? "Standard"})'),

          const Spacer(),

          Center(
            child: Text(
              'Ketuk lagi untuk kembali ke kartu depan',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.slateMuted,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketInfoCell(String label, String value, {bool isHighlight = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTypography.bodySmall.copyWith(fontSize: 10)),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: isHighlight ? 16 : 14,
            fontWeight: FontWeight.w800,
            color: isHighlight ? AppColors.orangePrimary : AppColors.midnight,
          ),
        ),
      ],
    );
  }

  Widget _buildPerkRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.orangePrimary),
          const SizedBox(width: 10),
          Text('$title: ', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.midnight)),
          Expanded(
            child: Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12, color: AppColors.slateMuted),
            ),
          ),
        ],
      ),
    );
  }
}
