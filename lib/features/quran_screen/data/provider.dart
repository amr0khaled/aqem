import 'package:aqem/features/quran_screen/domain/surah_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aqem/core/utils/services/api.dart';
import '../domain/ayah_reponse.dart';

// Create a provider for the API service
final apiServiceProvider = Provider((ref) => ApiService());

// Create a FutureProvider that calls the API
final ayahsProvider = FutureProvider.family<AyahsResponseBody, int>((
  ref,
  id,
) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.fetchAyahs(id);
});

final surahsProvider = FutureProvider<SurahsResponseBody>((ref) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.fetchSurahs();
});
