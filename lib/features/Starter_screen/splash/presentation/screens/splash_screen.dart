import 'dart:async';

import 'package:aqem/core/theme/App_Color.dart';
import 'package:aqem/features/starter_screen/onboarding/screen/_onboarding_screen.dart.dart';
import 'package:aqem/features/starter_screen/onboarding/widget/circle_widget.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _circles = const [
    Alignment(-0.8, -0.9),
    Alignment(0, 0.02),
    Alignment(0.8, 0.9),
  ];

  final _circleSizes = const [90.0, 215.0, 105.0];

  final _circleOpacities = const [0.15, 0.08, 0.15];

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const OnboardingScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
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

          for (var i = 0; i < _circles.length; i++)
            Align(
              alignment: _circles[i],
              child: CircleWidget(
                size: _circleSizes[i].w,
                opacity: _circleOpacities[i],
                color: AppColors.gold,
              ),
            ),

          Center(
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

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    3,
                    (i) => Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 4.w,
                      ),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StarBoxWidget extends StatelessWidget {
  const StarBoxWidget({super.key});

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
          const Positioned(
            top: cornerOffset,
            left: cornerOffset,
            child: CornerWidget(
              top: true,
              left: true,
              size: 10,
            ),
          ),
          const Positioned(
            top: cornerOffset,
            right: cornerOffset,
            child: CornerWidget(
              top: true,
              right: true,
              size: 10,
            ),
          ),
          const Positioned(
            bottom: cornerOffset,
            left: cornerOffset,
            child: CornerWidget(
              bottom: true,
              left: true,
              size: 10,
            ),
          ),
          const Positioned(
            bottom: cornerOffset,
            right: cornerOffset,
            child: CornerWidget(
              bottom: true,
              right: true,
              size: 10,
            ),
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