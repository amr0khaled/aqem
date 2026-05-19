import 'package:googleapis/youtube/v3.dart';
enum PlaylistFunction {
  tajweed,
  recitation,
  stories,
ChildrenMemorize,
  AdultMemorize,
  other,
}
class Category {
  final String language;
  final PlaylistFunction function;
  final Playlist playlist;
  Category({
    required this.language,
    required this.function,
    required this.playlist,
  });
}
class PlaylistCategorizer {
  //manually
  static final Map<String, PlaylistFunction> _idToFunction = {
    "PL3Q0fwpkr-mE0z2YIGoAQ2u_e1dC6jyp7": PlaylistFunction.AdultMemorize,
    "PLa4GKxenTk5XGzNcexkFzVJfVMjic6izh": PlaylistFunction.stories,
    "PLKhm8Z5pXdOXjBYqLvu2L2YCghTEPkMJj":PlaylistFunction.ChildrenMemorize

  };

  static String detectLanguage(String title) {
    final hasArabic = RegExp(r'[\u0600-\u06FF]').hasMatch(title);
    if (hasArabic) {
      return 'العربية';
    }
    return 'English';
  }

  static PlaylistFunction detectFunction(String title, String playlistId) {
    if (_idToFunction.containsKey(playlistId)) {
      return _idToFunction[playlistId]!;
    }
    final lowerTitle = title.toLowerCase();
    if (lowerTitle.contains('tajweed') ||
        lowerTitle.contains('تجويد') ||
        lowerTitle.contains('tajwid') ||
        lowerTitle.contains('تجوید')) {
      return PlaylistFunction.tajweed;
    }

    if (lowerTitle.contains('recitation') ||
        lowerTitle.contains('تلاوة') ||
        lowerTitle.contains('tilawah') ||
        lowerTitle.contains('قراءة') ||
        lowerTitle.contains('تلاوة')) {
      return PlaylistFunction.recitation;
    }
    if (lowerTitle.contains('story') ||
        lowerTitle.contains('stories') ||
        lowerTitle.contains('قصة') ||
        lowerTitle.contains('قصص') ) {
      return PlaylistFunction.stories;
    }

    if (lowerTitle.contains('حفظ') || lowerTitle.contains('memorize')|lowerTitle.contains('learn') ){
      if (lowerTitle.contains('اظفال')||lowerTitle.contains('child')||lowerTitle.contains('kids')){
        return PlaylistFunction.ChildrenMemorize;
      }
      return PlaylistFunction.AdultMemorize;
    }

    return PlaylistFunction.other;
  }

  static String getFunctionName(PlaylistFunction function, String language) {
    switch (function) {
      case PlaylistFunction.tajweed:
        return language == 'العربية' ? 'أحكام التجويد' : 'Tajweed Rules';
      case PlaylistFunction.recitation:
        return language == 'العربية' ? 'دروس التلاوة' : 'Recitation Lessons';
      case PlaylistFunction.stories:
        return language == 'العربية' ? 'قصص قرآنية' : 'Quranic Stories';
      case PlaylistFunction.AdultMemorize:
        return language == 'العربية' ? 'حفظ القرآن للبالغين' : 'Memorizing Quran For Adults';
      case PlaylistFunction.ChildrenMemorize:
        return language == 'العربية' ? 'حفظ القرآن للأطفال' : 'Memorizing Quran For Children';
      case PlaylistFunction.other:
        return language == 'العربية' ? 'أخرى' : 'Other';
    }
  }
  static Map<String, Map<PlaylistFunction, List<Playlist>>> categorize(
      List<Playlist> playlists,
      ) {
    final Map<String, Map<PlaylistFunction, List<Playlist>>> result = {};

    for (final playlist in playlists) {
      final title = playlist.snippet?.title ?? 'Untitled';
      final id = playlist.id ?? '';

      final language = detectLanguage(title);
      final function = detectFunction(title, id);

      result.putIfAbsent(language, () => {});
      result[language]!.putIfAbsent(function, () => []);
      result[language]![function]!.add(playlist);
    }
    for (final language in result.keys) {
      final sortedFunctions = <PlaylistFunction, List<Playlist>>{};
      final order = [
        PlaylistFunction.tajweed,
        PlaylistFunction.recitation,
        PlaylistFunction.stories,
        PlaylistFunction.AdultMemorize,
        PlaylistFunction.ChildrenMemorize,
        PlaylistFunction.other,
      ];
      for (final func in order) {
        if (result[language]!.containsKey(func)) {
          sortedFunctions[func] = result[language]![func]!;
        }
      }
      result[language] = sortedFunctions;
    }

    return result;
  }
}