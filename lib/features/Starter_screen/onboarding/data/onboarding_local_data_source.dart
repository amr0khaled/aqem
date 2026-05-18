import 'package:shared_preferences/shared_preferences.dart';

class OnboardingLocalDataSource {
  static const _key = 'seen_onboarding';

  final SharedPreferences prefs;

  OnboardingLocalDataSource(this.prefs);

  bool getSeen() {
    return prefs.getBool(_key) ?? false;
  }

  Future<void> setSeen() async {
    await prefs.setBool(_key, true);
  }
}