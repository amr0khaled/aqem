import 'dart:async';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

enum DayTimes { sunrise, noon, afternoon, sunset, evening, midnight }

class TimeThemeManager {
  // 1. Use ValueNotifier to broadcast color changes to the UI automatically
  static final ValueNotifier<Color> currentColorNotifier = ValueNotifier(
    _colors[DayTimes.midnight]!,
  );

  static late int _currentHour;

  static final Map<DayTimes, Color> _colors = {
    DayTimes.sunrise: Colors.yellow.shade100,
    DayTimes.noon: Colors.blue.shade900,
    DayTimes.afternoon: Color(0xFFFCECC9),
    DayTimes.sunset: Color(0xFFF7B801),
    DayTimes.evening: Color(0xFF0E070E),
    DayTimes.midnight: Color(0xFF09060E),
  };

  static final Map<int, DayTimes> _times = {
    6: DayTimes.sunrise,
    11: DayTimes.noon,
    15: DayTimes.afternoon,
    17: DayTimes.sunset,
    20: DayTimes.evening,
    23: DayTimes.midnight,
  };

  static void init() {
    _currentHour = DateTime.now().hour;

    Timer.periodic(const Duration(seconds: 1), (timer) {
      _currentHour = DateTime.now().hour;

      DayTimes currentDayTime = DayTimes.midnight;
      for (final hour in _times.keys) {
        if (_currentHour >= hour) {
          currentDayTime = _times[hour]!;
        } else {
          break;
        }
      }
      final newColor = _colors[currentDayTime]!;
      print(
        "Hour: $_currentHour, mode ${((_currentHour % 24) > 18 || (_currentHour % 24) < 6) ? Brightness.dark : Brightness.light}",
      );

      if (currentColorNotifier.value != newColor) {
        currentColorNotifier.value = newColor;
        print("Time changed! Hour: $_currentHour, Period: $currentDayTime");
      }
    });
  }

  // 2. Pass the dynamic color in as a parameter
  static List<ColorScheme> getSchemes(Color seedColor) {
    return [
      ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: Brightness.light,
      ).harmonized(),
      ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: Brightness.dark,
      ).harmonized(),
    ];
  }

  static ThemeMode getCurrentThemeMode() {
    int hour = _currentHour % 24;
    // Change theme from light to dark mode on sunset, evening and midnight
    if (hour >= 17 || hour < 6) {
      return ThemeMode.dark;
    }
    return ThemeMode.light;
  }
}
