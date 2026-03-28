import 'package:aqem/feature/settings_screen/settings_list_tile.dart';
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
          scale:44/59,
          child: Switch( //todo***********************************
            value: _darkMode,
            onChanged: (_){_changeThemeMode();},
            // inactiveTrackColor: Colors.transparent,
          ))
      , onTap: _changeThemeMode,
    );
  }
}
