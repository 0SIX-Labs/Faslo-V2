import 'package:hive/hive.dart';

part 'fast_session.g.dart';

@HiveType(typeId: 0)
class FastSession extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime startTime;

  @HiveField(2)
  final DateTime? endTime;

  @HiveField(3)
  final String planRatio;

  @HiveField(4)
  final int targetHours;

  @HiveField(5)
  final bool completed;

  FastSession({
    required this.id,
    required this.startTime,
    this.endTime,
    required this.planRatio,
    required this.targetHours,
    this.completed = false,
  });

  Duration get elapsed => (endTime ?? DateTime.now()).difference(startTime);
  bool get goalMet => elapsed.inHours >= targetHours;

  Map<String, dynamic> toJson() => {
        'id': id,
        'startTime': startTime.toIso8601String(),
        'endTime': endTime?.toIso8601String(),
        'planRatio': planRatio,
        'targetHours': targetHours,
        'completed': completed,
      };

  factory FastSession.fromJson(Map<String, dynamic> j) => FastSession(
        id: j['id'] as String,
        startTime: DateTime.parse(j['startTime'] as String),
        endTime: j['endTime'] != null
            ? DateTime.parse(j['endTime'] as String)
            : null,
        planRatio: j['planRatio'] as String,
        targetHours: j['targetHours'] as int,
        completed: j['completed'] as bool? ?? false,
      );
}
