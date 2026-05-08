import 'package:flutter/material.dart';
import 'package:flutter_revision_1/features/onboarding/screen/_onboarding_screen.dart.dart';
import 'package:flutter_revision_1/features/splash/presentation/screens/splash_screen.dart';
import 'package:flutter_revision_1/features/qibla/presentation/screens/qibla_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_revision_1/core/theme/dynamic_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(
    const ProviderScope(
      child: AqmApp(),
    ),
  );
}

class AqmApp extends StatelessWidget {
  const AqmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          home: const SplashScreen(),
      
          routes: {
            '/onboarding': (_) => const OnboardingScreen(),
            '/qibla': (_) => const QiblaScreen(),
          },
        );
      },
    );
  }
}