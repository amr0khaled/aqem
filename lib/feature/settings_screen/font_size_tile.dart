import 'package:aqem/feature/settings_screen/settings_list_tile.dart';
import 'package:flutter/material.dart';

class FontSizeTile extends StatelessWidget {
  const FontSizeTile({super.key});
  void _onReadFontTap(){
    //todo
  }
  @override
  Widget build(BuildContext context) {
    return SettingsListTile(
        title: 'حجم الخط',
        subTitle: 'تكبير أو تصغير النص',
        trailingTitle: 'متوسط', //todo
        iconData: Icons.color_lens_outlined,
        onTap: _onReadFontTap);
  }
}
