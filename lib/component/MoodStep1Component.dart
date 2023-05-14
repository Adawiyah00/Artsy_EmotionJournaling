import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../utils/Extensions/string_extensions.dart';
import '../main.dart';
import '../model/Mood.dart';
import '../utils/Extensions/context_extensions.dart';
import '../utils/Extensions/shared_pref.dart';
import '../utils/colors.dart';
import '../utils/Extensions/Constants.dart';
import '../utils/Extensions/Widget_extensions.dart';
import '../utils/Extensions/decorations.dart';
import '../utils/Extensions/int_extensions.dart';
import '../utils/Extensions/text_styles.dart';
import '../utils/common.dart';
import '../utils/constant.dart';

class MoodStep1Component extends StatefulWidget {
  static String tag = '/MoodStep1Component';
  final bool? isUpdate;
  final Mood? moodCard;
  final int? id;

  MoodStep1Component({this.isUpdate = false, this.moodCard, this.id = 0});

  @override
  MoodStep1ComponentState createState() => MoodStep1ComponentState();
}

class MoodStep1ComponentState extends State<MoodStep1Component> with TickerProviderStateMixin {
  AnimationController? animationController;
  int index = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    if (widget.isUpdate == true) {
      index = widget.id!;
      setState(() {});
    }else{
      healthStore.addToMood(mMoodList[0]);
    }
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  List<Color> mColor = [
    moodColor1,
    moodColor2,
    moodColor3,
    moodColor4,
    moodColor5,
    moodColor6,
    moodColor7,
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          8.height,
          Text("Hello ${getStringAsync(NICK_NAME).capitalizeFirstLetter()},\nWhat's your mood today?", style: boldTextStyle(size: 22, color: Colors.white), textAlign: TextAlign.center)
              .paddingSymmetric(horizontal: 16),
          40.height,
          SingleChildScrollView(
            child: Column(
              children: [
                Wrap(
                  runSpacing: 16,
                  spacing: 16,
                  alignment: WrapAlignment.center,
                  children: List.generate(mMoodList.length, (i) {
                    return Container(
                      width: (context.width() - 64) / 3,
                      padding: EdgeInsets.all(8),
                      decoration: boxDecorationRoundedWithShadowWidget(
                        backgroundColor: healthStore.moodList.isNotEmpty
                            ? healthStore.moodList[0].id == mMoodList[i].id
                                ? Colors.white
                                : mColor[i].withOpacity(0.5)
                            : mColor[i].withOpacity(0.5),
                        defaultRadius.toInt(),
                      ),
                      child: Lottie.asset(mMoodList[i].image!, height: 100, width: 100, fit: BoxFit.fill),
                    ).onTap(() {
                      healthStore.clearMood();
                      healthStore.addToMood(mMoodList[i]);
                      setState(() {
                        index = i;
                      });
                    });
                  }),
                ).paddingSymmetric(horizontal: 12, vertical: 12),
                40.height,
                Text("You're ${mMoodList[index].name}", style: boldTextStyle(size: 20, color: Colors.white)),
                8.height,
              ],
            ),
          ).expand(),
        ],
      ).paddingOnly(top: 16),
    );
  }
}
