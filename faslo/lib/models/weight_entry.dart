class WeightEntry {
  final String date; // YYYY-MM-DD
  final double valueKg;

  WeightEntry({required this.date, required this.valueKg});

  Map<String, dynamic> toJson() => {'date': date, 'valueKg': valueKg};

  factory WeightEntry.fromJson(Map<String, dynamic> j) => WeightEntry(
      date: j['date'] as String, valueKg: (j['valueKg'] as num).toDouble());
}
