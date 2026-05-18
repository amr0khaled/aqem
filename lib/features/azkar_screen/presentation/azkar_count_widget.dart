import 'package:flutter/material.dart';

class AzkarCountWidget extends StatelessWidget {
  AzkarCountWidget({super.key,
    required this.title,
    required this.count});
  int count;
  String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 117,
      height: 76,
      alignment: .center,
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: .circular(20)

      ),
      child: Column(
        mainAxisSize: .min,
        spacing: 5,
        children: [
          Text('$count',
              style: const TextStyle(
                fontSize: 24,
                height: 1.3,
                fontFamily: 'kitab',
                color: Colors.white),
              ),
          Text(title,
            style: TextStyle(
                fontSize: 12,
                height: 1.3,
                fontFamily: 'kitab',
                color: Color.fromRGBO(255, 255, 255, 0.8)),
            ),
        ],
      ),
    );
  }
}
