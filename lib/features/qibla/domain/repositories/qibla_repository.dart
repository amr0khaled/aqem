abstract class QiblaRepository {
  Future<double> getQiblaDirection({
    required double latitude,
    required double longitude,
  });
}