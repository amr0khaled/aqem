import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aqem/features/tazkier_screen/data/reminders_storage.dart';
import 'package:aqem/features/tazkier_screen/domain/reminder.dart';
import 'package:aqem/core/services/notification_service.dart';

class RemindersNotifier extends AsyncNotifier<List<Reminder>> {
  final _storage = RemindersStorage();

  /// build() is called once when the provider is first watched.
  /// Whatever it returns becomes the initial state.
  @override
  Future<List<Reminder>> build() async {
    final reminders = await _storage.load();
    // Re-sync notifications on app launch — in case reboots/updates
    // wiped scheduled alarms, or someone toggled a reminder before init.
    for (final r in reminders) {
      if (r.isEnabled) {
        await NotificationService.schedule(r);
      }
    }
    return reminders;
  }

Future<void> add(Reminder reminder) async {
  final current = state.value ?? [];
  final updated = [...current, reminder];
  state = AsyncValue.data(updated);
  await _storage.save(updated);
  await NotificationService.schedule(reminder);
}

  Future<void> remove(String id) async {
    final current = state.value ?? [];
    final updated = current.where((r) => r.id != id).toList();
    state = AsyncValue.data(updated);
    await _storage.save(updated);
    await NotificationService.cancel(id);
  }

  Future<void> toggleEnabled(String id) async {
    final current = state.value ?? [];
    final updated = current.map((r) {
      if (r.id != id) return r;
      return r.copyWith(isEnabled: !r.isEnabled);
    }).toList();
    state = AsyncValue.data(updated);
    await _storage.save(updated);

    final toggled = updated.firstWhere((r) => r.id == id);
    if (toggled.isEnabled) {
      await NotificationService.schedule(toggled);
    } else {
      await NotificationService.cancel(id);
    }
  }

  Future<void> edit(Reminder reminder) async {
    final current = state.value ?? [];
    final updated = current
        .map((r) => r.id == reminder.id ? reminder : r)
        .toList();
    state = AsyncValue.data(updated);
    await _storage.save(updated);

    // Cancel old schedule, schedule new (time/title/enabled may have changed).
    await NotificationService.cancel(reminder.id);
    if (reminder.isEnabled) {
      await NotificationService.schedule(reminder);
    }
  }
}

final remindersProvider =
    AsyncNotifierProvider<RemindersNotifier, List<Reminder>>(
      RemindersNotifier.new,
    );
