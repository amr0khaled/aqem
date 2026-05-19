import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/theme_entity.dart';

abstract class ThemeLocalDataSource {
  Future<AppThemeMode> getThemeMode();
  Future<void> saveThemeMode(AppThemeMode mode);
}

class ThemeLocalDataSourceImpl implements ThemeLocalDataSource {
  static const _key = 'app_theme_mode';

  final SharedPreferences _prefs;

  const ThemeLocalDataSourceImpl(this._prefs);

  @override
  Future<AppThemeMode> getThemeMode() async {
    final stored = _prefs.getString(_key);
    return AppThemeMode.values.firstWhere(
      (e) => e.name == stored,
      orElse: () => AppThemeMode.system,
    );
  }

  @override
  Future<void> saveThemeMode(AppThemeMode mode) async {
    await _prefs.setString(_key, mode.name);
  }
}
