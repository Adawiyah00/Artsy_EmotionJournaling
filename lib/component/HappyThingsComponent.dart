import 'package:flutter/material.dart';
import '../utils/Extensions/Widget_extensions.dart';
import '../utils/colors.dart';
import '../utils/Extensions/context_extensions.dart';
import '../utils/Extensions/int_extensions.dart';
import '../utils/Extensions/string_extensions.dart';
import '../main.dart';
import '../model/Activity.dart';
import '../model/MoodTagModel.dart';
import '../utils/Extensions/Constants.dart';
import '../utils/Extensions/decorations.dart';
import '../utils/Extensions/text_styles.dart';

class HappyThingsComponent extends StatefulWidget {
  static String tag = '/HappyThingsComponent';
  final String? value;

  HappyThingsComponent({this.value});

  @override
  HappyThingsComponentState createState() => HappyThingsComponentState();
}

class HappyThingsComponentState extends State<HappyThingsComponent> {
  List<Activity> mHappyList = [];
  List<MoodTagModel> mSadList = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    List<String> mergedIdList = [];
    List<String> mergedNameList = [];
    List<String> mergedImgList = [];
    List<Activity> activityList = [];
    List<String> mergedTagIdList = [];
    List<String> mergedTagNameList = [];
    List<String> mergedTagImgList = [];
    List<MoodTagModel> tagList = [];

    healthStore.moodCheckList.forEach((element) {
      if (widget.value == "Happy" ? element.moodName == "Happy" : element.moodName == "Sad") {
        element.activityId!.forEach((shop) => mergedIdList.add(shop));
        element.activityName!.forEach((shop) => mergedNameList.add(shop));
        element.activityImg!.forEach((shop) => mergedImgList.add(shop));
      }
      if (widget.value == "Happy" ? element.moodName == "Happy" : element.moodName == "Sad") {
        element.tagId!.forEach((shop) => mergedTagIdList.add(shop));
        element.tagName!.forEach((shop) => mergedTagNameList.add(shop));
        element.tagImg!.forEach((shop) => mergedTagImgList.add(shop));
      }
    });

    for (int i = 0; i < mergedIdList.length; i++) {
      Activity activity = Activity();
      activity.id = mergedIdList[i].toInt();
      activity.name = mergedNameList[i];
      activity.image = mergedImgList[i];
      activityList.add(activity);
    }
    for (int i = 0; i < mergedTagIdList.length; i++) {
      MoodTagModel activity = MoodTagModel();
      activity.id = mergedTagIdList[i].toInt();
      activity.name = mergedTagNameList[i];
      activity.image = mergedTagImgList[i];
      tagList.add(activity);
    }

    var seen = Set<String>();
    var seen1 = Set<String>();
    List<Activity> mActivityUniqueList = activityList.where((listId) => seen.add(listId.id.toString())).toList();
    List<MoodTagModel> mTagUniqueList = tagList.where((listId) => seen1.add(listId.id.toString())).toList();
    mActivityUniqueList.forEach((element) {
      mHappyList.add(element);
    });
    mTagUniqueList.forEach((element) {
      mSadList.add(element);
    });
    var map = Map();
    activityList.forEach((element) {
      if (!map.containsKey(element.id)) {
        map[element.id] = 1;
      } else {
        map[element.id] += 1;
      }
    });
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
      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.value == "Happy" ? "Things that make you happy" : "Things that make you sad", style: boldTextStyle()),
          Divider(color: primaryColor),
          4.height,
          Text("Activity", style: primaryTextStyle(size: 16, letterSpacing: 1.5)),
          8.height,
          GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6, crossAxisSpacing: 2),
            shrinkWrap: true,
            itemCount: mHappyList.length,
            padding: EdgeInsets.zero,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(mHappyList[index].image!, style: TextStyle(fontSize: 18, decoration: TextDecoration.none, color: Colors.white)),
                  4.height,
                  Text(mHappyList[index].name!, style: primaryTextStyle(size: 12), maxLines: 2,textAlign: TextAlign.center),
                ],
              );
            },
          ),
          16.height,
          Text("MoodTags", style: primaryTextStyle(size: 16, letterSpacing: 1.5)).visible(mSadList.isNotEmpty),
          8.height,
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6,childAspectRatio: 0.7),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: mSadList.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Text(mSadList[index].image!, style: TextStyle(fontSize: 18, decoration: TextDecoration.none, color: Colors.white)),
                  4.height,
                  Text("#" + mSadList[index].name!, style: primaryTextStyle(size: 12), maxLines: 2,textAlign: TextAlign.center),
                ],
              ).visible(!mSadList[index].name.isEmptyOrNull);
            },
          ),
        ],
      ),
    ).visible(mHappyList.isNotEmpty || mSadList.isNotEmpty);
  }
}
