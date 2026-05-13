import 'package:aqem/features/QuranLearning/YoutubeScreen.dart';
import 'package:flutter/material.dart';

class Playlist extends StatefulWidget {
  final int num;
  const Playlist({super.key, required this.num});

  @override
  // ignore: library_private_types_in_public_api
  PlaylistScreen createState() => PlaylistScreen();
}

class PlaylistScreen extends State<Playlist> {
  List<bool> selectedVideos = List.generate(7, (index) => false);
  int get selectedCount => selectedVideos.where((e) => e).length;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color.fromARGB(255, 248, 247, 244),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    title: Text(
                      "التقدم",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    subtitle: LinearProgressIndicator(
                      value: selectedCount / selectedVideos.length,
                      backgroundColor: Colors.white60,
                      valueColor: AlwaysStoppedAnimation(
                        Color.fromARGB(255, 13, 126, 94),
                      ),
                      //  color: Color.fromARGB(255, 13, 126, 94),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                _playlistSelection(num: widget.num),
                SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
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
                      'العوده',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _playlistSelection({required int num}) {
    if (num == 2) {
      return _videos2();
    }
    if (num == 3) {
      return _videos3();
    }
    if (num == 4) {
      return _videos4();
    }
    if (num == 5) {
      return _videos5();
    }
    if (num == 6) {
      return _videos6();
    }
    if (num == 7) {
      return _videos7();
    }
    return _videos1();
  }

  Widget _videos1() {
    return Column(
      children: [
        _buildPlaylistOption(
          name: "تجويد سورة الفاتحه",
          link:
              "https://www.youtube.com/watch?v=gHCvfC-5FDo&list=PLrh3vCTZVOBFg1PJw7QIk9C5QaQyProdm",
          index: 0,
        ),
        SizedBox(height: 12),
        _buildPlaylistOption(
          name: "تجويد سورة الفلق",
          link: "https://youtu.be/glCRJARVBVk?si=g3FS0I_tRhfqj63m",
          index: 1,
        ),
        SizedBox(height: 12),
        _buildPlaylistOption(
          name: "تجويد سورة الناس",
          link: "https://youtu.be/DCN5WGLIfCk?si=4atsjhKdOey45f7w",
          index: 2,
        ),
        SizedBox(height: 12),
        _buildPlaylistOption(
          name: "تجويد سورة الاخلاص",
          link: "https://youtu.be/N7TX784OQkw?si=q5aXF6jeO5Az1x3b",
          index: 3,
        ),
        SizedBox(height: 12),
        _buildPlaylistOption(
          name: "تجويد سورة الكافرون",
          link: "https://youtu.be/jBnkbJ7tMAE?si=3VJIvHNeMm5zEhaV",
          index: 4,
        ),
        SizedBox(height: 12),
        _buildPlaylistOption(
          name: "تجويد سورة النصر",
          link: "https://youtu.be/eV6cbRGopKA?si=MdT0hj_lDFv_YnPa",
          index: 5,
        ),
        SizedBox(height: 12),
        _buildPlaylistOption(
          name: "تجويد سورة الكوثر",
          link: "https://youtu.be/gE7AFEcguqo?si=83c4EI0odqzVZbLD",
          index: 6,
        ),
      ],
    );
  }

  Widget _videos2() {
    return ListView(
      children: [
        _buildPlaylistOption(
          name: "الاداب الظاهره للتلاوه",
          link: "https://youtu.be/Z75S42Vh5Mo?si=Ub-I3M2LU4xvJL5W",
          index: 0,
        ),
        SizedBox(height: 12),
        _buildPlaylistOption(
          name: "تتمة الاداب الظاهره",
          link: "https://youtu.be/Q5LNsVz9TdE?si=T_dyjw0a3RmNNk-2",
          index: 1,
        ),
        SizedBox(height: 12),
        _buildPlaylistOption(
          name: "الفهم, التعظيم,الحضور",
          link: "https://youtu.be/SmGa7gjF-No?si=htxYnGtOjNRYSvh1",
          index: 2,
        ),
        SizedBox(height: 12),
        _buildPlaylistOption(
          name: "تدبر لمعاني القران",
          link: "https://youtu.be/ytNCJC-CiE0?si=KbotBPBUzCM0aE2U",
          index: 3,
        ),
        SizedBox(height: 12),
        _buildPlaylistOption(
          name: "تجويد سورة الكافرون",
          link: "https://youtu.be/jBnkbJ7tMAE?si=3VJIvHNeMm5zEhaV",
          index: 4,
        ),
        SizedBox(height: 12),
        _buildPlaylistOption(
          name: "تجويد سورة النصر",
          link: "https://youtu.be/eV6cbRGopKA?si=MdT0hj_lDFv_YnPa",
          index: 5,
        ),
        SizedBox(height: 12),
        _buildPlaylistOption(
          name: "تجويد سورة الكوثر",
          link: "https://youtu.be/gE7AFEcguqo?si=83c4EI0odqzVZbLD",
          index: 6,
        ),
      ],
    );
  }

  Widget _videos3() {
    return ListView(
      children: [
        _buildPlaylistOption(
          name: "غراب بني ادم",
          link: "hhttps://youtu.be/eHobRabok1s?si=yngkfo6Yl5ZDNaN9",
          index: 0,
        ),
        SizedBox(height: 12),
        _buildPlaylistOption(
          name: "غراب بني ادم_الجزء الثاني",
          link: "https://youtu.be/0tvHdjWTGWs?si=w1SVwXvEUPYVQJWA",
          index: 1,
        ),
        SizedBox(height: 12),
        _buildPlaylistOption(
          name: "الفهم, التعظيم,الحضور",
          link: "https://youtu.be/SmGa7gjF-No?si=htxYnGtOjNRYSvh1",
          index: 2,
        ),
        SizedBox(height: 12),
        _buildPlaylistOption(
          name: "تدبر لمعاني القران",
          link: "https://youtu.be/ytNCJC-CiE0?si=KbotBPBUzCM0aE2U",
          index: 3,
        ),
        SizedBox(height: 12),
        _buildPlaylistOption(
          name: "تجويد سورة الكافرون",
          link: "https://youtu.be/jBnkbJ7tMAE?si=3VJIvHNeMm5zEhaV",
          index: 4,
        ),
        SizedBox(height: 12),
        _buildPlaylistOption(
          name: "تجويد سورة النصر",
          link: "https://youtu.be/eV6cbRGopKA?si=MdT0hj_lDFv_YnPa",
          index: 5,
        ),
        SizedBox(height: 12),
        _buildPlaylistOption(
          name: "تجويد سورة الكوثر",
          link: "https://youtu.be/gE7AFEcguqo?si=83c4EI0odqzVZbLD",
          index: 6,
        ),
      ],
    );
  }

  Widget _videos4() {
    return ListView(
      children: [
        _buildPlaylistOption(
          name: "الاداب الظاهره للتلاوه",
          link: "https://youtu.be/Z75S42Vh5Mo?si=Ub-I3M2LU4xvJL5W",
          index: 0,
        ),
        SizedBox(height: 12),
        _buildPlaylistOption(
          name: "تتمة الاداب الظاهره",
          link: "https://youtu.be/Q5LNsVz9TdE?si=T_dyjw0a3RmNNk-2",
          index: 1,
        ),
        SizedBox(height: 12),
        _buildPlaylistOption(
          name: "الفهم, التعظيم,الحضور",
          link: "https://youtu.be/SmGa7gjF-No?si=htxYnGtOjNRYSvh1",
          index: 2,
        ),
        SizedBox(height: 12),
        _buildPlaylistOption(
          name: "تدبر لمعاني القران",
          link: "https://youtu.be/ytNCJC-CiE0?si=KbotBPBUzCM0aE2U",
          index: 3,
        ),
        SizedBox(height: 12),
        _buildPlaylistOption(
          name: "تجويد سورة الكافرون",
          link: "https://youtu.be/jBnkbJ7tMAE?si=3VJIvHNeMm5zEhaV",
          index: 4,
        ),
        SizedBox(height: 12),
        _buildPlaylistOption(
          name: "تجويد سورة النصر",
          link: "https://youtu.be/eV6cbRGopKA?si=MdT0hj_lDFv_YnPa",
          index: 5,
        ),
        SizedBox(height: 12),
        _buildPlaylistOption(
          name: "تجويد سورة الكوثر",
          link: "https://youtu.be/gE7AFEcguqo?si=83c4EI0odqzVZbLD",
          index: 6,
        ),
      ],
    );
  }

  Widget _videos5() {
    return ListView(
      children: [
        _buildPlaylistOption(
          name: "الاداب الظاهره للتلاوه",
          link: "https://youtu.be/Z75S42Vh5Mo?si=Ub-I3M2LU4xvJL5W",
          index: 0,
        ),
        SizedBox(height: 12),
        _buildPlaylistOption(
          name: "تتمة الاداب الظاهره",
          link: "https://youtu.be/Q5LNsVz9TdE?si=T_dyjw0a3RmNNk-2",
          index: 1,
        ),
        SizedBox(height: 12),
        _buildPlaylistOption(
          name: "الفهم, التعظيم,الحضور",
          link: "https://youtu.be/SmGa7gjF-No?si=htxYnGtOjNRYSvh1",
          index: 2,
        ),
        SizedBox(height: 12),
        _buildPlaylistOption(
          name: "تدبر لمعاني القران",
          link: "https://youtu.be/ytNCJC-CiE0?si=KbotBPBUzCM0aE2U",
          index: 3,
        ),
        SizedBox(height: 12),
        _buildPlaylistOption(
          name: "تجويد سورة الكافرون",
          link: "https://youtu.be/jBnkbJ7tMAE?si=3VJIvHNeMm5zEhaV",
          index: 4,
        ),
        SizedBox(height: 12),
        _buildPlaylistOption(
          name: "تجويد سورة النصر",
          link: "https://youtu.be/eV6cbRGopKA?si=MdT0hj_lDFv_YnPa",
          index: 5,
        ),
        SizedBox(height: 12),
        _buildPlaylistOption(
          name: "تجويد سورة الكوثر",
          link: "https://youtu.be/gE7AFEcguqo?si=83c4EI0odqzVZbLD",
          index: 6,
        ),
      ],
    );
  }

  Widget _videos6() {
    return ListView(
      children: [
        _buildPlaylistOption(
          name: "الاداب الظاهره للتلاوه",
          link: "https://youtu.be/Z75S42Vh5Mo?si=Ub-I3M2LU4xvJL5W",
          index: 0,
        ),
        SizedBox(height: 12),
        _buildPlaylistOption(
          name: "تتمة الاداب الظاهره",
          link: "https://youtu.be/Q5LNsVz9TdE?si=T_dyjw0a3RmNNk-2",
          index: 1,
        ),
        SizedBox(height: 12),
        _buildPlaylistOption(
          name: "الفهم, التعظيم,الحضور",
          link: "https://youtu.be/SmGa7gjF-No?si=htxYnGtOjNRYSvh1",
          index: 2,
        ),
        SizedBox(height: 12),
        _buildPlaylistOption(
          name: "تدبر لمعاني القران",
          link: "https://youtu.be/ytNCJC-CiE0?si=KbotBPBUzCM0aE2U",
          index: 3,
        ),
        SizedBox(height: 12),
        _buildPlaylistOption(
          name: "تجويد سورة الكافرون",
          link: "https://youtu.be/jBnkbJ7tMAE?si=3VJIvHNeMm5zEhaV",
          index: 4,
        ),
        SizedBox(height: 12),
        _buildPlaylistOption(
          name: "تجويد سورة النصر",
          link: "https://youtu.be/eV6cbRGopKA?si=MdT0hj_lDFv_YnPa",
          index: 5,
        ),
        SizedBox(height: 12),
        _buildPlaylistOption(
          name: "تجويد سورة الكوثر",
          link: "https://youtu.be/gE7AFEcguqo?si=83c4EI0odqzVZbLD",
          index: 6,
        ),
      ],
    );
  }

  Widget _videos7() {
    return ListView(
      children: [
        _buildPlaylistOption(
          name: "الاداب الظاهره للتلاوه",
          link: "https://youtu.be/Z75S42Vh5Mo?si=Ub-I3M2LU4xvJL5W",
          index: 0,
        ),
        SizedBox(height: 12),
        _buildPlaylistOption(
          name: "تتمة الاداب الظاهره",
          link: "https://youtu.be/Q5LNsVz9TdE?si=T_dyjw0a3RmNNk-2",
          index: 1,
        ),
        SizedBox(height: 12),
        _buildPlaylistOption(
          name: "الفهم, التعظيم,الحضور",
          link: "https://youtu.be/SmGa7gjF-No?si=htxYnGtOjNRYSvh1",
          index: 2,
        ),
        SizedBox(height: 12),
        _buildPlaylistOption(
          name: "تدبر لمعاني القران",
          link: "https://youtu.be/ytNCJC-CiE0?si=KbotBPBUzCM0aE2U",
          index: 3,
        ),
        SizedBox(height: 12),
        _buildPlaylistOption(
          name: "تجويد سورة الكافرون",
          link: "https://youtu.be/jBnkbJ7tMAE?si=3VJIvHNeMm5zEhaV",
          index: 4,
        ),
        SizedBox(height: 12),
        _buildPlaylistOption(
          name: "تجويد سورة النصر",
          link: "https://youtu.be/eV6cbRGopKA?si=MdT0hj_lDFv_YnPa",
          index: 5,
        ),
        SizedBox(height: 12),
        _buildPlaylistOption(
          name: "تجويد سورة الكوثر",
          link: "https://youtu.be/gE7AFEcguqo?si=83c4EI0odqzVZbLD",
          index: 6,
        ),
      ],
    );
  }

  Widget _buildPlaylistOption({
    required String name,
    required String link,
    required int index,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xFFFFFFFF),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A1A1A),
          ),
        ),
        trailing: Checkbox(
          activeColor: const Color.fromARGB(255, 13, 126, 94),
          value: selectedVideos[index],
          onChanged: (value) {
            setState(() {
              selectedVideos[index] = value!;
            });
          },
        ),
        onTap: () {
          setState(() {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => YoutubeScreen(url: link, name: name),
              ),
            );
          });
        },
      ),
    );
  }
}
