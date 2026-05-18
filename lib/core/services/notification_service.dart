import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:aqem/features/tazkier_screen/domain/reminder.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    tz.initializeTimeZones();
    final tzName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(tzName));

    const settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      ),
    );
    await _plugin.initialize(settings);

    final android = _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    await android?.requestNotificationsPermission();
    await android?.requestExactAlarmsPermission();
  }

  static Future<void> schedule(Reminder reminder) async {
    if (!reminder.isEnabled) return;

    final now = tz.TZDateTime.now(tz.local);
    var when = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      reminder.hour,
      reminder.minute,
    );
    if (when.isBefore(now)) when = when.add(const Duration(days: 1));

    // Prefer exact alarms (fires precisely on time). Fall back to inexact if
    // the user hasn't granted the Alarms & Reminders permission (Android 12)
    // so the notification still fires rather than silently disappearing.
    // canScheduleExactNotifications() returns null on Android < 12, meaning
    // no special permission is required there — treat null the same as true.
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    final canExact = await android?.canScheduleExactNotifications();
    final scheduleMode = canExact == false
        ? AndroidScheduleMode.inexactAllowWhileIdle
        : AndroidScheduleMode.alarmClock;

    await _plugin.zonedSchedule(
      reminder.id.hashCode.abs(),
      reminder.title,
      reminder.message,
      when,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'reminders_channel',
          'التذكيرات',
          channelDescription: 'تذكيرات يومية للأذكار والصلوات',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: scheduleMode,
      matchDateTimeComponents:
          reminder.isDaily ? DateTimeComponents.time : null,
    );
  }

  static Future<void> cancel(String reminderId) async {
    await _plugin.cancel(reminderId.hashCode.abs());
  }
}