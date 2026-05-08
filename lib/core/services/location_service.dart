import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  final FlutterCompass compass;

  LocationService(this.compass);

  Future<bool> requestPermission() async {
    final permission = await Geolocator.requestPermission();

    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  Future<Position> getCurrentLocation() {
    return Geolocator.getCurrentPosition();
  }

  Stream<double> get compassStream =>
      FlutterCompass.events!.map((e) => e.heading ?? 0);
}