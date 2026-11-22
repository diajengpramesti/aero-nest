import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/interactive_scale_button.dart';
import '../../data/models/airport_model.dart';
import '../../data/mock/mock_flight_data.dart';

class CountryAirportPickerModal extends StatefulWidget {
  final bool isSelectingOrigin;
  final ValueChanged<Airport> onAirportSelected;

  const CountryAirportPickerModal({
    super.key,
    required this.isSelectingOrigin,
    required this.onAirportSelected,
  });

  static void show(
    BuildContext context, {
    required bool isSelectingOrigin,
    required ValueChanged<Airport> onAirportSelected,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => CountryAirportPickerModal(
        isSelectingOrigin: isSelectingOrigin,
        onAirportSelected: onAirportSelected,
      ),
    );
  }

  @override
  State<CountryAirportPickerModal> createState() => _CountryAirportPickerModalState();
}

class _CountryAirportPickerModalState extends State<CountryAirportPickerModal> {
  String _searchQuery = '';
  String _selectedCountryFilter = 'Semua';

  final List<String> _countryFilters = [
    'Semua',
    '🇮🇩 Indonesia',
    '🇯🇵 Jepang',
    '🇸🇬 Singapura',
    '🇫🇷 Prancis',
    '🇰🇷 Korea',
    '🇦🇺 Australia',
    '🇬🇧 Inggris',
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? const Color(0xFF16152B) : Colors.white;

    final filteredAirports = MockFlightData.airports.where((a) {
      if (_selectedCountryFilter != 'Semua') {
        final cleanFilter = _selectedCountryFilter.split(' ').last.toLowerCase();
        if (!a.country.toLowerCase().contains(cleanFilter)) {
          return false;
        }
      }
      if (_searchQuery.trim().isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        final matchesCode = a.code.toLowerCase().contains(q);
        final matchesCity = a.city.toLowerCase().contains(q);
        final matchesCountry = a.country.toLowerCase().contains(q);
        final matchesName = a.name.toLowerCase().contains(q);
        return matchesCode || matchesCity || matchesCountry || matchesName;
      }
      return true;
    }).toList();

    return Container(
      height: MediaQuery.of(context).size.height * 0.82,
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(36)),
        border: Border.all(
          color: isDark ? const Color(0xFF29274C) : AppColors.borderLight,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 44,
              height: 4,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF33305B) : AppColors.borderLight,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 18),

          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.orangeCream,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  widget.isSelectingOrigin
                      ? Icons.flight_takeoff_rounded
                      : Icons.flight_land_rounded,
                  color: AppColors.orangePrimary,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.isSelectingOrigin ? 'Pilih Kota Keberangkatan' : 'Pilih Negara & Kota Tujuan ✈️',
                    style: AppTypography.headingLarge.copyWith(
                      color: isDark ? Colors.white : AppColors.midnight,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'Pilihan rute domestik & destinasi internasional',
                    style: AppTypography.bodySmall.copyWith(
                      color: isDark ? const Color(0xFF9E9BAC) : AppColors.slateMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Search Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF22203E) : AppColors.surfaceSoft,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: isDark ? const Color(0xFF322E58) : AppColors.borderLight,
              ),
            ),
            child: TextField(
              onChanged: (val) => setState(() => _searchQuery = val),
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.white : AppColors.midnight,
              ),
              decoration: InputDecoration(
                hintText: 'Cari negara, kota (cth. Tokyo, Paris, Bali, CGK)',
                hintStyle: TextStyle(
                  fontSize: 13,
                  color: isDark ? const Color(0xFF6B6888) : AppColors.slateLight,
                ),
                border: InputBorder.none,
                icon: Icon(
                  Icons.search_rounded,
                  color: isDark ? const Color(0xFF9E9BAC) : AppColors.slateMuted,
                  size: 20,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Country Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _countryFilters.map((country) {
                final isSelected = _selectedCountryFilter == country;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCountryFilter = country),
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.orangePrimary
                          : (isDark ? const Color(0xFF1E1C38) : AppColors.surfaceSoft),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.orangePrimary
                            : (isDark ? const Color(0xFF2D2B4E) : AppColors.borderLight),
                      ),
                    ),
                    child: Text(
                      country,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected
                            ? Colors.white
                            : (isDark ? Colors.white70 : AppColors.midnight),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),

          // Airport List
          Expanded(
            child: filteredAirports.isEmpty
                ? Center(
                    child: Text(
                      'Tidak ada bandara yang cocok',
                      style: AppTypography.bodyMedium,
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredAirports.length,
                    itemBuilder: (context, index) {
                      final a = filteredAirports[index];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: InteractiveScaleButton(
                          onPressed: () {
                            widget.onAirportSelected(a);
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: isDark ? const Color(0xFF1C1A36) : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isDark ? const Color(0xFF2A284E) : AppColors.borderLight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                // Flag & Code Badge
                                Container(
                                  width: 52,
                                  height: 52,
                                  decoration: BoxDecoration(
                                    color: isDark ? const Color(0xFF252347) : AppColors.surfaceSoft,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(a.flagEmoji, style: const TextStyle(fontSize: 18)),
                                      Text(
                                        a.code,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w800,
                                          color: isDark ? Colors.white : AppColors.midnight,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 14),

                                // City & Details
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            a.city,
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800,
                                              color: isDark ? Colors.white : AppColors.midnight,
                                            ),
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            '• ${a.country}',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: isDark ? const Color(0xFF9E9BAC) : AppColors.slateMuted,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        '${a.name} • ${a.terminal}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: isDark ? const Color(0xFF7A7790) : AppColors.slateLight,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 14,
                                  color: AppColors.orangePrimary,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
