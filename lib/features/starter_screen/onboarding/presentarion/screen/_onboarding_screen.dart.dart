import 'package:aqem/core/theme/App_Color.dart';
import 'package:aqem/features/QuranLearning/Quranpage.dart';
import 'package:aqem/features/home_screen/presentation/view.dart';
import 'package:aqem/features/starter_screen/onboarding/presentarion/widget/_onboarding_section.dart.dart';
import 'package:aqem/features/starter_screen/onboarding/presentarion/widget/button.dart';
import 'package:aqem/features/starter_screen/onboarding/presentarion/widget/circle_widget.dart';
import 'package:aqem/features/starter_screen/onboarding/presentarion/widget/indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingModel {
  final String title;
  final String desc;
  final String image;
  final Color color;

  const OnboardingModel({
    required this.title,
    required this.desc,
    required this.image,
    required this.color,
  });
}

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  int index = 0;

  final List<OnboardingModel> sections = const [
    OnboardingModel(
      title: "القرآن الكريم",
      desc:
          "اقرأ القرآن الكريم بخط واضح وتصميم جميل مع\nإمكانية الاستماع للتلاوات",
      image: "assets/icons/book.png",
      color: AppColors.primary,
    ),
    OnboardingModel(
      title: "مواقيت الصلاة",
      desc: "تنبيهات دقيقة لمواقيت الصلاة حسب موقعك مع\nصوت الأذان",
      image: "assets/icons/clock.png",
      color: AppColors.gold,
    ),
    OnboardingModel(
      title: "رفيقك الروحاني",
      desc: "تذكيرات يومية، أذكار، تسبيح، وكل ما تحتاجه في\nرحلتك الإيمانية",
      image: "assets/icons/heart.png",
      color: AppColors.primary,
    ),
  ];

  void nextSection() async {
    if (index < sections.length - 1) {
      setState(() {
        index++;
      });
    } else {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isFirstTime', true);

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final current = sections[index];

    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: const Alignment(1.9, -1.2),
            child: CircleWidget(
              size: 200.w,
              color: current.color,
              opacity: 0.10,
            ),
          ),
          Align(
            alignment: const Alignment(0, -0.2),
            child: CircleWidget(
              size: 280.w,
              color: current.color,
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
                const Expanded(flex: 2, child: SizedBox()),

                OnboardingSection(
                  title: current.title,
                  description: current.desc,
                  image: current.image,
                  color: current.color,
                ),

                SizedBox(height: 30.h),

                Indicator(index: index, activeColor: current.color),

                const Expanded(flex: 3, child: SizedBox()),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Button(
                      text: index == sections.length - 1
                          ? "ابدأ الآن"
                          : "< التالي",
                      color: current.color,
                      onTap: nextSection,
                    ),
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

