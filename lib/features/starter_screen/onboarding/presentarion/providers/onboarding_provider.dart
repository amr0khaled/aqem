import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/providers/shared_prefs_provider.dart';
import '../../data/onboarding_local_data_source.dart';

final onboardingDataSourceProvider =
    Provider<OnboardingLocalDataSource>((ref) {
  final prefs = ref.watch(sharedPrefsProvider);
  return OnboardingLocalDataSource(prefs);
});