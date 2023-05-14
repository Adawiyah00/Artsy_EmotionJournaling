import 'package:flutter/material.dart';

import '../database/MoodActivityDBHelper.dart';

class Activity extends ChangeNotifier {
  String? image;
  String? name;
  int? id;
  bool? isSelected = false;

  Activity({this.image, this.name,this.id});

  Future<void> addActivity(String datetime, String image, String name) async {
    MoodActivityDBHelper.insert('moods_activity', {
      'datetime': datetime,
      'moodActivityImage': image,
      'moodActivityName': name,
    });
    notifyListeners();
  }

  Future<void> deleteActivity(int id) async {
    MoodActivityDBHelper.delete(id);
    notifyListeners();
  }

  Future<void> updateActivity(int id,String datetime, String mood, String image) async {
    MoodActivityDBHelper.update(
        'moods_activity',
        {
          'datetime': datetime,
          'moodActivityName': mood,
          'moodActivityImage': image,
        },
        id);
    notifyListeners();
  }
  Future<void> updateActivityImage(int id,String datetime,  String image) async {
    MoodActivityDBHelper.update(
        'moods_activity',
        {
          'datetime': datetime,
          'moodActivityImage': image,
        },
        id);
    notifyListeners();
  }
}
