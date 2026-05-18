import 'package:flutter/material.dart';
import 'package:aqem/core/theme/App_Color.dart';
import 'package:aqem/features/tazkier_screen/presentation/add_reminder_dialog.dart';
// Brand colors — move into core/theme later so the whole app shares them.

const _brandGreen = AppColors.primary;
const _bg = AppColors.bg;
const _tipGold = AppColors.gold;


class TazkierScreen extends StatelessWidget {
  const TazkierScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _Header(
                onAdd: () {
                  showDialog(
                    context: context,
                    builder: (_) => const AddReminderDialog(),
                  );
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    for (int i = 0; i < 4; i++)
                      const _ReminderCard(title: 'صدقة يومية', time: '12:00 م'),
                    const SizedBox(height: 4),
                    _AddNewButton(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => const AddReminderDialog(),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    const _TipCard(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Header: green rounded bar with title on the right, "+" on the left
// ─────────────────────────────────────────────────────────────────────────────
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
                  color: Colors.white.withValues(alpha: 0.18),
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

// ─────────────────────────────────────────────────────────────────────────────
// Reminder card: heart on the right, title+time in the middle, switch on the left
// ─────────────────────────────────────────────────────────────────────────────
class _ReminderCard extends StatefulWidget {
  final String title;
  final String time;
  const _ReminderCard({required this.title, required this.time});

  @override
  State<_ReminderCard> createState() => _ReminderCardState();
}

class _ReminderCardState extends State<_ReminderCard> {
  // Local state for Phase 1. In Phase 2 this moves into a Riverpod provider.
  bool _on = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Heart circle — START side (visual right in RTL)
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: _brandGreen,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.favorite, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 12),
          // Title + time
          Expanded(
            child: Column(
              // In RTL, CrossAxisAlignment.start = right-aligned
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      widget.time,
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                    const SizedBox(width: 4),
                    Icon(Icons.access_time, size: 14, color: Colors.grey[600]),
                  ],
                ),
              ],
            ),
          ),
          // Switch — END side (visual left in RTL)
          Switch(
            value: _on,
            onChanged: (v) => setState(() => _on = v),
            activeThumbColor: _brandGreen,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// "Add new reminder" placeholder button
// ─────────────────────────────────────────────────────────────────────────────
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

// ─────────────────────────────────────────────────────────────────────────────
// Tip card at the bottom (gold-tinted)
// ─────────────────────────────────────────────────────────────────────────────
class _TipCard extends StatelessWidget {
  const _TipCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:AppColors.beige,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.gold.withValues(alpha: 0.4)),
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
              color: _tipGold,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.lightbulb, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }
}
