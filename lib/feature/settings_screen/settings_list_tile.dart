import 'package:aqem/core/widgets/special_icon.dart';
import 'package:flutter/material.dart';

class SettingsListTile extends StatelessWidget {
  const SettingsListTile({super.key, required this.title, required this.subTitle, required this.iconData, this.trailing, required this.onTap, this.trailingTitle});
  final String title,subTitle;
  final String? trailingTitle;
  final IconData iconData;
  final Widget? trailing;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: .rtl,
      child: InkWell(
        onTap: onTap,
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
          trailing: trailing??SizedBox(
            width: 68.67,
            child: Row(
              mainAxisAlignment: .end,
              spacing: 12,
              children: [
                Text(trailingTitle??'',
                  style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'kitab',
                      color: .new(0xFF6B6B6B)
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 7.5),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                  ),
                )
              ],
            ),
          ),
          contentPadding: .symmetric(vertical: 0,horizontal: 16),
        ),
      ),
    );
  }
}
