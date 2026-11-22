import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/interactive_scale_button.dart';
import '../../../core/widgets/soft_3d_card.dart';
import '../../controllers/booking_controller.dart';
import 'payment_transaction_screen.dart';
import 'widgets/baggage_slider.dart';

class PassengerAddonsScreen extends StatefulWidget {
  final BookingController controller;

  const PassengerAddonsScreen({
    super.key,
    required this.controller,
  });

  @override
  State<PassengerAddonsScreen> createState() => _PassengerAddonsScreenState();
}

class _PassengerAddonsScreenState extends State<PassengerAddonsScreen> {
  final _nameController = TextEditingController(text: 'Ajeng Pratama');
  final _emailController = TextEditingController(text: 'ajeng.pratama@aeronest.io');
  final _phoneController = TextEditingController(text: '+62 812-9988-7711');
  final _passportController = TextEditingController(text: 'ID-8829104');

  late String _meal;
  late int _extraBaggage;
  late bool _insurance;

  final List<Map<String, String>> _meals = [
    {'name': 'Wagyu Tenderloin Bowl', 'desc': 'Daging wagyu meltique saus truffle', 'badge': 'Chef Pick'},
    {'name': 'Salmon Teriyaki & Rice', 'desc': 'Salmon norwegia panggang segar', 'badge': 'Seafood'},
    {'name': 'Vegan Garden Salad Bowl', 'desc': 'Alpukat, edamame, balsamic glazed', 'badge': 'Plant-Based'},
    {'name': 'Traditional Nasi Padang', 'desc': 'Rendang daging autentik', 'badge': 'Favorite'},
  ];

  @override
  void initState() {
    super.initState();
    _meal = widget.controller.selectedMeal;
    _extraBaggage = widget.controller.extraBaggageKg;
    _insurance = widget.controller.hasTravelInsurance;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passportController.dispose();
    super.dispose();
  }

  void _onProceedToPayment() {
    widget.controller.updateAddons(
      meal: _meal,
      extraBaggage: _extraBaggage,
      insurance: _insurance,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => PaymentTransactionScreen(
          controller: widget.controller,
          passengerName: _nameController.text.trim().isEmpty ? 'Ajeng Pratama' : _nameController.text.trim(),
          passengerEmail: _emailController.text.trim().isEmpty ? 'ajeng@aeronest.io' : _emailController.text.trim(),
          passengerPhone: _phoneController.text.trim().isEmpty ? '+62 812-9988-7711' : _phoneController.text.trim(),
          passportNumber: _passportController.text.trim().isEmpty ? 'ID-8829104' : _passportController.text.trim(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final flight = widget.controller.selectedFlight;
    final seat = widget.controller.selectedSeat;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded,
              size: 20, color: isDark ? Colors.white : AppColors.midnight),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Data & Layanan Tambahan',
          style: AppTypography.headingMedium.copyWith(
            color: isDark ? Colors.white : AppColors.midnight,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 140),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Flight & Seat Summary Card
            Soft3DCard(
              baseColor: isDark ? const Color(0xFF16152B) : Colors.white,
              border: Border.all(
                color: isDark ? const Color(0xFF29274C) : AppColors.borderLight,
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.orangeCream,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.flight_takeoff_rounded, color: AppColors.orangePrimary, size: 22),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${flight?.airlineName ?? "Flight"} • ${flight?.flightNumber ?? ""}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: isDark ? Colors.white : AppColors.midnight,
                          ),
                        ),
                        Text(
                          '${flight?.departure.city} (${flight?.departure.code}) ➔ ${flight?.arrival.city} (${flight?.arrival.code})',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark ? const Color(0xFF9E9BAC) : AppColors.slateMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.midnight,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Kursi ${seat?.code ?? "12A"}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Section 1: Passenger Information
            Text('DATA PENUMPANG UTAMA', style: AppTypography.bodySmall),
            const SizedBox(height: 10),
            Soft3DCard(
              baseColor: isDark ? const Color(0xFF16152B) : Colors.white,
              border: Border.all(
                color: isDark ? const Color(0xFF29274C) : AppColors.borderLight,
              ),
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  _buildInputField(
                    label: 'Nama Lengkap (sesuai Paspor / KTP)',
                    controller: _nameController,
                    icon: Icons.person_outline_rounded,
                    isDark: isDark,
                  ),
                  const SizedBox(height: 14),
                  _buildInputField(
                    label: 'Nomor Identitas / Paspor',
                    controller: _passportController,
                    icon: Icons.badge_outlined,
                    isDark: isDark,
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: _buildInputField(
                          label: 'Email Konfirmasi',
                          controller: _emailController,
                          icon: Icons.email_outlined,
                          isDark: isDark,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildInputField(
                          label: 'No. WhatsApp',
                          controller: _phoneController,
                          icon: Icons.phone_outlined,
                          isDark: isDark,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Section 2: Meal Selection
            Text('PILIHAN MAKANAN DI PESAWAT', style: AppTypography.bodySmall),
            const SizedBox(height: 10),
            Column(
              children: _meals.map((m) {
                final isSelected = _meal == m['name'];
                return GestureDetector(
                  onTap: () => setState(() => _meal = m['name']!),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? (isDark ? const Color(0xFF221F3F) : AppColors.orangeCream)
                          : (isDark ? const Color(0xFF16152B) : Colors.white),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? AppColors.orangePrimary : (isDark ? const Color(0xFF29274C) : AppColors.borderLight),
                        width: isSelected ? 1.5 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected ? AppColors.orangePrimary : AppColors.slateLight,
                              width: 2,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: isSelected
                              ? Container(
                                  width: 10,
                                  height: 10,
                                  decoration: const BoxDecoration(
                                    color: AppColors.orangePrimary,
                                    shape: BoxShape.circle,
                                  ),
                                )
                              : null,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    m['name']!,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: isDark ? Colors.white : AppColors.midnight,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: AppColors.lilacSoft,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      m['badge']!,
                                      style: const TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.lilacAccent,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(m['desc']!, style: const TextStyle(fontSize: 11, color: AppColors.slateMuted)),
                            ],
                          ),
                        ),
                        const Text(
                          'Gratis',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.mintSuccess,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 18),

            // Section 3: Extra Baggage
            Soft3DCard(
              baseColor: isDark ? const Color(0xFF16152B) : Colors.white,
              border: Border.all(
                color: isDark ? const Color(0xFF29274C) : AppColors.borderLight,
              ),
              padding: const EdgeInsets.all(18),
              child: BaggageSlider(
                selectedExtraKg: _extraBaggage,
                onWeightChanged: (w) => setState(() => _extraBaggage = w),
              ),
            ),

            const SizedBox(height: 18),

            // Section 4: Travel Insurance
            Soft3DCard(
              baseColor: isDark ? const Color(0xFF16152B) : Colors.white,
              border: Border.all(
                color: isDark ? const Color(0xFF29274C) : AppColors.borderLight,
              ),
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.mintSoft,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.shield_rounded, color: AppColors.mintSuccess, size: 24),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'AeroProtect™ Insurance',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: isDark ? Colors.white : AppColors.midnight,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              'Rp 75.000',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: AppColors.orangePrimary,
                              ),
                            ),
                          ],
                        ),
                        const Text(
                          'Kompensasi delay penerbangan & bagasi hingga Rp 50jt',
                          style: TextStyle(fontSize: 11, color: AppColors.slateMuted),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: _insurance,
                    activeThumbColor: AppColors.orangePrimary,
                    onChanged: (val) => setState(() => _insurance = val),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Bottom Sticky Bar -> Go To Payment
      bottomSheet: Container(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF16152B) : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, -6),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Subtotal Perjalanan', style: TextStyle(fontSize: 11, color: AppColors.slateMuted)),
                  Text(
                    Formatters.formatRupiah(widget.controller.subtotalPrice),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: AppColors.orangePrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: InteractiveScaleButton(
                  onPressed: _onProceedToPayment,
                  child: Container(
                    height: 52,
                    decoration: BoxDecoration(
                      gradient: AppColors.sunsetOrangeGradient,
                      borderRadius: BorderRadius.circular(26),
                      boxShadow: AppShadows.orangeGlow,
                    ),
                    alignment: Alignment.center,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pilih Pembayaran',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(width: 6),
                        Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 18),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    required bool isDark,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: isDark ? const Color(0xFFB4B2C8) : AppColors.slateMuted,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF22203E) : AppColors.surfaceSoft,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isDark ? const Color(0xFF322E58) : AppColors.borderLight,
            ),
          ),
          child: TextField(
            controller: controller,
            style: TextStyle(
              fontSize: 14,
              color: isDark ? Colors.white : AppColors.midnight,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              icon: Icon(icon, size: 18, color: isDark ? const Color(0xFF9E9BAC) : AppColors.slateMuted),
            ),
          ),
        ),
      ],
    );
  }
}
