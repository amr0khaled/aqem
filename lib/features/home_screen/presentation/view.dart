import 'package:aqem/features/home_screen/presentation/app_bar.dart';
import 'package:aqem/features/home_screen/presentation/nav_cards.dart';
import 'package:aqem/features/home_screen/presentation/aya_card.dart';
import 'package:aqem/features/home_screen/presentation/next_pray.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Material(
              color: Colors.transparent,
              child: Ink(
                height: 478,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(36),
                    bottomRight: Radius.circular(36),
                  ),
                  gradient: LinearGradient(
                    colors: [Color(0xff0d7e5e), Color(0xff0a6349)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: const HomeAppBar(),
              ),
            ),

            Padding(
              // top: 418 creates a 60px overlap area over the 478px background
              padding: const EdgeInsets.only(top: 150, left: 16.0, right: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const NextPray(),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: AyahCard(verse: verses[0]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: const NavCards(),
                  ),
                  const SizedBox(
                    height: 40,
                  ), // Gives extra scroll space at the very bottom
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
