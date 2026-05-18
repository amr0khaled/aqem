import 'package:aqem/core/theme/App_Color.dart'; 
import 'package:flutter/material.dart'; 

class CircleWidget extends StatelessWidget {
  final double size;
  final double opacity;
  final Color color;

  const CircleWidget({
    super.key,
    required this.size,
    this.opacity = 0.1,
    this.color = AppColors.gold,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: color.withValues(alpha: opacity),
          width: 2,
        ),
      ),
    );
  }
}