import 'package:flutter/material.dart';
import 'package:aqem/core/theme/App_Color.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aqem/features/prayer_times_screen/domain/prayer.dart';
import 'package:aqem/features/prayer_times_screen/domain/prayer_times_data.dart';
import 'package:aqem/features/prayer_times_screen/presentation/providers/prayer_times_provider.dart';
enum _Status { passed, active, upcoming }


// ─── Screen ────────────────────────────────────────────────────────────
class PrayerTimesScreen extends ConsumerWidget {
  const PrayerTimesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(prayerTimesProvider);

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: asyncData.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 12),
                  Text(
                    'تعذّر تحميل مواقيت الصلاة\n$e',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () =>
                        ref.read(prayerTimesProvider.notifier).reload(),
                    child: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
            ),
          ),
          data: (data) => RefreshIndicator(
            onRefresh: () =>
                ref.read(prayerTimesProvider.notifier).reload(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _Header(data: data),
                  const SizedBox(height: 16),
                  for (final d in _computeDisplays(data.prayers, DateTime.now()))
                    _PrayerCard(display: d),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Status computation ────────────────────────────────────────────────
class _Display {
  final Prayer prayer;
  final _Status status;
  final Prayer? next; // only set when status==active
  const _Display(this.prayer, this.status, [this.next]);
}

List<_Display> _computeDisplays(List<Prayer> prayers, DateTime now) {
  final nowMins = now.hour * 60 + now.minute;
  final mains = prayers.where((p) => p.isMainPrayer).toList();

  // Find "active" = the most recent main prayer whose time has passed.
  // "Next" = the first main prayer still in the future.
  Prayer? active;
  Prayer? next;
  for (final p in mains) {
    if (p.inMinutes <= nowMins) {
      active = p;
    } else {
      next ??= p;
    }
  }

  return prayers.map((p) {
    if (p == active) return _Display(p, _Status.active, next);
    if (p.inMinutes < nowMins) return _Display(p, _Status.passed);
    return _Display(p, _Status.upcoming);
  }).toList();
}

// ─── Header (green gradient card) ──────────────────────────────────────
class _Header extends StatelessWidget {
  final PrayerTimesData data;
  const _Header({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.secondary],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(
                        'مواقيت الصلاة',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(Icons.arrow_back, color: Colors.white, size: 20),
                    ],
                  ),
                  SizedBox(height: 2),
                  Text(
                    'أوقات دقيقة حسب موقعك',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.secondary.withValues(alpha:0.5),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  data.location,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                ),
                const SizedBox(width: 6),
                Icon(Icons.location_on,
                    color: Colors.white.withValues(alpha:0.9), size: 16),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Text(
                  data.weekday,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  data.gregorianDate,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  data.hijriDate,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Prayer card (handles regular + active + sunrise) ──────────────────
class _PrayerCard extends StatefulWidget {
  final _Display display;
  const _PrayerCard({required this.display});

  @override
  State<_PrayerCard> createState() => _PrayerCardState();
}

class _PrayerCardState extends State<_PrayerCard> {
  bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    final p = widget.display.prayer;
    final isActive = widget.display.status == _Status.active;
    final fg = isActive ? Colors.white : Colors.black87;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: isActive
            ? Border.all(color: AppColors.gold, width: 1.5)
            : null,
        boxShadow: isActive
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha:0.05),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Icon circle (RIGHT side in RTL)
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: p.iconBg,
                  shape: BoxShape.circle,
                ),
                child: Icon(p.icon, color: Colors.brown.shade400, size: 24),
              ),
              const SizedBox(width: 12),
              // Name + status text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      p.arabicName,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: fg,
                      ),
                    ),
                    if (isActive && widget.display.next != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          _countdown(p, widget.display.next!),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withValues(alpha:0.85),
                          ),
                        ),
                      )
                    else if (widget.display.status == _Status.upcoming)
                      const Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: Text(
                          'قادمة',
                          style: TextStyle(fontSize: 11, color: Colors.black54),
                        ),
                      ),
                  ],
                ),
              ),
              // Time
              Text(
                p.formattedTime,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: fg,
                ),
              ),
              const SizedBox(width: 12),
              // Toggle area (LEFT side in RTL) — only for the 5 main prayers
              if (p.isMainPrayer) _toggleArea(isActive),
            ],
          ),
          if (isActive) ...[
            const SizedBox(height: 14),
            _progressBar(p, widget.display.next!),
          ],
        ],
      ),
    );
  }

  Widget _toggleArea(bool isActive) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.notifications_none,
          color: isActive ? Colors.white : Colors.black54,
          size: 18,
        ),
        const SizedBox(width: 4),
        Transform.scale(
          scale: 0.85,
          child: Switch(
            value: _enabled,
            onChanged: (v) => setState(() => _enabled = v),
            activeThumbColor : Colors.white,
            activeTrackColor: isActive ? AppColors.gold : AppColors.primary,
          ),
        ),
        Text(
          'مفعل',
          style: TextStyle(
            fontSize: 10,
            color: isActive ? Colors.white70 : Colors.black54,
          ),
        ),
      ],
    );
  }

  /// "بعد ساعة و 15 دقيقة" — minutes between now and the next prayer.
  String _countdown(Prayer current, Prayer next) {
    final now = DateTime.now();
    final nowMins = now.hour * 60 + now.minute;
    var diff = next.inMinutes - nowMins;
    if (diff < 0) diff += 24 * 60; // wrapped past midnight
    final h = diff ~/ 60;
    final m = diff % 60;
    if (h == 0) return 'بعد $m دقيقة';
    if (h == 1) return 'بعد ساعة و $m دقيقة';
    if (h == 2) return 'بعد ساعتين و $m دقيقة';
    return 'بعد $h ساعات و $m دقيقة';
  }

  /// Progress = (now − active.time) / (next.time − active.time)
  Widget _progressBar(Prayer active, Prayer next) {
    final now = DateTime.now();
    final nowMins = now.hour * 60 + now.minute;
    final total = next.inMinutes - active.inMinutes;
    final elapsed = nowMins - active.inMinutes;
    final pct = total > 0 ? (elapsed / total).clamp(0.0, 1.0) : 0.0;
    return Column(
      children: [
        Row(
          children: [
            Text(
              '${(pct * 100).round()}%',
              style: const TextStyle(color: Colors.white70, fontSize: 11),
            ),
            const Spacer(),
            const Text(
              'الوقت المنقضي',
              style: TextStyle(color: Colors.white70, fontSize: 11),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: pct,
            minHeight: 6,
            backgroundColor: Colors.white.withValues(alpha:0.2),
            valueColor: AlwaysStoppedAnimation(AppColors.gold),
          ),
        ),
      ],
    );
  }
}