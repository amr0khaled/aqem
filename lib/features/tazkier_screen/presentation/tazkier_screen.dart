import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aqem/core/theme/App_Color.dart'; // ← adjust path if needed
import 'package:aqem/features/tazkier_screen/domain/reminder.dart';
import 'package:aqem/features/tazkier_screen/presentation/add_reminder_dialog.dart';
import 'package:aqem/features/tazkier_screen/presentation/providers/reminders_provider.dart';
import 'package:aqem/features/tazkier_screen/presentation/reminder_options.dart';

class TazkierScreen extends ConsumerWidget {
  const TazkierScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncReminders = ref.watch(remindersProvider);

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _Header(onAdd: () => _openAddDialog(context, ref)),
              const SizedBox(height: 16),
              Expanded(
                child: asyncReminders.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Center(child: Text('خطأ: $e')),
                  data: (reminders) => ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      if (reminders.isEmpty)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 24),
                          child: Center(
                            child: Text(
                              'لا توجد تذكيرات بعد',
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),
                        )
                      else
                        for (final r in reminders)
                          _ReminderCard(
                            reminder: r,
                            onTap: () => _openEditDialog(context, ref, r),
                          ),
                      const SizedBox(height: 4),
                      _AddNewButton(onTap: () => _openAddDialog(context, ref)),
                      const SizedBox(height: 24),
                      const _TipCard(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openAddDialog(BuildContext context, WidgetRef ref) async {
    
    final reminder = await showDialog<Reminder>(
      context: context,
      builder: (_) => const AddReminderDialog(),
    );
    if (reminder != null) {
      await ref.read(remindersProvider.notifier).add(reminder);
    }
  }
}

Future<void> _openEditDialog(
  BuildContext context,
  WidgetRef ref,
  Reminder existing,
) async {
  final updated = await showDialog<Reminder>(
    context: context,
    builder: (_) => AddReminderDialog(
      initial: existing,
      onDelete: () {
        ref.read(remindersProvider.notifier).remove(existing.id);
      },
    ),
  );
  if (updated != null) {
    await ref.read(remindersProvider.notifier).edit(updated);
  }
}

// ─── Header ────────────────────────────────────────────────────────────
class _Header extends StatelessWidget {
  final VoidCallback onAdd;
  const _Header({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          const Text(
            'التذكيرات',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_back, color: Colors.white, size: 22),
          const Spacer(),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onAdd,
              customBorder: const CircleBorder(),
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Reminder card ─────────────────────────────────────────────────────
class _ReminderCard extends ConsumerWidget {
  final Reminder reminder;
  final VoidCallback onTap;
  const _ReminderCard({required this.reminder, required this.onTap});

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
                color: Colors.black.withOpacity(0.05),
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
                          _formatTime(reminder),
                          style: TextStyle(
                              color: Colors.grey[600], fontSize: 13),
                        ),
                        const SizedBox(width: 4),
                        Icon(Icons.access_time,
                            size: 14, color: Colors.grey[600]),
                      ],
                    ),
                  ],
                ),
              ),
              Switch(
                value: reminder.isEnabled,
                onChanged: (_) {
                  ref
                      .read(remindersProvider.notifier)
                      .toggleEnabled(reminder.id);
                },
                activeColor: AppColors.primary,
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

  String _formatTime(Reminder r) {
    final h12 = r.hour == 0 ? 12 : (r.hour > 12 ? r.hour - 12 : r.hour);
    final period = r.hour < 12 ? 'ص' : 'م';
    final hh = h12.toString().padLeft(2, '0');
    final mm = r.minute.toString().padLeft(2, '0');
    return '$hh:$mm $period';
  }
}


// ─── Add-new placeholder button ────────────────────────────────────────
class _AddNewButton extends StatelessWidget {
  final VoidCallback onTap;
  const _AddNewButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'إضافة تذكير جديد',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(width: 8),
              Icon(Icons.add, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Tip card ──────────────────────────────────────────────────────────
class _TipCard extends StatelessWidget {
  const _TipCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.beige,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.gold.withOpacity(0.4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'نصيحة',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 6),
                Text(
                  'المداومة على الأذكار اليومية تجلب السكينة والطمأنينة '
                  'للقلب. احرص على تفعيل التذكيرات لتبقى على اتصال دائم بالله.',
                  style: TextStyle(fontSize: 13, height: 1.6),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: AppColors.gold,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.lightbulb, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }
}
