import 'dart:async';

import 'package:aqem/features/azkar/data/dua_data.dart';
import 'package:flutter/material.dart';

class DuaTile extends StatefulWidget {
  const DuaTile({super.key
    ,required this.dua
    ,this.duaNarrator
    ,this.duaNotices
    ,required this.onFavouritePress
    ,required this.category
    , required this.onComplete
    ,this.count
    , required this.isFavourite
    , required this.onMidnight,
    required this.currentCount,
    required this.onCountUpdate,});
  final String? dua,duaNarrator;
  final List<String>? duaNotices;
  final int? count;
  final void Function() onFavouritePress;
  final void Function() onMidnight;
  final void Function() onComplete;
  final int currentCount;
  final void Function(int newCount) onCountUpdate;
  final bool isFavourite;
  final DuaCategory category;
  @override
  State<DuaTile> createState() => _DuaTileState();
}

class _DuaTileState extends State<DuaTile> {
  bool  _expand=false;
  int _counter = 100;
  bool _favourite = false,_disabled=false;
  Timer? _midnightTimer;


  @override
  void initState() {
    super.initState();
    setState(() {
      _favourite=widget.isFavourite;
      _counter = widget.currentCount;
      if (_counter == 0) _disabled = true;
    });
    _scheduleMidnightReset();
  }

  void _scheduleMidnightReset() {
    DateTime now = DateTime.now();

    // Get exactly 12:00 AM of the NEXT day
    DateTime nextMidnight = DateTime(now.year, now.month, now.day + 1);

    // Calculate how long to wait
    Duration timeUntilMidnight = nextMidnight.difference(now);

    // Set a timer to trigger at exactly midnight
    _midnightTimer = Timer(timeUntilMidnight, () {
      if (mounted) {
        setState(() {
          _counter=widget.count??_counter;
          _disabled = false;
        });
      }
      // Reschedule for the next day in case they leave the app open for 48 hours!
      widget.onMidnight();
      _scheduleMidnightReset();
    });
  }

  @override
  void dispose() {
    // ALWAYS cancel timers when the widget is destroyed to prevent memory leaks
    _midnightTimer?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Card(
        shadowColor: Colors.transparent,
        color: _disabled?Theme.of(context).disabledColor:null,
        shape:RoundedRectangleBorder(
            borderRadius: .circular(20)
        ),
        child: InkWell(
          borderRadius: .circular(20),
          hoverDuration: Duration(milliseconds: 90),
          onTap: (){
            setState(() {
              if(!_disabled) _expand=!_expand;
            });
          },
          child: Directionality(
            textDirection: .rtl,
            child: Column(
              mainAxisSize: .min,
              crossAxisAlignment: .start,
              children: [
                ListTile(

                  contentPadding: ((widget.duaNotices?.length??0)==1&&(widget.duaNotices?[0].length??0)<19)?EdgeInsets.all(12):EdgeInsetsGeometry.directional(top: 12,start: 12,end: 12,bottom: 0),
                  titleAlignment: .top,
                  horizontalTitleGap: 12,
                  leading: SizedBox(
                    height: 40,
                    width: 40,
                    child: TextButton(
                        onPressed: (){
                          if(_counter>0){
                            setState(() {
                              _counter--;
                              widget.onCountUpdate(_counter);
                            if(_counter==0){
                              _disabled= true;
                              widget.onComplete();
                            }
                            });
                          }

                        },
                        onLongPress: (){
                          setState(() {
                            _counter=widget.count??_counter;
                            _disabled=false;
                            widget.onCountUpdate(_counter);
                          });
                        },
                        style: TextButton.styleFrom(
                            shape: CircleBorder(),
                            padding: .zero,
                            foregroundColor: Colors.white,
                            backgroundColor: _disabled?Colors.green:Colors.orange,
                        ),
                        child: Text(_counter.toString(),
                          style: TextStyle(
                            fontWeight: .new(400),
                            fontSize: 16
                          ),)
                    ),
                  ),
                  title: Text(
                    maxLines: _expand?null:2,
                    overflow: _expand?null:.ellipsis,
                    widget.dua??'',
                      style: const TextStyle(
                        fontFamily: 'Kitab',
                        height: 1.62
                      )),
                  trailing: IconButton(
                    highlightColor: Colors.transparent,
                      onPressed: (){
                        setState(() {
                          _favourite=!_favourite;
                        });
                        widget.onFavouritePress();
                      },
                      icon: Icon(
                          _favourite?Icons.favorite:Icons.favorite_outline,
                          color: _favourite?Colors.red:null,
                      ),
                          iconSize: 16,
                          padding: .zero,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 64,left: 12,top: 8,bottom: 20),
                  child: Stack(
                    children: [
                      SizedBox(
                        height: _expand?null:25.9,
                        child: Wrap(
                          runSpacing: 8,
                          spacing: 8,
                          clipBehavior: .antiAlias,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 8),
                              decoration: BoxDecoration(
                                color: .fromRGBO(212-10, 175-10, 55-10,1),//todo*******************
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                widget.duaNarrator??'',
                                style: TextStyle(
                                  fontFamily: 'Kitab',
                                ),
                              ),
                            ),
                            ...widget.duaNotices!.map(
                                    (notice)=>Container(
                                  padding: const .symmetric(vertical: 2.0,horizontal: 8),
                                  decoration: BoxDecoration(
                                    border: .all(
                                        color: .fromRGBO(13, 126, 94, 0.12)
                                    ),
                                    borderRadius: .circular(12),
                                  ),
                                  child: Text(
                                    notice,
                                    style: TextStyle(
                                      fontFamily: 'Kitab',
                                    ),
                                  ),
                                )
                            ),

                          ],
                        ),
                      ),
                      if(!_expand)
                      Container(
                          alignment: .bottomLeft,
                          child: Icon(Icons.keyboard_arrow_down,size: 22,color: Color(0xFF6B6B6B),))

                    ],
                  ),
                ),
              ],
            ),

          ),
        ),
      ),
    );
  }
}
