import '../entities/theme_entity.dart';
import '../repositories/theme_repository.dart';

class GetThemeUseCase {
  final ThemeRepository _repository;

  const GetThemeUseCase(this._repository);

  Future<ThemeEntity> call() => _repository.getTheme();
}
