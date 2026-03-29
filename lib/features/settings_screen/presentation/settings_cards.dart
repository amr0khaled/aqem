import 'package:aqem/features/settings_screen/presentation/about_app_tile.dart';
import 'package:aqem/features/settings_screen/presentation/dark_mode_tile.dart';
import 'package:aqem/features/settings_screen/presentation/drawing_type_tile.dart';
import 'package:aqem/features/settings_screen/presentation/font_size_tile.dart';
import 'package:aqem/features/settings_screen/presentation/language_tile.dart';
import 'package:aqem/features/settings_screen/presentation/notification_tile.dart';
import 'package:aqem/features/settings_screen/presentation/settings_card.dart';
import 'package:aqem/features/settings_screen/presentation/version_tile.dart';
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
