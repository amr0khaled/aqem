import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:aqem/core/theme/App_Color.dart';
import 'package:aqem/features/tazkier_screen/domain/reminder.dart';
import 'package:aqem/features/tazkier_screen/presentation/reminder_options.dart';

class AddReminderDialog extends StatefulWidget {
  final Reminder? initial;
  final VoidCallback? onDelete;
  const AddReminderDialog({super.key, this.initial, this.onDelete});

  @override
  State<AddReminderDialog> createState() => _AddReminderDialogState();
}

class _AddReminderDialogState extends State<AddReminderDialog> {
  late final TextEditingController _titleController;
  late final TextEditingController _messageController;
  late TimeOfDay _selectedTime;
  late int _selectedIcon;
  late int _selectedColor;
  late bool _dailyRepeat;

  bool get _isEditing => widget.initial != null;

  // Formats the current TimeOfDay into a locale-independent 12h Arabic string.
  String get _formattedTime {
    final h = _selectedTime.hour;
    final h12 = h == 0 ? 12 : (h > 12 ? h - 12 : h);
    final period = h < 12 ? 'ص' : 'م';
    return '${h12.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')} $period';
  }

  @override
  void initState() {
    super.initState();
    final r = widget.initial;
    if (r != null) {
      _titleController = TextEditingController(text: r.title);
      _messageController = TextEditingController(text: r.message ?? '');
      _selectedTime = TimeOfDay(hour: r.hour, minute: r.minute);
      _selectedIcon = r.iconIndex;
      _selectedColor = r.colorIndex;
      _dailyRepeat = r.isDaily;
    } else {
      _titleController = TextEditingController();
      _messageController = TextEditingController();
      _selectedTime = const TimeOfDay(hour: 12, minute: 0);
      _selectedIcon = 2;
      _selectedColor = 4;
      _dailyRepeat = true;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  bool isDark =
      PlatformDispatcher.instance.platformBrightness == Brightness.dark;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: DefaultTextStyle(
        style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 480,
            maxHeight: MediaQuery.of(context).size.height * 0.9,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _header(),
                  const SizedBox(height: 16),
                  _field('عنوان التذكير', _titleInput()),
                  const SizedBox(height: 12),
                  _field('رسالة الإشعار (اختياري)', _messageInput()),
                  const SizedBox(height: 16),
                  _field('وقت التذكير', _timePicker(context)),
                  const SizedBox(height: 16),
                  _field('اختر الأيقونة', _iconGrid()),
                  const SizedBox(height: 16),
                  _field('اختر اللون', _colorRow()),
                  const SizedBox(height: 20),
                  _repeatRow(),
                  const SizedBox(height: 16),
                  _preview(),
                  const SizedBox(height: 20),
                  _actions(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ── Widgets ────────────────────────────────────────────────────────────

  Widget _header() => Row(
    children: [
      Text(
        _isEditing ? 'تعديل التذكير' : 'إضافة تذكير جديد',
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),
      const Spacer(),
      if (_isEditing && widget.onDelete != null)
        IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.red),
          onPressed: _onDelete,
        ),
      IconButton(
        icon: const Icon(Icons.close, color: Colors.black54),
        onPressed: () => Navigator.of(context).pop(),
      ),
    ],
  );

  Widget _field(String label, Widget child) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Padding(
        padding: const EdgeInsets.only(right: 4, bottom: 6),
        child: Text(label, style: const TextStyle(fontSize: 13)),
      ),
      child,
    ],
  );

  InputDecoration _inputBox(String hint) => InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
    filled: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    border: _border(Colors.grey.shade300),
    enabledBorder: _border(Colors.grey.shade300),
    focusedBorder: _border(AppColors.primary),
  );

  OutlineInputBorder _border(Color c) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: c),
  );

  Widget _titleInput() => TextField(
    controller: _titleController,
    textAlign: TextAlign.right,
    decoration: _inputBox('مثال: صلاة الضحى، قراءة ورد...'),
    onChanged: (_) => setState(() {}),
  );

  Widget _messageInput() => TextField(
    controller: _messageController,
    textAlign: TextAlign.right,
    decoration: _inputBox('مثال: حان وقت ذكرك...'),
  );

  Widget _timePicker(BuildContext context) => InkWell(
    onTap: () => _pickTime(context),
    borderRadius: BorderRadius.circular(10),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Text(_formattedTime, style: const TextStyle(fontSize: 15)),
          const Spacer(),
          Icon(Icons.schedule, color: Colors.grey[500], size: 20),
        ],
      ),
    ),
  );

  Future<void> _pickTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null) setState(() => _selectedTime = picked);
  }

  Widget _iconGrid() => Wrap(
    spacing: 10,
    runSpacing: 10,
    children: List.generate(availableIcons.length, (i) {
      final selected = i == _selectedIcon;
      return GestureDetector(
        onTap: () => setState(() => _selectedIcon = i),
        child: Container(
          width: 54,
          height: 50,
          decoration: BoxDecoration(
            color: selected
                ? (isDark
                      ? ColorScheme.fromSeed(seedColor: AppColors.mint).primary
                      : AppColors.mint)
                : (isDark ? Colors.black : Colors.white),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected
                  ? (isDark
                        ? ColorScheme.fromSeed(
                            seedColor: AppColors.primary,
                          ).primary
                        : AppColors.primary)
                  : (isDark ? Colors.grey.shade800 : Colors.grey.shade300),
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Icon(
            availableIcons[i],
            color: selected
                ? (isDark
                      ? ColorScheme.fromSeed(
                          seedColor: AppColors.primary,
                        ).onPrimary
                      : AppColors.primary)
                : (isDark ? Colors.grey.shade300 : Colors.black54),
            size: 22,
          ),
        ),
      );
    }),
  );

  Widget _colorRow() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: List.generate(availableColors.length, (i) {
      final selected = i == _selectedColor;
      return GestureDetector(
        onTap: () => setState(() => _selectedColor = i),
        child: Container(
          width: 56,
          height: 36,
          decoration: BoxDecoration(
            color: availableColors[i],
            borderRadius: BorderRadius.circular(18),
            border: selected
                ? Border.all(color: Colors.black87, width: 2)
                : null,
          ),
        ),
      );
    }),
  );

  Widget _repeatRow() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(14),
    ),
    child: Row(
      children: [
        const Text('تكرار يومي', style: TextStyle(fontWeight: FontWeight.w600)),
        const Spacer(),
        Switch(
          value: _dailyRepeat,
          onChanged: (v) => setState(() => _dailyRepeat = v),
          activeThumbColor: Colors.white,
          activeTrackColor: AppColors.primary,
        ),
      ],
    ),
  );

  Widget _preview() => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: Theme.of(context).brightness == Brightness.dark
            ? [
                ColorScheme.fromSeed(seedColor: AppColors.mint).primary,
                Colors.black12,
              ]
            : [AppColors.mint, Colors.white],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('معاينة التذكير', style: TextStyle(fontSize: 11)),
        const SizedBox(height: 10),
        Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: availableColors[_selectedColor],
                shape: BoxShape.circle,
              ),
              child: Icon(
                availableIcons[_selectedIcon],
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
                    _titleController.text.isEmpty
                        ? 'عنوان التذكير'
                        : _titleController.text,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formattedTime,
                    style: TextStyle(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withAlpha(120),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );

  Widget _actions() => Row(
    children: [
      SizedBox(
        width: 100,
        height: 48,
        child: OutlinedButton(
          onPressed: () => Navigator.of(context).pop(),
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Colors.grey.shade300),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: Text(
            'إلغاء',
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: SizedBox(
          height: 48,
          child: ElevatedButton(
            onPressed: _onSave,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Text(
              _isEditing ? 'حفظ التعديل' : 'حفظ التذكير',
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
          ),
        ),
      ),
    ],
  );

  // ── Actions ───────────────────────────────────────────────────────────

  void _onSave() {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      _snack('الرجاء إدخال عنوان التذكير');
      return;
    }
    final message = _messageController.text.trim();
    Navigator.of(context).pop(
      Reminder(
        id:
            widget.initial?.id ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        message: message.isEmpty ? null : message,
        hour: _selectedTime.hour,
        minute: _selectedTime.minute,
        iconIndex: _selectedIcon,
        colorIndex: _selectedColor,
        isDaily: _dailyRepeat,
        isEnabled: widget.initial?.isEnabled ?? true,
      ),
    );
  }

  Future<void> _onDelete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('حذف التذكير'),
        content: Text('هل تريد حذف "${widget.initial?.title ?? ''}"؟'),
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
    if (confirmed == true && mounted) {
      widget.onDelete?.call();
      Navigator.of(context).pop();
    }
  }

  void _snack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }
}
