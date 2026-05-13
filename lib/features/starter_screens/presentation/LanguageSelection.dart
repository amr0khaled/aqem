import 'package:flutter/material.dart';
class LanguageSelection extends StatefulWidget {
  const LanguageSelection({super.key});
  @override
  // ignore: library_private_types_in_public_api
  LanguageSelectionScreen createState() => LanguageSelectionScreen();
}
class LanguageSelectionScreen extends State<LanguageSelection> {
  String selectedLanguage = 'Arabic';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 247, 244),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              buildIconContainer(icon: Icons.language),
              SizedBox(height: 10),
              Center(
                child: const Text(
                  'اختر اللغة',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
              ),
              Center(
                child: const Text(
                  'Select Your Preferred Language',
                  style: TextStyle(fontSize: 16, color: Color(0xFF666666)),
                ),
              ),
              const SizedBox(height: 40),
              buildLanguageOption(
                icon: Icon(Icons.language),
                language: 'العربية',
                subLanguage: 'Arabic',
                isSelected: selectedLanguage == 'Arabic',
                selectable: true
              ),
              const SizedBox(height: 16),
              buildLanguageOption(
                icon: Icon(Icons.south_america),
                language: 'English',
                subLanguage: 'English',
                isSelected: selectedLanguage == 'English',
                selectable: true
              ),
              const Spacer(),
              // Continue button
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 13, 126, 94),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(382, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 2,
                  ),
                  child: const Text(
                    'متابعة',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIconContainer({required IconData icon}) {
    return Center(
      child: Container(
        width: 96,
        height: 96,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(23),
          color: Color.fromARGB(255, 13, 126, 94),
          shape: BoxShape.rectangle,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 2,
              offset: const Offset(1, 1),
            ),
          ],
        ),
        padding: EdgeInsets.all(10),
        child: Icon(icon, size: 48, color: Colors.white),
      ),
    );
  }

  Widget buildLanguageOption({
    required Icon icon,
    required String language,
    required String subLanguage,
    required bool isSelected,
    required bool selectable,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLanguage = subLanguage;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          gradient: selectable
              ? (isSelected
                    ? const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 227, 255, 246),
                          Color(0xFFFFFFFF),
                        ],
                      )
                    : null)
              : null,
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? Color.fromARGB(255, 13, 126, 94)
                : const Color(0xFFFFFFFF),
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 2,
                    offset: const Offset(2, 2),
                  ),
                ]
              : [],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          leading: selectable
              ? Icon(icon.icon)
              : Container(
            height: 30,
            width: 30,
            child: Icon(icon.icon ,color: Color.fromARGB(255, 13, 126, 94),),// special icon
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(255, 241, 255, 251),
              shape: BoxShape.rectangle,

            ),
          ),
          title: Text(
            language,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
            ),
          ),
          subtitle: Text(
            subLanguage,
            style: TextStyle(fontSize: 14, color: Color(0xFF666666)),
          ),
          trailing: selectable?(isSelected
              ? Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 13, 126, 94),
                    shape: BoxShape.circle,
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 2,
                              offset: const Offset(1, 1),
                            ),
                          ]
                        : [],
                  ),

                  padding: EdgeInsets.all(4),
                  child: Icon(Icons.check, size: 16, color: Colors.white),
                )
              : SizedBox()): SizedBox(),
          onTap: () {
            setState(() {
              selectable?selectedLanguage = subLanguage:null;
            });
          },
        ),
      ),
    );
  }
}
