class Reminder {
  final String id;
  final String title;
  final int hour;     // 0–23 (24-hour format)
  final int minute;   // 0–59
  final int iconIndex;
  final int colorIndex;
  final bool isDaily;
  final bool isEnabled;

  const Reminder({
    required this.id,
    required this.title,
    required this.hour,
    required this.minute,
    required this.iconIndex,
    required this.colorIndex,
    required this.isDaily,
    required this.isEnabled,
  });

  /// Creates a new Reminder with some fields changed. We use this for
  /// "toggle enabled" — copy everything, flip one bool. This is the
  /// standard immutable-update pattern.
  Reminder copyWith({
    String? title,
    int? hour,
    int? minute,
    int? iconIndex,
    int? colorIndex,
    bool? isDaily,
    bool? isEnabled,
  }) {
    return Reminder(
      id: id,
      title: title ?? this.title,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      iconIndex: iconIndex ?? this.iconIndex,
      colorIndex: colorIndex ?? this.colorIndex,
      isDaily: isDaily ?? this.isDaily,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'hour': hour,
    'minute': minute,
    'iconIndex': iconIndex,
    'colorIndex': colorIndex,
    'isDaily': isDaily,
    'isEnabled': isEnabled,
  };

  factory Reminder.fromJson(Map<String, dynamic> json) => Reminder(
    id: json['id'] as String,
    title: json['title'] as String,
    hour: json['hour'] as int,
    minute: json['minute'] as int,
    iconIndex: json['iconIndex'] as int,
    colorIndex: json['colorIndex'] as int,
    isDaily: json['isDaily'] as bool,
    isEnabled: json['isEnabled'] as bool,
  );
}