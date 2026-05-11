import 'package:flutter/material.dart';
import 'language_card.dart';
import 'language_dropdown.dart';
import 'zoom_controls.dart';

/// A toolbar row that combines the LanguageCard, LanguageDropdown,
/// and ZoomControls into a single horizontal bar.
///
/// This matches the layout from the design image 2:
/// [عربي green card] [العربية dropdown ▼] ......... [zoom-] [20px] [zoom+]
class ReaderToolbar extends StatelessWidget {
  /// Current language text shown on the green card (short form, e.g. "عربي").
  final String currentLanguageShort;

  /// List of available languages for the dropdown.
  final List<LanguageItem> languages;

  /// Currently selected language code.
  final String selectedLanguageCode;

  /// Called when a language is changed from the dropdown.
  final ValueChanged<String> onLanguageChanged;

  /// Current zoom value.
  final int zoomValue;

  /// Called when zoom-out is pressed.
  final VoidCallback onZoomOut;

  /// Called when zoom-in is pressed.
  final VoidCallback onZoomIn;

  /// Minimum zoom value.
  final int minZoom;

  /// Maximum zoom value.
  final int maxZoom;

  const ReaderToolbar({
    super.key,
    required this.currentLanguageShort,
    required this.languages,
    required this.selectedLanguageCode,
    required this.onLanguageChanged,
    required this.zoomValue,
    required this.onZoomOut,
    required this.onZoomIn,
    this.minZoom = 10,
    this.maxZoom = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFFE0E0E0),
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        children: [
          // Green language card
          LanguageCard(
            languageText: currentLanguageShort,
            onTap: () {
              // Optional: cycle to next language or open a full picker
            },
          ),

          const SizedBox(width: 12.0),

          // Language dropdown
          LanguageDropdown(
            languages: languages,
            selectedLanguageCode: selectedLanguageCode,
            onLanguageChanged: onLanguageChanged,
          ),

          const Spacer(),

          // Zoom controls
          ZoomControls(
            zoomValue: zoomValue,
            onZoomOut: onZoomOut,
            onZoomIn: onZoomIn,
            minValue: minZoom,
            maxValue: maxZoom,
          ),
        ],
      ),
    );
  }
}
