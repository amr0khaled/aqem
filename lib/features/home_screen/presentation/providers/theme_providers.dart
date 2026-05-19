import 'package:aqem/core/providers/shared_prefs_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/theme_local_datasource.dart';
import '../../data/repositories/theme_repository_impl.dart';
import '../../domain/entities/theme_entity.dart';
import '../../domain/repositories/theme_repository.dart';
import '../../domain/usecases/get_theme_usecase.dart';
import '../../domain/usecases/save_theme_usecase.dart';

// ─── Infrastructure ──────────────────────────────────────────────────────────

final themeLocalDataSourceProvider = Provider<ThemeLocalDataSource>((ref) {
  return ThemeLocalDataSourceImpl(ref.watch(sharedPrefsProvider));
});

final themeRepositoryProvider = Provider<ThemeRepository>((ref) {
  return ThemeRepositoryImpl(ref.watch(themeLocalDataSourceProvider));
});

// ─── Use Cases ────────────────────────────────────────────────────────────────

final getThemeUseCaseProvider = Provider<GetThemeUseCase>((ref) {
  return GetThemeUseCase(ref.watch(themeRepositoryProvider));
});

final saveThemeUseCaseProvider = Provider<SaveThemeUseCase>((ref) {
  return SaveThemeUseCase(ref.watch(themeRepositoryProvider));
});

// ─── State Notifier ───────────────────────────────────────────────────────────

class ThemeNotifier extends AsyncNotifier<ThemeEntity> {
  @override
  Future<ThemeEntity> build() async {
    return ref.read(getThemeUseCaseProvider).call();
  }

  Future<void> setTheme(AppThemeMode mode) async {
    final current = state.value ?? const ThemeEntity(mode: AppThemeMode.system);
    final updated = current.copyWith(mode: mode);

    state = AsyncData(updated);
    await ref.read(saveThemeUseCaseProvider).call(updated);
  }
}

final themeNotifierProvider = AsyncNotifierProvider<ThemeNotifier, ThemeEntity>(
  ThemeNotifier.new,
);
