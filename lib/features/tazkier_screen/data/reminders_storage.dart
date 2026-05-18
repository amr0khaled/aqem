import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aqem/features/tazkier_screen/domain/reminder.dart';

class RemindersStorage {
  static const _key = 'reminders';

  Future<List<Reminder>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) return [];
    final list = jsonDecode(raw) as List;
    return list
      .map((e) => Reminder.fromJson(e as Map<String, dynamic>))
      .toList();
  }

  Future<void> save(List<Reminder> reminders) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = jsonEncode(reminders.map((r) => r.toJson()).toList());
    await prefs.setString(_key, raw);
  }
}