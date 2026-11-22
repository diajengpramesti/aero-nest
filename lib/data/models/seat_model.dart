enum SeatCabinClass {
  firstClass,
  business,
  economy,
}

class Seat {
  final String code; // e.g., "12A"
  final int row;
  final String column; // 'A', 'B', 'C', 'D', 'E', 'F'
  final SeatCabinClass cabinClass;
  final bool isBooked;
  final double extraPrice;
  final List<String> perks;

  const Seat({
    required this.code,
    required this.row,
    required this.column,
    required this.cabinClass,
    this.isBooked = false,
    this.extraPrice = 0.0,
    this.perks = const [],
  });

  bool get isWindow => column == 'A' || column == 'F';
  bool get isAisle => column == 'C' || column == 'D';
}
