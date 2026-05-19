import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationData {
  final String displayName;
  final String apiAddress;
  const LocationData({required this.displayName, required this.apiAddress});
}

class LocationService {
  static Future<LocationData> getCurrent() async {
    print('LOC: start');

    final enabled = await Geolocator.isLocationServiceEnabled();
    print('LOC: services enabled = $enabled');
    if (!enabled) {
      throw const LocationException('خدمة الموقع غير مفعّلة على الجهاز.');
    }

    var perm = await Geolocator.checkPermission();
    print('LOC: permission = $perm');
    if (perm == LocationPermission.denied) {
      perm = await Geolocator.requestPermission();
      print('LOC: permission after request = $perm');
    }
    if (perm == LocationPermission.denied) {
      throw const LocationException('تم رفض إذن الموقع.');
    }
    if (perm == LocationPermission.deniedForever) {
      throw const LocationException(
        'إذن الموقع مرفوض دائمًا. الرجاء تفعيله من إعدادات التطبيق.',
      );
    }

    // Last known position is instant — use it if available.
    Position? position = await Geolocator.getLastKnownPosition();
    print('LOC: last known = $position');

    // Otherwise, fetch fresh — but with a hard 15-second timeout so we
    // can't hang forever waiting for a GPS lock indoors.
    if (position == null) {
      print('LOC: requesting fresh position (15s timeout)');
      try {
        position = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.medium,
            timeLimit: Duration(seconds: 15),
          ),
        );
        print('LOC: fresh position = $position');
      } catch (e) {
        print('LOC: getCurrentPosition failed: $e');
        throw LocationException(
          'تعذّر تحديد الموقع. تأكد من تفعيل GPS والمحاولة مرة أخرى.',
        );
      }
    }

    print('LOC: reverse geocoding ${position.latitude}, ${position.longitude}');

    String apiAddress;
    String displayName;

    await setLocaleIdentifier('en');
    final en = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    print('LOC: english placemarks = ${en.length}');
    if (en.isEmpty) {
      throw const LocationException('تعذّر تحديد الموقع.');
    }
    final enPlace = en.first;
    final enCity = (enPlace.locality?.isNotEmpty ?? false)
        ? enPlace.locality!
        : (enPlace.administrativeArea ?? '');
    apiAddress = '$enCity,${enPlace.country ?? ''}';
    print('LOC: api address = $apiAddress');

    try {
      await setLocaleIdentifier('ar');
      final ar = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (ar.isNotEmpty) {
        final arPlace = ar.first;
        final arCity = (arPlace.locality?.isNotEmpty ?? false)
            ? arPlace.locality!
            : (arPlace.administrativeArea ?? '');
        displayName = '$arCity، ${arPlace.country ?? ''}';
      } else {
        displayName = apiAddress;
      }
    } catch (e) {
      print('LOC: arabic geocoding failed: $e');
      displayName = apiAddress;
    }

    print('LOC: done. display = $displayName, api = $apiAddress');
    return LocationData(displayName: displayName, apiAddress: apiAddress);
  }
}

class LocationException implements Exception {
  final String message;
  const LocationException(this.message);

  @override
  String toString() => message;
}