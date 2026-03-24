import 'package:aqem/core/widgets/special_icon.dart';
import 'package:flutter/material.dart';

class DuaTile extends StatefulWidget {
  const DuaTile({super.key,this.dua,this.duaNarrator,this.duaNotice});
  final String? dua,duaNarrator,duaNotice;
  @override
  State<DuaTile> createState() => _DuaTileState();
}

class _DuaTileState extends State<DuaTile> {
  bool _favourite = false,_expand=false;
  int _counter = 0;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Card(
          shadowColor: Colors.transparent,
          shape:RoundedRectangleBorder(
              borderRadius: .circular(20)
          ),
          child: InkWell(
            borderRadius: .circular(20),
            hoverDuration: Duration(milliseconds: 90),
            onTap: (){
              setState(() {
                _expand=!_expand;
              });
            },
            child: Directionality(
              textDirection: .rtl,
              child: ListTile(
                contentPadding: EdgeInsets.all(12),
                titleAlignment: .top,
                horizontalTitleGap: 12,
                leading: SizedBox(
                  height: 40,
                  width: 40,
                  child: TextButton(
                      onPressed: (){
                        setState(() {
                          _counter++;
                        });
                      },
                      style: TextButton.styleFrom(
                          shape: CircleBorder(),
                          padding: .zero,
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.orange,
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
                  widget.dua??"أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ، لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ، رَبِّ أَسْأَلُكَ خَيْرَ مَا فِي هَذَا الْيَوْمِ وَخَيْرَ مَا بَعْدَهُ، وَأَعُوذُ بِكَ مِنْ شَرِّ مَا فِي هَذَا الْيَوْمِ وَشَرِّ مَا بَعْدَهُ",
                    style: const TextStyle(
                      fontFamily: 'Kitab',
                      height: 1.62
                    )),
                subtitle: Row(

                  spacing: 8,
                  children: [
                    Column(
                      mainAxisSize: .min,
                      crossAxisAlignment: .start,
                      spacing: 8,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 8),
                          decoration: BoxDecoration(
                            color: .fromRGBO(212-10, 175-10, 55-10,1),//todo*******************
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            widget.duaNarrator??"رواه مسلم",
                            style: TextStyle(
                              fontFamily: 'Kitab',
                            ),
                          ),
                        ),
                        if(widget.duaNotice!=null&&widget.duaNotice!.length>19)Container(
                          padding: const .symmetric(vertical: 2.0,horizontal: 8),
                          decoration: BoxDecoration(
                            border: .all(
                                color: .fromRGBO(13, 126, 94, 0.12)
                            ),
                            borderRadius: .circular(12),
                          ),
                          child: Text(
                            widget.duaNotice!,
                            style: TextStyle(
                              fontFamily: 'Kitab',
                            ),
                          ),
                        ),
                      ],
                    ),

                    if(widget.duaNotice!=null && widget.duaNotice!.length<19)Container(
                      padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 8),
                      decoration: BoxDecoration(
                        border: .all(
                          color: Color.fromRGBO(13, 126, 94, 0.12)
                        ),
                          borderRadius: .circular(12),
                      ),
                      child: Text(
                        widget.duaNotice!,
                        style: TextStyle(
                          fontFamily: 'Kitab',
                        ),
                      ),
                    ),
                  ],
                ),
                trailing: IconButton(
                  highlightColor: Colors.transparent,
                    onPressed: (){
                      setState(() {
                        _favourite=!_favourite;
                      });
                    },
                    icon: Icon(
                        _favourite?Icons.favorite:Icons.favorite_outline,
                        color: _favourite?Colors.red:null,
                    ),
                        iconSize: 16,
                        padding: .zero,
                ),
              ),
            ),
          ),
        )
    );
  }
}
