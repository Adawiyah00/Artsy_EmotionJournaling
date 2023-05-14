// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppStore on _AppStore, Store {
  late final _$isDarkModeOnAtom =
      Atom(name: '_AppStore.isDarkModeOn', context: context);

  @override
  bool get isDarkModeOn {
    _$isDarkModeOnAtom.reportRead();
    return super.isDarkModeOn;
  }

  @override
  set isDarkModeOn(bool value) {
    _$isDarkModeOnAtom.reportWrite(value, super.isDarkModeOn, () {
      super.isDarkModeOn = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_AppStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$nameAtom = Atom(name: '_AppStore.name', context: context);

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$isDailyNotificationOnAtom =
      Atom(name: '_AppStore.isDailyNotificationOn', context: context);

  @override
  bool get isDailyNotificationOn {
    _$isDailyNotificationOnAtom.reportRead();
    return super.isDailyNotificationOn;
  }

  @override
  set isDailyNotificationOn(bool value) {
    _$isDailyNotificationOnAtom.reportWrite(value, super.isDailyNotificationOn,
        () {
      super.isDailyNotificationOn = value;
    });
  }

  late final _$reminderTimeAtom =
      Atom(name: '_AppStore.reminderTime', context: context);

  @override
  String? get reminderTime {
    _$reminderTimeAtom.reportRead();
    return super.reminderTime;
  }

  @override
  set reminderTime(String? value) {
    _$reminderTimeAtom.reportWrite(value, super.reminderTime, () {
      super.reminderTime = value;
    });
  }

  late final _$isShowIconAtom =
      Atom(name: '_AppStore.isShowIcon', context: context);

  @override
  bool? get isShowIcon {
    _$isShowIconAtom.reportRead();
    return super.isShowIcon;
  }

  @override
  set isShowIcon(bool? value) {
    _$isShowIconAtom.reportWrite(value, super.isShowIcon, () {
      super.isShowIcon = value;
    });
  }

  late final _$_AppStoreActionController =
      ActionController(name: '_AppStore', context: context);

  @override
  void setNikName(String nikName) {
    final _$actionInfo =
        _$_AppStoreActionController.startAction(name: '_AppStore.setNikName');
    try {
      return super.setNikName(nikName);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool val) {
    final _$actionInfo =
        _$_AppStoreActionController.startAction(name: '_AppStore.setLoading');
    try {
      return super.setLoading(val);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isDarkModeOn: ${isDarkModeOn},
isLoading: ${isLoading},
name: ${name},
isDailyNotificationOn: ${isDailyNotificationOn},
reminderTime: ${reminderTime},
isShowIcon: ${isShowIcon}
    ''';
  }
}
