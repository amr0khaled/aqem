import 'package:flutter/material.dart';

/// A language selector dropdown that displays the currently selected language
/// with a globe/language icon and a dropdown chevron.
///
/// When tapped, it shows a popup menu with available languages.
/// The selected language text is displayed in dark gray.
class LanguageDropdown extends StatelessWidget {
  /// The list of available languages to choose from.
  /// Each entry is a map with 'code' and 'name' keys.
  /// Example: [{'code': 'ar', 'name': 'العربية'}, {'code': 'en', 'name': 'English'}]
  final List<LanguageItem> languages;

  /// The code of the currently selected language.
  final String selectedLanguageCode;

  /// Called when a new language is selected.
  final ValueChanged<String> onLanguageChanged;

  const LanguageDropdown({
    super.key,
    required this.languages,
    required this.selectedLanguageCode,
    required this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final LanguageItem selectedItem = languages.firstWhere(
      (item) => item.code == selectedLanguageCode,
      orElse: () => languages.isNotEmpty
          ? languages.first
          : LanguageItem(code: '', name: ''),
    );

    return PopupMenuButton<String>(
      offset: const Offset(0, 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      elevation: 4,
      onSelected: onLanguageChanged,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: Colors.transparent),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Language icon
            const Icon(Icons.language, size: 18.0, color: Color(0xFF757575)),
            const SizedBox(width: 6.0),

            // Current language name
            Text(
              selectedItem.name ?? "",
              style: const TextStyle(
                color: Color(0xFF212121),
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(width: 4.0),

            // Dropdown chevron
            const Icon(
              Icons.keyboard_arrow_down,
              size: 18.0,
              color: Color(0xFF757575),
            ),
          ],
        ),
      ),
      itemBuilder: (BuildContext context) {
        return languages.map((LanguageItem item) {
          final bool isSelected = item.code == selectedLanguageCode;
          return PopupMenuItem<String>(
            value: item.code,
            height: 40.0,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    item.name,
                    style: TextStyle(
                      color: isSelected
                          ? const Color(0xFF2E7D32)
                          : const Color(0xFF212121),
                      fontSize: 14.0,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                ),
                if (isSelected)
                  const Icon(Icons.check, size: 18.0, color: Color(0xFF2E7D32)),
              ],
            ),
          );
        }).toList();
      },
    );
  }
}

/// Data model for a language item in the dropdown.
class LanguageItem {
  /// Short language code (e.g. 'ar', 'en', 'fr').
  final String code;

  /// Display name of the language in its own script (e.g. 'العربية', 'English').
  final String name;

  const LanguageItem({required this.code, required this.name});
}
