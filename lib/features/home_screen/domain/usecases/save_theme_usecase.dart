import '../entities/theme_entity.dart';
import '../repositories/theme_repository.dart';

class SaveThemeUseCase {
  final ThemeRepository _repository;

  const SaveThemeUseCase(this._repository);

  Future<void> call(ThemeEntity theme) => _repository.saveTheme(theme);
}
