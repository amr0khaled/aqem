import 'dart:convert';
import 'package:aqem/features/quran_screen/domain/ayah_reponse.dart';
import 'package:aqem/features/quran_screen/domain/surah_response.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<AyahsResponseBody> fetchAyahs(int surah) async {
    final response = await http.get(
      Uri.parse(
        'https://islamy-backend.vercel.app/api/quran/surah/$surah/ayahs',
      ),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // Remove .map().toList() because AyahsResponseBody is a single object
      return AyahsResponseBody.fromJson(data);
    } else {
      throw Exception('Failed to load ayahs');
    }
  }

  Future<SurahsResponseBody> fetchSurahs() async {
    final response = await http.get(
      Uri.parse('https://islamy-backend.vercel.app/api/quran/surah'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // Remove .map().toList() because SurahsResponseBody is a single object
      return SurahsResponseBody.fromJson(data);
    } else {
      throw Exception('Failed to load surahs');
    }
  }
}
