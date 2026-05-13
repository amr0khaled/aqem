import 'package:aqem/features/QuranLearning/Playlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class Home extends StatefulWidget {
  const Home({super.key});
  @override
  // ignore: library_private_types_in_public_api
HomeScreen createState() => HomeScreen();
}
class HomeScreen extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === Header ===
              _buildHeader(),
              const SizedBox(height: 20),

              // === Progress Card ===
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _buildProgressCard(),
              ),
              const SizedBox(height: 28),

              // === Use Lessons Section ===
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _buildSectionTitle('استخدمي الدروس'),
              ),
              const SizedBox(height: 12),
               _buildVideoCardsRow(),
              const SizedBox(height: 28),

              // === My Favorite Courses Section ===
              const SizedBox(height: 12),

            ],
          ),
        ),
      ),
    );
  }

  // ===================== HEADER =====================
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 48, bottom: 24, left: 16, right: 16),
      decoration: const BoxDecoration(
        color: Color(0xFF00897B),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'تقدمي في الدرس',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
          ),
        ],
      ),
    );
  }

  // ===================== PROGRESS CARD =====================
  Widget _buildProgressCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Left side: Percentage circle
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  value: 0.78,
                  strokeWidth: 7,
                  backgroundColor: const Color(0xFFE0E0E0),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color(0xFF00897B),
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    '78%',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF00897B),
                    ),
                  ),
                  Text(
                    'تقدم',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF9E9E9E),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(width: 20),
          // Right side: text info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: '5 ',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF00897B),
                        ),
                      ),
                      TextSpan(
                        text: 'دروس',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF00897B),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'أكملت هذا الأسبوع',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF757575),
                  ),
                ),
                const SizedBox(height: 14),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: 0.78,
                    minHeight: 8,
                    backgroundColor: const Color(0xFFE0E0E0),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF00897B),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===================== SECTION TITLE =====================
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Color(0xFF333333),
      ),
    );
  }
  Widget _buildVideoCardsRow() {
    return Padding(padding:const EdgeInsets.all(30) ,
    child: 
        Wrap( spacing: 30 , runSpacing:20 ,children: [
          _buildVideoCard(
          num: 1,
          imageName: 'quran',
          duration: 7,
          title: 'احكام تجويد صورة الفران',
          link: "https://www.youtube.com/watch?v=gHCvfC-5FDo&list=PLrh3vCTZVOBFg1PJw7QIk9C5QaQyProdm"
        ),
        _buildVideoCard(
          num: 2,
          imageName: 'video2',
          duration:10,
          title: 'اداب تلاوة القران الكريم',
          link: ""
        ),
        _buildVideoCard(
          num: 3,
            imageName: 'video1',
            duration: 5,
            title: 'قصص الانبياء في القران',
            link: "https://www.youtube.com/watch?v=gHCvfC-5FDo&list=PLrh3vCTZVOBFg1PJw7QIk9C5QaQyProdm"
        ),

          _buildVideoCard(
          num: 4,
            imageName: 'video1',
            duration: 6,
            title: 'قصص النساء في القران',
            link: "https://www.youtube.com/watch?v=gHCvfC-5FDo&list=PLrh3vCTZVOBFg1PJw7QIk9C5QaQyProdm"
        ),
        _buildVideoCard(
          num: 5,
            imageName: 'p1',
            duration: 444,
            title: 'قصص العجائب في القران',
            link: "https://www.youtube.com/watch?v=gHCvfC-5FDo&list=PLrh3vCTZVOBFg1PJw7QIk9C5QaQyProdm"
        ),
          _buildVideoCard(
          num: 6,
            imageName: 'p1',
            duration: 5,
            title: 'قصص ايات القران',
            link: "https://www.youtube.com/watch?v=gHCvfC-5FDo&list=PLrh3vCTZVOBFg1PJw7QIk9C5QaQyProdm"
        ),
          _buildVideoCard(
          num: 7,
            imageName: 'video1',
            duration: 2,
            title: ' حفظ جزء عم للاطفال',
            link: "https://www.youtube.com/watch?v=gHCvfC-5FDo&list=PLrh3vCTZVOBFg1PJw7QIk9C5QaQyProdm"
        ),
          _buildVideoCard(
          num: 8,
            imageName: 'video1',
            duration: 4,
            title: ' حفظ جزء عم للبالغين',
            link: "https://www.youtube.com/watch?v=gHCvfC-5FDo&list=PLrh3vCTZVOBFg1PJw7QIk9C5QaQyProdm"
        ),
        ],),
      );
  }

  Widget _buildVideoCard({
    required int num,
    required String imageName,
    required int duration,
    required String title,
    required String link,
  }) {
    return GestureDetector(
      onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => Playlist(num: num)),
          );
      },
      child: Container(
      width: 190,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail area
          Stack(
            children: [
              Container(
                height: 110,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(14),
                  ),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF4DB6AC), Color(0xFF00897B)],
                  ),
                  image: DecorationImage(
                    image: AssetImage('images/$imageName.jpg'),
                    fit: BoxFit.cover,
                    onError: (_, __) {},
                  ),
                ),
              ),
              // Play button overlay
              Positioned.fill(
                child: Center(
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFC107),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                ),
              ),
              // Duration label
              Positioned(
                bottom: 6,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    duration.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Title
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF333333),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ),);
  }


}
