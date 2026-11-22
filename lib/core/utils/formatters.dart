class Formatters {
  static const List<String> _monthsId = [
    '',
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'Mei',
    'Jun',
    'Jul',
    'Agu',
    'Sep',
    'Okt',
    'Nov',
    'Des',
  ];

  static const List<String> _daysId = [
    '',
    'Sen',
    'Sel',
    'Rab',
    'Kam',
    'Jum',
    'Sab',
    'Min',
  ];

  /// Format rupiah currency safely without dependency on external locale files
  static String formatRupiah(num amount) {
    final int intAmount = amount.round();
    final String str = intAmount.abs().toString();
    final StringBuffer buffer = StringBuffer();

    for (int i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) {
        buffer.write('.');
      }
      buffer.write(str[i]);
    }

    return 'Rp ${intAmount < 0 ? '-' : ''}$buffer';
  }

  /// Format date e.g. "Sen, 23 Nov 2026"
  static String formatDate(DateTime date) {
    final dayName = _daysId[date.weekday.clamp(1, 7)];
    final monthName = _monthsId[date.month.clamp(1, 12)];
    return '$dayName, ${date.day} $monthName ${date.year}';
  }

  /// Format short date e.g. "23 Nov"
  static String formatDateShort(DateTime date) {
    final monthName = _monthsId[date.month.clamp(1, 12)];
    return '${date.day} $monthName';
  }

  /// Format time e.g. "09:30"
  static String formatTime(DateTime time) {
    final h = time.hour.toString().padLeft(2, '0');
    final m = time.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  /// Format duration e.g. "1j 45m"
  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    return '${hours}j ${minutes}m';
  }
}
