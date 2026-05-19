import 'package:aqem/features/home_screen/presentation/view.dart';
import 'package:flutter/material.dart';
import 'package:aqem/core/theme/dynamic_color.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  print("API Key exists: ${dotenv.env['GOOGLE_API_KEY'] != null}");
  print("API Key first 10 chars: ${dotenv.env['GOOGLE_API_KEY']?.substring(0, 10)}");
  TimeThemeManager.init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    ProviderScope(
      child: Directionality(textDirection: TextDirection.rtl, child: MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: TimeThemeManager.currentColorNotifier,
      builder: (context, dynamicColor, child) {
        final schemes = TimeThemeManager.getSchemes(dynamicColor);
        final light = schemes[0];
        final dark = schemes[1];
        final currentMode =
            ThemeMode.light; // TimeThemeManager.getCurrentThemeMode();
        return MaterialApp(
          title: 'Aqem',
          theme: ThemeData(
            colorScheme: light,
            iconButtonTheme: IconButtonThemeData(
              style: ButtonStyle(
                iconSize: WidgetStateProperty.all(20),
                iconColor: WidgetStateProperty.all(Colors.white),
              ),
            ),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            colorScheme: dark,
            iconButtonTheme: IconButtonThemeData(
              style: ButtonStyle(
                iconSize: WidgetStateProperty.all(20),
                iconColor: WidgetStateProperty.all(Colors.white),
              ),
            ),
            progressIndicatorTheme: ProgressIndicatorThemeData(
              linearTrackColor: Colors.blue,
            ),
            useMaterial3: true,
          ),
          themeMode: currentMode,
          debugShowCheckedModeBanner: false,
          home: const FrontScreen(),
          locale: Locale('ar', 'EG'),
          supportedLocales: [Locale('ar', 'EG'), Locale('en', 'US')],
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        );
      },
    );
  }
}

class FrontScreen extends StatefulWidget {
  const FrontScreen({super.key});

  @override
  State<FrontScreen> createState() => _FrontScreenState();
}

class _FrontScreenState extends State<FrontScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(extendBodyBehindAppBar: true, body: HomeView());
  }
}
