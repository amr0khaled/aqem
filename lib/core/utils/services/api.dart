import 'dart:convert';
import 'package:aqem/core/utils/models/response.dart';
import 'package:aqem/features/quran_screen/domain/ayah_reponse.dart';
import 'package:aqem/features/quran_screen/domain/surah_response.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:googleapis/youtube/v3.dart';
import 'package:googleapis_auth/auth_io.dart';
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

class PrayerApiService {
  static Future<Map<String, dynamic>> getPrayerTimes({
    String country = "Egypt",
    String city = "Alexandria",
    String state = "",
    int method = 5,
    String date = "",
  }) async {
    final Date = date.isEmpty ? _getCurrentDate() : date;
    final addressList = [city, country];
    if (state != "") {
      addressList.insert(0, state);
    }
    final address = addressList.join(", ");

    var urlString =
        'https://islamy-backend.vercel.app/api/pray-times/$Date'
        '?address=${Uri.encodeComponent(address)}';
    final url = Uri.parse(urlString);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return data['timings'];
      } else {
        throw Exception("API error: ${data['status']}");
      }
    } else {
      throw Exception("failed to load prayer times");
    }
  }

  static String _getCurrentDate() {
    final now = DateTime.now();
    return "${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}";
  }
}

class YoutubeApiService {
  static final String _apiKey = dotenv.get("GOOGLE_API_KEY");

  Future<YoutubeResponse<Playlist>> fetchPlaylistMetadata(
    List<String> id, {
    String? token,
    int? max = 5,
  }) async {
    print("Started");
    final client = _createClient();
    try {
      YouTubeApi api = YouTubeApi(client);
      print("fetching");
      final res = await api.playlists.list(
        ["snippet", "contentDetails"],
        id: id,
        pageToken: token,
        maxResults: max,
      );
      final ytRes = YoutubeResponse<Playlist>(
        totalResults: res.pageInfo?.totalResults ?? 0,
        resultsPerPage: res.pageInfo?.resultsPerPage ?? 0,
        items: res.items ?? [],
        nextPageToken: res.nextPageToken,
        prevPageToken: res.prevPageToken,
      );
      print("Got it ${ytRes.items.length}");
      return ytRes;
    } finally {
      client.close();
      print("Close");
    }
  }

  http.Client _createClient() => clientViaApiKey(_apiKey);

  Future<YoutubeResponse<PlaylistItem>> fetchPlaylistItems(
    String id, {
    int? maxResults = 20,
    String? pageToken,
  }) async {
    final client = _createClient();
    try {
      YouTubeApi api = YouTubeApi(client);
      final res = await api.playlistItems.list(
        ["snippet", "contentDetails"],
        playlistId: id,
        maxResults: maxResults,
        pageToken: pageToken,
      );

      return YoutubeResponse(
        totalResults: res.pageInfo?.totalResults ?? 0,
        resultsPerPage: res.pageInfo?.resultsPerPage ?? 0,
        items: res.items ?? [],
        nextPageToken: res.nextPageToken,
        prevPageToken: res.prevPageToken,
      );
    } finally {
      client.close();
    }
  }
}
