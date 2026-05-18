// import 'dart:async';

// import 'package:flutter_compass/flutter_compass.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:hooks_riverpod/legacy.dart';
// import 'package:http/http.dart' as http;

// import '../../data/datasources/qibla_remote_datasource.dart';
// import '../../data/repositories/qibla_repository_impl.dart';
// import '../../domain/usecases/get_qibla_direction.dart';

// final qiblaProvider = StateNotifierProvider<QiblaNotifier, QiblaState>((ref) {
//   final repo = QiblaRepositoryImpl(QiblaRemoteDataSource(http.Client()));

//   final useCase = GetQiblaDirection(repo);

//   return QiblaNotifier(useCase);
// });

// class QiblaState {
//   final double? qiblahDirection;
//   final double compassAngle;
//   final bool isLoading;
//   final String? error;
//   final String city;
//   final double distanceKm;

//   const QiblaState({
//     this.qiblahDirection,
//     this.compassAngle = 0,
//     this.isLoading = true,
//     this.error,
//     this.city = '',
//     this.distanceKm = 0,
//   });

//   QiblaState copyWith({
//     double? qiblahDirection,
//     double? compassAngle,
//     bool? isLoading,
//     String? error,
//     String? city,
//     double? distanceKm,
//   }) {
//     return QiblaState(
//       qiblahDirection: qiblahDirection ?? this.qiblahDirection,
//       compassAngle: compassAngle ?? this.compassAngle,
//       isLoading: isLoading ?? this.isLoading,
//       error: error ?? this.error,
//       city: city ?? this.city,
//       distanceKm: distanceKm ?? this.distanceKm,
//     );
//   }
// }

// class QiblaNotifier extends StateNotifier<QiblaState> {
//   final GetQiblaDirection getQiblaDirection;

//   StreamSubscription? _compassSub;

//   QiblaNotifier(this.getQiblaDirection) : super(const QiblaState()) {
//     _init();
//   }

//   Future<void> _init() async {
//     try {
//       final permission = await Geolocator.requestPermission();

//       if (permission == LocationPermission.denied ||
//           permission == LocationPermission.deniedForever) {
//         state = state.copyWith(
//           isLoading: false,
//           error: 'Location permission denied',
//         );
//         return;
//       }

//       final pos = await Geolocator.getCurrentPosition();

//       final dir = await getQiblaDirection(
//         latitude: pos.latitude,
//         longitude: pos.longitude,
//       );

//       final placemarks = await placemarkFromCoordinates(
//         pos.latitude,
//         pos.longitude,
//       );

//       final place = placemarks.first;

//       final cityName =
//           place.locality ??
//           place.subAdministrativeArea ??
//           place.administrativeArea ??
//           'Unknown location';

//       final distance =
//           Geolocator.distanceBetween(
//             pos.latitude,
//             pos.longitude,
//             21.4225,
//             39.8262,
//           ) /
//           1000;

//       state = state.copyWith(
//         qiblahDirection: dir,
//         isLoading: false,
//         city: cityName,
//         distanceKm: distance,
//       );

//       _compassSub = FlutterCompass.events?.listen((event) {
//         final heading = event.heading ?? 0;
//         state = state.copyWith(compassAngle: (heading + 360) % 360);
//       });
//     } catch (_) {
//       state = state.copyWith(isLoading: false, error: 'Failed to load Qibla');
//     }
//   }

//   @override
//   void dispose() {
//     _compassSub?.cancel();
//     super.dispose();
//   }
// }

import 'dart:async';
import 'dart:math';

import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'package:http/http.dart' as http;

import '../../data/datasources/qibla_remote_datasource.dart';
import '../../data/repositories/qibla_repository_impl.dart';
import '../../domain/usecases/get_qibla_direction.dart';

final qiblaProvider =
    StateNotifierProvider<QiblaNotifier, QiblaState>((ref) {
  final repo = QiblaRepositoryImpl(
    QiblaRemoteDataSource(http.Client()),
  );

  final useCase = GetQiblaDirection(repo);

  return QiblaNotifier(useCase);
});

class QiblaState {
  final double? qiblahDirection;
  final double compassAngle;
  final bool isLoading;
  final String? error;

  final String city;
  final double distanceKm;

  final double arrowRad;
  final double compassAngleRad;
  final double displayBearing;
  final bool isAligned;

  const QiblaState({
    this.qiblahDirection,
    this.compassAngle = 0,
    this.isLoading = true,
    this.error,
    this.city = '',
    this.distanceKm = 0,
    this.arrowRad = 0,
    this.compassAngleRad = 0,
    this.displayBearing = 0,
    this.isAligned = false,
  });

  QiblaState copyWith({
    double? qiblahDirection,
    double? compassAngle,
    bool? isLoading,
    String? error,
    String? city,
    double? distanceKm,
    double? arrowRad,
    double? compassAngleRad,
    double? displayBearing,
    bool? isAligned,
  }) {
    return QiblaState(
      qiblahDirection: qiblahDirection ?? this.qiblahDirection,
      compassAngle: compassAngle ?? this.compassAngle,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      city: city ?? this.city,
      distanceKm: distanceKm ?? this.distanceKm,
      arrowRad: arrowRad ?? this.arrowRad,
      compassAngleRad: compassAngleRad ?? this.compassAngleRad,
      displayBearing: displayBearing ?? this.displayBearing,
      isAligned: isAligned ?? this.isAligned,
    );
  }
}

class QiblaNotifier extends StateNotifier<QiblaState> {
  final GetQiblaDirection getQiblaDirection;
  StreamSubscription? _compassSub;

  QiblaNotifier(this.getQiblaDirection)
      : super(const QiblaState()) {
    _init();
  }

  double _normalize(double a) {
    var x = a % 360;
    if (x > 180) x -= 360;
    if (x < -180) x += 360;
    return x;
  }

  double _toRad(double d) => d * pi / 180;

  void _recalculate(double heading) {
    final qiblah = state.qiblahDirection ?? 0;

    final normalized = _normalize(qiblah - heading);

    state = state.copyWith(
      compassAngle: (heading + 360) % 360,
      displayBearing: (qiblah - heading + 360) % 360,
      compassAngleRad: _toRad(-heading),
      arrowRad: _toRad(normalized),
      isAligned: normalized.abs() < 2,
    );
  }

  Future<void> _init() async {
    try {
      final permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        state = state.copyWith(
          isLoading: false,
          error: 'Location permission denied',
        );
        return;
      }

      final pos = await Geolocator.getCurrentPosition();

      final dir = await getQiblaDirection(
        latitude: pos.latitude,
        longitude: pos.longitude,
      );

      final placemarks =
          await placemarkFromCoordinates(pos.latitude, pos.longitude);

      final place = placemarks.first;

      final city =
          place.locality ??
          place.subAdministrativeArea ??
          place.administrativeArea ??
          'Unknown';

      final distance = Geolocator.distanceBetween(
            pos.latitude,
            pos.longitude,
            21.4225,
            39.8262,
          ) /
          1000;

      state = state.copyWith(
        qiblahDirection: dir,
        city: city,
        distanceKm: distance,
        isLoading: false,
      );

      _compassSub = FlutterCompass.events?.listen((event) {
        _recalculate(event.heading ?? 0);
      });
    } catch (_) {
      state =
          state.copyWith(isLoading: false, error: 'Failed to load Qibla');
    }
  }

  @override
  void dispose() {
    _compassSub?.cancel();
    super.dispose();
  }
}