import 'dart:async';

import 'package:flutter_revision_1/features/qibla/domain/usecases/get_qibla_direction.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'package:http/http.dart' as http;
import '../../data/datasources/qibla_remote_datasource.dart';
import '../../data/repositories/qibla_repository_impl.dart';


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

  const QiblaState({
    this.qiblahDirection,
    this.compassAngle = 0,
    this.isLoading = true,
    this.error,
  });

  QiblaState copyWith({
    double? qiblahDirection,
    double? compassAngle,
    bool? isLoading,
    String? error,
  }) {
    return QiblaState(
      qiblahDirection: qiblahDirection ?? this.qiblahDirection,
      compassAngle: compassAngle ?? this.compassAngle,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
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

      state = state.copyWith(
        qiblahDirection: dir,
        isLoading: false,
      );

      _compassSub = FlutterCompass.events?.listen((event) {
        final heading = event.heading ?? 0;
        state = state.copyWith(
          compassAngle: (heading + 360) % 360,
        );
      });
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load Qibla',
      );
    }
  }

  @override
  void dispose() {
    _compassSub?.cancel();
    super.dispose();
  }
}