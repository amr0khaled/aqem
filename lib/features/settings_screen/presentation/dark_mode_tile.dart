import 'package:aqem/features/home_screen/domain/entities/theme_entity.dart';
import 'package:aqem/features/home_screen/presentation/providers/theme_providers.dart';
import 'package:aqem/features/settings_screen/presentation/settings_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DarkModeTile extends ConsumerStatefulWidget {
  const DarkModeTile({super.key});

  @override
  ConsumerState<DarkModeTile> createState() => _DarkModeTileState();
}

class _DarkModeTileState extends ConsumerState<DarkModeTile> {
  bool _darkMode = false;
  void _changeThemeMode() {
    setState(() {
      _darkMode = !_darkMode;
      ref
          .read(themeNotifierProvider.notifier)
          .setTheme(_darkMode ? AppThemeMode.dark : AppThemeMode.light);
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeAsync = ref.watch(themeNotifierProvider);
    return themeAsync.when(
      error: (e, s) {
        WidgetsBinding.instance.addPostFrameCallback((t) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Error: $e", textDirection: TextDirection.ltr),
            ),
          );
        });
        return const SizedBox.shrink();
      },
      loading: () => const SizedBox.shrink(),
      data: (data) {
        return SettingsListTile(
          title: 'الوضع الليلي',
          subTitle: 'تبديل بين الوضع الفاتح والداكن',
          iconData: Icons.dark_mode_outlined,
          trailing: Transform.scale(
            scale: 43 / 59,
            child: Switch(
              padding: .zero, //todo***********************************
              value: _darkMode,
              inactiveThumbColor: Colors.white.withValues(alpha: 0.8),
              activeTrackColor: Theme.of(context).colorScheme.inversePrimary,
              trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
              onChanged: (_) {
                _changeThemeMode();
              },
            ),
          ),
          onTap: _changeThemeMode,
        );
      },
    );
  }
}
