import 'package:flutter/material.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:  Row(
          children: [
            SizedBox(width:20),
            ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      elevation: 8,
                      shadowColor: Colors.black,
                      backgroundColor: Color.fromARGB(255, 13, 126, 94),
                      foregroundColor: Colors.white,
                     // minimumSize: Size(382, 56),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24))),
                  child:  Text("التالي"),
                ),
            Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      elevation: 8,
                      shadowColor: Colors.black ,
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                     // minimumSize: Size(382, 56),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24))),
                  child: Text("السابق"),
                ),
            SizedBox(width: 20,),
              ],
            ),
    );
  }
}