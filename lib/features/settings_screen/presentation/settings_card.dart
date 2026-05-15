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
            fontSize: 13,
            color: const .new(0xFF6B6B6B),
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
                    color: Theme.of(context).colorScheme.inversePrimary.withValues(alpha: 0.1),
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
