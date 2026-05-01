import 'package:aqem/features/settings_screen/presentation/settings_list_tile.dart';
import 'package:flutter/material.dart';

class VersionTile extends StatelessWidget {
  const VersionTile({super.key});
  @override
  Widget build(BuildContext context) {
    return SettingsListTile(
        title: 'الإصدار',
        subTitle: 'إصدار التطبيق الحالي',
        iconData: Icons.info_outline,
        trailing: Container(
          padding: .only(top: 4,right: 12,left: 12,bottom: 3),
          decoration: BoxDecoration(
            color: .fromRGBO(157, 157, 157, 0.15),
            borderRadius: .circular(16),
          ),
          child: Text(
            '1.0.0',//todo
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'kitab',
              color: const Color(0x8F6B6B6B),

            ),
          ),
        ),
        onTap: (){});
  }
}
