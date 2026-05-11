import 'package:flutter/material.dart';
import './collapsible_app_bar.dart';
import './reader_toolbar.dart';
import './language_dropdown.dart';

/// Main screen that demonstrates all the Quran Reader components working together.
///
/// Layout:
/// - CustomScrollView with CollapsibleAppBar (shrinks/expands on scroll)
/// - Sticky ReaderToolbar below the AppBar (language card, dropdown, zoom controls)
/// - Scrollable content area with sample text
class QuranReaderScreen extends StatefulWidget {
  const QuranReaderScreen({super.key});

  @override
  State<QuranReaderScreen> createState() => _QuranReaderScreenState();
}

class _QuranReaderScreenState extends State<QuranReaderScreen> {
  // ── Zoom state ──
  int _zoomValue = 20;

  // ── Language state ──

  String _selectedLanguageCode = 'ar';

  static const List<LanguageItem> _languages = [
    LanguageItem(code: 'ar', name: 'العربية'),
    LanguageItem(code: 'en', name: 'English'),
    LanguageItem(code: 'fr', name: 'Français'),
    LanguageItem(code: 'ur', name: 'اردو'),
    LanguageItem(code: 'ms', name: 'Bahasa Melayu'),
    LanguageItem(code: 'tr', name: 'Türkçe'),
  ];

  static const Map<String, String> _languageShortNames = {
    'ar': 'عربي',
    'en': 'EN',
    'fr': 'FR',
    'ur': 'اردو',
    'ms': 'MS',
    'tr': 'TR',
  };

  void _onZoomOut() {
    if (_zoomValue > 10) {
      setState(() => _zoomValue--);
    }
  }

  void _onZoomIn() {
    if (_zoomValue < 40) {
      setState(() => _zoomValue++);
    }
  }

  void _onLanguageChanged(String code) {
    setState(() => _selectedLanguageCode = code);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // ── Collapsible green AppBar ──
          CollapsibleAppBar(
            title: 'قارئ الكتب الصوتي',
            subtitle: 'قسم 7 - قرآن',
            expandedHeight: 200.0,
            onBookmarkPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Bookmark pressed')));
            },
            onSpeakerPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Speaker pressed')));
            },
          ),

          // ── Sticky toolbar (language card + dropdown + zoom) ──
          SliverPersistentHeader(
            pinned: true,
            delegate: _ToolbarPersistentHeader(
              toolbar: ReaderToolbar(
                currentLanguageShort:
                    _languageShortNames[_selectedLanguageCode] ?? 'عربي',
                languages: _languages,
                selectedLanguageCode: _selectedLanguageCode,
                onLanguageChanged: _onLanguageChanged,
                zoomValue: _zoomValue,
                onZoomOut: _onZoomOut,
                onZoomIn: _onZoomIn,
              ),
            ),
          ),

          // ── Scrollable content area ──
          SliverToBoxAdapter(child: _buildContent()),
        ],
      ),
    );
  }

  /// Build the main content area with sample Quran text.
  /// Text size scales with the zoom value.
  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Surah header
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              children: [
                Text(
                  'سورة الفاتحة',
                  style: TextStyle(
                    fontSize: _zoomValue.toDouble() + 8,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2E7D32),
                  ),
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(height: 4.0),
                Text(
                  'The Opening',
                  style: TextStyle(
                    fontSize: _zoomValue.toDouble() - 4,
                    color: const Color(0xFF757575),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),

          // Sample Quran verses – text size scales with zoom
          Text(
            'بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ',
            style: TextStyle(
              fontSize: _zoomValue.toDouble() + 4,
              height: 2.0,
              color: const Color(0xFF212121),
            ),
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 16.0),
          Text(
            'الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ',
            style: TextStyle(
              fontSize: _zoomValue.toDouble() + 4,
              height: 2.0,
              color: const Color(0xFF212121),
            ),
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 16.0),
          Text(
            'الرَّحْمَنِ الرَّحِيمِ',
            style: TextStyle(
              fontSize: _zoomValue.toDouble() + 4,
              height: 2.0,
              color: const Color(0xFF212121),
            ),
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 16.0),
          Text(
            'مَالِكِ يَوْمِ الدِّينِ',
            style: TextStyle(
              fontSize: _zoomValue.toDouble() + 4,
              height: 2.0,
              color: const Color(0xFF212121),
            ),
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 16.0),
          Text(
            'إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ',
            style: TextStyle(
              fontSize: _zoomValue.toDouble() + 4,
              height: 2.0,
              color: const Color(0xFF212121),
            ),
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 16.0),
          Text(
            'اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ',
            style: TextStyle(
              fontSize: _zoomValue.toDouble() + 4,
              height: 2.0,
              color: const Color(0xFF212121),
            ),
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 16.0),
          Text(
            'صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ',
            style: TextStyle(
              fontSize: _zoomValue.toDouble() + 4,
              height: 2.0,
              color: const Color(0xFF212121),
            ),
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 40.0),
        ],
      ),
    );
  }
}

/// Persistent header delegate that keeps the toolbar pinned below the AppBar.
class _ToolbarPersistentHeader extends SliverPersistentHeaderDelegate {
  final Widget toolbar;

  _ToolbarPersistentHeader({required this.toolbar});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return toolbar;
  }

  @override
  double get maxExtent => 52.0;

  @override
  double get minExtent => 52.0;

  @override
  bool shouldRebuild(covariant _ToolbarPersistentHeader oldDelegate) {
    return true; // Rebuild when zoom/language state changes
  }
}
