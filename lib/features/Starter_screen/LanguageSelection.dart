import 'package:flutter/material.dart';

class LanguageSelection extends StatefulWidget {
  const LanguageSelection({super.key});

  @override
  State<LanguageSelection> createState() => _LanguageSelectionScreen();
}

class _LanguageSelectionScreen extends State<LanguageSelection> {
  String selectedLanguage = 'Arabic';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 247, 244),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              Center(
                child: Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(23),
                    color: const Color.fromARGB(255, 13, 126, 94),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 2,
                        offset: Offset(1, 1),
                      )
                    ],
                  ),
                  padding: const EdgeInsets.all(10),
                  child: const Icon(Icons.language, size: 48, color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  'اختر اللغة',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
              ),
              const Center(
                child: Text(
                  'Select Your Preferred Language',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF666666),
                  ),
                ),
              ),
              const SizedBox(height: 40),

              _buildLanguageOption(
                icon: Icons.language,
                language: 'العربية',
                subLanguage: 'Arabic',
                isSelected: selectedLanguage == 'Arabic',
              ),
              const SizedBox(height: 16),
              _buildLanguageOption(
                icon: Icons.south_america,
                language: 'English',
                subLanguage: 'English',
                isSelected: selectedLanguage == 'English',
              ),

              const Spacer(),

              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/location');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 13, 126, 94),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(382, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
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

  Widget _buildLanguageOption({
    required IconData icon,
    required String language,
    required String subLanguage,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLanguage = subLanguage;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? const Color.fromARGB(255, 13, 126, 94)
                : Colors.white,
            width: 2,
          ),
        ),
        child: ListTile(
          leading: Icon(icon),
          title: Text(language),
          subtitle: Text(subLanguage),
          trailing: isSelected
              ? Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 13, 126, 94),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(4),
                  child: const Icon(Icons.check, size: 16, color: Colors.white),
                )
              : const SizedBox(),
          onTap: () {
            setState(() {
              selectedLanguage = subLanguage;
            });
          },
        ),
      ),
    );
  }
}