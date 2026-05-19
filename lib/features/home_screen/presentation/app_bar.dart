import 'package:aqem/features/home_screen/domain/entities/theme_entity.dart';
import 'package:aqem/features/home_screen/presentation/providers/theme_providers.dart';
import 'package:aqem/features/settings_screen/presentation/settings_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeAppBar extends ConsumerStatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  ConsumerState<HomeAppBar> createState() => _HomeAppBar();
  @override
  Size get preferredSize => Size.fromHeight(90);
}

class _HomeAppBar extends ConsumerState<HomeAppBar> {
  bool _darkMode = false;
  @override
  Widget build(BuildContext context) {
    final themeAsync = ref.watch(themeNotifierProvider);

    final themeMode = themeAsync.maybeWhen(
      data: (t) => t.flutterThemeMode,
      orElse: () => ThemeMode.system,
    );

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(color: Colors.transparent),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultTextStyle.merge(
              style: TextStyle(color: Colors.white),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("المصحف الشريف", style: TextStyle(fontSize: 36)),
                  Text(
                    "السلام عليكم ورحمة الله",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _darkMode = !_darkMode;
                        ref
                            .read(themeNotifierProvider.notifier)
                            .setTheme(
                              _darkMode
                                  ? AppThemeMode.dark
                                  : AppThemeMode.light,
                            );
                      });
                    },
                    icon: Icon(Icons.mode_night_outlined),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SettingsCards(),
                        ),
                      );
                    },
                    icon: Icon(Icons.settings_outlined),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
