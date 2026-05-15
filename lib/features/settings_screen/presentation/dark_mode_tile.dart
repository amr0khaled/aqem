import 'package:aqem/features/settings_screen/presentation/settings_list_tile.dart';
import 'package:flutter/material.dart';

class DarkModeTile extends StatefulWidget {
  const DarkModeTile({super.key});

  @override
  State<DarkModeTile> createState() => _DarkModeTileState();
}

class _DarkModeTileState extends State<DarkModeTile> {
  bool _darkMode=false;//todo*******************************
  void _changeThemeMode(){
    setState(() {
      _darkMode=!_darkMode;
      //todo************************************************
    });
 }
  @override
  Widget build(BuildContext context) {
    return SettingsListTile(
      title: 'الوضع الليلي',
      subTitle: 'تبديل بين الوضع الفاتح والداكن',
      iconData: Icons.dark_mode_outlined,
      trailing: Transform.scale(
          scale:43/59,
          child: Switch(
            padding: .zero,//todo***********************************
            value: _darkMode,
            inactiveThumbColor: Colors.white.withValues(alpha: 0.8),
            activeTrackColor: Theme.of(context).colorScheme.inversePrimary,
            trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
            onChanged: (_){_changeThemeMode();},
          ))
      , onTap: _changeThemeMode,
    );
  }
}
