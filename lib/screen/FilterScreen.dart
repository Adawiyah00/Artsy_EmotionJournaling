import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';
import '../utils/Extensions/decorations.dart';
import '../utils/Extensions/string_extensions.dart';
import '../utils/Extensions/text_styles.dart';
import '../utils/appWidget.dart';
import '../utils/colors.dart';
import '../component/BodyWidget.dart';
import '../main.dart';
import '../model/Activity.dart';
import '../model/MoodTagModel.dart';
import '../utils/Extensions/Colors.dart';
import '../utils/Extensions/Commons.dart';
import '../utils/Extensions/HorizontalList.dart';
import '../utils/Extensions/Widget_extensions.dart';
import '../utils/Extensions/int_extensions.dart';
import '../component/MoodDetailComponent.dart';
import '../database/DbHelper.dart';
import '../model/MoodModel.dart';
import '../utils/common.dart';

class FilterScreen extends StatefulWidget {
  static String tag = '/FilterScreen';

  @override
  FilterScreenState createState() => FilterScreenState();
}

class FilterScreenState extends State<FilterScreen> {
  int? moodId = 0;
  int? actId = 0;
  int? tagId = 0;

  List<MoodTagModel> moodList = [];
  Future<List>? mActivityList;
  List<Activity> mActivityDataList = [];
  Future<List>? mMoodTagList;

  List<String> mergedIdList = [];
  List<String> mergedNameList = [];
  List<String> mergedImgList = [];
  List<Activity> activityList = [];
  List<String> mergedTagIdList = [];
  List<String> mergedTagNameList = [];
  List<String> mergedTagImgList = [];
  List<MoodTagModel> tagList = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    healthStore.clearMoodFilter();
    mActivityList = DBHelper.getMoodTagSadData();
    mMoodTagList = DBHelper.getMoodTagData();
    healthStore.moodCheckList.forEach((element) {
      element.activityId!.forEach((shop) => mergedIdList.add(shop));
      element.activityName!.forEach((shop) => mergedNameList.add(shop));
      element.activityImg!.forEach((shop) => mergedImgList.add(shop));

      element.tagId!.forEach((shop) => mergedTagIdList.add(shop));
      element.tagName!.forEach((shop) => mergedTagNameList.add(shop));
      element.tagImg!.forEach((shop) => mergedTagImgList.add(shop));
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
      mActivityDataList.add(element);
    });
    mTagUniqueList.forEach((element) {
      moodList.add(element);
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
    return BodyWidget(
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBarWidget("Filter", textColor: Colors.white, showBack: false, color: transparentColor, elevation: 0),
        body: Stack(
          children: [
            NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => [
                SliverAppBar(
                  snap: true,
                  pinned: false,
                  floating: true,
                  expandedHeight: 370,
                  backgroundColor: Colors.transparent,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    background: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Moods', style: boldTextStyle(color: Colors.white, size: 14, letterSpacing: 1.5)).paddingSymmetric(horizontal: 16),
                        HorizontalList(
                          itemCount: mMoodList.length,
                          spacing: 0,
                          itemBuilder: (BuildContext context, int i) {
                            MoodModel mood = mMoodList[i];
                            return GestureDetector(
                              onTap: () {
                                moodId = mood.id;
                                DBHelper.getMoodFilterData(moodId!, actId!, tagId!);
                                setState(() {});
                              },
                              child: Container(
                                decoration: moodId == mood.id ? boxDecorationWithRoundedCornersWidget(border: Border.all(width: 1), backgroundColor: cardColor) : BoxDecoration(),
                                child: Lottie.asset(mood.image!, fit: BoxFit.fill, width: 65, height: 65),
                              ),
                            );
                          },
                        ),
                        16.height,
                        if (moodList.isNotEmpty) Text('Moods Tags', style: boldTextStyle(color: Colors.white, size: 14, letterSpacing: 1.5)).paddingSymmetric(horizontal: 16),
                        if (moodList.isNotEmpty) 4.height,
                        if (moodList.isNotEmpty)
                          HorizontalList(
                            itemCount: moodList.length,
                            spacing: 0,
                            itemBuilder: (BuildContext context, int i) {
                              String? moodImg = moodList[i].image;
                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      tagId = moodList[i].id;
                                      DBHelper.getMoodFilterData(moodId!, actId!, tagId!);
                                      setState(() {});
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                      decoration: tagId == moodList[i].id
                                          ? boxDecorationWithRoundedCornersWidget(border: Border.all(width: 1), backgroundColor: cardColor, borderRadius: radius())
                                          : BoxDecoration(),
                                      child: Column(
                                        children: [
                                          Text(moodImg!, style: TextStyle(fontSize: 22, decoration: TextDecoration.none, color: Colors.white)),
                                          6.height,
                                          Text("#" + moodList[i].name.validate(), style: primaryTextStyle(color: tagId == moodList[i].id ? textPrimaryColor : Colors.white, size: 12)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ).visible(!moodList[i].name.isEmptyOrNull);
                            },
                          ),
                        if (mActivityDataList.isNotEmpty) 16.height,
                        if (mActivityDataList.isNotEmpty) Text('Activities', style: boldTextStyle(color: Colors.white, size: 14, letterSpacing: 1.5)).paddingSymmetric(horizontal: 16),
                        if (mActivityDataList.isNotEmpty) 4.height,
                        if (mActivityDataList.isNotEmpty)
                          HorizontalList(
                            itemCount: mActivityDataList.length,
                            spacing: 0,
                            itemBuilder: (BuildContext context, int i) {
                              String? tagImg = mActivityDataList[i].image;
                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      actId = mActivityDataList[i].id;
                                      DBHelper.getMoodFilterData(moodId!, actId!, tagId!);
                                      setState(() {});
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                      decoration: actId == mActivityDataList[i].id
                                          ? boxDecorationWithRoundedCornersWidget(border: Border.all(width: 1), backgroundColor: cardColor, borderRadius: radius())
                                          : BoxDecoration(),
                                      child: Column(
                                        children: [
                                          Text(tagImg!, style: TextStyle(fontSize: 22, decoration: TextDecoration.none, color: Colors.white)),
                                          6.height,
                                          Text(mActivityDataList[i].name.validate(), style: primaryTextStyle(color: actId == mActivityDataList[i].id ? textPrimaryColor : Colors.white, size: 12)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ).visible(!mActivityDataList[i].name.isEmptyOrNull);
                            },
                          ),
                        if (mActivityDataList.isNotEmpty) 16.height,
                        Divider().paddingSymmetric(horizontal: 16)
                      ],
                    ),
                  ),
                ), //SliverAppBar
              ],
              body: ListView.builder(
                itemCount: healthStore.mFilterMood.length,
                primary: true,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(bottom: 65),
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredGrid(
                    position: index,
                    columnCount: 2,
                    duration: Duration(milliseconds: 375),
                    child: SlideAnimation(
                      verticalOffset: 10.0,
                      child: FadeInAnimation(
                        curve: Curves.fastOutSlowIn,
                        duration: Duration(milliseconds: 100),
                        child: MoodDetailComponent(healthStore.mFilterMood[index], onCall: () {
                          appStore.setLoading(true);
                          setState(() {});
                          appStore.setLoading(false);
                        }),
                      ),
                    ),
                  );
                },
              ),
            ),
            noDataWidget().visible(healthStore.moodCheckList.isEmpty).center()
          ],
        ),
      ),
    );
  }
}
