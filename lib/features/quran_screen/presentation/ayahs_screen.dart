import 'package:aqem/features/quran_screen/data/provider.dart';
import 'package:aqem/features/surah-page/presentation/ayah_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AyahsScreen extends ConsumerWidget {
  const AyahsScreen({super.key, required this.surah});
  final int surah;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ayahsResponse = ref.watch(ayahsProvider(surah));
    return Scaffold(
      body: ListView(
        children: [
          Container(
            color: Colors.white,
            child: ayahsResponse.when(
              data: (data) {
                final ayahs = data.ayahs;
                return ListView.builder(
                  itemCount: ayahs.length,
                  itemBuilder: (c, i) {
                    return AyahListTile(
                      ayahText: ayahs[i].text,
                      number: ayahs[i].numberInSurah,
                    );
                  },
                );
              },
              error: (err, stack) => Center(child: Text('Error: $err')),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ),
        ],
      ),
    );
  }
}
