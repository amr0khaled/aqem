part of "../data/provider.dart";

class PlaylistArgs {
  final String? token;
  final int? max;
  final List<String> ids;
  const PlaylistArgs({this.token, this.max, required this.ids});
}

class PlaylistItemArgs {
  final String? token;
  final int? max;
  final String id;
  const PlaylistItemArgs({this.token, this.max, required this.id});
}
