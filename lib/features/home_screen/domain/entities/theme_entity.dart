import 'package:flutter/material.dart';

enum AppThemeMode { light, dark, system }

class ThemeEntity {
  final AppThemeMode mode;

  const ThemeEntity({required this.mode});

  ThemeMode get flutterThemeMode {
    switch (mode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }

  ThemeEntity copyWith({AppThemeMode? mode}) {
    return ThemeEntity(mode: mode ?? this.mode);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ThemeEntity && other.mode == mode;

  @override
  int get hashCode => mode.hashCode;
}
