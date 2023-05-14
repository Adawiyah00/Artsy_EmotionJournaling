import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Extensions/AppButton.dart';
import '../Extensions/color_extensions.dart';
import '../Extensions/context_extensions.dart';
import '../Extensions/text_styles.dart';
import '../Extensions/string_extensions.dart';
import '../../main.dart';
import '../colors.dart';
import 'Colors.dart';
import 'Constants.dart';
import 'decorations.dart';
import 'device_extensions.dart';

bool hasMatch(String? s, String p) {
  return (s == null) ? false : RegExp(p).hasMatch(s);
}

get getContext => navigatorKey.currentState?.overlay?.context;

void finish(BuildContext context, [Object? result]) {
  if (Navigator.canPop(context)) Navigator.pop(context, result);
}

/// Hide soft keyboard
void hideKeyboard(context) => FocusScope.of(context).requestFocus(FocusNode());

/// Default AppBar
AppBar appBarWidget(
  String title, {
  @Deprecated('Use titleWidget instead') Widget? child,
  Widget? titleWidget,
  List<Widget>? actions,
  Color? color,
  bool center = false,
  Color? textColor,
  int textSize = 20,
  bool showBack = true,
  Color? shadowColor,
  double? elevation,
  Widget? backWidget,
  Brightness? brightness,
  SystemUiOverlayStyle? systemUiOverlayStyle,
  TextStyle? titleTextStyle,
  PreferredSizeWidget? bottom,
  Widget? flexibleSpace,
}) {
  return AppBar(
    centerTitle: center,
    title: titleWidget ??
        Text(
          title,
          style: titleTextStyle ?? (boldTextStyle(color: textColor ?? textPrimaryColorGlobal, size: textSize)),
        ),
    actions: actions,
    automaticallyImplyLeading: showBack,
    backgroundColor: color ?? appBarBackgroundColorGlobal,
    leading: showBack ? (backWidget ?? BackButton(color: textColor ?? textPrimaryColorGlobal)) : null,
    shadowColor: shadowColor,
    elevation: elevation ?? defaultAppBarElevation,
    systemOverlayStyle: systemUiOverlayStyle,
    bottom: bottom,
    flexibleSpace: flexibleSpace,
  );
}

/// Change status bar Color and Brightness
Future<void> setStatusBarColorWidget(
  Color statusBarColor, {
  Color? systemNavigationBarColor,
  Brightness? statusBarBrightness,
  Brightness? statusBarIconBrightness,
  int delayInMilliSeconds = 200,
}) async {
  await Future.delayed(Duration(milliseconds: delayInMilliSeconds));

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: statusBarColor,
      systemNavigationBarColor: systemNavigationBarColor,
      statusBarBrightness: statusBarBrightness,
      statusBarIconBrightness: statusBarIconBrightness ?? (statusBarColor.isDark() ? Brightness.light : Brightness.dark),
    ),
  );
}

/// Custom scroll behaviour widget
class SBehavior extends ScrollBehavior {
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

AppBar customAppBarWidget(
  String title, {
  @Deprecated('Use titleWidget instead') Widget? child,
  Widget? titleWidget,
  List<Widget>? actions,
  Color? color,
  bool center = false,
  Color? textColor,
  int textSize = 20,
  bool showBack = true,
  Color? shadowColor,
  double? elevation,
  Widget? backWidget,
  Brightness? brightness,
  SystemUiOverlayStyle? systemUiOverlayStyle,
  TextStyle? titleTextStyle,
  PreferredSizeWidget? bottom,
  Widget? flexibleSpace,
}) {
  return AppBar(
    centerTitle: center,
    title: titleWidget ?? Text(title, style: titleTextStyle ?? (boldTextStyle(color: textColor ?? textPrimaryColorGlobal, size: textSize))),
    actions: actions,
    automaticallyImplyLeading: showBack,
    backgroundColor: color ?? appBarBackgroundColorGlobal,
    leading: showBack ? (backWidget ?? BackButton(color: textColor ?? textPrimaryColorGlobal)) : null,
    shadowColor: shadowColor,
    elevation: elevation ?? defaultAppBarElevation,
    systemOverlayStyle: systemUiOverlayStyle,
    bottom: bottom,
    flexibleSpace: flexibleSpace,
  );
}

EdgeInsets dynamicAppButtonPadding(BuildContext context) {
  return EdgeInsets.symmetric(vertical: 14, horizontal: 16);
}

extension BooleanExtensions on bool? {
  /// Validate given bool is not null and returns given value if null.
  bool validate({bool value = false}) => this ?? value;
}

extension DoubleExtensions on double? {
  /// Validate given bool is not null and returns given value if null.
  double validate({double value = 0.0}) => this ?? value;
}

/// Set orientation to portrait
void setOrientationPortrait() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
}

/// Redirect to given widget without context
Future<T?> push<T>(
  Widget widget, {
  bool isNewTask = false,
  PageRouteAnimation? pageRouteAnimation,
  Duration? duration,
}) async {
  if (isNewTask) {
    return await Navigator.of(getContext).pushAndRemoveUntil(
      buildPageRoute(widget, pageRouteAnimation, duration),
      (route) => false,
    );
  } else {
    return await Navigator.of(getContext).push(
      buildPageRoute(widget, pageRouteAnimation, duration),
    );
  }
}

/// Dispose current screen or close current dialog
void pop([Object? object]) {
  if (Navigator.canPop(getContext)) Navigator.pop(getContext, object);
}

toast(String? value, {ToastGravity? gravity, length = Toast.LENGTH_SHORT, Color? bgColor, Color? textColor}) {
  Fluttertoast.showToast(
    msg: value.validate(),
    toastLength: length,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: bgColor,
    textColor: textColor,
    fontSize: 16.0,
  );
}

String storeBaseURL() {
  return isAndroid ? playStoreBaseURL : appStoreBaseURL;
}

Widget dotIndicator(list, i, {bool isPersonal = false}) {
  return SizedBox(
    height: 16,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        list.length,
        (ind) {
          return Container(
            height: isPersonal == true ? 6 : 4,
            width: isPersonal == true ? 6 : 20,
            margin: EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: i == ind
                    ? appStore.isDarkModeOn == true
                        ? Colors.white
                        : primaryColor
                    : Colors.grey.withOpacity(0.5),
                borderRadius: radiusWidget(4)),
          );
        },
      ),
    ),
  );
}

Widget appButton(BuildContext context, {String? text, double? width, Color bgColor = primaryColor, required Function onTap}) {
  return AppButtonWidget(
    text: text,
    textStyle: boldTextStyle(color: Colors.white),
    width: width ?? context.width(),
    elevation: 2,
    padding: EdgeInsets.all(16),
    shapeBorder: RoundedRectangleBorder(borderRadius: radius(), side: BorderSide(color: Colors.transparent)),
    color: bgColor,
    onTap: onTap,
  );
}

Widget appCancelButton(BuildContext context, {String? text, double? width, Color bgColor = primaryColor, required Function onTap}) {
  return AppButtonWidget(
    elevation: 0,
    text: text,
    textStyle: boldTextStyle(color: primaryColor),
    width: width ?? context.width(),
    padding: EdgeInsets.all(16),
    shapeBorder: RoundedRectangleBorder(borderRadius: radius(), side: BorderSide(color: primaryColor)),
    color: bgColor,
    onTap: onTap,
  );
}

InputDecoration inputDecoration(BuildContext context, {String? label, Widget? prefixIcon, Color? color, Widget? sWidget, Icon? sIcon, bool? isProfile = false, double? radius = 24}) {
  return InputDecoration(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(radius ?? defaultRadius), borderSide: BorderSide(color: color ?? textSecondaryColor)),
    focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(radius ?? defaultRadius), borderSide: BorderSide(color: color ?? Colors.red)),
    disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(radius ?? defaultRadius), borderSide: BorderSide(color: color ?? textSecondaryColor)),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(radius ?? defaultRadius), borderSide: BorderSide(color: color ?? textSecondaryColor)),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(radius ?? defaultRadius), borderSide: BorderSide(color: color ?? textSecondaryColor)),
    errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(radius ?? defaultRadius), borderSide: BorderSide(color: color ?? Colors.red)),
    alignLabelWithHint: true,
    isDense: true,
    prefixIcon: prefixIcon,
    suffix: sWidget,
    labelText: label ?? "Sample Text",
    labelStyle: secondaryTextStyle(color: color ?? textSecondaryColor),
    suffixIconColor: primaryColor,
    suffixIcon: sIcon,
  );
}

InputDecoration inputDecoration1(String? label, {Color? color}) {
  return InputDecoration(
    isDense: true,
    label: Text(label.validate(), style: primaryTextStyle(color: color ?? textPrimaryColorGlobal)),
    border: OutlineInputBorder(borderRadius: radius(16), borderSide: BorderSide(color: color ?? textPrimaryColorGlobal)),
    hintStyle: primaryTextStyle(color: color ?? textPrimaryColorGlobal),
  );
}
