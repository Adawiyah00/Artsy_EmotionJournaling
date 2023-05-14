import '../model/MoodModel.dart';
import '../model/Activity.dart';
import 'package:mobx/mobx.dart';
import '../model/Mood.dart';
import '../model/MoodTagModel.dart';
import '../model/TalkMoreModel.dart';

part 'HealthStore.g.dart';

class HealthStore = _HealthStore with _$HealthStore;

abstract class _HealthStore with Store {
  @observable
  List<MoodModel> moodList = ObservableList<MoodModel>();

  @observable
  List<Activity> activityList = ObservableList<Activity>();

  @observable
  List<MoodTagModel> moodTagList = ObservableList<MoodTagModel>();

  @observable
  List<TalkMoreModel> talkMoreList = ObservableList<TalkMoreModel>();

  @observable
  List<Mood> moodCheckList = ObservableList<Mood>();

  @observable
  List<String> mMood = ObservableList<String>();

  @observable
  List<String> mMoodPhotos = ObservableList<String>();

  @observable
  String? audioNote = '';

  @observable
  String note = '';

  @observable
  bool loaderCheck = false;

  @observable
  List<Mood> mFilterMood = ObservableList<Mood>();

  @action
  Future<void> setNotes(String notes) async {
    note = notes;
  }

  @action
  Future<void> setAudioNote(String notes) async {
    audioNote = notes;
  }

  @action
  Future<void> clearAudioNote() async {
    audioNote = '';
  }

  @action
  Future<void> setMoodPhotos(List<String> photo) async {
    mMoodPhotos.addAll(photo);
  }

  @action
  Future<void> setMoodPhotosClear() async {
    mMoodPhotos.clear();
  }

  //Mood
  @action
  Future<void> addToMood(MoodModel data) async {
    moodList.add(data);
  }

  @action
  Future<void> addMood(String data) async {
    mMood.add(data);
  }

  @action
  void addAllMoodItem(List<MoodModel> moodList) {
    moodList.addAll(moodList);
  }

  @action
  Future<void> clearMood() async {
    moodList.clear();
  }

  @action
  Future<void> removeMood(MoodModel data) async {
    moodList.remove(data);
  }

  //Activity
  @action
  Future<void> addToActivity(Activity data) async {
    activityList.add(data);
  }

  bool isItemInActivityList(int id) {
    return activityList.any((element) => element.id == id);
  }

  @action
  void addAllActivityItem(List<Activity> activityList) {
    activityList.addAll(activityList);
  }

  @action
  void addActivityItem(List<Activity> activityLists) {
    activityList = activityLists;
  }

  @action
  Future<void> clearActivity() async {
    activityList.clear();
  }

  @action
  Future<void> removeActivity(Activity data) async {
    activityList.remove(data);
  }

  // Mood Tag
  @action
  Future<void> addToMoodTag(MoodTagModel data) async {
    moodTagList.add(data);
  }

  bool isItemInMoodTagList(int id) {
    return moodTagList.any((element) => element.id == id);
  }

  @action
  void addAllMoodTagItem(List<MoodTagModel> moodTagList) {
    moodTagList.addAll(moodTagList);
  }

  @action
  void addMoodTagItem(List<MoodTagModel> moodTagLists) {
    moodTagList = moodTagLists;
  }

  @action
  Future<void> clearMoodTag() async {
    moodTagList.clear();
  }

  @action
  Future<void> removeMoodTag(MoodTagModel data) async {
    moodTagList.remove(data);
  }

  // Talk More
  @action
  Future<void> addToTalkMore(TalkMoreModel data) async {
    talkMoreList.add(data);
  }

  @action
  void addAllTalkMoreItem(List<TalkMoreModel> talkMoreList) {
    talkMoreList.addAll(talkMoreList);
  }

  @action
  Future<void> clearTalkMore() async {
    talkMoreList.clear();
  }

  @action
  Future<void> removeTalkMore(TalkMoreModel data) async {
    talkMoreList.remove(data);
  }

  // Mood Check
  @action
  Future<void> addToMoodCheck(Mood data) async {
    moodCheckList.add(data);
  }

  @action
  void addAllMoodCheckItem(List<Mood> moodCheckList) {
    moodCheckList.addAll(moodCheckList);
  }

  @action
  Future<void> clearMoodCheck() async {
    moodCheckList.clear();
  }

  @action
  Future<void> removeMoodCheck(Mood data) async {
    moodCheckList.remove(data);
  }
  @action
  Future<void> removeMoodCheckByID(int data) async {
    moodCheckList.remove(data);
  }
  //Filter
  @action
  Future<void> addFilterMood(Mood data) async {
    mFilterMood.add(data);
  }

  @action
  Future<void> clearMoodFilter() async {
    mFilterMood.clear();
  }

  @action
  Future<void> removeMoodFilter(Mood data) async {
    mFilterMood.remove(data);
  }
}
