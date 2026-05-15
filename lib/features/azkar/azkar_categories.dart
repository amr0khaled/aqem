import 'package:flutter/material.dart';

void main() {
  runApp(
    const Directionality(textDirection: TextDirection.rtl, child: AdkarApp()),
  );
}

class AdkarApp extends StatelessWidget {
  const AdkarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'الأدعية والأذكار',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Arial', useMaterial3: true),
      home: const AdkarScreen(),
    );
  }
}

class AdkarScreen extends StatelessWidget {
  const AdkarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(children: [Expanded(child: _buildGrid())]),
      ),
    );
  }

  Widget _buildGrid() {
    final categories = [
      _CategoryItem(
        title: 'أذكار الصباح',
        subtitle: '5 ذكر',
        color: const Color(0xFFFF9800),
        emoji: '🌅',
      ),
      _CategoryItem(
        title: 'أذكار المساء',
        subtitle: '3 ذكر',
        color: const Color(0xFF9C27B0),
        emoji: '🌙',
      ),
      _CategoryItem(
        title: 'أذكار النوم',
        subtitle: '3 ذكر',
        color: const Color(0xFF009688),
        emoji: '🛏️',
      ),
      _CategoryItem(
        title: 'أذكار بعد الصلاة',
        subtitle: '5 ذكر',
        color: const Color(0xFF4CAF50),
        emoji: '🕌',
      ),
      _CategoryItem(
        title: 'أدعية يومية',
        subtitle: '3 ذكر',
        color: const Color(0xFFE91E63),
        emoji: '🤲',
      ),
      _CategoryItem(
        title: 'آيات للحفظ',
        subtitle: '3 ذكر',
        color: const Color(0xFFFF9800),
        emoji: '📖',
      ),
    ];

    return Padding(
      padding: const EdgeInsets.all(14),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.25,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          // Reorder to match screenshot layout:
          // Row1: Sabah(right), Masaa(left)
          // Row2: Nawm(right), Salah(left)
          // Row3: Yawmiyya(right), Ayat(left)
          final reordered = [
            categories[0], // Sabah
            categories[1], // Masaa
            categories[2], // Nawm
            categories[3], // Salah
            categories[4], // Yawmiyya
            categories[5], // Ayat
          ];
          return _buildCategoryCard(reordered[index]);
        },
      ),
    );
  }

  Widget _buildCategoryCard(_CategoryItem item) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: item.color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: item.color.withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              left: 10,
              top: 0,
              bottom: 0,
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white.withOpacity(0.7),
                size: 16,
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 20,
                right: 15,
                left: 35,
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        item.emoji,
                        style: const TextStyle(fontSize: 28),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.subtitle,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.85),
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryItem {
  final String title;
  final String subtitle;
  final Color color;
  final String emoji;

  const _CategoryItem({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.emoji,
  });
}
