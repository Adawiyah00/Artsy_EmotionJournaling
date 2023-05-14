import 'package:flutter/material.dart';
import '../utils/Extensions/Widget_extensions.dart';
import '../component/TopActivtiyComponent.dart';
import '../component/TopMoodTagComponent.dart';
import '../main.dart';
import '../utils/Extensions/Colors.dart';
import '../component/BodyWidget.dart';
import '../component/HappyThingsComponent.dart';
import '../utils/Extensions/int_extensions.dart';
import '../component/MoodCounterComponent.dart';
import '../utils/Extensions/Commons.dart';
import '../utils/appWidget.dart';

class ReportScreen extends StatefulWidget {
  static String tag = '/ReportScreen';

  @override
  ReportScreenState createState() => ReportScreenState();
}

class ReportScreenState extends State<ReportScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {}

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return BodyWidget(
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBarWidget("Daily Report", textColor: Colors.white, showBack: false, color: transparentColor, elevation: 0),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  16.height,
                  MoodCounterComponent().visible(healthStore.moodCheckList.isNotEmpty),
                  HappyThingsComponent(value: "Happy"),
                  HappyThingsComponent(value: "Sad"),
                  TopMoodTagComponent().visible(healthStore.moodCheckList.isNotEmpty),
                  TopActivityComponent().visible(healthStore.moodCheckList.isNotEmpty),
                ],
              ),
            ),
            noDataWidget().visible(healthStore.moodCheckList.isEmpty).center()
          ],
        ),
      ),
    );
  }
}
