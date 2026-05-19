import '../../domain/entities/theme_entity.dart';
import '../../domain/repositories/theme_repository.dart';
import '../datasources/theme_local_datasource.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeLocalDataSource _dataSource;

  const ThemeRepositoryImpl(this._dataSource);

  @override
  Future<ThemeEntity> getTheme() async {
    final mode = await _dataSource.getThemeMode();
    return ThemeEntity(mode: mode);
  }

  @override
  Future<void> saveTheme(ThemeEntity theme) async {
    await _dataSource.saveThemeMode(theme.mode);
  }
}
