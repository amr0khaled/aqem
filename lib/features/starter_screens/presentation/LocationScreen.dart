import 'package:aqem/nesma/LanguageSelection.dart';
import 'package:flutter/material.dart';

class LocationScreen extends StatelessWidget {
  LanguageSelectionScreen lang = LanguageSelectionScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 247, 244),
      appBar: AppBar( backgroundColor: Color.fromARGB(255, 248, 247, 244),),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            lang.buildIconContainer(icon: Icons.location_on_outlined),
              SizedBox(height: 10),
              Center(
                child: const Text(
                  'تحديد الموقع',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
              ),
              Center(
                child: const Text(
                  ' نحتاج الي موقعك لححساب اوقات الصلاة الدقيقة في منطقتك واظهار المساجد القريبه منك',
                  style: TextStyle(fontSize: 13, color: Color(0xFF666666)),
                ),
              ),
              const SizedBox(height: 40),
               lang.buildLanguageOption(
                icon: Icon(Icons.location_on_outlined),
                language: 'اوقات الصلاة الدقيقة',
                subLanguage: 'حساب دقيق بناء على موقعك',
                isSelected :false,
                selectable:false,
              ),SizedBox(height: 5,), lang.buildLanguageOption(
                icon: Icon(Icons.near_me_outlined),
                language: 'المساجد القريبة',
                subLanguage: 'اكتشف المساجد من حولك',
                isSelected :false,
                selectable:false,
              ),SizedBox(height: 5,), lang.buildLanguageOption(
                icon: Icon(Icons.shield_outlined),
                language: 'خصوصيه محميه',
                subLanguage: 'بياناتك امنه ومحمية',
                isSelected :false,
                selectable:false,
              ),SizedBox(height: 60,),
              Row(
                children: [
                  SizedBox(width: 5),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("التالي"),
                    style: ElevatedButton.styleFrom(
                      elevation: 8,
                      shadowColor: Colors.black,
                      backgroundColor: Color.fromARGB(255, 13, 126, 94),
                      foregroundColor: Colors.white,
                       minimumSize: Size(110, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("السابق"),
                    style: ElevatedButton.styleFrom(
                      elevation: 8,
                      shadowColor: Colors.black,
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                       minimumSize: Size(110, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                ],
              ),


            ],
          ),
        ),
      ),
    );
  }
}
