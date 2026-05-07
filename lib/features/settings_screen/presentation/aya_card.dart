import 'package:flutter/material.dart';

const List<Map<String, String>> verses = [
  {'text': 'وَقُل رَّبِّ زِدْنِي عِلْمًا', 'surah': 'سورة طه', 'ayah': '114'},
  {'text': 'إِنَّ مَعَ الْعُسْرِ يُسْرًا', 'surah': 'سورة الشرح', 'ayah': '6'},
  {
    'text': 'وَتَوَكَّلْ عَلَى اللَّهِ وَكَفَىٰ بِاللَّهِ وَكِيلًا',
    'surah': 'سورة الأحزاب',
    'ayah': '3',
  },
  {
    'text': 'إِنَّ اللَّهَ مَعَ الصَّابِرِينَ',
    'surah': 'سورة البقرة',
    'ayah': '153',
  },
  {
    'text': 'وَمَن يَتَوَكَّلْ عَلَى اللَّهِ فَهُوَ حَسْبُهُ',
    'surah': 'سورة الطلاق',
    'ayah': '3',
  },
  {
    'text': 'فَإِنَّ مَعَ الْعُسْرِ يُسْرًا',
    'surah': 'سورة الشرح',
    'ayah': '5',
  },
  {
    'text': 'رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً وَفِي الْآخِرَةِ حَسَنَةً',
    'surah': 'سورة البقرة',
    'ayah': '201',
  },
];

Map<String, String> get todayVerse {
  final dayIndex =
      DateTime.now().difference(DateTime(2026, 1, 1)).inDays % verses.length;
  return verses[dayIndex];
}

const cardBg = Color(0xFFF6EDD2);
const starGold = Color(0xFFE4C113);
const textGreen = Color(0xFF3A6B4A);
const dividerGold = Color(0xFFB8960C);
const verseColor = Color(0xFF1A1A1A);
const refColor = Color(0xFF666666);

class AyahCard extends StatelessWidget {
  final Map<String, String> verse;

  const AyahCard({super.key, required this.verse});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 290,
      child: Container(
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: starGold, width: 2),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Stack(
            children: [
              Positioned(top: 0, right: 0, child: _hollowCircle(100)),

              Positioned(bottom: 0, left: 0, child: _hollowCircle(80)),

              Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 28,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: starGold,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.star_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      const SizedBox(height: 10),

                      const Text(
                        'آية اليوم',
                        style: TextStyle(
                          color: refColor,
                          fontSize: 14,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      const SizedBox(height: 20),

                      Container(height: 1, width: 80, color: dividerGold),
                      const SizedBox(height: 13),

                      Text(
                        '﴿ ${verse['text']} ﴾',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          height: 1.9,
                          color: verseColor,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(height: 1, width: 80, color: dividerGold),
                      const SizedBox(height: 10),
                      Text(
                        '${verse['surah']} - آية ${verse['ayah']}',
                        style: const TextStyle(
                          color: refColor,
                          fontSize: 13,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _hollowCircle(double size) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: starGold.withOpacity(0.07), width: 6),
      color: Colors.transparent,
    ),
  );
}