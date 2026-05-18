import 'package:aqem/core/utils/models/response.dart';
import 'package:aqem/core/utils/services/api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googleapis/youtube/v3.dart';
part "../domain/args.dart";

final ytApiServiceProvider = Provider((ref) => YoutubeApiService());

final playlistProvider =
    FutureProvider.family<YoutubeResponse<Playlist>, PlaylistArgs>((
      ref,
      args,
    ) async {
      final service = ref.watch(ytApiServiceProvider);
      final res = await service.fetchPlaylistMetadata(
        args.ids,
        token: args.token,
        max: args.max,
      );
      print("In provider got it ${res.items.length}");
      return res;
    });

final playlistItemsProvider =
    FutureProvider.family<YoutubeResponse<PlaylistItem>, PlaylistItemArgs>((
      ref,
      args,
    ) async {
      final service = ref.watch(ytApiServiceProvider);
      return service.fetchPlaylistItems(
        args.id,
        pageToken: args.token,
        maxResults: args.max,
      );
    });
