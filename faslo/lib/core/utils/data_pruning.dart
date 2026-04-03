import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive/hive.dart';
import '../../models/fast_session.dart';

/// Utility class for pruning old data to prevent database growth.
///
/// Keeps only the last 365 days of data for sessions and water entries.
/// Pruning runs at most once per day on app start.
class DataPruning {
  static const int _retentionDays = 365;
  static const String _lastPruningKey = 'last_data_pruning';

  /// Performs data pruning if it hasn't been done today.
  ///
  /// This method should be called on app start. It will:
  /// 1. Check if pruning has already been done today
  /// 2. If not, prune old fast sessions and water entries
  /// 3. Update the last pruning date
  static Future<void> pruneIfNeeded() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final lastPruningStr = prefs.getString(_lastPruningKey);

      // Check if pruning was already done today
      if (lastPruningStr != null) {
        final lastPruning = DateTime.tryParse(lastPruningStr);
        if (lastPruning != null) {
          final now = DateTime.now();
          final today = DateTime(now.year, now.month, now.day);
          final lastPruningDay = DateTime(
            lastPruning.year,
            lastPruning.month,
            lastPruning.day,
          );

          // Skip if already pruned today
          if (lastPruningDay.isAtSameMomentAs(today)) {
            return;
          }
        }
      }

      // Perform pruning
      await _pruneFastSessions();
      await _pruneWaterEntries();

      // Update last pruning date
      await prefs.setString(_lastPruningKey, DateTime.now().toIso8601String());
    } catch (e) {
      // Continue even if pruning fails - don't crash the app
    }
  }

  /// Prunes fast sessions older than 365 days.
  static Future<void> _pruneFastSessions() async {
    try {
      final box = Hive.box<FastSession>('fast_sessions');
      final cutoffDate =
          DateTime.now().subtract(const Duration(days: _retentionDays));
      final keysToDelete = <String>[];

      for (final key in box.keys) {
        final session = box.get(key);
        if (session != null && session.startTime.isBefore(cutoffDate)) {
          keysToDelete.add(key as String);
        }
      }

      // Delete old sessions
      for (final key in keysToDelete) {
        await box.delete(key);
      }
    } catch (e) {
      // Continue even if pruning fails
    }
  }

  /// Prunes water entries older than 365 days.
  static Future<void> _pruneWaterEntries() async {
    try {
      final box = Hive.box<int>('water_entries');
      final cutoffDate =
          DateTime.now().subtract(const Duration(days: _retentionDays));
      final cutoffStr = _dateToString(cutoffDate);
      final keysToDelete = <String>[];

      for (final key in box.keys) {
        final dateStr = key as String;
        // Compare date strings (format: YYYY-MM-DD)
        if (dateStr.compareTo(cutoffStr) < 0) {
          keysToDelete.add(dateStr);
        }
      }

      // Delete old entries
      for (final key in keysToDelete) {
        await box.delete(key);
      }
    } catch (e) {
      // Continue even if pruning fails
    }
  }

  /// Converts a DateTime to a date string in YYYY-MM-DD format.
  static String _dateToString(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  /// Forces pruning to run regardless of the last pruning date.
  /// Useful for testing or manual triggers.
  static Future<void> forcePrune() async {
    try {
      await _pruneFastSessions();
      await _pruneWaterEntries();

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_lastPruningKey, DateTime.now().toIso8601String());
    } catch (e) {
      // Continue even if pruning fails
    }
  }

  /// Returns the date of the last pruning operation.
  static Future<DateTime?> getLastPruningDate() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final lastPruningStr = prefs.getString(_lastPruningKey);
      if (lastPruningStr != null) {
        return DateTime.tryParse(lastPruningStr);
      }
    } catch (e) {
      // Return null on error
    }
    return null;
  }
}
