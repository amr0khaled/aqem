import 'package:flutter_revision_1/features/qibla/domain/repositories/qibla_repository.dart';


class GetQiblaDirection {
  final QiblaRepository repo;

  GetQiblaDirection(this.repo);

  Future<double> call({
    required double latitude,
    required double longitude,
  }) {
    return repo.getQiblaDirection(
      latitude: latitude,
      longitude: longitude,
    );
  }
}