import 'package:flutter/material.dart';

class SurahSelection extends StatefulWidget {
  int selectedButton = 1;
  @override
  _SurahSelectionScreen createState() => _SurahSelectionScreen();
}

class _SurahSelectionScreen extends State<SurahSelection> {
  int selectedButton = 1;

  final TextEditingController _searchController = TextEditingController();

  static const Color kGreen = Color(0xFF2D7A5F);
  static const double kExpandedHeight = 180.0;
  static const double kCollapsedHeight = 100.0;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color.fromARGB(255, 248, 247, 244),
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
                const SizedBox(height: 30),
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
                      color: Colors.white,
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
                                  : Color.fromARGB(255, 248, 247, 244);
                            }),
                            foregroundColor: WidgetStateProperty.resolveWith((
                              w,
                            ) {
                              return w.contains(WidgetState.selected)
                                  ? Colors.white
                                  : Color.fromARGB(255, 26, 26, 26);
                            }),
                            minimumSize: WidgetStatePropertyAll(
                              const Size(100, 32),
                            ),
                            shape: WidgetStateProperty.resolveWith((w) {
                              Color color = w.contains(WidgetState.selected)
                                  ? Color.fromARGB(255, 13, 126, 94)
                                  : Color.fromARGB(255, 248, 247, 244);
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

                // _buildSurahOption(
                //   arabName: 'الفاتحة',
                //   engName: 'Al-Fatihah · 7 آية',
                //   num: 1,
                //   makkiyah: true,
                // ),
                // const SizedBox(height: 16),
                // _buildSurahOption(
                //   arabName: 'البقرة',
                //   engName: 'Al-Baqarah · 286 آية',
                //   num: 2,
                //   makkiyah: false,
                // ),
                // const SizedBox(height: 30),
              ],
            ),
          ),

          // SliverList(
          //   delegate: SliverChildBuilderDelegate(
          //     (context, index) => _SurahTile(index: index + 1),
          //     childCount: 114,
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildSurahOption({
    required String arabName,
    required String engName,
    required int num,
    required bool makkiyah,
  }) {
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
          color: Colors.white,
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
            child: makkiyah
                ? Text(
                    "مكية",
                    style: TextStyle(
                      color: Color.fromARGB(255, 13, 126, 94),
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  )
                : Text(
                    "مدنية",
                    style: TextStyle(
                      color: Color.fromARGB(255, 212, 175, 55),
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: makkiyah
                  ? Color.fromARGB(50, 13, 126, 94)
                  : Color.fromARGB(50, 212, 175, 55),
            ),
          ),
          title: Text(
            arabName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
            ),
          ),
          subtitle: Text(
            engName,
            style: const TextStyle(fontSize: 12, color: Color(0xFF666666)),
          ),
          trailing: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                child: Icon(
                  Icons.star,
                  color: makkiyah
                      ? Color.fromARGB(50, 13, 126, 94)
                      : Color.fromARGB(50, 212, 175, 55),
                  size: 40,
                  semanticLabel: num.toString(),
                ),
              ),
              Text(
                num.toString(),
                style: TextStyle(
                  fontSize: 12,
                  color: makkiyah
                      ? Color.fromARGB(255, 13, 126, 94)
                      : Color.fromARGB(255, 212, 175, 55),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),

          onTap: () {},
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
        ? Color.fromARGB(255, 13, 126, 94)
        : Color.fromARGB(255, 212, 175, 55);
    Color background = teal
        ? Color.fromARGB(50, 13, 126, 94)
        : Color.fromARGB(255, 212, 175, 55);
    List<Color> gradient = teal
        ? [Color.fromARGB(40, 13, 126, 94), Color.fromARGB(40, 98, 179, 156)]
        : [Color.fromARGB(40, 212, 175, 55), Color.fromARGB(40, 244, 229, 194)];
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
              color: Color.fromARGB(255, 107, 107, 107),
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
              child: Opacity(
                opacity: titleOpacity,
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 22,
                ),
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
