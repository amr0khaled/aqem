import 'package:aqem/core/widgets/special_icon.dart';
import 'package:flutter/material.dart';

class SettingsListTile extends StatelessWidget {
  const SettingsListTile({super.key, required this.title, required this.subTitle, required this.iconData, required this.trailing});
  final String title,subTitle;
  final IconData iconData;
  final Widget trailing;
  
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: .rtl,
      child: ListTile(
        horizontalTitleGap: 12,
        // tileColor: Colors.orange,//////////////////////////////todo
        leading: SpecialIcon(
          content: Icon(iconData,
            color: Theme.of(context).colorScheme.inversePrimary,
            size: 20,
          ),
          padding: 10,
          borderRadius: 40,
          gradient: LinearGradient(
            colors: [
            Color.fromRGBO(13, 126, 94, 0.1),
            Color.fromRGBO(212, 175, 55, 0.1)
          ],
            begin: .topCenter,
            end: .bottomCenter,
          ),
          shadowFlag: true,

        ),
        title: Text(title,
          style: TextStyle(fontFamily: 'kitab'),
        ),
        subtitle: Text(subTitle,
            style: TextStyle(fontFamily: 'kitab',fontSize: 12,color: Color(0xFF6B6B6B))),
        trailing: trailing,
        contentPadding: .symmetric(vertical: 0,horizontal: 16),
      ),
    );
  }
}
