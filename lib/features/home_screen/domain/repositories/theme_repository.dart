import '../entities/theme_entity.dart';

abstract class ThemeRepository {
  /// Load the persisted theme from storage.
  Future<ThemeEntity> getTheme();

  /// Persist the theme to storage.
  Future<void> saveTheme(ThemeEntity theme);
}
