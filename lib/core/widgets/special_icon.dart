import 'package:flutter/material.dart';

class SpecialIcon extends StatelessWidget {
  SpecialIcon({super.key,required this.icon,this.padding=14,this.borderRadius=24, this.color});
  final Icon icon;
  final double padding, borderRadius;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all((padding)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          gradient: LinearGradient(
              colors: [color??Theme.of(context).colorScheme.inversePrimary,
                Color.from(alpha:1,
                    red: (color?.r ?? Theme.of(context).colorScheme.inversePrimary.r)*0.9,
                    green:  (color?.g ?? Theme.of(context).colorScheme.inversePrimary.g)*0.9,
                    blue:  (color?.b ?? Theme.of(context).colorScheme.inversePrimary.b)*0.9
                )
              ]
          ),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                blurRadius: 6,
                spreadRadius: -4,
                offset: Offset(0, 4)
            ),
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                blurRadius: 15,
                spreadRadius: -3,
                offset: Offset(0, 10)
            ),
          ]
      ),
      child: icon,
    );
  }
}