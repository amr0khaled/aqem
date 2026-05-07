import 'package:aqem/features/home_screen/domain/prayer_time.dart';
import 'package:aqem/features/home_screen/presentation/prayer_type.dart';
import 'package:flutter/material.dart';

class NextPrayerTimeCard extends StatelessWidget {
  final PrayerTime prayer;

  const NextPrayerTimeCard({super.key, required this.prayer});

  @override
  Widget build(BuildContext context) {
    String emoji = typeToEmoji[prayer.type]!;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 1),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: const BoxDecoration(
              color: Color(0xFFFFF3E0),
              shape: BoxShape.circle,
            ),
            child: Text(emoji),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              prayer.name,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Text(
              prayer.time,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
