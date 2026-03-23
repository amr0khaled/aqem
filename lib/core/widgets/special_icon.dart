import 'package:flutter/material.dart';

class SpecialIcon extends StatelessWidget {
  const SpecialIcon({super.key,required this.content,this.padding=14,this.borderRadius=24, this.color,this.gradientFlag=true,this.shadowFlag=true});
  final Widget content;
  final double padding, borderRadius;
  final Color? color;
  final bool gradientFlag,shadowFlag;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all((padding)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          gradient: LinearGradient(
              colors: [color??Theme.of(context).colorScheme.inversePrimary,
                Color.from(alpha:1,
                    red: (color?.r ?? Theme.of(context).colorScheme.inversePrimary.r)*(gradientFlag?0.9:1),
                    green:  (color?.g ?? Theme.of(context).colorScheme.inversePrimary.g)*(gradientFlag?0.9:1),
                    blue:  (color?.b ?? Theme.of(context).colorScheme.inversePrimary.b)*(gradientFlag?0.9:1)
                )
              ]
          ),
          boxShadow: shadowFlag?[
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
          ]:null
      ),
      child: content,
    );
  }
}