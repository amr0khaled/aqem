import 'package:aqem/features/azkar_screen/presentation/dua_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../data/dua_data.dart';

class AzkarInsideScreen extends StatefulWidget {
  AzkarInsideScreen({super.key, required this.category,
    required this.onUpdate,required this.onBackPressed});
  DuaCategory category;
  final VoidCallback onUpdate;
  final VoidCallback onBackPressed;
  @override
  State<AzkarInsideScreen> createState() => _AzkarInsideScreenState();
}

class _AzkarInsideScreenState extends State<AzkarInsideScreen> {
  bool _showBackButton = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:124,left: 18,right: 18,bottom: 20),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: _showBackButton?Column(
              mainAxisSize: .min,
              crossAxisAlignment: .start,
              children: [
                InkWell(
                    onTap: widget.onBackPressed,
                    splashFactory: NoSplash.splashFactory,
                    borderRadius: .circular(40),
                    highlightColor: Colors.transparent,
                    child:
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisSize: .min,
                      spacing: 16,
                      children: [
                        Icon(Icons.arrow_back,
                          size: 16,
                          color: Color.fromRGBO(107, 107, 107, 1),
                        ),
                        Text("العودة للفئات",style: TextStyle(
                          color: Color.fromRGBO(107, 107, 107, 1)
                        ),),
                      ],
                    ),
                  )
                ),
                Divider(height: 1,),
              ],
            ) :const SizedBox.shrink(),
          ),

          Expanded(
            child: NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                if (notification.direction == ScrollDirection.forward) {
                  // Scrolling up towards the top (finger moving down) -> Show
                  if (!_showBackButton) {
                    setState(() {
                      _showBackButton = true;
                    });
                  }
                } else if (notification.direction == ScrollDirection.reverse) {
                  // Scrolling down the list (finger moving up) -> Hide
                  if (_showBackButton) {
                    setState(() {
                      _showBackButton = false;
                    });
                  }
                }
                return false; // Let the notification bubble up
              },
              child: ListView(

                children: [
                  for(DuaRecord duaRecord in duaData)
                    if (duaRecord.category == widget.category)
                  DuaTile(
                      dua: duaRecord.dua,
                      duaNarrator: duaRecord.duaNarrator,
                      count: duaRecord.count,
                      currentCount: duaRecord.currentCount,
                      onCountUpdate: (newCount) {
                        setState(() {
                          duaRecord.currentCount = newCount;
                        });
                        },
                      duaNotices: duaRecord.duaNotices,
                      onFavouritePress: (){
                        setState(() {
                          duaRecord.isFavourite= !(duaRecord.isFavourite);
                          widget.onUpdate();
                        });
                        saveDuaData();
                      },

                      category: duaRecord.category
                      , onComplete: (){
                        setState(() {
                          duaRecord.isComplete=true;
                          widget.onUpdate();
                        });
                          saveDuaData();
                  },
                      isFavourite: duaRecord.isFavourite,
                    onMidnight: () {
                        setState(() {
                          duaRecord.isComplete=false;
                          duaRecord.currentCount = duaRecord.count;
                          widget.onUpdate();
                        });
                        saveDuaData();
                        },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
