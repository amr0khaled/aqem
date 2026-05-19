import 'package:flutter/material.dart';

/// Zoom controls with two circular buttons (zoom out / zoom in)
/// and a central display showing the current zoom level in pixels.
///
/// The [zoomValue] is a counter that will later be used to scale text size.
/// Pressing the zoom-out button decrements the value, and pressing the
/// zoom-in button increments it.
class ZoomControls extends StatelessWidget {
  /// Current zoom value (e.g. text size in px like 20).
  final int zoomValue;

  /// Called when the zoom-out button is pressed.
  final VoidCallback onZoomOut;

  /// Called when the zoom-in button is pressed.
  final VoidCallback onZoomIn;

  /// Minimum allowed zoom value.
  final int minValue;

  /// Maximum allowed zoom value.
  final int maxValue;

  /// Unit label displayed next to the value (e.g. "px").
  final String unit;

  const ZoomControls({
    super.key,
    required this.zoomValue,
    required this.onZoomOut,
    required this.onZoomIn,
    this.minValue = 10,
    this.maxValue = 40,
    this.unit = 'px',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Zoom-out button
        _ZoomButton(
          icon: Icons.zoom_out,
          onPressed: zoomValue > minValue ? onZoomOut : null,
          isEnabled: zoomValue > minValue,
        ),

        // Current zoom value display
        Container(
          width: 56.0,
          height: 32.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFFE0E0E0), width: 1.0),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            '$zoomValue$unit',
            style: const TextStyle(
              color: Color(0xFF424242),
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        // Zoom-in button
        _ZoomButton(
          icon: Icons.zoom_in,
          onPressed: zoomValue < maxValue ? onZoomIn : null,
          isEnabled: zoomValue < maxValue,
        ),
      ],
    );
  }
}

/// Private helper widget for a single circular zoom button.
class _ZoomButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final bool isEnabled;

  const _ZoomButton({
    required this.icon,
    required this.onPressed,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36.0,
      height: 36.0,
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        color: isEnabled ? const Color(0xFFE0E0E0) : const Color(0xFFF5F5F5),
        shape: BoxShape.circle,
        border: Border.all(
          color: isEnabled
              ? const Color(0xFFBDBDBD)
              : const Color(0xFFE0E0E0),
          width: 1.0,
        ),
        boxShadow: isEnabled
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 2.0,
                  offset: const Offset(0, 1),
                ),
              ]
            : [],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18.0),
          onTap: onPressed,
          child: Icon(
            icon,
            size: 20.0,
            color: isEnabled
                ? const Color(0xFF757575)
                : const Color(0xFFBDBDBD),
          ),
        ),
      ),
    );
  }
}
