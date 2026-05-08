class DirectionUtils {
  static const List<String> _directions = [
    "شمال",
    "شمال شرقي",
    "شرق",
    "جنوب شرقي",
    "جنوب",
    "جنوب غربي",
    "غرب",
    "شمال غربي",
  ];

  static String getDirection(double bearing) {
    final normalizedBearing = bearing % 360;

    final index = ((normalizedBearing + 22.5) ~/ 45) % 8;

    return _directions[index];
  }
}