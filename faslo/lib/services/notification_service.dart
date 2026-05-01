import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:faslo/l10n/app_localizations.dart';

class NotificationService {
  static final _plugin = FlutterLocalNotificationsPlugin();
  static bool _initialised = false;

  static Future<void> init() async {
    if (_initialised) return;
    tzdata.initializeTimeZones();
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    await _plugin.initialize(
      const InitializationSettings(android: android, iOS: ios),
    );
    _initialised = true;
  }

  /// Request Android 13+ notification permission.
  /// Call this AFTER the app UI is shown, never during cold-start init.
  static Future<void> requestPermission() async {
    final androidPlugin = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (androidPlugin != null) {
      try {
        await androidPlugin.requestNotificationsPermission();
      } catch (e) {
        debugPrint('Notification permission request failed: $e');
      }
    }
  }

  static AndroidNotificationDetails _androidDetails(
          String channelId, String channelName) =>
      AndroidNotificationDetails(
        channelId,
        channelName,
        importance: Importance.high,
        priority: Priority.high,
        enableVibration: true,
      );

  static const DarwinNotificationDetails _iosDetails =
      DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );

  static Future<void> showFastComplete(String locale, int hours) async {
    final l10n = await AppLocalizations.delegate.load(Locale(locale));
    await _plugin.show(
      1,
      l10n.fastCompletedTitle,
      l10n.fastCompletedBody(hours),
      NotificationDetails(
        android: _androidDetails('fast_complete', 'Fast Complete'),
        iOS: _iosDetails,
      ),
    );
  }

  static Future<void> scheduleHalfway(
      String locale, DateTime fastStart, int targetHours) async {
    final halfwayTime = fastStart.add(Duration(hours: targetHours ~/ 2));
    if (halfwayTime.isBefore(DateTime.now())) return;
    final l10n = await AppLocalizations.delegate.load(Locale(locale));

    await _plugin.zonedSchedule(
      2,
      l10n.halfwayTitle,
      l10n.halfwayBody,
      tz.TZDateTime.from(halfwayTime, tz.local),
      NotificationDetails(
        android: _androidDetails('milestones', 'Fasting Milestones'),
        iOS: _iosDetails,
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future<void> scheduleKetosis(String locale, DateTime fastStart) async {
    final ketosisTime = fastStart.add(const Duration(hours: 12));
    if (ketosisTime.isBefore(DateTime.now())) return;
    final l10n = await AppLocalizations.delegate.load(Locale(locale));

    await _plugin.zonedSchedule(
      3,
      l10n.ketosisTitle,
      l10n.ketosisBody,
      tz.TZDateTime.from(ketosisTime, tz.local),
      NotificationDetails(
        android: _androidDetails('milestones', 'Fasting Milestones'),
        iOS: _iosDetails,
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future<void> scheduleWaterReminders(String locale) async {
    // Cancel existing, schedule every 90 min during 8am–9pm
    await _plugin.cancel(10);
    final l10n = await AppLocalizations.delegate.load(Locale(locale));
    for (int i = 0; i < 9; i++) {
      final now = DateTime.now();
      var remind = DateTime(now.year, now.month, now.day, 8)
          .add(Duration(minutes: 90 * i));
      if (remind.isBefore(now)) remind = remind.add(const Duration(days: 1));
      await _plugin.zonedSchedule(
        10 + i,
        l10n.waterReminderTitle,
        l10n.waterReminderBody,
        tz.TZDateTime.from(remind, tz.local),
        NotificationDetails(
          android: _androidDetails('water', 'Water Reminders'),
          iOS: _iosDetails,
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    }
  }

  static Future<void> showFastStarted(String locale, DateTime endTime) async {
    final diff = endTime.difference(DateTime.now());
    final hours = diff.inHours;
    final minutes = diff.inMinutes.remainder(60);
    final l10n = await AppLocalizations.delegate.load(Locale(locale));

    await _plugin.show(
      0,
      l10n.fastingActiveTitle,
      l10n.fastingActiveBody(hours, minutes),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'fast_active',
          'Active Fast',
          importance: Importance.low,
          priority: Priority.low,
          ongoing: true,
          showWhen: true,
          when: endTime.millisecondsSinceEpoch,
          usesChronometer: true,
          chronometerCountDown: true,
          autoCancel: false,
          enableVibration: false,
        ),
        iOS: _iosDetails,
      ),
    );
  }

  static Future<void> updateOngoingNotification(
      String locale, DateTime endTime, bool is24h) async {
    if (endTime.isBefore(DateTime.now())) {
      await _plugin.cancel(0);
      return;
    }

    final diff = endTime.difference(DateTime.now());
    final hours = diff.inHours;
    final minutes = diff.inMinutes.remainder(60);
    final l10n = await AppLocalizations.delegate.load(Locale(locale));

    // Format end time display
    final now = DateTime.now();
    final isToday = endTime.day == now.day &&
        endTime.month == now.month &&
        endTime.year == now.year;

    String timeStr;
    if (is24h) {
      timeStr =
          '${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}';
    } else {
      final hour = endTime.hour > 12
          ? endTime.hour - 12
          : endTime.hour == 0
              ? 12
              : endTime.hour;
      final period = endTime.hour >= 12 ? 'PM' : 'AM';
      timeStr = '$hour:${endTime.minute.toString().padLeft(2, '0')} $period';
    }

    final endText = isToday
        ? 'Fasting ends today at $timeStr'
        : 'Fasting ends tomorrow at $timeStr';

    await _plugin.show(
      0,
      endText,
      l10n.fastingActiveBody(hours, minutes),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'fast_active',
          'Active Fast',
          importance: Importance.low,
          priority: Priority.low,
          ongoing: true,
          showWhen: true,
          when: endTime.millisecondsSinceEpoch,
          usesChronometer: true,
          chronometerCountDown: true,
          autoCancel: false,
          enableVibration: false,
          silent: true,
        ),
        iOS: _iosDetails,
      ),
    );
  }

  static Future<void> cancelOngoing() async {
    await _plugin.cancel(0);
  }

  static Future<void> cancelAll() async => _plugin.cancelAll();
}
