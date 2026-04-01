class WaterEntry {
  final String date; // YYYY-MM-DD
  final int glasses;

  WaterEntry({required this.date, required this.glasses});

  Map<String, dynamic> toJson() => {'date': date, 'glasses': glasses};

  factory WaterEntry.fromJson(Map<String, dynamic> j) =>
      WaterEntry(date: j['date'] as String, glasses: j['glasses'] as int);
}
