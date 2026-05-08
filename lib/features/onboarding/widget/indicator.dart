import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  final int index;
  final Color activeColor;
  final int length;

  const Indicator({
    super.key,
    required this.index,
    required this.activeColor,
    this.length = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(length, (i) {
        final isActive = i == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 22 : 6,
          height: 6,
          decoration: BoxDecoration(
            color: isActive ? activeColor : const Color(0xFFE6E6E6),
            borderRadius: BorderRadius.circular(10),
          ),
        );
      }),
    );
  }
}