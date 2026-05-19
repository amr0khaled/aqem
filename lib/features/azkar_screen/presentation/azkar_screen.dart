import 'package:aqem/core/widgets/special_icon.dart';
import 'package:aqem/features/azkar_screen/presentation/azkar_count_stage.dart';
import 'package:aqem/features/azkar_screen/presentation/azkar_inside_screen.dart';
import 'package:flutter/material.dart';

import '../data/dua_data.dart';

final categories = [
  _CategoryItem(
    title: 'أذكار الصباح',
    subtitle: '5 ذكر',
    color: const Color(0xFFFF9800),
    emoji: '🌅',
    onTap: () {},
    category: DuaCategory.sabah,
  ),
  _CategoryItem(
    title: 'أذكار المساء',
    subtitle: '3 ذكر',
    color: const Color(0xFF9C27B0),
    emoji: '🌙',
    onTap: () {},
    category: DuaCategory.masaa,
  ),
  _CategoryItem(
    title: 'أذكار النوم',
    subtitle: '3 ذكر',
    color: const Color(0xFF009688),
    emoji: '🛏️',
    onTap: () {},
    category: DuaCategory.nawm,
  ),
  _CategoryItem(
    title: 'أذكار بعد الصلاة',
    subtitle: '5 ذكر',
    color: const Color(0xFF4CAF50),
    emoji: '🕌',
    onTap: () {},
    category: DuaCategory.salah,
  ),
  _CategoryItem(
    title: 'أدعية يومية',
    subtitle: '3 ذكر',
    color: const Color(0xFFE91E63),
    emoji: '🤲',
    onTap: () {},
    category: DuaCategory.daily,
  ),
  _CategoryItem(
    title: 'آيات للحفظ',
    subtitle: '3 ذكر',
    color: const Color(0xFFFF9800),
    emoji: '📖',
    onTap: () {},
    category: DuaCategory.hefz,
  ),
];

class AzkarScreen extends StatefulWidget {
  const AzkarScreen({super.key});

  @override
  State<AzkarScreen> createState() => _AzkarScreenState();
}

class _AzkarScreenState extends State<AzkarScreen> {
  int viewIndex = 0;
  DuaCategory category = DuaCategory.sabah;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
          style: ButtonStyle(iconSize: WidgetStatePropertyAll(18)),
        ),
        title: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              "الأدعية والأذكار",
              style: TextStyle(color: Colors.white, fontSize: 24, height: 1.3),
            ),
            Text(
              "حصن المسلم اليومي",
              style: TextStyle(
                color: Colors.white,
                fontWeight: .w400,
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ],
        ),
        actions: [
          SpecialIcon(
            content: Text('🤲'),
            color: Colors.white.withValues(alpha: 0.2),
            shadowFlag: false,
            gradientFlag: false,
          ),
        ],
        actionsPadding: .symmetric(horizontal: 18),
        backgroundColor: Color(0xFF0D7E5E),
        toolbarHeight: 80,
      ),
      body: Stack(
        children: [
          AzkarCountStage(
            firstWidgetTitle: (viewIndex == 0) ? 'الفئات' : 'ذكر',
            firstWidgetNumber: viewIndex == 0
                ? categories.length
                : (viewIndex == 1
                      ? (category == DuaCategory.sabah
                            ? duaData
                                  .where(
                                    (duaRecord) =>
                                        duaRecord.category == DuaCategory.sabah,
                                  )
                                  .length
                            : (category == DuaCategory.masaa
                                  ? duaData
                                        .where(
                                          (duaRecord) =>
                                              duaRecord.category ==
                                              DuaCategory.masaa,
                                        )
                                        .length
                                  : ((category == DuaCategory.hefz
                                        ? duaData
                                              .where(
                                                (duaRecord) =>
                                                    duaRecord.category ==
                                                    DuaCategory.hefz,
                                              )
                                              .length
                                        : (category == DuaCategory.nawm
                                              ? duaData
                                                    .where(
                                                      (duaRecord) =>
                                                          duaRecord.category ==
                                                          DuaCategory.nawm,
                                                    )
                                                    .length
                                              : (category == DuaCategory.daily
                                                    ? duaData
                                                          .where(
                                                            (duaRecord) =>
                                                                duaRecord
                                                                    .category ==
                                                                DuaCategory
                                                                    .daily,
                                                          )
                                                          .length
                                                    : (category ==
                                                              DuaCategory.salah
                                                          ? duaData
                                                                .where(
                                                                  (duaRecord) =>
                                                                      duaRecord
                                                                          .category ==
                                                                      DuaCategory
                                                                          .salah,
                                                                )
                                                                .length
                                                          : 0)))))))
                      : 0),
            completedNumber: duaData
                .where((duaRecord) => duaRecord.isComplete)
                .length,
            favouriteNumber: duaData
                .where((duaRecord) => duaRecord.isFavourite)
                .length,
          ),
          viewIndex == 0
              ? _buildGrid()
              : AzkarInsideScreen(
                  category: category,
                  onUpdate: () {
                    setState(() {});
                  },
                  onBackPressed: () {
                    if (viewIndex == 1) {
                      setState(() {
                        viewIndex = 0;
                      });
                    }
                  },
                ),
        ],
      ),
    );
  }

  Widget _buildGrid() {
    return Padding(
      padding: const EdgeInsets.only(top: 124 - 16, left: 14, right: 14),
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
            ...categories.map((item) {
              item.onTap = () {
                setState(() {
                  viewIndex = 1;
                  category = item.category;
                });
              };
              return item;
            }),
            // categories[0], // Sabah
            // categories[1], // Masaa
            // categories[2], // Nawm
            // categories[3], // Salah
            // categories[4], // Yawmiyya
            // categories[5], // Ayat
          ];
          return _buildCategoryCard(reordered[index]);
        },
      ),
    );
  }

  Widget _buildCategoryCard(_CategoryItem item) {
    return Container(
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
      child: Material(
        color: item.color,
        borderRadius: .circular(16),
        child: InkWell(
          onTap: () {
            item.onTap();
          },
          borderRadius: .circular(16),
          child: Stack(
            children: [
              Positioned(
                left: 10,
                top: 0,
                bottom: 0,
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white.withOpacity(0.7),
                  size: 16,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(
                  top: 16,
                  bottom: 16,
                  right: 15,
                  left: 35,
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
      ),
    );
  }
}

class _CategoryItem {
  final String title;
  final String subtitle;
  final Color color;
  final String emoji;
  final DuaCategory category;
  Function onTap;

  _CategoryItem({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.emoji,
    required this.onTap,
    required this.category,
  });
}
