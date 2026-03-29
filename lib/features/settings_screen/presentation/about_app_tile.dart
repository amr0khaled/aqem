import 'package:aqem/features/settings_screen/presentation/settings_list_tile.dart';
import 'package:flutter/material.dart';

class AboutAppTile extends StatelessWidget {
  const AboutAppTile({super.key});
  void _onTap(){
    //todo
}
  @override
  Widget build(BuildContext context) {
    return SettingsListTile(
        title: 'عن التطبيق',
        subTitle: 'معلومات عن التطبيق',
        iconData: Icons.info_outline,
        onTap: _onTap);
  }
}
