import 'flight_model.dart';
import 'seat_model.dart';

class Passenger {
  final String id;
  final String title;
  final String fullName;
  final String email;
  final String phone;
  final String passportNumber;
  final Seat? seat;
  final String selectedMeal;
  final int extraBaggageKg;
  final bool hasInsurance;

  const Passenger({
    required this.id,
    this.title = 'Mr.',
    required this.fullName,
    required this.email,
    required this.phone,
    required this.passportNumber,
    this.seat,
    this.selectedMeal = 'Standard Gourmet',
    this.extraBaggageKg = 0,
    this.hasInsurance = true,
  });

  Passenger copyWith({
    String? title,
    String? fullName,
    String? email,
    String? phone,
    String? passportNumber,
    Seat? seat,
    String? selectedMeal,
    int? extraBaggageKg,
    bool? hasInsurance,
  }) {
    return Passenger(
      id: id,
      title: title ?? this.title,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      passportNumber: passportNumber ?? this.passportNumber,
      seat: seat ?? this.seat,
      selectedMeal: selectedMeal ?? this.selectedMeal,
      extraBaggageKg: extraBaggageKg ?? this.extraBaggageKg,
      hasInsurance: hasInsurance ?? this.hasInsurance,
    );
  }
}

enum BookingStatus {
  confirmed,
  checkInOpen,
  boarding,
  completed,
}

class Booking {
  final String id;
  final String pnr;
  final Flight flight;
  final Passenger passenger;
  final Seat seat;
  final String gate;
  final String boardingGroup;
  final DateTime boardingTime;
  final BookingStatus status;
  final double totalPrice;
  final DateTime bookedAt;

  const Booking({
    required this.id,
    required this.pnr,
    required this.flight,
    required this.passenger,
    required this.seat,
    required this.gate,
    required this.boardingGroup,
    required this.boardingTime,
    required this.status,
    required this.totalPrice,
    required this.bookedAt,
  });
}
