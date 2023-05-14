import 'package:flutter/cupertino.dart';

import '../database/MoodTagDBHelper.dart';

class MoodTagModel extends ChangeNotifier {
  String? image;
  String? name;
  int? id;

  MoodTagModel({this.image, this.name, this.id});

  Future<void> addMoodTag(String datetime, String image, String name) async {
    MooTagDBHelper.insert('mood_tag', {
      'datetime': datetime,
      'moodTagImage': image,
      'moodTagName': name,
    });
    notifyListeners();
  }

  Future<void> deleteMoodTag(int id) async {
    MooTagDBHelper.delete(id);
    notifyListeners();
  }

  Future<void> updateMoodTag(int id, String dateTime, String mood, String image) async {
    MooTagDBHelper.update(
        'mood_tag',
        {
          'datetime': dateTime,
          'moodTagName': mood,
          'moodTagImage': image,
        },
        id);
    notifyListeners();
  }

  Future<void> updateMoodImg(int id, String dateTime, String image) async {
    MooTagDBHelper.update(
        'mood_tag',
        {
          'datetime': dateTime,
          'moodTagImage': image,
        },
        id);
    notifyListeners();
  }
}
