
import 'dart:async';
import 'package:aqem/core/theme/App_Color.dart';
import 'package:aqem/features/QuranLearning/Quranpage.dart';
import 'package:aqem/features/starter_screen/onboarding/presentarion/screen/_onboarding_screen.dart.dart';
import 'package:aqem/features/starter_screen/onboarding/presentarion/widget/circle_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class CircleData {
  final Alignment alignment;
  final double size;
  final double opacity;

  const CircleData({
    required this.alignment,
    required this.size,
    required this.opacity,
  });
}

class _SplashScreenState extends State<SplashScreen> {
  final List<CircleData> _circles = const [
    CircleData(
      alignment: Alignment(-0.8, -0.9),
      size: 90,
      opacity: 0.15,
    ),
    CircleData(
      alignment: Alignment(0, 0.02),
      size: 215,
      opacity: 0.08,
    ),
    CircleData(
      alignment: Alignment(0.8, 0.9),
      size: 105,
      opacity: 0.15,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _navigateAfterSplash();
  }

  Future<void> _navigateAfterSplash() async {
    await Future.delayed(const Duration(seconds: 3));

    final prefs = await SharedPreferences.getInstance();    // Get saved local preferences

    final isFirstTime = prefs.getBool('isFirstTime') ?? true;    // Get saved local preferences

    if (!mounted) return;  // Prevent navigation if widget removed from tree

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => isFirstTime
            ? const OnboardingScreen()
            : const HomeScreen(),
      ),
    );
  }

  Widget _buildBackground() {
    return Positioned.fill(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0D7E5E),
              Color(0xFF0A6349),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }

  Widget _buildCircles() {
    return Stack(
      children: _circles.map((circle) {
        return Align(
          alignment: circle.alignment,
          child: CircleWidget(
            size: circle.size.w,
            opacity: circle.opacity,
            color: AppColors.gold,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildIndicators() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        3,
        (i) => Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          width: 6.w,
          height: 6.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.gold.withValues(
              alpha: i == 1 ? 1 : 0.4,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const StarBoxWidget(),

          SizedBox(height: 28.h),

          const Text(
            "مواقيت الصلاة",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 28,
              color: Colors.white,
            ),
          ),

          SizedBox(height: 14.h),

          const Text(
            "﴿إِنَّ الصَّلَاةَ كَانَتْ عَلَى الْمُؤْمِنِينَ كِتَابًا مَوْقُوتًا﴾",
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontFamily: 'Amiri',
              fontSize: 18,
              color: AppColors.gold,
              height: 1.8,
            ),
          ),

          SizedBox(height: 6.h),

          const Text(
            "سورة النساء - آية 103",
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white70,
            ),
          ),

          SizedBox(height: 36.h),

          _buildIndicators(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          _buildCircles(),
          _buildContent(),
        ],
      ),
    );
  }
}

class StarBoxWidget extends StatelessWidget {
  const StarBoxWidget({super.key});

  Widget _buildCorner({
    double? top,
    double? bottom,
    double? left,
    double? right,
    required bool isTop,
    required bool isBottom,
    required bool isLeft,
    required bool isRight,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: CornerWidget(
        top: isTop,
        bottom: isBottom,
        left: isLeft,
        right: isRight,
        size: 10,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const cornerOffset = 7.0;
    const mainSize = 70.0;
    const outerSize = 90.0;

    return SizedBox(
      width: outerSize.w,
      height: outerSize.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _buildCorner(
            top: cornerOffset,
            left: cornerOffset,
            isTop: true,
            isBottom: false,
            isLeft: true,
            isRight: false,
          ),

          _buildCorner(
            top: cornerOffset,
            right: cornerOffset,
            isTop: true,
            isBottom: false,
            isLeft: false,
            isRight: true,
          ),

          _buildCorner(
            bottom: cornerOffset,
            left: cornerOffset,
            isTop: false,
            isBottom: true,
            isLeft: true,
            isRight: false,
          ),

          _buildCorner(
            bottom: cornerOffset,
            right: cornerOffset,
            isTop: false,
            isBottom: true,
            isLeft: false,
            isRight: true,
          ),

          Container(
            width: mainSize.w,
            height: mainSize.w,
            decoration: BoxDecoration(
              color: const Color(0x26FFFFFF),
              borderRadius: BorderRadius.circular(20.w),
              border: Border.all(
                color: AppColors.gold,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.gold.withValues(alpha: 0.24),
                  blurRadius: 20.w,
                  spreadRadius: 22.w,
                ),
              ],
            ),
            child: const Center(
              child: Icon(
                Icons.star,
                color: AppColors.gold,
                size: 45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CornerWidget extends StatelessWidget {
  final bool top;
  final bool bottom;
  final bool left;
  final bool right;
  final double size;
  final double borderWidth;
  final Color color;

  const CornerWidget({
    super.key,
    this.top = false,
    this.bottom = false,
    this.left = false,
    this.right = false,
    this.size = 16,
    this.borderWidth = 2,
    this.color = AppColors.gold,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.w,
      height: size.w,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            top: top
                ? BorderSide(
                    color: color,
                    width: borderWidth.w,
                  )
                : BorderSide.none,
            bottom: bottom
                ? BorderSide(
                    color: color,
                    width: borderWidth.w,
                  )
                : BorderSide.none,
            left: left
                ? BorderSide(
                    color: color,
                    width: borderWidth.w,
                  )
                : BorderSide.none,
            right: right
                ? BorderSide(
                    color: color,
                    width: borderWidth.w,
                  )
                : BorderSide.none,
          ),
        ),
      ),
    );
  }
}