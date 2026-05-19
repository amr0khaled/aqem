import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const TasbihApp());
}

class TasbihApp extends StatelessWidget {
  const TasbihApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'المسبحة الإلكترونية',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Amiri',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2D7A52)),
        useMaterial3: true,
      ),
      home: const TasbihScreen(),
    );
  }
}

// ─── Data Model ──────────────────────────────────────────────────────────────

class DhikrItem {
  final String name;
  final int target;
  final String virtue;
  final String source;

  const DhikrItem({
    required this.name,
    required this.target,
    required this.virtue,
    required this.source,
  });
}

const List<DhikrItem> dhikrList = [
  DhikrItem(
    name: 'سبحان الله',
    target: 33,
    virtue:
        '"مَنْ قَالَ سُبْحَانَ اللهِ وَبِحَمْدِهِ فِي يَوْمٍ مِائَةَ مَرَّةٍ حُطَّتْ خَطَايَاهُ وَإِنْ كَانَتْ مِثْلَ زَبَدِ الْبَحْرِ"',
    source: 'رواه البخاري ومسلم',
  ),
  DhikrItem(
    name: 'الحمد لله',
    target: 33,
    virtue:
        '"الحمدُ للهِ تملأُ الميزانَ، وسبحانَ اللهِ والحمدُ للهِ تملآنِ أو تملأُ ما بين السماءِ والأرضِ"',
    source: 'رواه مسلم',
  ),
  DhikrItem(
    name: 'الله أكبر',
    target: 34,
    virtue:
        '"أَلَا أُخْبِرُكَ بِأَحَبِّ الْكَلَامِ إِلَى اللَّهِ؟ سُبْحَانَ اللَّهِ وَبِحَمْدِهِ"',
    source: 'رواه مسلم',
  ),
  DhikrItem(
    name: 'لا إله إلا الله',
    target: 100,
    virtue:
        '"مَنْ قَالَ لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ مِئَةَ مَرَّةٍ كَانَتْ لَهُ عَدْلَ عَشْرِ رِقَابٍ"',
    source: 'رواه البخاري ومسلم',
  ),
];

// ─── Main Screen ─────────────────────────────────────────────────────────────

class TasbihScreen extends StatefulWidget {
  const TasbihScreen({super.key});

  @override
  State<TasbihScreen> createState() => _TasbihScreenState();
}

class _TasbihScreenState extends State<TasbihScreen>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;
  final List<int> _counts = [0, 0, 0, 0];
  final List<int> _rounds = [0, 0, 0, 0];
  final List<int> _totals = [0, 0, 0, 0];

  late AnimationController _progressController;
  late AnimationController _bumpController;
  late AnimationController _pulseController;

  late Animation<double> _progressAnim;
  late Animation<double> _bumpAnim;
  late Animation<double> _pulseAnim;

  double _previousProgress = 0.0;

  // Colors
  static const Color greenDark = Color(0xFF1A5C3A);
  static const Color greenMain = Color(0xFF2D7A52);
  static const Color greenLight = Color(0xFF4A9E6E);
  static const Color greenPale = Color(0xFFE8F5EE);
  static const Color gold = Color(0xFFC9A84C);
  static const Color goldLight = Color(0xFFF5E6B8);
  static const Color bgColor = Color(0xFFF4F7F5);
  static const Color textDark = Color(0xFF1A2E22);
  static const Color textMid = Color(0xFF4A6355);
  static const Color textLight = Color(0xFF8AAA95);

  @override
  void initState() {
    super.initState();

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _bumpController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _progressAnim = Tween<double>(begin: 0, end: 0).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeInOut),
    );
    _bumpAnim = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.2), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 1),
    ]).animate(CurvedAnimation(parent: _bumpController, curve: Curves.easeOut));

    _pulseAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _progressController.dispose();
    _bumpController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  DhikrItem get current => dhikrList[_selectedIndex];
  int get count => _counts[_selectedIndex];
  int get rounds => _rounds[_selectedIndex];
  int get total => _totals[_selectedIndex];

  void _selectDhikr(int idx) {
    if (idx == _selectedIndex) return;
    setState(() {
      _selectedIndex = idx;
      _previousProgress = 0;
    });
    _animateProgress(0.0);
  }

  void _animateProgress(double target) {
    _progressAnim = Tween<double>(
      begin: _previousProgress,
      end: target,
    ).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeInOut),
    );
    _progressController.forward(from: 0);
    _previousProgress = target;
  }

  void _handleCount() {
    HapticFeedback.lightImpact();
    setState(() {
      _counts[_selectedIndex]++;
      _totals[_selectedIndex]++;

      if (_counts[_selectedIndex] >= current.target) {
        _rounds[_selectedIndex]++;
        _counts[_selectedIndex] = 0;
        HapticFeedback.heavyImpact();
        _pulseController.forward(from: 0);
        _animateProgress(0.0);
        _previousProgress = 0.0;
      } else {
        final progress = _counts[_selectedIndex] / current.target;
        _animateProgress(progress);
      }
    });
    _bumpController.forward(from: 0);
  }

  void _resetCurrent() {
    HapticFeedback.mediumImpact();
    setState(() {
      _counts[_selectedIndex] = 0;
      _rounds[_selectedIndex] = 0;
      _totals[_selectedIndex] = 0;
      _previousProgress = 0.0;
    });
    _animateProgress(0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildTabs(),
                  _buildCounterCard(),
                  _buildVirtueCard(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Header ────────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return SizedBox.fromSize(
      size: Size.fromHeight(120),
      child: Container(
        color: greenDark,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'المسبحة الإلكترونية',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Amiri',
              ),
            ),
            SizedBox(height: 4),
            Text(
              'سبّح واذكر الله في كل وقت',
              style: TextStyle(
                color: Color(0xBBFFFFFF),
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Tabs ──────────────────────────────────────────────────────────────────

  Widget _buildTabs() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 8),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 3.2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(dhikrList.length, (i) {
          final isActive = i == _selectedIndex;
          return GestureDetector(
            onTap: () => _selectDhikr(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: isActive ? Colors.white : const Color(0xFFF0F4F1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isActive ? greenMain : Colors.transparent,
                  width: 2,
                ),
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    dhikrList[i].name,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Amiri',
                      fontWeight: FontWeight.w600,
                      color: isActive ? greenDark : textMid,
                    ),
                  ),
                  if (isActive)
                    Container(
                      margin: const EdgeInsets.only(top: 3),
                      width: 5,
                      height: 5,
                      decoration: const BoxDecoration(
                        color: greenMain,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  // ── Counter Card ──────────────────────────────────────────────────────────

  Widget _buildCounterCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: greenMain.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
      child: Column(
        children: [
          // Dhikr name
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Text(
              current.name,
              key: ValueKey(_selectedIndex),
              style: const TextStyle(
                fontFamily: 'Amiri',
                fontSize: 30,
                fontStyle: FontStyle.italic,
                color: greenMain,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 28),

          // Circle progress
          _buildCircleProgress(),
          const SizedBox(height: 28),

          // Tasbih button
          _buildTasbihButton(),
          const SizedBox(height: 28),

          // Stats row
          _buildStatsRow(),
        ],
      ),
    );
  }

  Widget _buildCircleProgress() {
    return SizedBox(
      width: 180,
      height: 180,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Pulse ring on completion
          AnimatedBuilder(
            animation: _pulseAnim,
            builder: (context, _) {
              return Container(
                width: 180 + _pulseAnim.value * 30,
                height: 180 + _pulseAnim.value * 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: greenMain.withValues(alpha:
                        (1 - _pulseAnim.value).clamp(0, 1) * 0.4),
                    width: 3,
                  ),
                ),
              );
            },
          ),

          // SVG-style arc
          AnimatedBuilder(
            animation: _progressAnim,
            builder: (context, _) {
              return CustomPaint(
                size: const Size(180, 180),
                painter: CircleProgressPainter(
                  progress: _progressAnim.value,
                  bgColor: const Color(0xFFE8F0EB),
                  fgColor: greenMain,
                  strokeWidth: 10,
                ),
              );
            },
          ),

          // Inner content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _bumpAnim,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _bumpAnim.value,
                    child: child,
                  );
                },
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 100),
                  child: Text(
                    '$count',
                    key: ValueKey('$_selectedIndex-$count'),
                    style: const TextStyle(
                      fontSize: 52,
                      fontWeight: FontWeight.w700,
                      color: textDark,
                      height: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'من ${current.target}',
                style: const TextStyle(fontSize: 13, color: textLight),
              ),
              const SizedBox(height: 6),
              // Gold progress bar
              AnimatedBuilder(
                animation: _progressAnim,
                builder: (context, _) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: SizedBox(
                      width: 50,
                      height: 4,
                      child: LinearProgressIndicator(
                        value: _progressAnim.value,
                        backgroundColor: const Color(0xFFE8F0EB),
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(gold),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTasbihButton() {
    return GestureDetector(
      onTap: _handleCount,
      child: AnimatedBuilder(
        animation: _pulseController,
        builder: (context, child) => child!,
        child: Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: greenMain,
            boxShadow: [
              BoxShadow(
                color: greenMain.withValues(alpha:0.35),
                blurRadius: 24,
                offset: const Offset(0, 6),
              ),
              BoxShadow(
                color: greenMain.withValues(alpha:0.2),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Highlight
              Positioned(
                top: 18,
                left: 22,
                child: Container(
                  width: 50,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha:0.18),
                  ),
                ),
              ),
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'تسبيح',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontFamily: 'Amiri',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'اضغط للعد',
                    style: TextStyle(
                      color: Color(0xCCFFFFFF),
                      fontSize: 11,
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

  Widget _buildStatsRow() {
    return Column(
      children: [
        Divider(color: const Color(0xFFF0F4F1), thickness: 1),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Rounds
            _statItem('$rounds', 'الجولات'),

            // Reset button
            GestureDetector(
              onTap: _resetCurrent,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFD0DDD5), width: 1.5),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Row(
                  children: const [
                    Icon(Icons.refresh, size: 16, color: textMid),
                    SizedBox(width: 4),
                    Text('إعادة تعيين',
                        style: TextStyle(fontSize: 13, color: textMid)),
                  ],
                ),
              ),
            ),

            // Total
            _statItem('$total', 'الإجمالي اليوم'),
          ],
        ),
      ],
    );
  }

  Widget _statItem(String value, String label) {
    return Column(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: Text(
            value,
            key: ValueKey(value),
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: textDark,
            ),
          ),
        ),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 11, color: textLight)),
      ],
    );
  }

  // ── Virtue Card ───────────────────────────────────────────────────────────

  Widget _buildVirtueCard() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 350),
      child: Container(
        key: ValueKey(_selectedIndex),
        margin: const EdgeInsets.fromLTRB(16, 4, 16, 4),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFDF8EC), Color(0xFFF8F0D6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: const Color(0xFFE8D9A0)),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: gold,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.star, color: Colors.white, size: 20),
            ),
            const SizedBox(height: 10),
            const Text(
              'فضل التسبيح',
              style: TextStyle(
                fontSize: 13,
                color: gold,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              current.virtue,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Amiri',
                fontSize: 17,
                color: Color(0xFF5C4A1A),
                height: 1.9,
              ),
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 10),
            Text(
              current.source,
              style: const TextStyle(fontSize: 12, color: Color(0xFF9A8040)),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Circle Progress Painter ──────────────────────────────────────────────────

class CircleProgressPainter extends CustomPainter {
  final double progress;
  final Color bgColor;
  final Color fgColor;
  final double strokeWidth;

  CircleProgressPainter({
    required this.progress,
    required this.bgColor,
    required this.fgColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Background arc
    final bgPaint = Paint()
      ..color = bgColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, bgPaint);

    // Foreground arc
    if (progress > 0) {
      final fgPaint = Paint()
        ..color = fgColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      final sweepAngle = 2 * math.pi * progress;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2,
        sweepAngle,
        false,
        fgPaint,
      );
    }
  }

  @override
  bool shouldRepaint(CircleProgressPainter old) =>
      old.progress != progress ||
      old.bgColor != bgColor ||
      old.fgColor != fgColor;
}
