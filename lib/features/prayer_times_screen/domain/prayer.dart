import 'package:flutter/material.dart';

class Prayer {
  final String arabicName;
  final int hour;     // 0–23
  final int minute;   // 0–59
  final IconData icon;
  final Color iconBg;
  /// false for Sunrise (informational only — no toggle, no "active" state)
  final bool isMainPrayer;

  const Prayer({
    required this.arabicName,
    required this.hour,
    required this.minute,
    required this.icon,
    required this.iconBg,
    this.isMainPrayer = true,
  });

  String get formattedTime {
    final h12 = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
    final m = minute.toString().padLeft(2, '0');
    return '$h12:$m';
  }

  int get inMinutes => hour * 60 + minute;
}