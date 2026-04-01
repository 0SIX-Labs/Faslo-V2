import 'package:share_plus/share_plus.dart';
import '../models/fast_session.dart';

class ShareService {
  ShareService._();

  /// Generate share text for a completed fast
  static String buildShareText({
    required Duration elapsed,
    required int streak,
    required String planRatio,
  }) {
    final hours = elapsed.inHours;
    final minutes = elapsed.inMinutes % 60;
    final durationStr = minutes > 0 ? '${hours}h ${minutes}m' : '${hours}h';

    final streakLine =
        streak > 0 ? '\nStreak: $streak day${streak > 1 ? 's' : ''} 🔥' : '';

    return '$durationStr fast completed 🔥$streakLine\n\nFaslo — Fast with intention.';
  }

  /// Share completed fast as text
  static Future<void> shareFast({
    required FastSession session,
    required int streak,
  }) async {
    final text = buildShareText(
      elapsed: session.elapsed,
      streak: streak,
      planRatio: session.planRatio,
    );

    await Share.share(text);
  }

  /// Future: Share as image
  /// Will capture the ShareCard widget as PNG and share
  // static Future<void> shareImage(GlobalKey boundaryKey) async {
  //   // Implementation for future image export
  // }
}
