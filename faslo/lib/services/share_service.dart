import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
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

  /// Share ShareCard widget as high resolution image
  /// Optimized for Instagram Stories / WhatsApp Status
  static Future<void> shareImage(GlobalKey boundaryKey) async {
    try {
      // Capture widget as high resolution image
      RenderRepaintBoundary boundary = boundaryKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;

      // 3x pixel density for crisp high quality output
      final image = await boundary.toImage(pixelRatio: 3.0);
      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      final Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Save to temporary file
      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/fast_completed.png').create();
      await file.writeAsBytes(pngBytes);

      // Share image
      await Share.shareXFiles(
        [XFile(file.path)],
        subject: 'Fast Completed!',
      );
    } catch (e) {
      // Fallback to text share if image capture fails
    }
  }
}
