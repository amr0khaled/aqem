import 'package:flutter/material.dart';
import 'package:aqem/core/theme/App_Color.dart';


const _brandGreen = AppColors.primary;
const _lightGreenBg = AppColors.mint;






// The 10 picker icons (order matches the Figma: 2 rows of 5)
const _availableIcons = <IconData>[
  Icons.notifications_outlined,
  Icons.favorite_border,
  Icons.access_time,
  Icons.nightlight_outlined,
  Icons.wb_sunny_outlined,
  Icons.star_border,
  Icons.wb_twilight_outlined,
  Icons.wb_sunny,
  Icons.coffee_outlined,
  Icons.menu_book_outlined,
];

// The 5 picker colors
const _availableColors = <Color>[
  Color(0xFFE89BAB), // pink
  Color(0xFFB07FCB), // purple
  Color(0xFF7C95E0), // blue
  Color(0xFFD9C58E), // gold
  Color(0xFF0D7E5E), // green
];

class AddReminderDialog extends StatefulWidget {
  const AddReminderDialog({super.key});

  @override
  State<AddReminderDialog> createState() => _AddReminderDialogState();
}

class _AddReminderDialogState extends State<AddReminderDialog> {
  final _titleController = TextEditingController();
  final _timeController = TextEditingController(text: '12:00');
  String _period = 'صباحاً';
  int _selectedIcon = 2;  // clock
  int _selectedColor = 4; // green
  bool _dailyRepeat = true;

  @override
  void dispose() {
    _titleController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
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
                const SizedBox(height: 16),
                _field('وقت التذكير', _timeRow()),
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
    );
  }

  // ── header: title on right, X on left ───────────────────────────────────
  Widget _header() => Row(
        children: [
          const Text(
            'إضافة تذكير جديد',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black54),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );

  // ── reusable label + field wrapper ──────────────────────────────────────
  Widget _field(String label, Widget child) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 4, bottom: 6),
            child: Text(
              label,
              style: const TextStyle(fontSize: 13, color: Colors.black54),
            ),
          ),
          child,
        ],
      );

  InputDecoration _inputBox(String hint) => InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        border: _border(Colors.grey.shade300),
        enabledBorder: _border(Colors.grey.shade300),
        focusedBorder: _border(_brandGreen),
      );

  OutlineInputBorder _border(Color c) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: c),
      );

  Widget _titleInput() => TextField(
        controller: _titleController,
        textAlign: TextAlign.right,
        decoration: _inputBox('مثال: صلاة الضحى، قراءة ورد...'),
        onChanged: (_) => setState(() {}), // refresh preview live
      );

  // ── time row: text field on right, period dropdown on left ──────────────
  Widget _timeRow() => Row(
        children: [
          Expanded(
            child: TextField(
              controller: _timeController,
              textAlign: TextAlign.right,
              decoration: _inputBox(''),
              onChanged: (_) => setState(() {}),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _period,
                items: const [
                  DropdownMenuItem(value: 'صباحاً', child: Text('صباحاً')),
                  DropdownMenuItem(value: 'مساءً', child: Text('مساءً')),
                ],
                onChanged: (v) => setState(() => _period = v ?? 'صباحاً'),
              ),
            ),
          ),
        ],
      );

  // ── icon grid: 10 icons, tap to select ──────────────────────────────────
  Widget _iconGrid() => Wrap(
        spacing: 10,
        runSpacing: 10,
        children: List.generate(_availableIcons.length, (i) {
          final selected = i == _selectedIcon;
          return GestureDetector(
            onTap: () => setState(() => _selectedIcon = i),
            child: Container(
              width: 54,
              height: 50,
              decoration: BoxDecoration(
                color: selected ? _lightGreenBg : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: selected ? _brandGreen : Colors.grey.shade300,
                  width: selected ? 1.5 : 1,
                ),
              ),
              child: Icon(
                _availableIcons[i],
                color: selected ? _brandGreen : Colors.black54,
                size: 22,
              ),
            ),
          );
        }),
      );

  // ── color row ───────────────────────────────────────────────────────────
  Widget _colorRow() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(_availableColors.length, (i) {
          final selected = i == _selectedColor;
          return GestureDetector(
            onTap: () => setState(() => _selectedColor = i),
            child: Container(
              width: 56,
              height: 36,
              decoration: BoxDecoration(
                color: _availableColors[i],
                borderRadius: BorderRadius.circular(18),
                border: selected
                    ? Border.all(color: Colors.black87, width: 2)
                    : null,
              ),
            ),
          );
        }),
      );

  // ── daily repeat toggle ─────────────────────────────────────────────────
  Widget _repeatRow() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            const Text(
              'تكرار يومي',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            Switch(
              value: _dailyRepeat,
              onChanged: (v) => setState(() => _dailyRepeat = v),
              activeColor: Colors.white,
              activeTrackColor: _brandGreen,
            ),
          ],
        ),
      );

  // ── live preview ────────────────────────────────────────────────────────
  Widget _preview() => Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [_lightGreenBg, Colors.white],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _brandGreen.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'معاينة التذكير',
              style: TextStyle(fontSize: 11, color: Colors.black54),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: _availableColors[_selectedColor],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _availableIcons[_selectedIcon],
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
                        '${_timeController.text.isEmpty ? "12:00" : _timeController.text} '
                        '${_period == "صباحاً" ? "ص" : "م"}',
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  // ── cancel + save buttons ───────────────────────────────────────────────
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
              child: const Text(
                'إلغاء',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  // TODO Phase 2: build a Reminder object and
                  // Navigator.pop(context, reminder);
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _brandGreen,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'حفظ التذكير',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                ),
              ),
            ),
          ),
        ],
      );
}