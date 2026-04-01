class MoodEntry {
  final String date; // YYYY-MM-DD
  final int score; // 1–5

  MoodEntry({required this.date, required this.score});

  Map<String, dynamic> toJson() => {'date': date, 'score': score};

  factory MoodEntry.fromJson(Map<String, dynamic> j) =>
      MoodEntry(date: j['date'] as String, score: j['score'] as int);
}
