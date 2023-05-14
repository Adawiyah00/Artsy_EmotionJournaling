import '../utils/Extensions/shared_pref.dart';
import 'package:mobx/mobx.dart';
import '../utils/constant.dart';

part 'AppStore.g.dart';

class AppStore = _AppStore with _$AppStore;

abstract class _AppStore with Store {
  @observable
  bool isDarkModeOn = false;

  @observable
  bool isLoading = false;

  @observable
  String name = '';

  @observable
  bool isDailyNotificationOn = false;

  @observable
  String? reminderTime = '';

  @observable
  bool? isShowIcon = false;


  @action
  void setNikName(String nikName) {
    name = nikName;
    setValue(NICK_NAME, nikName);
  }





  @action
  void setLoading(bool val) => isLoading = val;
}
