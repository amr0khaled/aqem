import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aqem/features/prayer_times_screen/data/prayer_times_api.dart';
import 'package:aqem/features/prayer_times_screen/domain/prayer_times_data.dart';

class PrayerTimesNotifier extends AsyncNotifier<PrayerTimesData> {
  final _api = PrayerTimesApi();

  // Hardcoded for now — Phase 3 replaces this with actual GPS location.
  static const _defaultAddress = 'Alexandria,Egypt';

  @override
  Future<PrayerTimesData> build() async {
    return _api.fetchToday(address: _defaultAddress);
  }

  /// Pull-to-refresh or manual reload.
  Future<void> reload() async {
    state = const AsyncValue.loading();
    try {
      final data = await _api.fetchToday(address: _defaultAddress);
      state = AsyncValue.data(data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final prayerTimesProvider =
    AsyncNotifierProvider<PrayerTimesNotifier, PrayerTimesData>(
      PrayerTimesNotifier.new,
    );