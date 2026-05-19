import 'package:aqem/core/utils/models/response.dart';
import 'package:aqem/features/QuranLearning/YoutubeScreen.dart';
import 'package:aqem/features/QuranLearning/data/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googleapis/youtube/v3.dart';

class PlaylistScreen extends ConsumerStatefulWidget {
  final String id;
  final String name;
  const PlaylistScreen({super.key, required this.id, required this.name});

  @override
  // ignore: library_private_types_in_public_api
  ConsumerState<PlaylistScreen> createState() => _PlaylistScreen();
}

class _PlaylistScreen extends ConsumerState<PlaylistScreen> {
  AsyncValue<YoutubeResponse<PlaylistItem>> service =
      const AsyncValue.loading();
  String? token;
  int? max;
  int itemsLength = 0;

  late List<String> ids;
  late List<bool> finished = [];
  double percentage = 0;

  @override
  void initState() {
    super.initState();
    final args = PlaylistItemArgs(id: widget.id, token: token, max: max);
    WidgetsBinding.instance.addPostFrameCallback((t) async {
      final playlistItems = await ref.read(playlistItemsProvider(args).future);
      setState(() {
        service = AsyncValue.data(playlistItems);
        itemsLength = playlistItems.items.length;
        finished = List.filled(itemsLength, false);
        ids = List.of(playlistItems.items.map((e) => e.id ?? ""));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFF00897B),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
          padding: const EdgeInsets.only(
            top: 20,
          ).add(EdgeInsets.symmetric(horizontal: 16)),
          child: SafeArea(
            child: Text(
              widget.name,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, con) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: con.maxHeight),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 24,
                            ),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 2),
                                  blurRadius: 8,
                                  color: Colors.black12,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Wrap(
                              alignment: WrapAlignment.spaceBetween,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              runSpacing: 20,
                              children: [
                                Text(
                                  "التقدم",
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "${percentage * 100}%",
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                LinearProgressIndicator(
                                  value: percentage,
                                  valueColor: AlwaysStoppedAnimation(
                                    Color.fromARGB(255, 13, 126, 94),
                                  ),
                                  color: Color.fromARGB(255, 13, 126, 94),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Divider(
                            thickness: 2,
                            radius: BorderRadius.circular(8),
                          ),
                          SizedBox(height: 10),
                          _playlistItems(),
                          SizedBox(height: 30),
                        ],
                      ),
                      Positioned(
                        left: 0,
                        bottom: 0,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Center(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  13,
                                  126,
                                  94,
                                ),
                                minimumSize: Size(con.maxWidth - 24, 56),
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
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _loading() {
    return const Center(
      child: CircularProgressIndicator(color: Color.fromARGB(255, 13, 126, 94)),
    );
  }

  Widget _playlistItems() {
    return Container(
      child: service.when(
        data: (data) {
          return Wrap(
            alignment: WrapAlignment.start,
            spacing: 20,
            runSpacing: 20,
            children: List.generate(data.items.length, (i) {
              final item = data.items[i];
              final snippet = item.snippet;

              if (snippet == null) {
                return Container();
              }
              return Material(
                elevation: 6,
                color: Colors.transparent,
                shadowColor: Theme.of(
                  context,
                ).colorScheme.onSurface.withAlpha(10),
                borderRadius: BorderRadius.circular(16),
                child: ListTile(
                  style: ListTileStyle.list,
                  enableFeedback: true,
                  tileColor: Theme.of(context).colorScheme.surfaceContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  title: Text(
                    snippet.title ?? "",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  leading: Checkbox(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    activeColor: Color(0xFF00897B),
                    value: finished[i],
                    onChanged: (e) {
                      setState(() {
                        finished[i] = e ?? false;
                        percentage =
                            finished.where((e) => e == true).length /
                            finished.length;
                      });
                    },
                  ),
                  onTap: () {
                    setState(() {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => YoutubeScreen(item: item),
                        ),
                      );
                    });
                  },
                ),
              );
            }),
          );
        },
        error: (err, stack) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Error: $err"),
              duration: const Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
            ),
          );
          return Center(
            child: Text("""Error: $err
Stack: $stack"""),
          );
        },
        loading: () => _loading(),
      ),
    );
  }
}
