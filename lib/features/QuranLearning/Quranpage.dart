import 'package:aqem/core/utils/models/response.dart';
import 'package:googleapis/youtube/v3.dart';
import 'package:aqem/features/QuranLearning/PlaylistScreen.dart';
import 'package:aqem/features/QuranLearning/data/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'domain/playlistCategorizer.dart';

class QuranPage extends ConsumerStatefulWidget {
  const QuranPage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  ConsumerState<QuranPage> createState() => QuranPageScreen();
}

class QuranPageScreen extends ConsumerState<QuranPage> {
  AsyncValue<YoutubeResponse<Playlist>> service = const AsyncValue.loading();
  final Set<String> _expandedLanguages = {};
  @override
  void initState() {
    super.initState();
    print("=== QuranPage initState START ===");
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
      "PLfUTesWN0JTyQvVOoRQnUguU-v0kxoL-p",
      "PLNalK17Hk_LLXXtEd7cPt4iQOansx4hrC",
      "PLr-mGUA8J2jZhxMrL3aIMztK8ahe3j3J5",
      "PL2DS0i9dIF-fJL1unaXvyyzkryVa2NqtB",
      "PL01rifg2BPPNhIHrCJLzPqC_QLlSeCy3F",
      "PLMpZpT9IRpAC3CgmxnJJxXXVXNCPi7htq",
      "PLbhs-wBfoMATnLCIpm1BS_TNsevpsYhE_",
      "PLF-AzhmyjY8xEojcjawrgQ8P21MJRuVfM",
      "PL3Q0fwpkr-mE0z2YIGoAQ2u_e1dC6jyp7",
      "PLa4GKxenTk5XGzNcexkFzVJfVMjic6izh",
    ];
    print("Fetching playlists for IDs: ${playlistsIds.length} items");

    String? token;
    final args = PlaylistArgs(ids: playlistsIds, max: 5, token: token);
    WidgetsBinding.instance.addPostFrameCallback((t) async {
      print("Post frame callback running...");
      try {
        final playlists = await ref.read(playlistProvider(args).future);
        print("Playlists received: ${playlists.items.length}");
        if (!mounted) return;
        setState(() {
          service = AsyncValue.data(playlists);
          if (playlists.items.isNotEmpty) {
            final categorized = PlaylistCategorizer.categorize(playlists.items);
            if (categorized.isNotEmpty) {
              _expandedLanguages.add(categorized.keys.first);
            }
          }
        });
        print("setState completed");
      } catch (e, stack) {
        print("ERROR fetching playlists: $e");
        print("Stack: $stack");
        if (mounted) {
          setState(() {
            service = AsyncValue.error(e, stack);
          });
        }
      }
    });
    print("=== QuranPage initState END ===");
  }

  @override
  Widget build(BuildContext context) {
    print(
      "=== QuranPage BUILD called, service state: ${service.runtimeType} ===",
    );
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: _buildHeader(),
      ),
      body: service.when(
        data: (data) {
          print("QuranPage: data branch, items: ${data.items.length}");
          if (data.items.isEmpty) {
            return const Center(child: Text('No playlists found'));
          }
          final categorized = PlaylistCategorizer.categorize(data.items);
          return _buildCategorizedView(categorized);
        },
        error: (err, stack) {
          print("QuranPage: error branch: $err");
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Error: $err"),
                duration: const Duration(seconds: 3),
                behavior: SnackBarBehavior.floating,
              ),
            );
          });
          return Center(child: Text("Error: $err\n\n$stack"));
        },
        loading: () {
          print("QuranPage: loading branch");
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

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
            'تقدم في الدرس',
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

  Widget _buildCategorizedView(
    Map<String, Map<PlaylistFunction, List<Playlist>>> categorized,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      child: Column(
        children: categorized.entries.map((languageEntry) {
          final language = languageEntry.key;
          final functions = languageEntry.value;
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ExpansionTile(
              initiallyExpanded: _expandedLanguages.contains(language),
              onExpansionChanged: (expanded) {
                setState(() {
                  if (expanded) {
                    _expandedLanguages.add(language);
                  } else {
                    _expandedLanguages.remove(language);
                  }
                });
              },
              tilePadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 8,
              ),
              title: Row(
                children: [
                  Icon(
                    language == 'العربية' ? Icons.language : Icons.public,
                    color: const Color(0xFF00897B),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    language,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00897B),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '(${_totalCount(functions)})',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              children: functions.entries.map((functionEntry) {
                final function = functionEntry.key;
                final playlists = functionEntry.value;
                final functionName = PlaylistCategorizer.getFunctionName(
                  function,
                  language,
                );
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 16,
                        bottom: 12,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _getFunctionIcon(function),
                            size: 20,
                            color: Colors.grey.shade700,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            functionName,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '(${playlists.length})',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: playlists.map((playlist) {
                          return _buildVideoCard(playlist);
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (function != functions.keys.last)
                      const Divider(height: 8, indent: 20, endIndent: 20),
                  ],
                );
              }).toList(),
            ),
          );
        }).toList(),
      ),
    );
  }

  int _totalCount(Map<PlaylistFunction, List<Playlist>> functions) {
    return functions.values.fold(0, (sum, list) => sum + list.length);
  }

  IconData _getFunctionIcon(PlaylistFunction function) {
    switch (function) {
      case PlaylistFunction.tajweed:
        return Icons.auto_awesome;
      case PlaylistFunction.recitation:
        return Icons.mic;
      case PlaylistFunction.stories:
        return Icons.menu_book;
      case PlaylistFunction.ChildrenMemorize:
        return Icons.child_care;
      case PlaylistFunction.AdultMemorize:
        return Icons.person;
      case PlaylistFunction.other:
        return Icons.playlist_play;
    }
  }

  Widget _buildVideoCard(Playlist playlist) {
    final snippet = playlist.snippet;
    final id = playlist.id;
    final title = snippet?.title ?? 'Untitled';
    final thumbnail = snippet?.thumbnails?.medium?.url;
    final itemCount = playlist.contentDetails?.itemCount ?? 0;
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
                      image: thumbnail == null
                          ? null
                          : DecorationImage(
                              image: NetworkImage(thumbnail),
                              fit: BoxFit.cover,
                              onError: (_, __) {},
                            ),
                    ),
                    child: thumbnail == null
                        ? const Center(
                            child: Icon(
                              Icons.playlist_play,
                              color: Colors.white70,
                              size: 40,
                            ),
                          )
                        : null,
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
                      '$itemCount videos',
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
