import 'package:flutter/material.dart';

class SurahSelection extends StatefulWidget {
  int selectedButton = 1;
  @override
  _SurahSelectionScreen createState() => _SurahSelectionScreen();
}

class _SurahSelectionScreen extends State<SurahSelection> {
  int selectedButton = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 247, 244),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            SizedBox.fromSize(
              size: Size.fromHeight(57),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 2,
                      offset: const Offset(2, 2),
                    ),
                  ],
                  color: Colors.white,
                ),

                child: Theme(
                  data: ThemeData(
                    elevatedButtonTheme: ElevatedButtonThemeData(
                      style: ButtonStyle(
                        padding: WidgetStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 12),
                        ),
                        backgroundColor: WidgetStateProperty.resolveWith((w) {
                          return w.contains(WidgetState.selected)
                              ? Color.fromARGB(255, 13, 126, 94)
                              : Color.fromARGB(255, 248, 247, 244);
                        }),
                        foregroundColor: WidgetStateProperty.resolveWith((w) {
                          return w.contains(WidgetState.selected)
                              ? Colors.white
                              : Color.fromARGB(255, 26, 26, 26);
                        }),
                        minimumSize: WidgetStatePropertyAll(
                          const Size(100, 32),
                        ),
                        shape: WidgetStateProperty.resolveWith((w) {
                          Color color = w.contains(WidgetState.selected)
                              ? Color.fromARGB(255, 13, 126, 94)
                              : Color.fromARGB(255, 248, 247, 244);
                          return RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                            side: BorderSide(color: color, width: .1),
                          );
                        }),
                        elevation: WidgetStatePropertyAll(1),
                      ),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 20),
                      ElevatedButton(
                        statesController: WidgetStatesController(() {
                          if (selectedButton == 1) {
                            return {WidgetState.selected};
                          } else {
                            return null;
                          }
                        }()),
                        onPressed: () {
                          setState(() {
                            selectedButton = 1;
                          });
                        },
                        child: const Text(
                          ' الكل',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(width: 17),
                      ElevatedButton(
                        statesController: WidgetStatesController(() {
                          if (selectedButton == 2) {
                            return {WidgetState.selected};
                          } else {
                            return null;
                          }
                        }()),
                        onPressed: () {
                          setState(() {
                            selectedButton = 2;
                          });
                        },
                        child: const Text(
                          'مكية     86',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 17),
                      ElevatedButton(
                        statesController: WidgetStatesController(() {
                          if (selectedButton == 3) {
                            return {WidgetState.selected};
                          } else {
                            return null;
                          }
                        }()),
                        onPressed: () {
                          setState(() {
                            selectedButton = 3;
                          });
                        },
                        child: const Text(
                          'مدنية     28',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      // const SizedBox(width: 20),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox.fromSize(
              size: Size.fromHeight(145),
              child: Container(
                constraints: BoxConstraints.expand(height: 174),
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildNumberBox(
                      icon: Icons.auto_stories_outlined,
                      text: "سورة",
                      number: "114",
                      teal: true,
                    ),
                    _buildNumberBox(
                      icon: Icons.star_border,
                      text: "اية",
                      number: "6236",
                      teal: false,
                    ),
                    _buildNumberBox(
                      icon: Icons.bookmark_border_outlined,
                      text: "صفحة",
                      number: "604",
                      teal: true,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            _buildSurahOption(
              arabName: 'الفاتحة',
              engName: 'Al-Fatihah · 7 آية',
              num: 1,
              makkiyah: true,
            ),
            const SizedBox(height: 16),
            _buildSurahOption(
              arabName: 'البقرة',
              engName: 'Al-Baqarah · 286 آية',
              num: 2,
              makkiyah: false,
            ),

            const Spacer(),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSurahOption({
    required String arabName,
    required String engName,
    required int num,
    required bool makkiyah,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        // padding: const EdgeInsets.symmetric(horizontal: 16, vertical:5),
        height: 90,
        width: 390,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: .5,
              offset: const Offset(.5, .5),
            ),
          ],
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          leading: Container(
            height: 20,
            width: 42,
            alignment: Alignment.center,
            child: makkiyah
                ? Text(
                    "مكية",
                    style: TextStyle(
                      color: Color.fromARGB(255, 13, 126, 94),
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  )
                : Text(
                    "مدنية",
                    style: TextStyle(
                      color: Color.fromARGB(255, 212, 175, 55),
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: makkiyah
                  ? Color.fromARGB(50, 13, 126, 94)
                  : Color.fromARGB(50, 212, 175, 55),
            ),
          ),
          title: Text(
            arabName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
            ),
          ),
          subtitle: Text(
            engName,
            style: const TextStyle(fontSize: 12, color: Color(0xFF666666)),
          ),
          trailing: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                child: Icon(
                  Icons.star,
                  color: makkiyah
                      ? Color.fromARGB(50, 13, 126, 94)
                      : Color.fromARGB(50, 212, 175, 55),
                  size: 40,
                  semanticLabel: num.toString(),
                ),
              ),
              Text(
                num.toString(),
                style: TextStyle(
                  fontSize: 12,
                  color: makkiyah
                      ? Color.fromARGB(255, 13, 126, 94)
                      : Color.fromARGB(255, 212, 175, 55),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),

          onTap: () {},
        ),
      ),
    );
  }

  Widget _buildNumberBox({
    required IconData icon,
    required String text,
    required String number,
    required bool teal,
  }) {
    Color foreground = teal
        ? Color.fromARGB(255, 13, 126, 94)
        : Color.fromARGB(255, 212, 175, 55);
    Color background = teal
        ? Color.fromARGB(50, 13, 126, 94)
        : Color.fromARGB(255, 212, 175, 55);
    List<Color> gradient = teal
        ? [Color.fromARGB(40, 13, 126, 94), Color.fromARGB(40, 98, 179, 156)]
        : [Color.fromARGB(40, 212, 175, 55), Color.fromARGB(40, 244, 229, 194)];
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: background, width: .1),
      ),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 22),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 2.5),
            child: Icon(icon, color: foreground, size: 20),
          ),
          SizedBox(height: 12),
          Text(
            number,
            style: TextStyle(fontSize: 18, color: foreground),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: Color.fromARGB(255, 107, 107, 107),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
