import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../main.dart';
import '../utils/Extensions/Constants.dart';
import '../utils/Extensions/context_extensions.dart';
import '../utils/Extensions/int_extensions.dart';
import '../utils/Extensions/decorations.dart';
import '../utils/Extensions/text_styles.dart';
import '../utils/colors.dart';
import '../utils/images.dart';

class MoodCounterComponent extends StatefulWidget {
  static String tag = '/MoodCounterComponent';

  @override
  MoodCounterComponentState createState() => MoodCounterComponentState();
}

class MoodCounterComponentState extends State<MoodCounterComponent> {
  double a = 0;
  double b = 0;
  double c = 0;
  double d = 0;
  double e = 0;
  double f = 0;
  double g = 0;
  double h = 0;

  int touchedIndex = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    log(healthStore.moodCheckList.toString());
    healthStore.moodCheckList.forEach((element) {
      print(element.moodName);
      if (element.moodName == "Scared") {
        a = a + 1;
      } else if (element.moodName == "Sad") {
        b = b + 1;
      } else if (element.moodName == "Angry") {
        c = c + 1;
      } else if (element.moodName == "Smile") {
        d = d + 1;
      } else if (element.moodName == "Cry") {
        e = e + 1;
      } else if (element.moodName == "Loving") {
        f = f + 1;
      } else if (element.moodName == "Happy") {
        h = h + 1;
      }
    });
    setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width(),
      decoration: boxDecorationRoundedWithShadowWidget(defaultRadius.toInt(), backgroundColor: cardColor),
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Mood Counter", style: boldTextStyle()),
          Divider(color: primaryColor),
          4.height,
          AspectRatio(
            aspectRatio: 1.3,
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions || pieTouchResponse == null || pieTouchResponse.touchedSection == null) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                  });
                }),
                borderData: FlBorderData(show: false),
                sectionsSpace: 0,
                centerSpaceRadius: 0,
                sections: showingSections(),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(7, (i) {
      final isTouched = i == touchedIndex;
      final radius = isTouched ? 110.0 : 100.0;
      final widgetSize = isTouched ? 40.0 : 40.0;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: moodColor1,
            value: a,
            title: 'Scared'.toString(),
            radius: radius,
            titleStyle: boldTextStyle(color: Colors.white),
            badgeWidget: _Badge(scare_animation, size: widgetSize, borderColor: moodColor1),
            badgePositionPercentageOffset: .98,
          );
        case 1:
          return PieChartSectionData(
            color: moodColor2,
            value: b,
            title: 'Sad'.toString(),
            radius: radius,
            titleStyle: boldTextStyle(color: Colors.white),
            badgeWidget: _Badge(sad_animation, size: widgetSize, borderColor: moodColor2),
            badgePositionPercentageOffset: .98,
          );
        case 2:
          return PieChartSectionData(
            color: moodColor3,
            value: c,
            title: 'Angry'.toString(),
            radius: radius,
            titleStyle: boldTextStyle(color: Colors.white),
            badgeWidget: _Badge(angry_animation, size: widgetSize, borderColor: moodColor3),
            badgePositionPercentageOffset: .98,
          );
        case 3:
          return PieChartSectionData(
            color: moodColor4,
            value: d,
            title: 'Smile'.toString(),
            radius: radius,
            titleStyle: boldTextStyle(color: Colors.white),
            badgeWidget: _Badge(smiley_animation, size: widgetSize, borderColor: moodColor4),
            badgePositionPercentageOffset: .98,
          );
        case 4:
          return PieChartSectionData(
            color: moodColor5,
            value: e,
            title: 'Cry'.toString(),
            radius: radius,
            titleStyle: boldTextStyle(color: Colors.white),
            badgeWidget: _Badge(joy_animation, size: widgetSize, borderColor: moodColor5),
            badgePositionPercentageOffset: .98,
          );
        case 5:
          return PieChartSectionData(
            color: moodColor6,
            value: f,
            title: 'Loving'.toString(),
            radius: radius,
            titleStyle: boldTextStyle(color: Colors.white),
            badgeWidget: _Badge(loving_animation, size: widgetSize, borderColor: moodColor6),
            badgePositionPercentageOffset: .98,
          );
        case 6:
          return PieChartSectionData(
            color: moodColor7,
            value: h,
            title: 'Happy'.toString(),
            radius: radius,
            titleStyle: boldTextStyle(color: Colors.white),
            badgeWidget: _Badge(happy_animation, size: widgetSize, borderColor: moodColor7),
            badgePositionPercentageOffset: .98,
          );
        default:
          throw 'Oh no';
      }
    });
  }
}

class _Badge extends StatelessWidget {
  final String svgAsset;
  final double size;
  final Color borderColor;

  _Badge(this.svgAsset, {Key? key, required this.size, required this.borderColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(child: Lottie.asset(svgAsset, height: 50, width: 50, fit: BoxFit.fill)),
    );
  }
}
