import 'dart:async';

import 'package:aqem/core/widgets/special_icon.dart';
import 'package:aqem/features/home_screen/domain/prayer_time.dart';
import 'package:aqem/features/home_screen/presentation/next_pray_small_card.dart';
import 'package:aqem/features/home_screen/domain/prayer_type.dart';
import 'package:flutter/material.dart';

class NextPray extends StatefulWidget {
  const NextPray({super.key});

  @override
  State<NextPray> createState() => _NextPrayState();
}

class _NextPrayState extends State<NextPray> {
  double value = 0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Durations.short1, (t) {
      if (value > 1.0) {
        setState(() => value = 0);
        return;
      }
      setState(() => value += 0.01);
    });
  }

  List<PrayerTime> prayers = [
    PrayerTime(type: PrayerType.asr, name: "العصر", time: "3:45"),
    PrayerTime(type: PrayerType.maghreb, name: "المغرب", time: "6:15"),
    PrayerTime(type: PrayerType.isha, name: "العشاء", time: "7:45"),
    PrayerTime(type: PrayerType.fajr, name: "الفجر", time: "5:15"),
    PrayerTime(type: PrayerType.sunrise, name: "الشروق", time: "6:45"),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(color: Colors.black),
      child: SizedBox.fromSize(
        size: Size.fromHeight(267),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 1st item (details)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SpecialIcon(
                        scale: 1.3,
                        borderRadius: 155,
                        gradientFlag: true,
                        gradient: LinearGradient(
                          colors: [Color(0xff0d7e5e), Color(0xff0a6349)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        content: Icon(
                          Icons.access_time_outlined,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "الصلاة القادمة",
                              style: TextStyle(fontSize: 12),
                            ),
                            const Text(
                              "صلاة الظهر",
                              style: TextStyle(fontSize: 24),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "12:30",
                        style: TextStyle(
                          fontSize: 30,
                          color: Color(0xff0D7E5E),
                        ),
                      ),
                      const Text(
                        "بعد ساعة و 15 دقيقة",
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              // 2nd item (progress)
              LinearProgressIndicator(
                backgroundColor: Color(0xffE8E6E1),
                color: Color(0xff0D7E5E),
                value: value,
                minHeight: 6,
              ),

              // 3rd item (next prayers)
              Column(
                children: [
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(5, (i) {
                        return NextPrayerTimeCard(prayer: prayers[i]);
                      }),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
