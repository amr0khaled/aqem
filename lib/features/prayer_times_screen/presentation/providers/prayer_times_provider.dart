import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aqem/features/prayer_times_screen/data/location_service.dart';
import 'package:aqem/features/prayer_times_screen/data/prayer_times_api.dart';
import 'package:aqem/features/prayer_times_screen/domain/prayer_times_data.dart';

class PrayerTimesNotifier extends AsyncNotifier<PrayerTimesData> {
  final _api = PrayerTimesApi();

  @override
  Future<PrayerTimesData> build() async {
    final location = await LocationService.getCurrent();
    final apiData = await _api.fetchToday(address: location.apiAddress);

    // The API class fills the `location` field with whatever string we
    // sent it (English). Replace it here with the Arabic display name.
    return PrayerTimesData(
      prayers: apiData.prayers,
      location: location.displayName,
      weekday: apiData.weekday,
      gregorianDate: apiData.gregorianDate,
      hijriDate: apiData.hijriDate,
    );
  }

  /// Re-fetches both location and prayer times. Bound to the
  /// pull-to-refresh and the retry button.
  Future<void> reload() async {
    state = const AsyncValue.loading();
    try {
      final location = await LocationService.getCurrent();
      final apiData = await _api.fetchToday(address: location.apiAddress);
      state = AsyncValue.data(PrayerTimesData(
        prayers: apiData.prayers,
        location: location.displayName,
        weekday: apiData.weekday,
        gregorianDate: apiData.gregorianDate,
        hijriDate: apiData.hijriDate,
      ));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final prayerTimesProvider =
    AsyncNotifierProvider<PrayerTimesNotifier, PrayerTimesData>(
      PrayerTimesNotifier.new,
    );