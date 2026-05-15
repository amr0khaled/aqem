class SurahsResponseBody {
  final int count;
  final List<SurahDetails> surahs;

  SurahsResponseBody({required this.count, required this.surahs});

  factory SurahsResponseBody.fromJson(Map<String, dynamic> json) =>
      SurahsResponseBody(
        count: json['count'],
        surahs: (json['surahs'] as List)
            .map((e) => SurahDetails.fromJson(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
    'count': count,
    'surahs': surahs.map((e) => e.toJson()).toList(),
  };
}

class SurahDetails {
  final int number;
  final String name;
  final String englishName;
  final String englishNameTranslation;
  final int numberOfAyahs;
  final String revelationType;

  SurahDetails({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.numberOfAyahs,
    required this.revelationType,
  });

  factory SurahDetails.fromJson(Map<String, dynamic> json) => SurahDetails(
    number: json['number'],
    name: json['name'],
    englishName: json['englishName'],
    englishNameTranslation: json['englishNameTranslation'],
    numberOfAyahs: json['numberOfAyahs'],
    revelationType: json['revelationType'],
  );

  Map<String, dynamic> toJson() => {
    'number': number,
    'name': name,
    'englishName': englishName,
    'englishNameTranslation': englishNameTranslation,
    'numberOfAyahs': numberOfAyahs,
    'revelationType': revelationType,
  };
}
