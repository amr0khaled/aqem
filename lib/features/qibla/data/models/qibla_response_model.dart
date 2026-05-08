class QiblaResponseModel {
  final double direction;

  QiblaResponseModel({required this.direction});

  factory QiblaResponseModel.fromJson(Map<String, dynamic> json) {
    return QiblaResponseModel(
      direction: (json['data']['direction'] as num).toDouble(),
    );
  }
}