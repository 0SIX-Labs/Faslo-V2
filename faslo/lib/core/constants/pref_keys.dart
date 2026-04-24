class PrefKeys {
  static const String onboardingDone = 'onboarding_done';
  static const String appTheme = 'app_theme';
  static const String appLocale = 'app_locale';
  static const String units = 'units'; // 'metric' | 'imperial'
  static const String clockFormat = 'clock_format'; // '24h' | '12h'
  static const String userName = 'user_name';
  static const String activePlan =
      'active_plan'; // plan ratio string e.g. '16:8'
  static const String activeFastStart = 'active_fast_start'; // ISO8601 or empty
  static const String fastSessions = 'fast_sessions'; // JSON array
  static const String weightEntries = 'weight_entries'; // JSON array
  static const String waterEntries = 'water_entries'; // JSON array
  static const String moodEntries = 'mood_entries'; // JSON array
  static const String notifFastEnd = 'notif_fast_end';
  static const String notifHalfway = 'notif_halfway';
  static const String notifKetosis = 'notif_ketosis';
  static const String notifWater = 'notif_water';
  static const String notifEnabled = 'notif_enabled';
  static const String waterGoal = 'water_goal'; // int, default 8
}
