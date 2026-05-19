import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/qibla_response_model.dart';

class QiblaRemoteDataSource {
  final http.Client client;

  QiblaRemoteDataSource(this.client);

  Future<double> getQiblaDirection({
    required double latitude,
    required double longitude,
  }) async {
    final uri = Uri.parse(
      'https://api.aladhan.com/v1/qibla/$latitude/$longitude',
    );

    final response = await client.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch Qibla');
    }

    final jsonMap = json.decode(response.body);

    return QiblaResponseModel.fromJson(jsonMap).direction;
  }
}

