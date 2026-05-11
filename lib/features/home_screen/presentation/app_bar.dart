import 'package:flutter/material.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBar();
  @override
  Size get preferredSize => Size.fromHeight(90);
}

class _HomeAppBar extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(color: Colors.transparent),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultTextStyle.merge(
              style: TextStyle(color: Colors.white),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("المصحف الشريف", style: TextStyle(fontSize: 36)),
                  Text(
                    "السلام عليكم ورحمة الله",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.mode_night_outlined),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.settings_outlined),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
