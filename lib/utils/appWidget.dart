import 'package:flutter/material.dart';
import '../utils/Extensions/Widget_extensions.dart';
import 'Extensions/Commons.dart';
import 'Extensions/string_extensions.dart';
import 'Extensions/text_styles.dart';
import 'colors.dart';
import 'images.dart';

Widget noDataWidget() {
  return Image.asset(ic_no_data, fit: BoxFit.cover, height: 100, width: 100,color: Colors.white.withOpacity(0.6)).center();
}

appBar(String? title, {bool? showBack = false, List<Widget>? action}) {
  return appBarWidget(title.validate(),
      color: primaryColor, elevation: 0, titleTextStyle: primaryTextStyle(size: 22, color: Colors.white), textColor: Colors.white, showBack: showBack == true ? true : false, actions: action);
}
