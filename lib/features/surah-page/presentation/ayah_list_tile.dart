import 'package:flutter/material.dart';

class AyahListTile extends StatefulWidget {
  const AyahListTile({super.key, required this.ayahText, required this.number});
  final String ayahText;
  final int number;

  @override
  State<AyahListTile> createState() => _AyahListTileState();
}

class _AyahListTileState extends State<AyahListTile> {
  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.brightnessOf(context) == Brightness.dark;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      color: isDark ? Colors.grey.shade900 : Colors.white,
      child: Material(
        color: Colors.transparent,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                widget.ayahText,
                style: TextStyle(
                  fontFamily: "Kitab",
                  letterSpacing: 1.8,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.clip,
              ),
            ),
            trailing: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: isDark ? Colors.black87 : Colors.white38,
                    offset: Offset(0, 2),
                    blurRadius: 2,
                  ),
                ],
                gradient: LinearGradient(
                  colors: [Color(0xff0c7c5c), Color(0xff096248)],
                  begin: AlignmentDirectional.topCenter,
                  end: AlignmentDirectional.bottomCenter,
                ),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  widget.number.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
