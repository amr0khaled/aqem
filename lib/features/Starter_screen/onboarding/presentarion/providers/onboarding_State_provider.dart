import 'package:flutter_riverpod/legacy.dart';

import '../../data/onboarding_local_data_source.dart';
import 'onboarding_provider.dart';

final onboardingStateProvider =
    StateNotifierProvider<OnboardingNotifier, bool>((ref) {
  final dataSource = ref.watch(onboardingDataSourceProvider);
  return OnboardingNotifier(dataSource);
});

class OnboardingNotifier extends StateNotifier<bool> {
  final OnboardingLocalDataSource dataSource;

  OnboardingNotifier(this.dataSource) : super(false) {
    _load();
  }

  void _load() {
    state = dataSource.getSeen();
  }

  Future<void> markSeen() async {
    await dataSource.setSeen();
    state = true;
  }
}