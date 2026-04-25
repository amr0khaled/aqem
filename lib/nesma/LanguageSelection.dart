import 'package:flutter/material.dart';
class LanguageSelection extends StatefulWidget{
  const LanguageSelection({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LanguageSelectionScreen createState()=>
      _LanguageSelectionScreen();
}
class _LanguageSelectionScreen extends State<LanguageSelection>{
  String selectedLanguage='Arabic';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 247, 244) ,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              Center(
                child: const Text(
                  'اختر اللغة',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A1A),
                  ),
                ),),
              Center(
                child: const Text(
                  'Select Your Preferred Language',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF666666),
                  ),
                ),),
              const SizedBox(height: 40),
              _buildLanguageOption(
                icon: Icon(Icons.language) ,
                language: 'العربية',
                subLanguage: 'Arabic',
                isSelected: selectedLanguage=='Arabic',
              ),
              const SizedBox(height: 16),
              _buildLanguageOption(
                icon: Icon(Icons.location_city),
                language: 'English',
                subLanguage: 'English',
                isSelected: selectedLanguage=='English',
              ),
              const Spacer(),
              // Continue button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle continue action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 13, 126, 94),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(382, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'متابعة',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }Widget _buildLanguageOption({
    required Icon icon,
    required String language,
    required String subLanguage,
    required bool isSelected,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? const Color.fromARGB(255, 13, 126, 94) : const Color(0xFFFFFFFF),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(20),
        color: isSelected ?  Color.fromARGB(255, 243, 247, 246): const Color(0xFFFFFFFF),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading:icon,
        title: Text(
          language,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A1A1A),
          ),
        ),
        subtitle: Text(
          subLanguage,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF666666),
          ),
        ),
        trailing:
        Radio<String>(
          value: subLanguage,
          groupValue: selectedLanguage,
          onChanged: (value) {
            setState((){
              selectedLanguage=subLanguage;

            });
          },
          activeColor: const Color.fromARGB(255, 13, 126, 94),
        ),
        onTap: () {
          setState(() {
            selectedLanguage= subLanguage;

          });

        },
      ),
    );
  }
}