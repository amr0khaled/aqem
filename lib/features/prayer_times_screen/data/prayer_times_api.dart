import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:aqem/features/prayer_times_screen/domain/prayer.dart';
import 'package:aqem/features/prayer_times_screen/domain/prayer_times_data.dart';

class PrayerTimesApi {
  static const _baseUrl = 'https://islamy-backend.vercel.app';

  /// Fetches today's prayer times for the given address.
  /// Address example: "Alexandria,Egypt"
  Future<PrayerTimesData> fetchToday({required String address}) async {
    final uri = Uri.parse('$_baseUrl/api/pray-times').replace(
      queryParameters: {'address': address},
    );

    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw Exception(
        'Failed to load prayer times (HTTP ${response.statusCode})',
      );
    }

    final body = jsonDecode(response.body) as Map<String, dynamic>;
    return _parse(body, address);
  }

  PrayerTimesData _parse(Map<String, dynamic> body, String address) {
    final timings = body['timings'] as Map<String, dynamic>;
    final date = body['date'] as Map<String, dynamic>;
    final hijri = date['hijri'] as Map<String, dynamic>;
    final gregorian = date['gregorian'] as Map<String, dynamic>;

    // Build the 6 prayer cards in display order.
    // We assign icons and colors here because they're visual choices,
    // not API data. Sunrise is marked non-main so it has no toggle.
    final prayers = [
      _prayer('الفجر',   timings['Fajr']    as String, Icons.wb_twilight,      const Color(0xFFF7C9AC)),
      _prayer('الشروق',  timings['Sunrise'] as String, Icons.wb_sunny,         const Color(0xFFFCEEC8), isMain: false),
      _prayer('الظهر',   timings['Dhuhr']   as String, Icons.wb_cloudy,        const Color(0xFFFCEEC8)),
      _prayer('العصر',   timings['Asr']     as String, Icons.wb_cloudy,        const Color(0xFFFCEEC8)),
      _prayer('المغرب',  timings['Maghrib'] as String, Icons.wb_twilight,      const Color(0xFFF6BFA0)),
      _prayer('العشاء',  timings['Isha']    as String, Icons.nightlight_round, const Color(0xFFE8E2D5)),
    ];

    // Hijri date — all already in Arabic in the API response.
    final hijriWeekday = (hijri['weekday'] as Map<String, dynamic>)['ar'] as String;
    final hijriDay = hijri['day'] as String;
    final hijriMonthAr = (hijri['month'] as Map<String, dynamic>)['ar'] as String;
    final hijriYear = hijri['year'] as String;

    // Gregorian — API gives only English month name. Translate to Arabic.
    final gregDay = gregorian['day'] as String;
    final gregMonthEn = (gregorian['month'] as Map<String, dynamic>)['en'] as String;
    final gregYear = gregorian['year'] as String;
    final gregMonthAr = _gregorianMonths[gregMonthEn] ?? gregMonthEn;

    return PrayerTimesData(
      prayers: prayers,
      location: address, // Phase 3 will replace this with a nice Arabic name
      weekday: hijriWeekday,
      gregorianDate: '$gregDay $gregMonthAr $gregYear',
      hijriDate: '$hijriDay $hijriMonthAr $hijriYear',
    );
  }

  /// Parses an API time string into a Prayer.
  /// The API returns formats like "05:15" or "05:15 (EET)" — we strip
  /// anything after the first space.
  Prayer _prayer(
    String arabicName,
    String rawTime,
    IconData icon,
    Color iconBg, {
    bool isMain = true,
  }) {
    final clean = rawTime.split(' ').first;
    final parts = clean.split(':');
    return Prayer(
      arabicName: arabicName,
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
      icon: icon,
      iconBg: iconBg,
      isMainPrayer: isMain,
    );
  }

  static const _gregorianMonths = {
    'January': 'يناير',
    'February': 'فبراير',
    'March': 'مارس',
    'April': 'أبريل',
    'May': 'مايو',
    'June': 'يونيو',
    'July': 'يوليو',
    'August': 'أغسطس',
    'September': 'سبتمبر',
    'October': 'أكتوبر',
    'November': 'نوفمبر',
    'December': 'ديسمبر',
  };
}