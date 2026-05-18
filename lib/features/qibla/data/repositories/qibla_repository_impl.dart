import '../datasources/qibla_remote_datasource.dart';
import '../../domain/repositories/qibla_repository.dart';

class QiblaRepositoryImpl implements QiblaRepository {
  final QiblaRemoteDataSource remote;

  QiblaRepositoryImpl(this.remote);

  @override
  Future<double> getQiblaDirection({
    required double latitude,
    required double longitude,
  }) {
    return remote.getQiblaDirection(
      latitude: latitude,
      longitude: longitude,
    );
  }
}