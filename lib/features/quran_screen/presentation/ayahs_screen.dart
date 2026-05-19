import 'package:aqem/features/quran_screen/data/provider.dart';
import 'package:aqem/features/quran_screen/domain/surah_response.dart';
import 'package:aqem/features/surah-page/presentation/ayah_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AyahsScreen extends ConsumerWidget {
  const AyahsScreen({super.key, required this.surah});
  final SurahDetails surah;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ayahsResponse = ref.watch(ayahsProvider(surah.number));
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0D7E5E), Color(0xFF0D7E5E), Color(0xFF0A6349)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: DefaultTextStyle.merge(
                  style: TextStyle(color: Colors.white),
                  child: SafeArea(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        BackButton(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              surah.name,
                              style: const TextStyle(
                                fontSize: 28,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.visible,
                              textDirection: TextDirection.rtl,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 15),
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
    );
  }
}
