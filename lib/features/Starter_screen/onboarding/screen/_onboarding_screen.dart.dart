import 'package:flutter/material.dart';
import 'package:flutter_revision_1/features/onboarding/widget/_onboarding_section.dart.dart';
import 'package:flutter_revision_1/features/onboarding/widget/button.dart';
import 'package:flutter_revision_1/features/onboarding/widget/circle_widget.dart';
import 'package:flutter_revision_1/features/onboarding/widget/indicator.dart';
import '../../../core/theme/dynamic_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_revision_1/features/qibla/presentation/screens/qibla_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int index = 0;

  final sections = [
    {
      'title': "القرآن الكريم",
      'desc':
          "اقرأ القرآن الكريم بخط واضح وتصميم جميل مع\nإمكانية الاستماع للتلاوات",
      'image': "assets/icons/book.png",
      'color': AppColors.primary,
    },
    {
      'title': "مواقيت الصلاة",
      'desc': "تنبيهات دقيقة لمواقيت الصلاة حسب موقعك مع\nصوت الأذان",
      'image': "assets/icons/clock.png",
      'color': AppColors.gold,
    },
    {
      'title': "رفيقك الروحاني",
      'desc': "تذكيرات يومية، أذكار، تسبيح، وكل ما تحتاجه في\nرحلتك الإيمانية",
      'image': "assets/icons/heart.png",
      'color': AppColors.primary,
    },
  ];

  void nextSection() {
    if (index < sections.length - 1) {
      setState(() => index++);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const QiblaScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final current = sections[index];

    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: const Alignment(1.9, -1.2),
            child: CircleWidget(
              size: 200.w,
              color: current['color'] as Color,
              opacity: 0.10,
            ),
          ),
          Align(
            alignment: const Alignment(0, -0.2),
            child: CircleWidget(
              size: 280.w,
              color: current['color'] as Color,
              opacity: 0.05,
            ),
          ),
          Align(
            alignment: const Alignment(-2.5, 1.3),
            child: CircleWidget(
              size: 250.w,
              color: AppColors.gold,
              opacity: 0.10,
            ),
          ),
          Padding(
  padding: EdgeInsets.all(20.w),
  child: Column(
    children: [
      Expanded(flex: 2, child: SizedBox()),
      OnboardingSection(
        title: current['title'] as String,
        description: current['desc'] as String,
        image: current['image'] as String,
        color: current['color'] as Color,
      ),
      SizedBox(height: 30.h),
      Indicator(index: index, activeColor: current['color'] as Color),
      Expanded(flex: 3, child: SizedBox()),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Button(
            text: index == sections.length - 1 ? "ابدأ الآن" : "< التالي",
            color: current['color'] as Color,
            onTap: nextSection,
          ),
          if (index != sections.length - 1)
            const Text(
              "تخطي",
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF9E9E9E),
              ),
            )
          else
            const SizedBox(),
        ],
      ),
      SizedBox(height: 20.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
