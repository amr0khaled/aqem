import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
enum DuaCategory { sabah, masaa, nawm, salah, daily, hefz }

class DuaRecord {
  final String dua, duaNarrator;
  final List<String> duaNotices;
  final DuaCategory category;
  final int count;
  int currentCount;
  bool isFavourite, isComplete;

  DuaRecord({
    required this.dua,
    required this.duaNarrator,
    required this.duaNotices,
    required this.category,
    this.isFavourite = false,
    this.isComplete = false,
    required this.count,
    int? currentCount,
  }):currentCount = currentCount ?? count;

  //factory constructor to create a DuaRecord from a JSON map
  factory DuaRecord.fromJson(Map<String, dynamic> json) {
    return DuaRecord(
      dua: json['dua'] ?? '',
      duaNarrator: json['duaNarrator'] ?? '',
      // Convert JSON array to a Dart List of Strings
      duaNotices: List<String>.from(json['duaNotices'] ?? []),
      // Match the string in JSON to the exact enum name
      category: DuaCategory.values.firstWhere(
            (e) => e.name == json['category'],
        orElse: () => DuaCategory.sabah, // Fallback just in case
      ),
      count: json['count'] ?? 1,
      currentCount: json['currentCount'],
      isFavourite: json['isFavourite'] ?? false,
      isComplete: json['isComplete'] ?? false,
    );
  }

  // this right below your fromJson method
  Map<String, dynamic> toJson() {
    return {
      'dua': dua,
      'duaNarrator': duaNarrator,
      'duaNotices': duaNotices,
      'category': category.name, // Convert enum back to string
      'count': count,
      'currentCount': currentCount,
      'isFavourite': isFavourite,
      'isComplete': isComplete,
    };
  }
}

// Declare a global or state variable to hold the data once loaded
List<DuaRecord> duaData = [];

Future<File> _getLocalFile() async {
  final directory = await getApplicationDocumentsDirectory();
  return File('${directory.path}/local_dua_data.json');
}

Future<void> initDuaData() async {
  final file = await _getLocalFile();

  if (await file.exists()) {
    // FIle exists locally! Read it from the device (keeps your favorites saved)
    final String jsonString = await file.readAsString();
    final List<dynamic> jsonList = jsonDecode(jsonString);
    duaData = jsonList.map((json) => DuaRecord.fromJson(json)).toList();
  } else {
    // First time opening the app! Load from assets and save locally
    final String jsonString = await rootBundle.loadString('assets/dua_data.json');
    final List<dynamic> jsonList = jsonDecode(jsonString);
    duaData = jsonList.map((json) => DuaRecord.fromJson(json)).toList();

    // Save a copy to local storage immediately
    await saveDuaData();
  }
}

// Call this function whenever a favorite or complete button is clicked!
Future<void> saveDuaData() async {
  final file = await _getLocalFile();
  // Convert our Dart objects back into JSON
  final List<Map<String, dynamic>> jsonList = duaData.map((d) => d.toJson()).toList();
  // Write the file to the device
  await file.writeAsString(jsonEncode(jsonList));
}
