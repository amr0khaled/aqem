import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aqem/core/theme/App_Color.dart';
import 'package:aqem/features/tazkier_screen/domain/reminder.dart';
import 'package:aqem/features/tazkier_screen/presentation/providers/reminders_provider.dart';
import 'package:aqem/features/tazkier_screen/presentation/reminder_options.dart';

class ReminderCard extends ConsumerWidget {
  final Reminder reminder;
  final VoidCallback onTap;

  const ReminderCard({super.key, required this.reminder, required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: ValueKey(reminder.id),
      direction: DismissDirection.horizontal,
      background: _swipeBackground(AlignmentDirectional.centerStart),
      secondaryBackground: _swipeBackground(AlignmentDirectional.centerEnd),
      confirmDismiss: (_) => _confirmDelete(context),
      onDismissed: (_) {
        ref.read(remindersProvider.notifier).remove(reminder.id);
      },
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha:0.05),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: availableColors[reminder.colorIndex],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  availableIcons[reminder.iconIndex],
                  color: Colors.white,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reminder.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          reminder.formattedTime,
                          style: TextStyle(color: Colors.grey[600], fontSize: 13),
                        ),
                        const SizedBox(width: 4),
                        Icon(Icons.access_time, size: 14, color: Colors.grey[600]),
                        if (reminder.isDaily) ...[
                          const SizedBox(width: 6),
                          Icon(Icons.repeat, size: 12, color: Colors.grey[500]),
                          const SizedBox(width: 2),
                          Text(
                            'يومي',
                            style: TextStyle(color: Colors.grey[500], fontSize: 11),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              Switch(
                value: reminder.isEnabled,
                onChanged: (_) {
                  ref.read(remindersProvider.notifier).toggleEnabled(reminder.id);
                },
                activeThumbColor : AppColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _swipeBackground(AlignmentGeometry alignment) => Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(18),
        ),
        alignment: alignment,
        child: const Icon(Icons.delete, color: Colors.white),
      );

  Future<bool> _confirmDelete(BuildContext context) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('حذف التذكير'),
        content: Text('هل تريد حذف "${reminder.title}"؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('حذف', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    return ok ?? false;
  }
}
