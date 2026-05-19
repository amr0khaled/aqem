import 'dart:async';
import 'package:flutter_riverpod/legacy.dart';
import 'package:riverpod/riverpod.dart';
import 'package:aqem/features/home_screen/domain/prayer_time.dart';
import 'package:aqem/features/home_screen/domain/prayer_type.dart';
import 'package:aqem/core/utils/services/api.dart';

class PrayerState {
  final List<PrayerTime> prayers;
  final PrayerTime? nextPrayer;
  final Duration remaining;
  final double progress;
  final bool isLoading;
  final String? error;

  PrayerState({
    required this.prayers,
    this.nextPrayer,
    required this.remaining,
    required this.progress,
    this.isLoading = false,
    this.error,
  });

  factory PrayerState.initial() => PrayerState(
    prayers: [],
    nextPrayer: null,
    remaining: Duration.zero,
    progress: 0,
    isLoading: true,
  );

  PrayerState copyWith({
    List<PrayerTime>? prayers,
    PrayerTime? nextPrayer,
    Duration? remaining,
    double? progress,
    bool? isLoading,
    String? error,
  }) {
    return PrayerState(
      prayers: prayers ?? this.prayers,
      nextPrayer: nextPrayer ?? this.nextPrayer,
      remaining: remaining ?? this.remaining,
      progress: progress ?? this.progress,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class PrayerNotifier extends StateNotifier<PrayerState> {
  Timer? _timer;

  PrayerNotifier() : super(PrayerState.initial()) {
    loadPrayerTimes();
  }

  Future<void> loadPrayerTimes() async {
    try{
      final timings = await PrayerApiService.getPrayerTimes(
        country: "Egypt",
        city: "Alexandria",
        method: 5,
      );
    final prayers = [
      PrayerTime(type: PrayerType.fajr, name: "الفجر", time: timings['Fajr']),
      PrayerTime(type: PrayerType.sunrise, name: "الشروق", time: timings['Sunrise']??"",),
      PrayerTime(type: PrayerType.dhohr, name: "الظهر", time: timings['Dhuhr']??""),
      PrayerTime(type: PrayerType.asr, name: "العصر", time: timings['Asr']??""),
      PrayerTime(type: PrayerType.maghreb, name: "المغرب", time: timings['Maghrib']??"",),
      PrayerTime(type: PrayerType.isha, name: "العشاء", time: timings['Isha']),
    ];

    state = state.copyWith(prayers: prayers, isLoading: false,
      error: null,);
    _updatePrayerData();
    _startTimer();
  }
    catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updatePrayerData();
    });
  }

  void _updatePrayerData() {
    if (state.prayers.isEmpty) return;
    final now = DateTime.now();
    final prayers = state.prayers;

    for (int i = 0; i < prayers.length; i++) {
      final prayer = prayers[i];
      final prayerTime = _parsePrayerTime(prayer.time);
      if (prayerTime.isAfter(now)) {
        final remaining = prayerTime.difference(now);
        final previousPrayerTime = i == 0
            ? _parsePrayerTime(prayers.last.time).subtract(const Duration(days: 1))
            : _parsePrayerTime(prayers[i - 1].time);

        final totalSeconds = prayerTime.difference(previousPrayerTime).inSeconds;
        final passedSeconds = now.difference(previousPrayerTime).inSeconds;
        final progress = totalSeconds > 0 ? passedSeconds / totalSeconds : 0.0;
        state = state.copyWith(
          nextPrayer: prayer,
          remaining: remaining,
          progress: progress,
        );
        return;
      }
    }

    final nextPrayer = prayers.first;
    final fajrTomorrow = _parsePrayerTime(prayers.first.time).add(const Duration(days: 1));
    final remaining = fajrTomorrow.difference(now);

    state = state.copyWith(
      nextPrayer: nextPrayer,
      remaining: remaining,
      progress: 0.0,
    );
  }

  DateTime _parsePrayerTime(String time) {
    final now = DateTime.now();
    final parts = time.split(":");
    return DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(parts[0]),
      int.parse(parts[1]),
    );
  }

  String get remainingText {
    final hours = state.remaining.inHours;
    final minutes = state.remaining.inMinutes.remainder(60);
    return "بعد  $hours ساعة و $minutes دقيقة";
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
final prayerProvider = StateNotifierProvider<PrayerNotifier, PrayerState>((ref) {
  return PrayerNotifier();
});
final remainingTextProvider = Provider<String>((ref) {
  final notifier = ref.watch(prayerProvider.notifier);
  return notifier.remainingText;
});