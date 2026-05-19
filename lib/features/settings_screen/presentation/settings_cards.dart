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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff0d7e5e), Color(0xff0a6349)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(color: Colors.transparent),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.arrow_back, size: 16),
                    ),
                  ),
                  DefaultTextStyle.merge(
                    style: TextStyle(color: Colors.white),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("الإعدادات", style: TextStyle(fontSize: 24)),
                        Text(
                          "تخصيص تجربتك",
                          style: TextStyle(fontSize: 12, color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ).add(const EdgeInsets.only(top: 32)),
        child: ListView(
          children: [
            SettingsCard(
              title: 'الإعدادات العامة',
              settingsCardList: [
                DarkModeTile(),
                LanguageTile(),
                NotificationTile(),
              ],
            ),
            SizedBox(height: 20),
            SettingsCard(
              title: 'إعدادات القراءة',
              settingsCardList: [DrawingTypeTile(), FontSizeTile()],
            ),
            SizedBox(height: 20),
            SettingsCard(
              title: 'حول التطبيق',
              settingsCardList: [AboutAppTile(), VersionTile()],
            ),
          ],
        ),
      ),
    );
  }
}
