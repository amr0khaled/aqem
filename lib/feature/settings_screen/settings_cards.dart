import 'package:aqem/feature/settings_screen/about_app_tile.dart';
import 'package:aqem/feature/settings_screen/dark_mode_tile.dart';
import 'package:aqem/feature/settings_screen/drawing_type_tile.dart';
import 'package:aqem/feature/settings_screen/font_size_tile.dart';
import 'package:aqem/feature/settings_screen/language_tile.dart';
import 'package:aqem/feature/settings_screen/notification_tile.dart';
import 'package:aqem/feature/settings_screen/settings_card.dart';
import 'package:aqem/feature/settings_screen/version_tile.dart';
import 'package:flutter/material.dart';

class SettingsCards extends StatelessWidget {
  const SettingsCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: .rtl
      ,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: [
            SettingsCard(
                title: 'الإعدادات العامة',
                settingsCardList: [DarkModeTile(),LanguageTile(),NotificationTile()]
            ),
            SizedBox(
              height: 20,
            ),
            SettingsCard(
                title: 'إعدادات القراءة',
                settingsCardList: [DrawingTypeTile(),FontSizeTile()]),
            SizedBox(
              height: 20,
            ),
            SettingsCard(
                title: 'حول التطبيق',
                settingsCardList: [AboutAppTile(),VersionTile()]),
          ],

        ),
      ),
    );
  }
}
