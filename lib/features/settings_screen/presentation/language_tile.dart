import 'package:aqem/features/settings_screen/presentation/settings_list_tile.dart';
import 'package:flutter/material.dart';

class LanguageTile extends StatelessWidget {
  const LanguageTile({super.key});
  void _onLanguageTap(){
    //todo: do the language logic here
  }
  @override
  Widget build(BuildContext context) {
    return SettingsListTile(
        title: 'اللغة',
        subTitle: 'تغيير لغة التطبيق',
        iconData: Icons.language,
        trailingTitle: 'العربية',
        onTap: _onLanguageTap);
  }
}
