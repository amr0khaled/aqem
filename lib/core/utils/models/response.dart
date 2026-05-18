import 'package:googleapis/youtube/v3.dart';

class YoutubeResponse<T> {
  final String? nextPageToken;
  final String? prevPageToken;
  final int totalResults;
  final int resultsPerPage;
  final List<T> items;

  YoutubeResponse({
    this.nextPageToken,
    this.prevPageToken,
    required this.totalResults,
    required this.resultsPerPage,
    required this.items,
  });

  bool get hasNextPage => nextPageToken != null;
}
