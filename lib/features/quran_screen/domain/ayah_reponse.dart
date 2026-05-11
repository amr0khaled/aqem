class AyahsResponseBody {
  final int number;
  final String name;
  final String englishName;
  final String englishNameTranslation;
  final int numberOfAyahs;
  final String revelationType;
  final Edition edition;
  final List<AyahDetails> ayahs;

  AyahsResponseBody({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.numberOfAyahs,
    required this.revelationType,
    required this.edition,
    required this.ayahs,
  });

  factory AyahsResponseBody.fromJson(Map<String, dynamic> json) => AyahsResponseBody(
    number: json['number'],
    name: json['name'],
    englishName: json['englishName'],
    englishNameTranslation: json['englishNameTranslation'],
    numberOfAyahs: json['numberOfAyahs'],
    revelationType: json['revelationType'],
    edition: Edition.fromJson(json['edition']),
    ayahs: (json['ayahs'] as List).map((e) => AyahDetails.fromJson(e)).toList(),
  );

  Map<String, dynamic> toJson() => {
    'number': number,
    'name': name,
    'englishName': englishName,
    'englishNameTranslation': englishNameTranslation,
    'numberOfAyahs': numberOfAyahs,
    'revelationType': revelationType,
    'edition': edition.toJson(),
    'ayahs': ayahs.map((e) => e.toJson()).toList(),
  };
}

class Edition {
  final String identifier;
  final String language;
  final String name;
  final String englishName;
  final String format;
  final String type;
  final String direction;

  Edition({
    required this.identifier,
    required this.language,
    required this.name,
    required this.englishName,
    required this.format,
    required this.type,
    required this.direction,
  });

  factory Edition.fromJson(Map<String, dynamic> json) => Edition(
    identifier: json['identifier'],
    language: json['language'],
    name: json['name'],
    englishName: json['englishName'],
    format: json['format'],
    type: json['type'],
    direction: json['direction'],
  );

  Map<String, dynamic> toJson() => {
    'identifier': identifier,
    'language': language,
    'name': name,
    'englishName': englishName,
    'format': format,
    'type': type,
    'direction': direction,
  };
}

class AyahDetails {
  final int hizbQuarter;
  final int juz;
  final int manzil;
  final int number;
  final int numberInSurah;
  final int page;
  final int ruku;
  final bool sajda;
  final String text;

  AyahDetails({
    required this.hizbQuarter,
    required this.juz,
    required this.manzil,
    required this.number,
    required this.numberInSurah,
    required this.page,
    required this.ruku,
    required this.sajda,
    required this.text,
  });

  factory AyahDetails.fromJson(Map<String, dynamic> json) => AyahDetails(
    hizbQuarter: json['hizbQuarter'],
    juz: json['juz'],
    manzil: json['manzil'],
    number: json['number'],
    numberInSurah: json['numberInSurah'],
    page: json['page'],
    ruku: json['ruku'],
    sajda: json['sajda'],
    text: json['text'],
  );

  Map<String, dynamic> toJson() => {
    'hizbQuarter': hizbQuarter,
    'juz': juz,
    'manzil': manzil,
    'number': number,
    'numberInSurah': numberInSurah,
    'page': page,
    'ruku': ruku,
    'sajda': sajda,
    'text': text,
  };
}
