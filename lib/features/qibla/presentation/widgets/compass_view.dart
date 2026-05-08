import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CompassView extends StatelessWidget {
  final double compassAngle;

  final double arrowAngle;

  const CompassView({
    super.key,

    required this.compassAngle,

    required this.arrowAngle,
  });

  @override
  Widget build(BuildContext context) {
    const lineColor = Color(0xFFBDBEB9);

    return Stack(
      alignment: Alignment.center,

      children: [
        Transform.rotate(
          angle: compassAngle,

          child: Container(
            width: 320,

            height: 320,

            decoration: BoxDecoration(
              shape: BoxShape.circle,

              color: const Color(0xFFF4F5F4),

              border: Border.all(color: Color(0xFFEEF3EE), width: 6),

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),

                  blurRadius: 16,

                  spreadRadius: 2,

                  offset: const Offset(0, 12),
                ),
              ],
            ),

            child: Stack(
              alignment: Alignment.center,

              children: [
                const Positioned(
                  top: 28,

                  child: Text("شمال", style: TextStyle(color: lineColor)),
                ),

                const Positioned(
                  bottom: 28,

                  child: Text("جنوب", style: TextStyle(color: lineColor)),
                ),

                const Positioned(
                  right: 28,

                  child: Text("شرق", style: TextStyle(color: lineColor)),
                ),

                const Positioned(
                  left: 28,

                  child: Text("غرب", style: TextStyle(color: lineColor)),
                ),

                ...List.generate(4, (i) {
                  final angle = (i * 90 + 45) * pi / 180;

                  final radius = 125;

                  return Positioned(
                    left: 160 + radius * cos(angle) - 6,

                    top: 160 + radius * sin(angle) - 6,

                    child: Container(
                      width: 14,

                      height: 14,

                      decoration: const BoxDecoration(
                        color: lineColor,

                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                }),

                ...List.generate(4, (i) {
                  return Transform.rotate(
                    angle: i * pi / 2,

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Container(width: 3, height: 24, color: lineColor),

                        Container(width: 3, height: 24, color: lineColor),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),

        Transform.rotate(
          angle: arrowAngle,

          child: const Icon(Icons.navigation, color: Colors.red, size: 45),
        ),

        Center(
          child: SizedBox(
            width: 150,

            height: 150,

            child: SvgPicture.asset("assets/icons/Qibla.svg"),
          ),
        ),
      ],
    );
  }
}


