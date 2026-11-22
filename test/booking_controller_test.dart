import 'package:flutter_test/flutter_test.dart';
import 'package:aero_nest/presentation/controllers/auth_controller.dart';
import 'package:aero_nest/presentation/controllers/booking_controller.dart';
import 'package:aero_nest/core/utils/formatters.dart';
import 'package:aero_nest/data/mock/mock_flight_data.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting('id_ID', null);
  });

  group('AuthController Guest & Auth Test Suite', () {
    test('Initial state is not logged in and not guest', () {
      final auth = AuthController();
      expect(auth.isLoggedIn, isFalse);
      expect(auth.isGuest, isFalse);
    });

    test('loginAsGuest sets isLoggedIn and isGuest to true', () {
      final auth = AuthController();
      auth.loginAsGuest();
      expect(auth.isLoggedIn, isTrue);
      expect(auth.isGuest, isTrue);
      expect(auth.userName, equals('Tamu AeroNest'));
    });

    test('login with credentials switches out of guest mode', () {
      final auth = AuthController();
      auth.loginAsGuest();
      expect(auth.isGuest, isTrue);

      final ok = auth.login(email: 'ajeng@aeronest.io', password: 'secretpassword');
      expect(ok, isTrue);
      expect(auth.isLoggedIn, isTrue);
      expect(auth.isGuest, isFalse);
    });
  });

  group('BookingController Test Suite', () {
    test('Initial state has default airports and sample bookings', () {
      final controller = BookingController();
      expect(controller.departureAirport.code, equals('CGK'));
      expect(controller.arrivalAirport.code, equals('DPS'));
      expect(controller.filteredFlights.isNotEmpty, isTrue);
      expect(controller.myBookings.isNotEmpty, isTrue);
    });

    test('Swap airports switches origin and destination', () {
      final controller = BookingController();
      controller.swapAirports();
      expect(controller.departureAirport.code, equals('DPS'));
      expect(controller.arrivalAirport.code, equals('CGK'));
    });

    test('Selecting international destination updates flights dynamically', () {
      final controller = BookingController();
      final tokyo = MockFlightData.airports.firstWhere((a) => a.code == 'HND');
      controller.setAirports(controller.departureAirport, tokyo);

      expect(controller.arrivalAirport.city, equals('Tokyo'));
      expect(controller.filteredFlights.isNotEmpty, isTrue);
    });

    test('Applying promo code AEROGENZ gives Rp 250.000 discount', () {
      final controller = BookingController();
      final flight = controller.filteredFlights.first;
      controller.selectFlight(flight);

      final initialPrice = controller.subtotalPrice;
      final ok = controller.applyPromo('AEROGENZ');

      expect(ok, isTrue);
      expect(controller.discountAmount, equals(250000));
      expect(controller.checkoutTotalPrice, equals(initialPrice - 250000));
    });

    test('Confirm booking creates valid PNR and adds to myBookings', () {
      final controller = BookingController();
      final prevCount = controller.myBookings.length;
      final booking = controller.confirmBooking(
        fullName: 'Ajeng Traveler',
        email: 'ajeng@example.com',
        phone: '+62812345678',
        passport: 'ID-9999',
      );

      expect(controller.myBookings.length, equals(prevCount + 1));
      expect(booking.pnr.startsWith('SKY-'), isTrue);
      expect(booking.passenger.fullName, equals('Ajeng Traveler'));
    });
  });

  group('Formatters Test Suite', () {
    test('Currency format correctly shows Rupiah symbol', () {
      final formatted = Formatters.formatRupiah(1500000);
      expect(formatted.contains('1.500.000'), isTrue);
    });
  });
}
