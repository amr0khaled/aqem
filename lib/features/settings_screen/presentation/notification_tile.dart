import 'package:aqem/features/settings_screen/presentation/settings_list_tile.dart';
import 'package:flutter/material.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({super.key});
  void _onNotificationTap(){
    //todo: add the logic of this tile here
}
  @override
  Widget build(BuildContext context) {
    return SettingsListTile(
        title: 'الإشعارات',
        subTitle: 'إدارة التنبيهات والإشعارات',
        iconData: Icons.notifications_none_outlined,
        onTap: _onNotificationTap);
  }
}
