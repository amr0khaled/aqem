import 'package:flutter/material.dart';

/// A green card chip that displays the current language name.
///
/// This is a rounded rectangle with a forest green background and
/// white text, typically placed next to the language dropdown.
class LanguageCard extends StatelessWidget {
  /// The language text to display (e.g. "عربي").
  final String languageText;

  /// Background color of the card. Defaults to the same green as the AppBar.
  final Color backgroundColor;

  /// Callback when the card is tapped.
  final VoidCallback? onTap;

  const LanguageCard({
    super.key,
    required this.languageText,
    this.backgroundColor = const Color(0xFF2E7D32),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 4.0,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            languageText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
