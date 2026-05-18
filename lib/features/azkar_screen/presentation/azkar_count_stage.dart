import 'package:aqem/features/azkar/presentation/azkar_count_widget.dart';
import 'package:aqem/features/azkar/data/dua_data.dart';
import 'package:flutter/material.dart';

class AzkarCountStage extends StatelessWidget {
  AzkarCountStage({super.key,
    required this.firstWidgetTitle,
    required this.firstWidgetNumber,
    required this.completedNumber,
    required this.favouriteNumber
  ,});
  String firstWidgetTitle;
  int firstWidgetNumber,completedNumber,favouriteNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .only(top: 16,bottom: 32),
      decoration: BoxDecoration(
          gradient: LinearGradient(colors:
          [Color(0xFF0D7E5E),Color(0xFF0A6349)],
            begin: .topCenter,
            end: .bottomCenter,
          )
      ),
      child: Row(
        spacing: 12,
        mainAxisSize: .max,
        mainAxisAlignment: .center,
        children: [
          AzkarCountWidget(title: firstWidgetTitle, count: firstWidgetNumber),
          AzkarCountWidget(title: 'مكتملة اليوم', count:completedNumber),
          AzkarCountWidget(title: 'المفضلة', count: favouriteNumber),
        ],
      ),
    );
  }
}
