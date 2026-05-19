import 'package:aqem/features/prayer_times_screen/domain/prayer.dart';

class PrayerTimesData {
  final List<Prayer> prayers;
  final String location;
  final String weekday;        // الثلاثاء
  final String gregorianDate;  // 21 أكتوبر 2025
  final String hijriDate;      // 28 ربيع الثاني 1447

  const PrayerTimesData({
    required this.prayers,
    required this.location,
    required this.weekday,
    required this.gregorianDate,
    required this.hijriDate,
  });
}