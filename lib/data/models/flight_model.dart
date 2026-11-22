import 'airport_model.dart';

class Flight {
  final String id;
  final String flightNumber;
  final String airlineName;
  final String airlineCode;
  final int airlineColorHex;
  final Airport departure;
  final Airport arrival;
  final DateTime departureTime;
  final DateTime arrivalTime;
  final int stops; // 0 for direct
  final String? transitCity;
  final double basePrice;
  final String aircraftType;
  final int baggageKg;
  final int cabinBaggageKg;
  final bool hasMeal;
  final bool hasWifi;
  final bool hasUsb;
  final int co2SavedPercentage;

  const Flight({
    required this.id,
    required this.flightNumber,
    required this.airlineName,
    required this.airlineCode,
    required this.airlineColorHex,
    required this.departure,
    required this.arrival,
    required this.departureTime,
    required this.arrivalTime,
    this.stops = 0,
    this.transitCity,
    required this.basePrice,
    required this.aircraftType,
    this.baggageKg = 20,
    this.cabinBaggageKg = 7,
    this.hasMeal = true,
    this.hasWifi = true,
    this.hasUsb = true,
    this.co2SavedPercentage = 18,
  });

  Duration get duration => arrivalTime.difference(departureTime);

  bool get isDirect => stops == 0;
}
