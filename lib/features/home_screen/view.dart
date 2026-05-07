import 'package:aqem/features/home_screen/app_bar.dart';
import 'package:aqem/features/home_screen/presentation/next_pray.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: HomeAppBar(),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Material(
              color: Colors.transparent,
              child: Ink(
                height: 478,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(36),
                  gradient: LinearGradient(
                    colors: [Color(0xff0d7e5e), Color(0xff0a6349)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ).add(EdgeInsets.only(top: 32)),
            child: ListView(children: [NextPray()]),
          ),
        ],
      ),
    );
  }
}
