import 'package:aqem/feature/settings_screen/settings_list_tile.dart';
import 'package:flutter/material.dart';

class DrawingTypeTile extends StatelessWidget {
  const DrawingTypeTile({super.key});
  void onDrawingTap(){
    //todo add the logic of this tile here
  }
  @override
  Widget build(BuildContext context) {
    return  SettingsListTile(
        title: 'نوع الرسم',
        subTitle: 'اختيار طريقة رسم المصحف',
        iconData: Icons.menu_book,
        trailingTitle: 'عثماني', //todo
        onTap: onDrawingTap
    );
  }
}
