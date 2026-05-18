class QiblaResponseModel {
  final double direction;

  QiblaResponseModel({required this.direction});

  factory QiblaResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];

    if (data == null || data['direction'] == null) {
      throw Exception('Invalid Qibla API response');
    }

    return QiblaResponseModel(
      direction: (data['direction'] as num).toDouble(),
    );
  }
}