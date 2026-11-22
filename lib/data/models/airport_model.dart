class Airport {
  final String code;
  final String city;
  final String name;
  final String country;
  final String countryCode; // e.g. "ID", "JP", "SG", "FR", "KR", "AU", "GB"
  final String flagEmoji;
  final String terminal;
  final String imageUrl;

  const Airport({
    required this.code,
    required this.city,
    required this.name,
    required this.country,
    required this.countryCode,
    required this.flagEmoji,
    this.terminal = 'Terminal 3',
    required this.imageUrl,
  });
}
