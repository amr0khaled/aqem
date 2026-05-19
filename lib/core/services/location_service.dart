
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Stream<double> get compassStream {
    final stream = FlutterCompass.events;
    if (stream == null) {
      return const Stream<double>.empty();
    }

    return stream.map((e) => e.heading ?? 0);
  }

  Future<bool> requestPermission() async {
    final permission = await Geolocator.requestPermission();

    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  Future<Position> getCurrentLocation() {
    return Geolocator.getCurrentPosition();
  }
}