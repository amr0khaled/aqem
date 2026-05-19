import 'package:aqem/core/widgets/special_icon.dart';
import 'package:aqem/features/home_screen/presentation/next_pray_small_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/provider.dart';

class NextPray extends ConsumerWidget {
  const NextPray({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prayerState = ref.watch(prayerProvider);
    final remainingText = ref.watch(remainingTextProvider);

    if (prayerState.isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(
              "جاري تحميل أوقات الصلاة...",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ],
        ),
      );
    }
    if (prayerState.prayers.isEmpty) {
      return const Center(
        child: Text(
          "لا توجد بيانات",
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
      );
    }
    if (prayerState.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text("خطأ: ${prayerState.error}"),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.invalidate(prayerProvider);
              },
              child: const Text("إعادة المحاولة"),
            ),
          ],
        ),
      );
    }
    return DefaultTextStyle(
      style: TextStyle(color: Colors.black),
      child: SizedBox.fromSize(
        size: Size.fromHeight(267),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 1st item (details)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SpecialIcon(
                        scale: 1.3,
                        borderRadius: 155,
                        gradientFlag: true,
                        gradient: LinearGradient(
                          colors: [Color(0xff0d7e5e), Color(0xff0a6349)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        content: Icon(
                          Icons.access_time_outlined,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "الصلاة القادمة",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'kitab',
                              ),
                            ),
                            Text(
                              prayerState.nextPrayer?.name ?? "",
                              style: TextStyle(
                                fontSize: 24,
                                fontFamily: 'kitab',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        prayerState.nextPrayer?.time ?? "",
                        style: TextStyle(
                          fontSize: 30,
                          color: Color(0xff0D7E5E),
                        ),
                      ),
                      Text(remainingText, style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
              // 2nd item (progress)
              LinearProgressIndicator(
                backgroundColor: Color(0xffE8E6E1),
                color: Color(0xff0D7E5E),
                value: prayerState.progress,
                minHeight: 6,
              ),

              // 3rd item (next prayers)
              Column(
                children: [
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: prayerState.prayers.map((p) {
                        return NextPrayerTimeCard(prayer: p);
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
