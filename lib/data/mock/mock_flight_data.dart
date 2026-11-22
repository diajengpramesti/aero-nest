import '../models/airport_model.dart';
import '../models/flight_model.dart';
import '../models/seat_model.dart';
import '../models/booking_model.dart';

class MockFlightData {
  static const List<Airport> airports = [
    // Indonesia 🇮🇩
    Airport(
      code: 'CGK',
      city: 'Jakarta',
      name: 'Soekarno-Hatta Int\'l Airport',
      country: 'Indonesia',
      countryCode: 'ID',
      flagEmoji: '🇮🇩',
      terminal: 'Terminal 3 Ultimate',
      imageUrl: 'https://images.unsplash.com/photo-1555899434-94d1368aa7af?w=600&q=80',
    ),
    Airport(
      code: 'DPS',
      city: 'Bali',
      name: 'I Gusti Ngurah Rai Int\'l',
      country: 'Indonesia',
      countryCode: 'ID',
      flagEmoji: '🇮🇩',
      terminal: 'Domestic & Int\'l',
      imageUrl: 'https://images.unsplash.com/photo-1537996194471-e657df975ab4?w=600&q=80',
    ),
    Airport(
      code: 'SUB',
      city: 'Surabaya',
      name: 'Juanda International Airport',
      country: 'Indonesia',
      countryCode: 'ID',
      flagEmoji: '🇮🇩',
      terminal: 'Terminal 1',
      imageUrl: 'https://images.unsplash.com/photo-1588668214407-6ea9a6d8c272?w=600&q=80',
    ),
    Airport(
      code: 'JOG',
      city: 'Yogyakarta',
      name: 'Yogyakarta Int\'l (YIA)',
      country: 'Indonesia',
      countryCode: 'ID',
      flagEmoji: '🇮🇩',
      terminal: 'Terminal A',
      imageUrl: 'https://images.unsplash.com/photo-1570789210967-2cac24afeb00?w=600&q=80',
    ),

    // Japan 🇯🇵
    Airport(
      code: 'HND',
      city: 'Tokyo',
      name: 'Tokyo Haneda International',
      country: 'Jepang',
      countryCode: 'JP',
      flagEmoji: '🇯🇵',
      terminal: 'Terminal 3',
      imageUrl: 'https://images.unsplash.com/photo-1503899036084-c55cdd92da26?w=600&q=80',
    ),
    Airport(
      code: 'KIX',
      city: 'Osaka',
      name: 'Kansai International Airport',
      country: 'Jepang',
      countryCode: 'JP',
      flagEmoji: '🇯🇵',
      terminal: 'Terminal 1',
      imageUrl: 'https://images.unsplash.com/photo-1590559899731-a382839e5549?w=600&q=80',
    ),

    // Singapore 🇸🇬
    Airport(
      code: 'SIN',
      city: 'Singapore',
      name: 'Singapore Changi Airport',
      country: 'Singapura',
      countryCode: 'SG',
      flagEmoji: '🇸🇬',
      terminal: 'Terminal 4 Jewel',
      imageUrl: 'https://images.unsplash.com/photo-1525625293386-3f8f99389edd?w=600&q=80',
    ),

    // France 🇫🇷
    Airport(
      code: 'CDG',
      city: 'Paris',
      name: 'Paris Charles de Gaulle',
      country: 'Prancis',
      countryCode: 'FR',
      flagEmoji: '🇫🇷',
      terminal: 'Terminal 2E',
      imageUrl: 'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?w=600&q=80',
    ),

    // South Korea 🇰🇷
    Airport(
      code: 'ICN',
      city: 'Seoul',
      name: 'Incheon International Airport',
      country: 'Korea Selatan',
      countryCode: 'KR',
      flagEmoji: '🇰🇷',
      terminal: 'Terminal 2',
      imageUrl: 'https://images.unsplash.com/photo-1538485399081-7191377e8241?w=600&q=80',
    ),

    // Australia 🇦🇺
    Airport(
      code: 'SYD',
      city: 'Sydney',
      name: 'Sydney Kingsford Smith',
      country: 'Australia',
      countryCode: 'AU',
      flagEmoji: '🇦🇺',
      terminal: 'Terminal 1 Int\'l',
      imageUrl: 'https://images.unsplash.com/photo-1506973035872-a4ec16b8e8d9?w=600&q=80',
    ),

    // United Kingdom 🇬🇧
    Airport(
      code: 'LHR',
      city: 'London',
      name: 'London Heathrow Airport',
      country: 'Inggris',
      countryCode: 'GB',
      flagEmoji: '🇬🇧',
      terminal: 'Terminal 5',
      imageUrl: 'https://images.unsplash.com/photo-1513635269975-59663e0ac1ad?w=600&q=80',
    ),
  ];

  /// Dynamically generates flights between any origin and destination airports
  static List<Flight> getFlightsForRoute(Airport dep, Airport arr, DateTime depDate) {
    final tomorrow = DateTime(depDate.year, depDate.month, depDate.day);
    final isInternational = dep.countryCode != arr.countryCode;

    if (isInternational) {
      return [
        Flight(
          id: 'FL-INT-001',
          flightNumber: 'GA-880',
          airlineName: 'Garuda Indonesia',
          airlineCode: 'GA',
          airlineColorHex: 0xFF0D5EAF,
          departure: dep,
          arrival: arr,
          departureTime: tomorrow.add(const Duration(hours: 8, minutes: 15)),
          arrivalTime: tomorrow.add(const Duration(hours: 15, minutes: 45)),
          stops: 0,
          basePrice: 6850000,
          aircraftType: 'Boeing 777-300ER',
          baggageKg: 35,
          cabinBaggageKg: 7,
          hasMeal: true,
          hasWifi: true,
          hasUsb: true,
          co2SavedPercentage: 24,
        ),
        Flight(
          id: 'FL-INT-002',
          flightNumber: 'SQ-958',
          airlineName: 'Singapore Airlines',
          airlineCode: 'SQ',
          airlineColorHex: 0xFF0B2144,
          departure: dep,
          arrival: arr,
          departureTime: tomorrow.add(const Duration(hours: 11, minutes: 30)),
          arrivalTime: tomorrow.add(const Duration(hours: 18, minutes: 50)),
          stops: 0,
          basePrice: 7920000,
          aircraftType: 'Airbus A350-900',
          baggageKg: 30,
          cabinBaggageKg: 7,
          hasMeal: true,
          hasWifi: true,
          hasUsb: true,
          co2SavedPercentage: 28,
        ),
        Flight(
          id: 'FL-INT-003',
          flightNumber: 'AF-254',
          airlineName: 'Air France / SkyTeam',
          airlineCode: 'AF',
          airlineColorHex: 0xFF002157,
          departure: dep,
          arrival: arr,
          departureTime: tomorrow.add(const Duration(hours: 19, minutes: 00)),
          arrivalTime: tomorrow.add(const Duration(hours: 33, minutes: 20)),
          stops: 1,
          transitCity: 'Singapore (SIN)',
          basePrice: 9450000,
          aircraftType: 'Boeing 787-9 Dreamliner',
          baggageKg: 40,
          cabinBaggageKg: 10,
          hasMeal: true,
          hasWifi: true,
          hasUsb: true,
          co2SavedPercentage: 21,
        ),
        Flight(
          id: 'FL-INT-004',
          flightNumber: 'NH-856',
          airlineName: 'All Nippon Airways (ANA)',
          airlineCode: 'NH',
          airlineColorHex: 0xFF003882,
          departure: dep,
          arrival: arr,
          departureTime: tomorrow.add(const Duration(hours: 21, minutes: 45)),
          arrivalTime: tomorrow.add(const Duration(hours: 31, minutes: 15)),
          stops: 0,
          basePrice: 8750000,
          aircraftType: 'Boeing 787-10 Suite',
          baggageKg: 46,
          cabinBaggageKg: 10,
          hasMeal: true,
          hasWifi: true,
          hasUsb: true,
          co2SavedPercentage: 30,
        ),
      ];
    } else {
      // Domestic route
      return [
        Flight(
          id: 'FL-DOM-001',
          flightNumber: 'GA-408',
          airlineName: 'Garuda Indonesia',
          airlineCode: 'GA',
          airlineColorHex: 0xFF0D5EAF,
          departure: dep,
          arrival: arr,
          departureTime: tomorrow.add(const Duration(hours: 7, minutes: 30)),
          arrivalTime: tomorrow.add(const Duration(hours: 9, minutes: 25)),
          stops: 0,
          basePrice: 1785000,
          aircraftType: 'Airbus A330-900neo',
          baggageKg: 30,
          cabinBaggageKg: 7,
          hasMeal: true,
          hasWifi: true,
          hasUsb: true,
          co2SavedPercentage: 22,
        ),
        Flight(
          id: 'FL-DOM-002',
          flightNumber: 'SAJ-712',
          airlineName: 'Super Air Jet',
          airlineCode: 'IU',
          airlineColorHex: 0xFFC29B38,
          departure: dep,
          arrival: arr,
          departureTime: tomorrow.add(const Duration(hours: 10, minutes: 40)),
          arrivalTime: tomorrow.add(const Duration(hours: 12, minutes: 35)),
          stops: 0,
          basePrice: 1150000,
          aircraftType: 'Airbus A320-200',
          baggageKg: 20,
          cabinBaggageKg: 7,
          hasMeal: false,
          hasWifi: false,
          hasUsb: true,
          co2SavedPercentage: 14,
        ),
        Flight(
          id: 'FL-DOM-003',
          flightNumber: 'BTK-651',
          airlineName: 'Batik Air Premium',
          airlineCode: 'ID',
          airlineColorHex: 0xFF7A1C1C,
          departure: dep,
          arrival: arr,
          departureTime: tomorrow.add(const Duration(hours: 14, minutes: 15)),
          arrivalTime: tomorrow.add(const Duration(hours: 16, minutes: 10)),
          stops: 0,
          basePrice: 1380000,
          aircraftType: 'Boeing 737-800',
          baggageKg: 20,
          cabinBaggageKg: 7,
          hasMeal: true,
          hasWifi: false,
          hasUsb: true,
          co2SavedPercentage: 18,
        ),
        Flight(
          id: 'FL-DOM-004',
          flightNumber: 'QZ-550',
          airlineName: 'AirAsia Premier',
          airlineCode: 'QZ',
          airlineColorHex: 0xFFED1C24,
          departure: dep,
          arrival: arr,
          departureTime: tomorrow.add(const Duration(hours: 17, minutes: 00)),
          arrivalTime: tomorrow.add(const Duration(hours: 18, minutes: 55)),
          stops: 0,
          basePrice: 940000,
          aircraftType: 'Airbus A321neo',
          baggageKg: 20,
          cabinBaggageKg: 7,
          hasMeal: true,
          hasWifi: false,
          hasUsb: true,
          co2SavedPercentage: 19,
        ),
      ];
    }
  }

  static List<Flight> getSampleFlights() {
    return getFlightsForRoute(airports[0], airports[1], DateTime.now().add(const Duration(days: 1)));
  }

  static List<Seat> generateCabinSeats() {
    final List<Seat> seats = [];

    // Rows 1-2: First Class (1-2-1 layout)
    for (int r = 1; r <= 2; r++) {
      for (final col in ['A', 'C', 'D', 'F']) {
        final isBooked = (r == 1 && col == 'A') || (r == 2 && col == 'D');
        seats.add(Seat(
          code: '$r$col',
          row: r,
          column: col,
          cabinClass: SeatCabinClass.firstClass,
          isBooked: isBooked,
          extraPrice: 1500000,
          perks: ['Lie-Flat Suite', 'Direct Aisle', 'Caviar Service', 'Privacy Door'],
        ));
      }
    }

    // Rows 3-6: Business Class (2-2 layout)
    for (int r = 3; r <= 6; r++) {
      for (final col in ['A', 'C', 'D', 'F']) {
        final isBooked = (r == 3 && col == 'C') || (r == 5 && col == 'A') || (r == 6 && col == 'F');
        seats.add(Seat(
          code: '$r$col',
          row: r,
          column: col,
          cabinClass: SeatCabinClass.business,
          isBooked: isBooked,
          extraPrice: 750000,
          perks: ['180° Recline', 'Noise-Cancel Tech', 'Gourmet Dining', 'Fast Track'],
        ));
      }
    }

    // Rows 7-18: Economy Class (3-3 layout)
    for (int r = 7; r <= 18; r++) {
      for (final col in ['A', 'B', 'C', 'D', 'E', 'F']) {
        final isBooked = (r % 2 == 0 && (col == 'B' || col == 'E')) ||
            (r == 9 && col == 'A') ||
            (r == 12 && col == 'C') ||
            (r == 15 && col == 'F');

        final isEmergencyExit = (r == 12);
        final extra = isEmergencyExit ? 150000.0 : (col == 'A' || col == 'F' ? 75000.0 : 0.0);

        final perks = <String>[];
        if (col == 'A' || col == 'F') perks.add('Panoramic Window');
        if (col == 'C' || col == 'D') perks.add('Quick Aisle Access');
        if (isEmergencyExit) perks.add('Extra 38" Legroom');
        perks.add('USB-C Charging');

        seats.add(Seat(
          code: '$r$col',
          row: r,
          column: col,
          cabinClass: SeatCabinClass.economy,
          isBooked: isBooked,
          extraPrice: extra,
          perks: perks,
        ));
      }
    }

    return seats;
  }

  static Booking getSampleActiveBooking() {
    final flights = getSampleFlights();
    final flight = flights.first;

    final passenger = const Passenger(
      id: 'PSG-001',
      title: 'Mr.',
      fullName: 'Ajeng Pratama',
      email: 'ajeng.pratama@aeronest.io',
      phone: '+62 812-9988-7711',
      passportNumber: 'ID-8829104',
      selectedMeal: 'Wagyu Tenderloin Rice',
      extraBaggageKg: 5,
      hasInsurance: true,
    );

    const seat = Seat(
      code: '12A',
      row: 12,
      column: 'A',
      cabinClass: SeatCabinClass.economy,
      extraPrice: 150000,
      perks: ['Panoramic Window', 'Extra 38" Legroom', 'USB-C Charging'],
    );

    return Booking(
      id: 'BKG-78192',
      pnr: 'SKY-7824X',
      flight: flight,
      passenger: passenger,
      seat: seat,
      gate: 'G-14',
      boardingGroup: 'Zone 2',
      boardingTime: flight.departureTime.subtract(const Duration(minutes: 45)),
      status: BookingStatus.boarding,
      totalPrice: flight.basePrice + 150000 + 75000,
      bookedAt: DateTime.now().subtract(const Duration(days: 2)),
    );
  }
}
