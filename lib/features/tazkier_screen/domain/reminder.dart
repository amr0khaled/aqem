class Reminder {
  final String id;
  final String title;
  final String? message; // optional notification body
  final int hour;        // 0–23 (24-hour)
  final int minute;      // 0–59
  final int iconIndex;
  final int colorIndex;
  final bool isDaily;
  final bool isEnabled;

  const Reminder({
    required this.id,
    required this.title,
    this.message,
    required this.hour,
    required this.minute,
    required this.iconIndex,
    required this.colorIndex,
    required this.isDaily,
    required this.isEnabled,
  });

  Reminder copyWith({
    String? title,
    String? message,
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
      message: message ?? this.message,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      iconIndex: iconIndex ?? this.iconIndex,
      colorIndex: colorIndex ?? this.colorIndex,
      isDaily: isDaily ?? this.isDaily,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }

  // ── Display helpers ──────────────────────────────────────────────────────

  String get formattedTime {
    final h12 = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
    final period = hour < 12 ? 'ص' : 'م';
    return '${h12.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
  }

  String get displayHour {
    final h12 = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
    return h12.toString().padLeft(2, '0');
  }

  String get displayMinute => minute.toString().padLeft(2, '0');

  String get displayPeriod => hour < 12 ? 'صباحاً' : 'مساءً';

  // ── Serialization ────────────────────────────────────────────────────────

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'message': message,
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
    message: json['message'] as String?,   // nullable — old reminders won't have this key
    hour: json['hour'] as int,
    minute: json['minute'] as int,
    iconIndex: json['iconIndex'] as int,
    colorIndex: json['colorIndex'] as int,
    isDaily: json['isDaily'] as bool,
    isEnabled: json['isEnabled'] as bool,
  );
}
