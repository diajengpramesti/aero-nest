import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_shadows.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/formatters.dart';
import '../../core/widgets/barcode_painter.dart';
import '../../core/widgets/interactive_scale_button.dart';
import '../../core/widgets/qr_code_painter.dart';
import '../../data/models/booking_model.dart';

class TicketPrintPreviewModal extends StatelessWidget {
  final Booking booking;

  const TicketPrintPreviewModal({
    super.key,
    required this.booking,
  });

  static void show(BuildContext context, {required Booking booking}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => TicketPrintPreviewModal(booking: booking),
    );
  }

  @override
  Widget build(BuildContext context) {
    final b = booking;
    final f = b.flight;

    return Container(
      height: MediaQuery.of(context).size.height * 0.90,
      decoration: const BoxDecoration(
        color: Color(0xFFF1F3F9),
        borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
      ),
      child: Column(
        children: [
          // Drag handle & Modal Header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.print_rounded, color: AppColors.orangePrimary, size: 24),
                    const SizedBox(width: 10),
                    Text(
                      'Pratinjau Cetak E-Ticket',
                      style: AppTypography.headingLarge.copyWith(fontSize: 18),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          // Scrollable Printable Thermal Ticket Receipt
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                  border: Border.all(color: AppColors.borderLight, width: 1.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Official Itinerary Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'AERONEST AIRWAYS',
                              style: AppTypography.headingLarge.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1.0,
                              ),
                            ),
                            const Text(
                              'OFFICIAL E-TICKET RECEIPT & ITINERARY',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w800,
                                color: AppColors.slateMuted,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.mintSoft,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.mintSuccess),
                          ),
                          child: const Text(
                            'STATUS: LUNAS / PAID',
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w900,
                              color: AppColors.mintSuccess,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),
                    const Divider(height: 1, thickness: 1.2),
                    const SizedBox(height: 16),

                    // Passenger & PNR Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildReceiptCell('NAMA PENUMPANG', b.passenger.fullName.toUpperCase()),
                        _buildReceiptCell('KODE PNR / BOOKING', b.pnr, isBold: true),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildReceiptCell('NOMOR PASPOR / ID', b.passenger.passportNumber),
                        _buildReceiptCell('E-TICKET NO.', 'ETKT-992014-${b.id}'),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Flight Segment Box
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceSoft,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.borderLight),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${f.airlineName} (${f.flightNumber})',
                                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
                              ),
                              Text(
                                f.aircraftType,
                                style: const TextStyle(fontSize: 11, color: AppColors.slateMuted),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(f.departure.code,
                                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
                                  Text(f.departure.city, style: const TextStyle(fontSize: 12)),
                                  Text(f.departure.terminal,
                                      style: const TextStyle(fontSize: 10, color: AppColors.slateMuted)),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${Formatters.formatDateShort(f.departureTime)}, ${Formatters.formatTime(f.departureTime)}',
                                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                              const Column(
                                children: [
                                  Icon(Icons.flight_takeoff_rounded, color: AppColors.orangePrimary, size: 20),
                                  Text('➔', style: TextStyle(color: AppColors.slateLight)),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(f.arrival.code,
                                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
                                  Text(f.arrival.city, style: const TextStyle(fontSize: 12)),
                                  Text(f.arrival.terminal,
                                      style: const TextStyle(fontSize: 10, color: AppColors.slateMuted)),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${Formatters.formatDateShort(f.arrivalTime)}, ${Formatters.formatTime(f.arrivalTime)}',
                                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Seat, Gate, Baggage
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildReceiptCell('KURSI', b.seat.code, isHighlight: true),
                        _buildReceiptCell('GATE', b.gate, isHighlight: true),
                        _buildReceiptCell('BOARDING', Formatters.formatTime(b.boardingTime)),
                        _buildReceiptCell('BAGASI', '${f.baggageKg + b.passenger.extraBaggageKg} kg'),
                      ],
                    ),

                    const SizedBox(height: 20),
                    const Divider(height: 1, thickness: 1.2),
                    const SizedBox(height: 16),

                    // Payment Breakdown
                    const Text('RINCIAN PEMBAYARAN ELEKTRONIK',
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.slateMuted)),
                    const SizedBox(height: 8),
                    _buildRowItem('Tarif Dasar Penerbangan', Formatters.formatRupiah(f.basePrice)),
                    if (b.seat.extraPrice > 0)
                      _buildRowItem('Biaya Kursi Pilihan', Formatters.formatRupiah(b.seat.extraPrice)),
                    if (b.passenger.extraBaggageKg > 0)
                      _buildRowItem('Ekstra Bagasi', Formatters.formatRupiah(b.passenger.extraBaggageKg * 45000)),
                    _buildRowItem('Pajak & Pelayanan Bandara (11%)', 'Termasuk'),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('TOTAL TELAH DIBAYAR',
                            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 13)),
                        Text(
                          Formatters.formatRupiah(b.totalPrice),
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                            color: AppColors.orangePrimary,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Security Barcode & QR Code
                    Row(
                      children: [
                        SizedBox(
                          width: 80,
                          height: 80,
                          child: CustomPaint(painter: QRCodePainter(primaryColor: AppColors.midnight)),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 40,
                                child: CustomPaint(
                                  size: const Size(double.infinity, 40),
                                  painter: BarcodePainter(seed: b.pnr),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'DOKUMEN SAH SEBAGAI PAS KABIN (ICAO STANDARD)',
                                style: AppTypography.bodySmall.copyWith(fontSize: 8, letterSpacing: 0.5),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Action Buttons: Print & Download PDF
          Container(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 16,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  // Print button
                  Expanded(
                    child: InteractiveScaleButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Row(
                              children: [
                                Icon(Icons.print_rounded, color: Colors.white),
                                SizedBox(width: 10),
                                Text('Mengirim dokumen tiket ke printer... 🖨️'),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.midnight,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        alignment: Alignment.center,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.print_rounded, color: Colors.white, size: 18),
                            SizedBox(width: 8),
                            Text(
                              'Cetak Tiket Fisik',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Download PDF button
                  Expanded(
                    child: InteractiveScaleButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: AppColors.mintSuccess,
                            content: Row(
                              children: [
                                const Icon(Icons.download_done_rounded, color: Colors.white),
                                const SizedBox(width: 10),
                                Text('E-Ticket-${b.pnr}.pdf berhasil diunduh! 📄'),
                              ],
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
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.picture_as_pdf_rounded, color: Colors.white, size: 18),
                            SizedBox(width: 8),
                            Text(
                              'Simpan PDF',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 13),
                            ),
                          ],
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

  Widget _buildReceiptCell(String label, String value, {bool isBold = false, bool isHighlight = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 9, color: AppColors.slateMuted, fontWeight: FontWeight.w700)),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: isHighlight ? 16 : 13,
            fontWeight: (isBold || isHighlight) ? FontWeight.w900 : FontWeight.w600,
            color: isHighlight ? AppColors.orangePrimary : AppColors.midnight,
          ),
        ),
      ],
    );
  }

  Widget _buildRowItem(String title, String price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 11, color: AppColors.slateMuted)),
          Text(price, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
