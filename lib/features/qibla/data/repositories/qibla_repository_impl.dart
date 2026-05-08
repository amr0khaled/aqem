import 'package:flutter_revision_1/features/qibla/data/datasources/qibla_remote_datasource.dart';
import 'package:flutter_revision_1/features/qibla/domain/repositories/qibla_repository.dart';

class QiblaRepositoryImpl implements QiblaRepository {
  final QiblaRemoteDataSource remote;

  QiblaRepositoryImpl(this.remote);

  @override
  Future<double> getQiblaDirection({
    required double latitude,
    required double longitude,
  }) async {
    return await remote.getQiblaDirection(
      latitude: latitude,
      longitude: longitude,
    );
  }
}