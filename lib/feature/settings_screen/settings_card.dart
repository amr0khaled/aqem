import 'package:flutter/material.dart';

class SettingsCard extends StatelessWidget {
  const SettingsCard({super.key,required this.title,required this.settingsCardList});
  final String title;
  final List<Widget> settingsCardList;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 13,
      crossAxisAlignment: .start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 18),
          child: Text(title,
          style: TextStyle(
            fontFamily: 'kitab',
            fontSize: 12,
            color: .new(0xFF6B6B6B),
            fontWeight: .new(500)
          ),),
        ),
        Card(
          margin: .zero,
          clipBehavior: .antiAlias,
          shape: RoundedRectangleBorder(
              borderRadius: .circular(20)
          ),
          child: Column(
            mainAxisSize: .min,
            children: [
              ...settingsCardList.map((tile){
              return   Column(
                children: [
                  tile,
                  if(settingsCardList.last!=tile)
                  Divider(
                    color: Color.from(
                        red:Theme.of(context).colorScheme.inversePrimary.r  ,
                        green:Theme.of(context).colorScheme.inversePrimary.g ,
                        blue: Theme.of(context).colorScheme.inversePrimary.b ,
                        alpha: 0.1),
                    height: 0,
                    indent: 15,
                  )
                ],
              );
              }),
            ],
          ),
        ),
      ],
    );
  }
}
