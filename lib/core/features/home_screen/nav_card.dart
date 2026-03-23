import 'package:flutter/material.dart';
import 'package:aqem/core/widgets/special_icon.dart';

class NavCard extends StatelessWidget{
   const NavCard({super.key,required this.iconData, required this.title,
    required this.subtitle,this.iconDataColor,
    this.iconBackgroundColor, required this.onCardTap});

  final IconData iconData;
  final Color? iconDataColor,iconBackgroundColor;
  final String title,subtitle;
  final void Function() onCardTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),

      child: InkWell(
        onTap: (){
          onCardTap();
        },
        hoverDuration: Duration(milliseconds: 90),
        borderRadius: BorderRadius.circular(20),
        child: Padding(
                padding: const EdgeInsets.only(left: 20,top: 20,right: 20,bottom:4),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
              SpecialIcon(
                icon: Icon(iconData,size: 28,color: iconDataColor??Colors.white,),
                color: iconBackgroundColor,
              )
                    ,
                    ListTile(
                      minVerticalPadding: 16,
                      contentPadding: EdgeInsets.all(0),
                      title: Text(
                        title,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontFamily: 'Kitab',//todo*************
                          fontSize: 18.0,
                          fontWeight: FontWeight(500),
                        ),
                      ),
                      subtitle: Text(
                          subtitle,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              fontFamily: 'Kitab',//todo**************
                              fontSize: 12.0,
                              fontWeight: FontWeight(400),
                              color: Color.fromRGBO(107, 107, 107, 1)
                          )
                      ),
                    )
                  ],
                ),
          ),
      ),
    );
  }
}