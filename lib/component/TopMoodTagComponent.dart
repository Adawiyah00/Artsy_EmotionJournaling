import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../utils/Extensions/context_extensions.dart';
import '../utils/Extensions/int_extensions.dart';
import '../model/ActivityChartModel.dart';
import '../utils/Extensions/Colors.dart';
import '../utils/Extensions/Constants.dart';
import '../utils/Extensions/decorations.dart';
import '../main.dart';
import '../utils/Extensions/text_styles.dart';
import '../utils/colors.dart';

class TopMoodTagComponent extends StatefulWidget {
  static String tag = '/TopMoodTagComponent';

  @override
  TopMoodTagComponentState createState() => TopMoodTagComponentState();
}

class TopMoodTagComponentState extends State<TopMoodTagComponent> {
  List<String> mTagList = [];
  List<ActivityChartModel> mTagChartList = [];
  List<int> mTagListCount = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    List<String> myList = [];
    healthStore.moodCheckList.forEachIndexed((index, element) {
      element.tagName!.forEach((element) {
        myList.add(element.toString());
      });
    });

    final map = <String, int>{};
    for (final letter in myList) {
      map[letter] = map.containsKey(letter) ? map[letter]! + 1 : 1;
    }

    mTagList = map.keys.toList(growable: false);
    mTagListCount = map.values.toList(growable: false);
    mTagList.sort((k1, k2) => map[k2]!.compareTo(map[k1]!));
    mTagListCount.sort((b, a) => a.compareTo(b));
    mTagList.forEachIndexed((index, element) {
      if (element.isNotEmpty) {
        if (index < 5) {
          ActivityChartModel chartModel = ActivityChartModel();
          chartModel.activityName = element.toString();
          chartModel.activityTotal = mTagListCount[index];
          mTagChartList.add(chartModel);
        }
      }
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: const EdgeInsets.all(0),
          tooltipMargin: 8,
          getTooltipItem: (BarChartGroupData group, int groupIndex, BarChartRodData rod, int rodIndex) {
            return BarTooltipItem(rod.toY.round().toString(), const TextStyle(color: textPrimaryColor, fontWeight: FontWeight.bold));
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    String? text;
    mTagChartList.forEachIndexed((index, element) {
      if (index == value) {
        text = element.activityName;
      }
    });
    return SideTitleWidget(
        axisSide: meta.axisSide,
        space: 4.0,
        child: Container(width: context.width() * 0.17, alignment: Alignment.center, child: Text("#" + text!, style: primaryTextStyle(size: 14), textAlign: TextAlign.center)));
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 30, getTitlesWidget: getTitles)),
        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      );

  FlBorderData get borderData => FlBorderData(show: false);

  final _barsGradient = LinearGradient(colors: [primaryColor, accentColor], begin: Alignment.bottomCenter, end: Alignment.topCenter);

  List<BarChartGroupData> get barGroups {
    List<BarChartGroupData> mList = [];
    mTagChartList.forEachIndexed((index, element) {
      mList.add(BarChartGroupData(x: index, barRods: [BarChartRodData(toY: double.parse(element.activityTotal.toString()), width: 20, gradient: _barsGradient)], showingTooltipIndicators: [0]));
    });
    return mList;
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
          Text("Top 5 Tags", style: boldTextStyle()),
          Divider(color: primaryColor),
          30.height,
          AspectRatio(
            aspectRatio: 1.7,
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              color: cardColor,
              child: BarChart(
                BarChartData(
                  barTouchData: barTouchData,
                  titlesData: titlesData,
                  borderData: borderData,
                  barGroups: barGroups,
                  gridData: FlGridData(show: false),
                  alignment: BarChartAlignment.spaceAround,
                ),
                swapAnimationDuration: Duration(milliseconds: 150), // Optional
                swapAnimationCurve: Curves.linear, // Optional
              ),
            ),
          )
        ],
      ),
    );
  }
}
