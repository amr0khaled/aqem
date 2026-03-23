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
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ),

        child: InkWell(
          onTap: (){
            onCardTap();
          },
          hoverDuration: Duration(milliseconds: 90),
          borderRadius: BorderRadius.circular(20),
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Padding(
                  padding: EdgeInsets.only(left: 20,top:(constraints.maxWidth < (MediaQuery.sizeOf(context).width/2))? 20:4,right: 20,bottom:4),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,

                    children: [
                      if(constraints.maxWidth < (MediaQuery.sizeOf(context).width/2))
                        SpecialIcon(
                          content: Icon(iconData,size: 28,color: iconDataColor??Colors.white,),
                          color: iconBackgroundColor,
                        )
                      ,
                      ListTile(
                        trailing:
                        constraints.maxWidth < (MediaQuery.sizeOf(context).width/2)?null:
                        SpecialIcon(
                          content: Icon(iconData,size: 28,color: iconDataColor??Colors.white,),
                          color: iconBackgroundColor,
                        ),
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
                );
              }
            ),
        ),
      ),
    );
  }
}