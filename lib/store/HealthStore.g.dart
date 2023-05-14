// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HealthStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HealthStore on _HealthStore, Store {
  late final _$moodListAtom =
      Atom(name: '_HealthStore.moodList', context: context);

  @override
  List<MoodModel> get moodList {
    _$moodListAtom.reportRead();
    return super.moodList;
  }

  @override
  set moodList(List<MoodModel> value) {
    _$moodListAtom.reportWrite(value, super.moodList, () {
      super.moodList = value;
    });
  }

  late final _$activityListAtom =
      Atom(name: '_HealthStore.activityList', context: context);

  @override
  List<Activity> get activityList {
    _$activityListAtom.reportRead();
    return super.activityList;
  }

  @override
  set activityList(List<Activity> value) {
    _$activityListAtom.reportWrite(value, super.activityList, () {
      super.activityList = value;
    });
  }

  late final _$moodTagListAtom =
      Atom(name: '_HealthStore.moodTagList', context: context);

  @override
  List<MoodTagModel> get moodTagList {
    _$moodTagListAtom.reportRead();
    return super.moodTagList;
  }

  @override
  set moodTagList(List<MoodTagModel> value) {
    _$moodTagListAtom.reportWrite(value, super.moodTagList, () {
      super.moodTagList = value;
    });
  }

  late final _$talkMoreListAtom =
      Atom(name: '_HealthStore.talkMoreList', context: context);

  @override
  List<TalkMoreModel> get talkMoreList {
    _$talkMoreListAtom.reportRead();
    return super.talkMoreList;
  }

  @override
  set talkMoreList(List<TalkMoreModel> value) {
    _$talkMoreListAtom.reportWrite(value, super.talkMoreList, () {
      super.talkMoreList = value;
    });
  }

  late final _$moodCheckListAtom =
      Atom(name: '_HealthStore.moodCheckList', context: context);

  @override
  List<Mood> get moodCheckList {
    _$moodCheckListAtom.reportRead();
    return super.moodCheckList;
  }

  @override
  set moodCheckList(List<Mood> value) {
    _$moodCheckListAtom.reportWrite(value, super.moodCheckList, () {
      super.moodCheckList = value;
    });
  }

  late final _$mMoodAtom = Atom(name: '_HealthStore.mMood', context: context);

  @override
  List<String> get mMood {
    _$mMoodAtom.reportRead();
    return super.mMood;
  }

  @override
  set mMood(List<String> value) {
    _$mMoodAtom.reportWrite(value, super.mMood, () {
      super.mMood = value;
    });
  }

  late final _$mMoodPhotosAtom =
      Atom(name: '_HealthStore.mMoodPhotos', context: context);

  @override
  List<String> get mMoodPhotos {
    _$mMoodPhotosAtom.reportRead();
    return super.mMoodPhotos;
  }

  @override
  set mMoodPhotos(List<String> value) {
    _$mMoodPhotosAtom.reportWrite(value, super.mMoodPhotos, () {
      super.mMoodPhotos = value;
    });
  }

  late final _$audioNoteAtom =
      Atom(name: '_HealthStore.audioNote', context: context);

  @override
  String? get audioNote {
    _$audioNoteAtom.reportRead();
    return super.audioNote;
  }

  @override
  set audioNote(String? value) {
    _$audioNoteAtom.reportWrite(value, super.audioNote, () {
      super.audioNote = value;
    });
  }

  late final _$noteAtom = Atom(name: '_HealthStore.note', context: context);

  @override
  String get note {
    _$noteAtom.reportRead();
    return super.note;
  }

  @override
  set note(String value) {
    _$noteAtom.reportWrite(value, super.note, () {
      super.note = value;
    });
  }

  late final _$loaderCheckAtom =
      Atom(name: '_HealthStore.loaderCheck', context: context);

  @override
  bool get loaderCheck {
    _$loaderCheckAtom.reportRead();
    return super.loaderCheck;
  }

  @override
  set loaderCheck(bool value) {
    _$loaderCheckAtom.reportWrite(value, super.loaderCheck, () {
      super.loaderCheck = value;
    });
  }

  late final _$mFilterMoodAtom =
      Atom(name: '_HealthStore.mFilterMood', context: context);

  @override
  List<Mood> get mFilterMood {
    _$mFilterMoodAtom.reportRead();
    return super.mFilterMood;
  }

  @override
  set mFilterMood(List<Mood> value) {
    _$mFilterMoodAtom.reportWrite(value, super.mFilterMood, () {
      super.mFilterMood = value;
    });
  }

  late final _$setNotesAsyncAction =
      AsyncAction('_HealthStore.setNotes', context: context);

  @override
  Future<void> setNotes(String notes) {
    return _$setNotesAsyncAction.run(() => super.setNotes(notes));
  }

  late final _$setAudioNoteAsyncAction =
      AsyncAction('_HealthStore.setAudioNote', context: context);

  @override
  Future<void> setAudioNote(String notes) {
    return _$setAudioNoteAsyncAction.run(() => super.setAudioNote(notes));
  }

  late final _$clearAudioNoteAsyncAction =
      AsyncAction('_HealthStore.clearAudioNote', context: context);

  @override
  Future<void> clearAudioNote() {
    return _$clearAudioNoteAsyncAction.run(() => super.clearAudioNote());
  }

  late final _$setMoodPhotosAsyncAction =
      AsyncAction('_HealthStore.setMoodPhotos', context: context);

  @override
  Future<void> setMoodPhotos(List<String> photo) {
    return _$setMoodPhotosAsyncAction.run(() => super.setMoodPhotos(photo));
  }

  late final _$setMoodPhotosClearAsyncAction =
      AsyncAction('_HealthStore.setMoodPhotosClear', context: context);

  @override
  Future<void> setMoodPhotosClear() {
    return _$setMoodPhotosClearAsyncAction
        .run(() => super.setMoodPhotosClear());
  }

  late final _$addToMoodAsyncAction =
      AsyncAction('_HealthStore.addToMood', context: context);

  @override
  Future<void> addToMood(MoodModel data) {
    return _$addToMoodAsyncAction.run(() => super.addToMood(data));
  }

  late final _$addMoodAsyncAction =
      AsyncAction('_HealthStore.addMood', context: context);

  @override
  Future<void> addMood(String data) {
    return _$addMoodAsyncAction.run(() => super.addMood(data));
  }

  late final _$clearMoodAsyncAction =
      AsyncAction('_HealthStore.clearMood', context: context);

  @override
  Future<void> clearMood() {
    return _$clearMoodAsyncAction.run(() => super.clearMood());
  }

  late final _$removeMoodAsyncAction =
      AsyncAction('_HealthStore.removeMood', context: context);

  @override
  Future<void> removeMood(MoodModel data) {
    return _$removeMoodAsyncAction.run(() => super.removeMood(data));
  }

  late final _$addToActivityAsyncAction =
      AsyncAction('_HealthStore.addToActivity', context: context);

  @override
  Future<void> addToActivity(Activity data) {
    return _$addToActivityAsyncAction.run(() => super.addToActivity(data));
  }

  late final _$clearActivityAsyncAction =
      AsyncAction('_HealthStore.clearActivity', context: context);

  @override
  Future<void> clearActivity() {
    return _$clearActivityAsyncAction.run(() => super.clearActivity());
  }

  late final _$removeActivityAsyncAction =
      AsyncAction('_HealthStore.removeActivity', context: context);

  @override
  Future<void> removeActivity(Activity data) {
    return _$removeActivityAsyncAction.run(() => super.removeActivity(data));
  }

  late final _$addToMoodTagAsyncAction =
      AsyncAction('_HealthStore.addToMoodTag', context: context);

  @override
  Future<void> addToMoodTag(MoodTagModel data) {
    return _$addToMoodTagAsyncAction.run(() => super.addToMoodTag(data));
  }

  late final _$clearMoodTagAsyncAction =
      AsyncAction('_HealthStore.clearMoodTag', context: context);

  @override
  Future<void> clearMoodTag() {
    return _$clearMoodTagAsyncAction.run(() => super.clearMoodTag());
  }

  late final _$removeMoodTagAsyncAction =
      AsyncAction('_HealthStore.removeMoodTag', context: context);

  @override
  Future<void> removeMoodTag(MoodTagModel data) {
    return _$removeMoodTagAsyncAction.run(() => super.removeMoodTag(data));
  }

  late final _$addToTalkMoreAsyncAction =
      AsyncAction('_HealthStore.addToTalkMore', context: context);

  @override
  Future<void> addToTalkMore(TalkMoreModel data) {
    return _$addToTalkMoreAsyncAction.run(() => super.addToTalkMore(data));
  }

  late final _$clearTalkMoreAsyncAction =
      AsyncAction('_HealthStore.clearTalkMore', context: context);

  @override
  Future<void> clearTalkMore() {
    return _$clearTalkMoreAsyncAction.run(() => super.clearTalkMore());
  }

  late final _$removeTalkMoreAsyncAction =
      AsyncAction('_HealthStore.removeTalkMore', context: context);

  @override
  Future<void> removeTalkMore(TalkMoreModel data) {
    return _$removeTalkMoreAsyncAction.run(() => super.removeTalkMore(data));
  }

  late final _$addToMoodCheckAsyncAction =
      AsyncAction('_HealthStore.addToMoodCheck', context: context);

  @override
  Future<void> addToMoodCheck(Mood data) {
    return _$addToMoodCheckAsyncAction.run(() => super.addToMoodCheck(data));
  }

  late final _$clearMoodCheckAsyncAction =
      AsyncAction('_HealthStore.clearMoodCheck', context: context);

  @override
  Future<void> clearMoodCheck() {
    return _$clearMoodCheckAsyncAction.run(() => super.clearMoodCheck());
  }

  late final _$removeMoodCheckAsyncAction =
      AsyncAction('_HealthStore.removeMoodCheck', context: context);

  @override
  Future<void> removeMoodCheck(Mood data) {
    return _$removeMoodCheckAsyncAction.run(() => super.removeMoodCheck(data));
  }

  late final _$removeMoodCheckByIDAsyncAction =
      AsyncAction('_HealthStore.removeMoodCheckByID', context: context);

  @override
  Future<void> removeMoodCheckByID(int data) {
    return _$removeMoodCheckByIDAsyncAction
        .run(() => super.removeMoodCheckByID(data));
  }

  late final _$addFilterMoodAsyncAction =
      AsyncAction('_HealthStore.addFilterMood', context: context);

  @override
  Future<void> addFilterMood(Mood data) {
    return _$addFilterMoodAsyncAction.run(() => super.addFilterMood(data));
  }

  late final _$clearMoodFilterAsyncAction =
      AsyncAction('_HealthStore.clearMoodFilter', context: context);

  @override
  Future<void> clearMoodFilter() {
    return _$clearMoodFilterAsyncAction.run(() => super.clearMoodFilter());
  }

  late final _$removeMoodFilterAsyncAction =
      AsyncAction('_HealthStore.removeMoodFilter', context: context);

  @override
  Future<void> removeMoodFilter(Mood data) {
    return _$removeMoodFilterAsyncAction
        .run(() => super.removeMoodFilter(data));
  }

  late final _$_HealthStoreActionController =
      ActionController(name: '_HealthStore', context: context);

  @override
  void addAllMoodItem(List<MoodModel> moodList) {
    final _$actionInfo = _$_HealthStoreActionController.startAction(
        name: '_HealthStore.addAllMoodItem');
    try {
      return super.addAllMoodItem(moodList);
    } finally {
      _$_HealthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addAllActivityItem(List<Activity> activityList) {
    final _$actionInfo = _$_HealthStoreActionController.startAction(
        name: '_HealthStore.addAllActivityItem');
    try {
      return super.addAllActivityItem(activityList);
    } finally {
      _$_HealthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addActivityItem(List<Activity> activityLists) {
    final _$actionInfo = _$_HealthStoreActionController.startAction(
        name: '_HealthStore.addActivityItem');
    try {
      return super.addActivityItem(activityLists);
    } finally {
      _$_HealthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addAllMoodTagItem(List<MoodTagModel> moodTagList) {
    final _$actionInfo = _$_HealthStoreActionController.startAction(
        name: '_HealthStore.addAllMoodTagItem');
    try {
      return super.addAllMoodTagItem(moodTagList);
    } finally {
      _$_HealthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addMoodTagItem(List<MoodTagModel> moodTagLists) {
    final _$actionInfo = _$_HealthStoreActionController.startAction(
        name: '_HealthStore.addMoodTagItem');
    try {
      return super.addMoodTagItem(moodTagLists);
    } finally {
      _$_HealthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addAllTalkMoreItem(List<TalkMoreModel> talkMoreList) {
    final _$actionInfo = _$_HealthStoreActionController.startAction(
        name: '_HealthStore.addAllTalkMoreItem');
    try {
      return super.addAllTalkMoreItem(talkMoreList);
    } finally {
      _$_HealthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addAllMoodCheckItem(List<Mood> moodCheckList) {
    final _$actionInfo = _$_HealthStoreActionController.startAction(
        name: '_HealthStore.addAllMoodCheckItem');
    try {
      return super.addAllMoodCheckItem(moodCheckList);
    } finally {
      _$_HealthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
moodList: ${moodList},
activityList: ${activityList},
moodTagList: ${moodTagList},
talkMoreList: ${talkMoreList},
moodCheckList: ${moodCheckList},
mMood: ${mMood},
mMoodPhotos: ${mMoodPhotos},
audioNote: ${audioNote},
note: ${note},
loaderCheck: ${loaderCheck},
mFilterMood: ${mFilterMood}
    ''';
  }
}
