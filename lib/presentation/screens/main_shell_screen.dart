import 'package:flutter/material.dart';
import '../../core/localization/locale_controller.dart';
import '../../core/theme/theme_controller.dart';
import '../controllers/auth_controller.dart';
import '../controllers/booking_controller.dart';
import '../navigation/gen_z_glassy_dock.dart';
import '../screens/explore/explore_screen.dart';
import '../screens/trips/my_trips_screen.dart';
import '../screens/radar/radar_deals_screen.dart';
import '../screens/profile/gen_z_passport_profile_screen.dart';
import '../screens/search_results/flight_search_results_screen.dart';
import '../screens/boarding_pass/boarding_pass_screen.dart';

class MainShellScreen extends StatefulWidget {
  final AuthController authController;
  final LocaleController localeController;
  final ThemeController themeController;

  const MainShellScreen({
    super.key,
    required this.authController,
    required this.localeController,
    required this.themeController,
  });

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  int _currentIndex = 0;
  final BookingController _bookingController = BookingController();

  @override
  void dispose() {
    _bookingController.dispose();
    super.dispose();
  }

  void _onNavigateToSearchResults() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => FlightSearchResultsScreen(
          controller: _bookingController,
        ),
      ),
    );
  }

  void _onOpenActivePass() {
    if (_bookingController.myBookings.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => BoardingPassScreen(
            booking: _bookingController.myBookings.first,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      ExploreScreen(
        controller: _bookingController,
        authController: widget.authController,
        localeController: widget.localeController,
        themeController: widget.themeController,
        onNavigateToResults: _onNavigateToSearchResults,
        onOpenActivePass: _onOpenActivePass,
      ),
      MyTripsScreen(
        controller: _bookingController,
      ),
      RadarDealsScreen(
        controller: _bookingController,
      ),
      GenZPassportProfileScreen(
        authController: widget.authController,
        localeController: widget.localeController,
        themeController: widget.themeController,
      ),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          // Current Tab screen
          IndexedStack(
            index: _currentIndex,
            children: screens,
          ),

          // Gen-Z Glassy Dock Navigation Bar
          GenZGlassyDock(
            selectedIndex: _currentIndex,
            onTabSelected: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ],
      ),
    );
  }
}
