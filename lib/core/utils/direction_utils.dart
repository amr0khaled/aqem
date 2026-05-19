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
    final normalized = ((bearing % 360) + 360) % 360;

    final index = ((normalized + 22.5) ~/ 45) % 8;

    return _directions[index];
  }
}