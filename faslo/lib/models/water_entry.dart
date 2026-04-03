import 'package:hive/hive.dart';

part 'water_entry.g.dart';

@HiveType(typeId: 1)
class WaterEntry extends HiveObject {
  @HiveField(0)
  final String date; // YYYY-MM-DD

  @HiveField(1)
  final int glasses;

  WaterEntry({required this.date, required this.glasses});

  Map<String, dynamic> toJson() => {'date': date, 'glasses': glasses};

  factory WaterEntry.fromJson(Map<String, dynamic> j) =>
      WaterEntry(date: j['date'] as String, glasses: j['glasses'] as int);
}
