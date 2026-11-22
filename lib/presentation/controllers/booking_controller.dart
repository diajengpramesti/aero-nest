import 'package:flutter/material.dart';
import '../../data/models/airport_model.dart';
import '../../data/models/flight_model.dart';
import '../../data/models/seat_model.dart';
import '../../data/models/booking_model.dart';
import '../../data/mock/mock_flight_data.dart';

enum TripType { oneWay, roundTrip, multiCity }

enum FlightSortBy { cheapest, fastest, earliest }

enum PaymentMethodType { qris, virtualAccount, creditCard, eWallet }

class BookingController extends ChangeNotifier {
  // Search parameters
  TripType _tripType = TripType.roundTrip;
  Airport _departureAirport = MockFlightData.airports[0]; // CGK (Jakarta)
  Airport _arrivalAirport = MockFlightData.airports[1]; // DPS (Bali)
  DateTime _departureDate = DateTime.now().add(const Duration(days: 1));
  DateTime _returnDate = DateTime.now().add(const Duration(days: 5));
  int _adultPassengers = 1;
  int _childPassengers = 0;
  SeatCabinClass _preferredCabin = SeatCabinClass.economy;

  // Filter & Search results
  FlightSortBy _sortBy = FlightSortBy.cheapest;
  bool _directFlightsOnly = false;
  double _maxPrice = 25000000;
  List<Flight> _allFlights = [];
  List<Flight> _filteredFlights = [];

  // Active Flow Selection
  Flight? _selectedFlight;
  Seat? _selectedSeat;
  String _selectedMeal = 'Wagyu Tenderloin Bowl';
  int _extraBaggageKg = 0;
  bool _hasTravelInsurance = true;

  // Transaction & Payment
  PaymentMethodType _selectedPaymentMethod = PaymentMethodType.qris;
  String _selectedBankOrWallet = 'BCA';
  String? _appliedPromoCode;
  double _discountAmount = 0.0;

  // Booked Tickets
  final List<Booking> _myBookings = [];
  Booking? _currentBoardingPass;

  BookingController() {
    _refreshFlightsForCurrentRoute();
    _myBookings.add(MockFlightData.getSampleActiveBooking());
    _currentBoardingPass = _myBookings.first;
  }

  // Getters
  TripType get tripType => _tripType;
  Airport get departureAirport => _departureAirport;
  Airport get arrivalAirport => _arrivalAirport;
  DateTime get departureDate => _departureDate;
  DateTime get returnDate => _returnDate;
  int get adultPassengers => _adultPassengers;
  int get childPassengers => _childPassengers;
  int get totalPassengers => _adultPassengers + _childPassengers;
  SeatCabinClass get preferredCabin => _preferredCabin;

  FlightSortBy get sortBy => _sortBy;
  bool get directFlightsOnly => _directFlightsOnly;
  double get maxPrice => _maxPrice;
  List<Flight> get filteredFlights => _filteredFlights;

  Flight? get selectedFlight => _selectedFlight;
  Seat? get selectedSeat => _selectedSeat;
  String get selectedMeal => _selectedMeal;
  int get extraBaggageKg => _extraBaggageKg;
  bool get hasTravelInsurance => _hasTravelInsurance;

  PaymentMethodType get selectedPaymentMethod => _selectedPaymentMethod;
  String get selectedBankOrWallet => _selectedBankOrWallet;
  String? get appliedPromoCode => _appliedPromoCode;
  double get discountAmount => _discountAmount;

  List<Booking> get myBookings => _myBookings;
  Booking? get currentBoardingPass => _currentBoardingPass;

  // Total price calculation for active checkout
  double get subtotalPrice {
    if (_selectedFlight == null) return 0;
    double base = _selectedFlight!.basePrice * totalPassengers;
    if (_selectedSeat != null) {
      base += _selectedSeat!.extraPrice;
    }
    base += (_extraBaggageKg * 45000);
    if (_hasTravelInsurance) {
      base += (75000 * totalPassengers);
    }
    return base;
  }

  double get checkoutTotalPrice {
    final sub = subtotalPrice;
    final total = sub - _discountAmount;
    return total < 0 ? 0 : total;
  }

  // Setters & Actions
  void setTripType(TripType type) {
    _tripType = type;
    notifyListeners();
  }

  void swapAirports() {
    final temp = _departureAirport;
    _departureAirport = _arrivalAirport;
    _arrivalAirport = temp;
    _refreshFlightsForCurrentRoute();
    notifyListeners();
  }

  void setAirports(Airport dep, Airport arr) {
    _departureAirport = dep;
    _arrivalAirport = arr;
    _refreshFlightsForCurrentRoute();
    notifyListeners();
  }

  void setDates(DateTime dep, DateTime? ret) {
    _departureDate = dep;
    if (ret != null) _returnDate = ret;
    _refreshFlightsForCurrentRoute();
    notifyListeners();
  }

  void updatePassengers({required int adults, required int children}) {
    _adultPassengers = adults;
    _childPassengers = children;
    notifyListeners();
  }

  void setCabinClass(SeatCabinClass cabin) {
    _preferredCabin = cabin;
    notifyListeners();
  }

  void setSortBy(FlightSortBy sort) {
    _sortBy = sort;
    _applyFlightFilters();
    notifyListeners();
  }

  void toggleDirectFlightsOnly(bool value) {
    _directFlightsOnly = value;
    _applyFlightFilters();
    notifyListeners();
  }

  void setMaxPrice(double price) {
    _maxPrice = price;
    _applyFlightFilters();
    notifyListeners();
  }

  void _refreshFlightsForCurrentRoute() {
    _allFlights = MockFlightData.getFlightsForRoute(
      _departureAirport,
      _arrivalAirport,
      _departureDate,
    );
    _applyFlightFilters();
  }

  void _applyFlightFilters() {
    var result = _allFlights.where((f) {
      if (_directFlightsOnly && !f.isDirect) return false;
      if (f.basePrice > _maxPrice) return false;
      return true;
    }).toList();

    switch (_sortBy) {
      case FlightSortBy.cheapest:
        result.sort((a, b) => a.basePrice.compareTo(b.basePrice));
        break;
      case FlightSortBy.fastest:
        result.sort((a, b) => a.duration.compareTo(b.duration));
        break;
      case FlightSortBy.earliest:
        result.sort((a, b) => a.departureTime.compareTo(b.departureTime));
        break;
    }

    _filteredFlights = result;
  }

  void selectFlight(Flight flight) {
    _selectedFlight = flight;
    _selectedSeat = null;
    notifyListeners();
  }

  void selectSeat(Seat seat) {
    _selectedSeat = seat;
    notifyListeners();
  }

  void updateAddons({
    required String meal,
    required int extraBaggage,
    required bool insurance,
  }) {
    _selectedMeal = meal;
    _extraBaggageKg = extraBaggage;
    _hasTravelInsurance = insurance;
    notifyListeners();
  }

  void setPaymentMethod(PaymentMethodType method, {String? subOption}) {
    _selectedPaymentMethod = method;
    if (subOption != null) _selectedBankOrWallet = subOption;
    notifyListeners();
  }

  bool applyPromo(String code) {
    if (code.trim().toUpperCase() == 'AEROGENZ') {
      _appliedPromoCode = 'AEROGENZ';
      _discountAmount = 250000;
      notifyListeners();
      return true;
    }
    return false;
  }

  void removePromo() {
    _appliedPromoCode = null;
    _discountAmount = 0.0;
    notifyListeners();
  }

  Booking confirmBooking({
    required String fullName,
    required String email,
    required String phone,
    required String passport,
  }) {
    final flight = _selectedFlight ?? _allFlights.first;
    final seat =
        _selectedSeat ??
        const Seat(
          code: '14B',
          row: 14,
          column: 'B',
          cabinClass: SeatCabinClass.economy,
        );

    final passenger = Passenger(
      id: 'PSG-${DateTime.now().millisecondsSinceEpoch % 10000}',
      fullName: fullName,
      email: email,
      phone: phone,
      passportNumber: passport,
      seat: seat,
      selectedMeal: _selectedMeal,
      extraBaggageKg: _extraBaggageKg,
      hasInsurance: _hasTravelInsurance,
    );

    final booking = Booking(
      id: 'BKG-${DateTime.now().millisecondsSinceEpoch % 100000}',
      pnr: 'SKY-${(1000 + (DateTime.now().millisecond * 7)) % 9000}X',
      flight: flight,
      passenger: passenger,
      seat: seat,
      gate: 'G-${(flight.flightNumber.hashCode % 18).abs() + 1}',
      boardingGroup:
          'Zone ${seat.cabinClass == SeatCabinClass.business ? '1' : '3'}',
      boardingTime: flight.departureTime.subtract(const Duration(minutes: 45)),
      status: BookingStatus.confirmed,
      totalPrice: checkoutTotalPrice > 0
          ? checkoutTotalPrice
          : flight.basePrice,
      bookedAt: DateTime.now(),
    );

    _myBookings.insert(0, booking);
    _currentBoardingPass = booking;
    notifyListeners();
    return booking;
  }

  void setActiveBoardingPass(Booking booking) {
    _currentBoardingPass = booking;
    notifyListeners();
  }
}
