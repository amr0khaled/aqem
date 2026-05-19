import 'package:aqem/features/azkar_screen/data/dua_data.dart';
import 'package:aqem/features/home_screen/presentation/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/providers/shared_prefs_provider.dart';
import 'core/theme/App_Color.dart';
import 'features/starter_screen/splash/presentation/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  TimeThemeManager.init();
  await initDuaData();

  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [sharedPrefsProvider.overrideWithValue(prefs)],
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: const AqemApp(),
      ),
    ),
  );
}

class AqemApp extends StatelessWidget {
  const AqemApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (_, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          home: const SplashScreen(),
        );
      },
    );
  }
}
<<<<<<< HEAD

=======
>>>>>>> basmala-modification
