import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tzdata;

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
    // Request Android 13+ notification permission
    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    _initialised = true;
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

  static Future<void> showFastComplete(int hours) async {
    await _plugin.show(
      1,
      'Fast Complete! 🎉',
      'Your ${hours}h fast is done. Amazing work.',
      NotificationDetails(
        android: _androidDetails('fast_complete', 'Fast Complete'),
        iOS: _iosDetails,
      ),
    );
  }

  static Future<void> scheduleHalfway(
      DateTime fastStart, int targetHours) async {
    final halfwayTime = fastStart.add(Duration(hours: targetHours ~/ 2));
    if (halfwayTime.isBefore(DateTime.now())) return;
    await _plugin.zonedSchedule(
      2,
      'Halfway There 🔥',
      'You are halfway through your fast. Keep going!',
      tz.TZDateTime.from(halfwayTime, tz.local),
      NotificationDetails(
        android: _androidDetails('milestones', 'Fasting Milestones'),
        iOS: _iosDetails,
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future<void> scheduleKetosis(DateTime fastStart) async {
    final ketosisTime = fastStart.add(const Duration(hours: 12));
    if (ketosisTime.isBefore(DateTime.now())) return;
    await _plugin.zonedSchedule(
      3,
      'Ketosis Reached 💫',
      'Your body has entered ketosis. Fat burning is in full effect.',
      tz.TZDateTime.from(ketosisTime, tz.local),
      NotificationDetails(
        android: _androidDetails('milestones', 'Fasting Milestones'),
        iOS: _iosDetails,
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future<void> scheduleWaterReminders() async {
    // Cancel existing, schedule every 90 min during 8am–9pm
    await _plugin.cancel(10);
    for (int i = 0; i < 9; i++) {
      final now = DateTime.now();
      var remind = DateTime(now.year, now.month, now.day, 8)
          .add(Duration(minutes: 90 * i));
      if (remind.isBefore(now)) remind = remind.add(const Duration(days: 1));
      await _plugin.zonedSchedule(
        10 + i,
        'Stay Hydrated 💧',
        'Time to drink a glass of water.',
        tz.TZDateTime.from(remind, tz.local),
        NotificationDetails(
          android: _androidDetails('water', 'Water Reminders'),
          iOS: _iosDetails,
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    }
  }

  static Future<void> cancelAll() async => _plugin.cancelAll();
}
