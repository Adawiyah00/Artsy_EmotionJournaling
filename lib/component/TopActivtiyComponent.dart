import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../utils/Extensions/Colors.dart';
import '../utils/Extensions/int_extensions.dart';
import '../utils/colors.dart';
import '../main.dart';
import '../model/ActivityChartModel.dart';
import '../utils/Extensions/context_extensions.dart';
import '../utils/Extensions/text_styles.dart';
import '../utils/Extensions/decorations.dart';

class TopActivityComponent extends StatefulWidget {
  static String tag = '/TopActivityComponent';

  @override
  TopActivityComponentState createState() => TopActivityComponentState();
}

class TopActivityComponentState extends State<TopActivityComponent> {
  List<String> mActivityList = [];
  List<ActivityChartModel> mActivityChartList = [];
  List<int> mActivityListCount = [];

  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
    List<String> myList = [];
    healthStore.moodCheckList.forEachIndexed((index, element) {
      element.activityName!.forEach((element) {
        myList.add(element.toString());
      });
    });

    final map = <String, int>{};
    for (final letter in myList) {
      map[letter] = map.containsKey(letter) ? map[letter]! + 1 : 1;
    }

    mActivityList = map.keys.toList(growable: false);
    mActivityListCount = map.values.toList(growable: false);
    mActivityList.sort((k1, k2) => map[k2]!.compareTo(map[k1]!));
    mActivityListCount.sort((b, a) => a.compareTo(b));
    mActivityList.forEachIndexed((index, element) {
      if (element.isNotEmpty) {
        if (index < 5) {
          ActivityChartModel chartModel = ActivityChartModel();
          chartModel.activityName = element.toString();
          chartModel.activityTotal = mActivityListCount[index];
          mActivityChartList.add(chartModel);
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
    mActivityChartList.forEachIndexed((index, element) {
      if (index == value) {
        text = element.activityName;
      }
    });
    return SideTitleWidget(axisSide: meta.axisSide, space: 4.0, child: Container(width: context.width() * 0.17, alignment: Alignment.center, child: Text(text!, style: primaryTextStyle(size: 14),textAlign: TextAlign.center,)));
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 30, getTitlesWidget: getTitles)),
        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      );

  FlBorderData get borderData => FlBorderData(show: false);

  final _barsGradient = const LinearGradient(
    colors: [primaryColor, accentColor],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  List<BarChartGroupData> get barGroups {
    List<BarChartGroupData> mList = [];
    mActivityChartList.forEachIndexed((index, element) {
      mList.add(BarChartGroupData(x: index, barRods: [BarChartRodData(toY: double.parse(element.activityTotal.toString()), width: 20, gradient: _barsGradient)], showingTooltipIndicators: [0]));
    });
    return mList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width(),
      decoration: boxDecorationWithRoundedCornersWidget(backgroundColor: cardColor),
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Top 5 Activities", style: boldTextStyle()),
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
