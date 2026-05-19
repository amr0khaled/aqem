import 'package:aqem/core/utils/models/response.dart';
import 'package:googleapis/youtube/v3.dart';
import 'package:aqem/features/QuranLearning/PlaylistScreen.dart';
import 'package:aqem/features/QuranLearning/data/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});
  @override
  // ignore: library_private_types_in_public_api
  ConsumerState<Home> createState() => HomeScreen();
}

class HomeScreen extends ConsumerState<Home> {
  List<String> playlistsIds = [
    "PLrh3vCTZVOBFg1PJw7QIk9C5QaQyProdm",
    "PLcgZz-bFmPJGssn_LeVi1z7R69RJs8yXo",
    "PLi9e2_6LJN0IWTf56ySmcBsBuX82_dNaR",
    "PLwNeHLk_z0aSekqYqJdRtuYS74rcGXoWF",
    "PL7WAHKhMttd7_57UysVeO5RHiedgY_rBh",
    "PLwNeHLk_z0aQ7rYXtqXCqlSPE_4qxUkF2",
    "PLn3YCsyQvOYbJGlimLvlTw0uBEx5qtkVM",
    "PLsabgwJDKALr2-EPjszQZ3eTQQ1yl81ui",
    "PLJ0WU3XQoz4_vDPS0Xlaf3E2LgUz7pJsp",
    "PLJ0WU3XQoz48dYxaKhohHdaN-DDlTAIx3",
    "PLN4Jcpui4Yq23t4Yo3rKRzRt9MmMHa70I",
    "PLKhm8Z5pXdOXjBYqLvu2L2YCghTEPkMJj",
    "PLMs1030u4hsHktPKd9xHaCVINOGVQUllc",
    "PLMs1030u4hsEq4Mh1aaaKuEupEYDP9nda",
  ];

  @override
  Widget build(BuildContext context) {
    String? token;
    final args = PlaylistArgs(ids: playlistsIds, max: 5, token: token);
    final service = ref.read(playlistProvider(args));
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: _buildHeader(),
      ),
      body: SizedBox(
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: _buildVideoCardsRow(service),
        ),
      ),
    );
  }

  // ===================== HEADER =====================
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 48, bottom: 12, left: 16, right: 16),
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
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: IconButton.styleFrom(minimumSize: const Size(8, 8)),
            icon: Icon(Icons.arrow_forward, color: Colors.white, size: 28),
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

  Widget _buildVideoCardsRow(AsyncValue<YoutubeResponse<Playlist>> service) {
    return Container(
      child: service.when(
        skipLoadingOnRefresh: false,
        skipLoadingOnReload: false,
        data: (data) {
          return SingleChildScrollView(
            child: Center(
              child: Wrap(
                spacing: 20,
                runSpacing: 20,
                children: List.generate(data.items.length, (i) {
                  final item = data.items[i];
                  final snippet = item.snippet;
                  if (snippet == null) {
                    return _buildVideoCard(
                      id: null,
                      num: i,
                      imageName: "NULL",
                      duration: 0,
                      title: "NONE",
                    );
                  }
                  return _buildVideoCard(
                    id: item.id!,
                    num: i,
                    imageName: snippet.title ?? "NULL",
                    duration: item.contentDetails?.itemCount ?? 1,
                    title: snippet.title ?? "",
                    thumbnail: snippet.thumbnails?.medium?.url,
                  );
                }),
              ),
            ),
          );
        },
        error: (err, stack) {
          WidgetsBinding.instance.addPostFrameCallback((t) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                elevation: 3,
                margin: const EdgeInsets.only(bottom: 36, left: 16, right: 16),
                content: Text(
                  "Error: $err",
                  textDirection: TextDirection.ltr,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                duration: const Duration(seconds: 3),
                behavior: SnackBarBehavior.floating,
                dismissDirection: DismissDirection.down,
                backgroundColor: Colors.red.shade900,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
          });
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Error in loading playlists,\nConnect to Internet and try again.",
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, color: Colors.red.shade800),
                ),
                SizedBox.fromSize(size: Size.fromHeight(20)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 13, 126, 94),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
                      "Retry",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => _loading(),
      ),
    );
  }

  Widget _loading() {
    return Container(child: const Center(child: CircularProgressIndicator()));
  }

  Widget _buildVideoCard({
    required String? id,
    required int num,
    required String imageName,
    required int duration,
    required String title,
    String? thumbnail,
  }) {
    return GestureDetector(
      onTap: () {
        if (id == null) return;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PlaylistScreen(id: id, name: title),
          ),
        );
      },
      child: Container(
        width: 160,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 8,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail area
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(
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
                        image: thumbnail == null
                            ? AssetImage('images/$imageName.jpg')
                            : NetworkImage(thumbnail),
                        fit: BoxFit.cover,
                        onError: (_, __) {},
                      ),
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
      ),
    );
  }
}
