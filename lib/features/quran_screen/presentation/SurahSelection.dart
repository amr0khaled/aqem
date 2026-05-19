import 'package:aqem/features/quran_screen/data/provider.dart';
import 'package:aqem/features/quran_screen/domain/surah_response.dart';
import 'package:aqem/features/quran_screen/presentation/ayahs_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum SuraRevelation { all, makia, madinan }

class SurahSelection extends ConsumerStatefulWidget {
  int selectedButton = 1;

  SurahSelection({super.key});
  @override
  _SurahSelectionScreen createState() => _SurahSelectionScreen();
}

class _SurahSelectionScreen extends ConsumerState<SurahSelection> {
  int selectedButton = 1;

  final TextEditingController _searchController = TextEditingController();

  static const double kExpandedHeight = 180.0;
  static const double kCollapsedHeight = 100.0;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  SuraRevelation rev = SuraRevelation.all;

  @override
  Widget build(BuildContext context) {
    final surahsResponse = ref.watch(surahsProvider);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: _QuranAppBarDelegate(
              expandedHeight: kExpandedHeight,
              collapsedHeight: kCollapsedHeight,
              searchController: _searchController,
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox.fromSize(
                  size: Size.fromHeight(57),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          offset: const Offset(2, 2),
                        ),
                      ],
                      color: Theme.of(context).colorScheme.surfaceDim,
                    ),
                    child: Theme(
                      data: ThemeData(
                        elevatedButtonTheme: ElevatedButtonThemeData(
                          style: ButtonStyle(
                            padding: WidgetStatePropertyAll(
                              EdgeInsets.symmetric(horizontal: 12),
                            ),
                            backgroundColor: WidgetStateProperty.resolveWith((
                              w,
                            ) {
                              return w.contains(WidgetState.selected)
                                  ? Color.fromARGB(255, 13, 126, 94)
                                  : Theme.of(
                                      context,
                                    ).colorScheme.primaryContainer;
                            }),
                            foregroundColor: WidgetStateProperty.resolveWith((
                              w,
                            ) {
                              return w.contains(WidgetState.selected)
                                  ? Colors.white
                                  : Theme.of(
                                      context,
                                    ).colorScheme.onPrimaryContainer;
                            }),
                            minimumSize: WidgetStatePropertyAll(
                              const Size(100, 32),
                            ),
                            shape: WidgetStateProperty.resolveWith((w) {
                              Color color = w.contains(WidgetState.selected)
                                  ? Color.fromARGB(255, 13, 126, 94)
                                  : Theme.of(
                                      context,
                                    ).colorScheme.primaryContainer;
                              return RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                                side: BorderSide(color: color, width: .1),
                              );
                            }),
                            elevation: WidgetStatePropertyAll(1),
                          ),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(width: 20),
                          ElevatedButton(
                            statesController: WidgetStatesController(() {
                              if (selectedButton == 1) {
                                return {WidgetState.selected};
                              } else {
                                return null;
                              }
                            }()),
                            onPressed: () {
                              setState(() {
                                selectedButton = 1;
                                rev = SuraRevelation.all;
                              });
                            },
                            child: const Text(
                              ' الكل',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(width: 17),
                          ElevatedButton(
                            statesController: WidgetStatesController(() {
                              if (selectedButton == 2) {
                                return {WidgetState.selected};
                              } else {
                                return null;
                              }
                            }()),
                            onPressed: () {
                              setState(() {
                                selectedButton = 2;
                                rev = SuraRevelation.makia;
                              });
                            },
                            child: const Text(
                              'مكية     86',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(width: 17),
                          ElevatedButton(
                            statesController: WidgetStatesController(() {
                              if (selectedButton == 3) {
                                return {WidgetState.selected};
                              } else {
                                return null;
                              }
                            }()),
                            onPressed: () {
                              setState(() {
                                selectedButton = 3;
                                rev = SuraRevelation.madinan;
                              });
                            },
                            child: const Text(
                              'مدنية     28',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox.fromSize(
                  size: Size.fromHeight(145),
                  child: Container(
                    constraints: BoxConstraints.expand(height: 174),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildNumberBox(
                          icon: Icons.auto_stories_outlined,
                          text: "سورة",
                          number: "114",
                          teal: true,
                        ),
                        _buildNumberBox(
                          icon: Icons.star_border,
                          text: "اية",
                          number: "6236",
                          teal: false,
                        ),
                        _buildNumberBox(
                          icon: Icons.bookmark_border_outlined,
                          text: "صفحة",
                          number: "604",
                          teal: true,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          surahsResponse.when(
            data: (body) {
              final filtered = body.surahs
                  .where((e) {
                    switch (rev) {
                      case SuraRevelation.makia:
                        return e.revelationType != "Medinan";
                      case SuraRevelation.madinan:
                        return e.revelationType == "Medinan";
                      default:
                        return true;
                    }
                  })
                  .where((e) {
                    if (_searchController.text.isNotEmpty) {
                      return e.name.contains(_searchController.text);
                    }
                    return true;
                  })
                  .toList();
              return SliverList(
                delegate: SliverChildBuilderDelegate((context, i) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: _buildSurahOption(surah: filtered[i]),
                  );
                }, childCount: filtered.length),
              );
            },
            error: (err, stack) =>
                SliverFillRemaining(child: Center(child: Text('Error: $err'))),
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSurahOption({required SurahDetails surah}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        // padding: const EdgeInsets.symmetric(horizontal: 16, vertical:5),
        height: 90,
        width: 390,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: .5,
              offset: const Offset(.5, .5),
            ),
          ],
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          leading: Container(
            height: 20,
            width: 42,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: surah.revelationType != "Medinan"
                  ? Theme.of(context).colorScheme.secondaryContainer
                  : Theme.of(context).colorScheme.tertiaryContainer,
            ),
            child: surah.revelationType != "Medinan"
                ? Text(
                    "مكية",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  )
                : Text(
                    "مدنية",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onTertiaryContainer,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
          ),
          title: Text(
            surah.name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
              fontFamily: "Kitab",
            ),
          ),
          subtitle: Text(
            surah.englishName,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black87
                  : Colors.grey.shade300,
            ),
          ),
          trailing: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: Icon(
                  Icons.star,
                  color: surah.revelationType != "Medinan"
                      ? Theme.of(context).colorScheme.secondaryContainer
                      : Theme.of(context).colorScheme.tertiaryContainer,
                  size: 40,
                  semanticLabel: surah.number.toString(),
                ),
              ),
              Text(
                surah.number.toString(),
                style: TextStyle(
                  fontSize: 12,
                  color: surah.revelationType != "Medinan"
                      ? Theme.of(context).colorScheme.onSecondaryContainer
                      : Theme.of(context).colorScheme.onTertiaryContainer,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),

          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (c) => AyahsScreen(surah: surah)),
            );
          },
        ),
      ),
    );
  }

  Widget _buildNumberBox({
    required IconData icon,
    required String text,
    required String number,
    required bool teal,
  }) {
    Color foreground = teal
        ? Theme.of(context).colorScheme.onTertiaryContainer
        : Theme.of(context).colorScheme.onPrimaryContainer;
    Color background = teal
        ? Theme.of(context).colorScheme.tertiaryContainer
        : Theme.of(context).colorScheme.primaryContainer;
    List<Color> gradient = teal
        ? [
            Theme.of(context).colorScheme.tertiaryContainer,
            Theme.of(context).colorScheme.onTertiaryFixed,
          ]
        : [
            Theme.of(context).colorScheme.primaryContainer,
            Theme.of(context).colorScheme.onPrimaryFixed,
          ];
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: background, width: .1),
      ),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 22),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 2.5),
            child: Icon(icon, color: foreground, size: 20),
          ),
          SizedBox(height: 12),
          Text(
            number,
            style: TextStyle(fontSize: 18, color: foreground),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: teal
                  ? Theme.of(context).colorScheme.tertiary
                  : Theme.of(context).colorScheme.secondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _QuranAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final double collapsedHeight;
  final TextEditingController searchController;

  const _QuranAppBarDelegate({
    required this.expandedHeight,
    required this.collapsedHeight,
    required this.searchController,
  });

  @override
  double get minExtent => collapsedHeight;

  @override
  double get maxExtent => expandedHeight;

  @override
  bool shouldRebuild(covariant _QuranAppBarDelegate oldDelegate) => false;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    // 0.0 = fully expanded, 1.0 = fully collapsed
    final double progress = (shrinkOffset / (expandedHeight - collapsedHeight))
        .clamp(0.0, 1.0);

    return _QuranAppBarContent(
      progress: progress,
      searchController: searchController,
    );
  }
}

class _QuranAppBarContent extends StatelessWidget {
  final double progress;
  final TextEditingController searchController;

  static const Color kGreen = Color(0xFF2D7A5F);

  const _QuranAppBarContent({
    required this.progress,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    // Title fades out as we collapse
    final titleOpacity = (1.0 - progress * 2).clamp(0.0, 1.0);

    // Search bar moves up as we collapse
    final searchTopWhenExpanded = topPadding + 76.0;
    final searchTopWhenCollapsed = topPadding + 12.0;
    final searchTop =
        searchTopWhenExpanded -
        (searchTopWhenExpanded - searchTopWhenCollapsed) * progress;

    // Search bar widens slightly when collapsed (more horizontal padding removed)
    final searchHorizontalPadding = 16.0 - (4.0 * progress);

    return Container(
      color: kGreen,
      child: Stack(
        children: [
          // ── Title + subtitle (fades out) ──────────────────────────────
          if (titleOpacity > 0)
            Positioned(
              top: topPadding + 10,
              left: 0,
              right: 0, // leave room for nav arrow
              child: Opacity(
                opacity: titleOpacity,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'القرآن الكريم',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '114 سورة',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),

          // ── Forward arrow ──────────────────────────────────────────────
          if (titleOpacity > 0)
            Positioned(
              top: topPadding + 14,
              right: 16,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 22,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),

          // ── Search bar (slides up on collapse) ────────────────────────
          Positioned(
            top: searchTop,
            left: searchHorizontalPadding,
            right: searchHorizontalPadding,
            child: _SearchBar(controller: searchController),
          ),
        ],
      ),
    );
  }
}

// ─── Search Bar ────────────────────────────────────────────────────────────────

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;

  const _SearchBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.25), width: 1),
      ),
      child: TextField(
        controller: controller,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        style: const TextStyle(color: Colors.white, fontSize: 14),
        cursorColor: Colors.white,
        decoration: const InputDecoration(
          hintText: 'ابحث عن سورة...',
          hintStyle: TextStyle(color: Colors.white60, fontSize: 14),
          hintTextDirection: TextDirection.rtl,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          suffixIcon: Icon(Icons.search, color: Colors.white70, size: 20),
          suffixIconConstraints: BoxConstraints(minWidth: 44, minHeight: 44),
        ),
      ),
    );
  }
}
