import 'package:flutter/cupertino.dart';
import '../database/DbHelper.dart';
import 'MoodModel.dart';

class Mood extends ChangeNotifier {
  int? id;
  String? dateTime;
  int? moodId;
  String? moodName;
  String? moodImg;
  List<String>? activityId;
  List<String>? activityImg;
  List<String>? activityName;
  String? note;
  List<String>? tagId;
  List<String>? tagImg;
  List<String>? tagName;
  String? voiceNote;
  List<String>? photos;
  String? date;
  List<ActivityListModel>? mActivity;
  List<ActivityListModel>? mMood;

  Mood(
      {this.id,
      this.dateTime,
      this.moodName,
      this.moodId,
      this.moodImg,
      this.activityId,
      this.activityImg,
      this.activityName,
      this.note,
      this.tagId,
      this.tagImg,
      this.tagName,
      this.voiceNote,
      this.photos,
      this.date,
      this.mActivity,
      this.mMood});

  Future<void> addMood(
      {String? datetime,
      String? date,
      int? moodid,
      String? mood,
      String? image,
      String? actid,
      String? actimage,
      String? actname,
      String? note,
      String? tagId,
      String? tag,
      String? tagImage,
      String? voiceNote,
      String? photos}) async {
    DBHelper.insert('user_moods', {
      'datetime': datetime!,
      'date': date!,
      'mood_id': moodid!,
      'mood': mood!,
      'image': image!,
      'act_id': actid!,
      'actimage': actimage!,
      'actname': actname!,
      'note': note!,
      'tag_id': tagId!,
      'tag': tag!,
      'tagImage': tagImage!,
      'voiceNote': voiceNote!,
      'photos': photos!,
    });
    notifyListeners();
  }

  Future<void> deleteMood(int datetime) async {
    DBHelper.delete(datetime);
    notifyListeners();
  }

  Future<void> updateMood(
      {int? id,
      String? datetime,
      String? date,
      int? moodid,
      String? mood,
      String? image,
      String? actid,
      String? actimage,
      String? actname,
      String? note,
      String? tagId,
      String? tag,
      String? tagImage,
      String? voiceNote,
      String? photos}) async {
    DBHelper.update(
        'user_moods',
        {
          'id': id!,
          'datetime': datetime!,
          'date': date!,
          'mood_id': moodid!,
          'mood': mood!,
          'image': image!,
          'act_id': actid!,
          'actimage': actimage!,
          'actname': actname!,
          'note': note!,
          'tag_id': tagId!,
          'tag': tag!,
          'tagImage': tagImage!,
          'voiceNote': voiceNote!,
          'photos': photos!,
        },
        id);
    notifyListeners();
  }
}
