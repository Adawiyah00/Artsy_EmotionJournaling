import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../main.dart';
import '../model/Activity.dart';
import '../utils/Extensions/Commons.dart';
import '../utils/Extensions/HorizontalList.dart';
import '../utils/Extensions/context_extensions.dart';
import '../utils/Extensions/int_extensions.dart';
import '../utils/Extensions/string_extensions.dart';
import '../model/MoodModel.dart';
import '../screen/AddHealthScreen.dart';
import '../screen/ImageViewScreen.dart';
import '../utils/Extensions/Constants.dart';
import '../utils/Extensions/Widget_extensions.dart';
import '../model/Mood.dart';
import '../utils/Extensions/decorations.dart';
import '../utils/Extensions/text_styles.dart';
import '../utils/colors.dart';
import '../utils/common.dart';
import 'AudioPlayComponent.dart';

class MoodDetailComponent extends StatefulWidget {
  static String tag = '/MoodDetailComponent';

  final Mood mMoodList;
  final Function onCall;

  MoodDetailComponent(this.mMoodList, {required this.onCall});

  @override
  MoodDetailComponentState createState() => MoodDetailComponentState();
}

class MoodDetailComponentState extends State<MoodDetailComponent> {
  List<Activity> activityList = [];
  List<MoodModel> moodList = [];
  List<String>? mPhoto = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    getTagData();
    getActivityData();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  getTagData() {
    List<int> id = [];
    List<String> img = [];
    List<String> name = [];

    widget.mMoodList.tagId!.forEach((shop) => id.add(shop.toInt()));
    widget.mMoodList.tagName!.forEach((shop) => name.add(shop));
    widget.mMoodList.tagImg!.forEach((shop) => img.add(shop));

    for (int i = 0; i < id.length; i++) {
      MoodModel mood = MoodModel();
      mood.id = id[i].toInt();
      mood.name = name[i];
      mood.image = img[i];
      moodList.add(mood);
    }

    var seen1 = Set<String>();
    List<MoodModel> mTagUniqueList = moodList.where((listId) => seen1.add(listId.id.toString())).toList();
    mTagUniqueList.forEach((element) {
      moodList = mTagUniqueList;
    });
  }

  getActivityData() {
    List<int> id = [];
    List<String> img = [];
    List<String> name = [];
    widget.mMoodList.activityId!.forEach((shop) => id.add(shop.toInt()));
    widget.mMoodList.activityName!.forEach((shop) => name.add(shop));
    widget.mMoodList.activityImg!.forEach((shop) => img.add(shop));

    for (int i = 0; i < id.length; i++) {
      Activity activity = Activity();
      activity.id = id[i].toInt();
      activity.name = name[i];
      activity.image = img[i];
      activityList.add(activity);
    }

    var seen1 = Set<String>();
    List<Activity> mActivityUniqueList = activityList.where((listId) => seen1.add(listId.id.toString())).toList();
    mActivityUniqueList.forEach((element) {
      activityList = mActivityUniqueList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecorationRoundedWithShadowWidget(defaultRadius.toInt(), backgroundColor: cardColor),
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      decoration: boxDecorationWithRoundedCornersWidget(
                          backgroundColor: cardTopColor, borderRadius: BorderRadius.only(topLeft: radiusCircular(defaultRadius), topRight: Radius.circular(defaultRadius))),
                      child: Text(widget.mMoodList.date.toString(), style: boldTextStyle(color: Colors.white, size: 14))),
                  if (widget.mMoodList.tagName != null && widget.mMoodList.tagName!.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(top: 8, left: 75, right: 12),
                      child: Wrap(
                        runSpacing: 8,
                        spacing: 4,
                        children: widget.mMoodList.tagName!.map((e) {
                          return Text("#" + e.toString(), style: primaryTextStyle(size: 14), maxLines: 2).visible(!e.isEmptyOrNull);
                        }).toList(),
                      ),
                    )
                ],
              ),
              CircleAvatar(
                minRadius: 20,
                maxRadius: 35,
                backgroundColor: cardTopColor,
                child: Lottie.asset(widget.mMoodList.moodImg!, height: 80, width: 80),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!widget.mMoodList.note!.isEmptyOrNull) 8.height,
                Text(widget.mMoodList.note!, style: primaryTextStyle(), maxLines: 2, overflow: TextOverflow.ellipsis),
                if (!widget.mMoodList.note!.isEmptyOrNull) 4.height,
                Divider(thickness: 1, color: primaryColor),
                8.height,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      runSpacing: 8,
                      spacing: 4,
                      children: widget.mMoodList.activityImg!.map((e) {
                        return Text(e, style: TextStyle(fontSize: 26, decoration: TextDecoration.none, color: Colors.white), maxLines: 2, overflow: TextOverflow.ellipsis);
                      }).toList(),
                    ).expand(),
                    8.width,
                    if (widget.mMoodList.voiceNote!.isNotEmpty)
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: boxDecorationWithShadowWidget(backgroundColor: context.cardColor, borderRadius: BorderRadius.all(Radius.circular(defaultRadius))),
                        margin: EdgeInsets.all(2),
                        child: Icon(Icons.mic),
                      ),
                  ],
                ),
              ],
            ),
          ),
          if (widget.mMoodList.photos != null)
            if (!widget.mMoodList.photos!.first.isEmptyOrNull)
              HorizontalList(
                  itemCount: widget.mMoodList.photos!.length,
                  itemBuilder: (context, i) {
                    return Image.file(File(widget.mMoodList.photos![i]), width: 60, height: 60, fit: BoxFit.cover).cornerRadiusWithClipRRect(8);
                  }),
          8.height,
        ],
      ),
    ).onTap(() async {
      moodList.clear();
      activityList.clear();
      getTagData();
      getActivityData();
      await showModalBottomSheet(
        context: context,
        isDismissible: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25.0))),
        backgroundColor: cardColor,
        builder: (c) => SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.mMoodList.date.toString(), style: boldTextStyle(size: 14)),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(8),
                        decoration: boxDecorationRoundedWithShadowWidget(8, backgroundColor: Colors.white),
                        child: InkWell(
                            child: Padding(padding: EdgeInsets.all(6), child: Icon(Icons.delete)),
                            onTap: () async {
                              deleteDialog(context, () {
                                Mood? moodCard = Mood();
                                healthStore.removeMoodCheck(widget.mMoodList);
                                moodCard.deleteMood(widget.mMoodList.id!);
                                appStore.setLoading(true);
                                init();
                                setState(() {});
                                finish(context);
                                finish(context);
                                widget.onCall();
                              });
                            }),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        decoration: boxDecorationRoundedWithShadowWidget(8, backgroundColor: Colors.white),
                        child: InkWell(
                            child: Padding(padding: EdgeInsets.all(6), child: Icon(Icons.edit)),
                            onTap: () async {
                              healthStore.clearMood();
                              MoodModel mood = MoodModel();
                              mood.id = widget.mMoodList.moodId;
                              mood.name = widget.mMoodList.moodName;
                              mood.image = widget.mMoodList.moodImg;
                              healthStore.addToMood(mood);
                              AddHealthScreen(
                                moodCard: widget.mMoodList,
                                isUpdate: true,
                                onCall: () {
                                  finish(context);
                                  widget.onCall();
                                  setState(() {});
                                },
                              ).launch(context);
                              setState(() {});
                            }),
                      ),
                    ],
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Lottie.asset(widget.mMoodList.moodImg!, height: 60, width: 60),
                  8.width,
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('MOOD TAGS', style: secondaryTextStyle(letterSpacing: 1)),
                        Divider(color: primaryColor),
                        Wrap(
                          children: moodList.map((e) {
                            return Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(e.image.toString(), style: secondaryTextStyle(size: 18), maxLines: 2),
                                  4.height,
                                  Text("#" + e.name.toString(), style: secondaryTextStyle(color: textPrimaryColorGlobal, size: 12), maxLines: 2),
                                ],
                              ),
                            ).visible(!e.name.isEmptyOrNull);
                          }).toList(),
                        ),
                      ],
                    ),
                  ).expand().visible(moodList.isNotEmpty),
                ],
              ),
              if (activityList.isNotEmpty) Text('ACTIVITIES', style: secondaryTextStyle(letterSpacing: 1)),
              Divider(color: primaryColor).visible(activityList.isNotEmpty),
              Wrap(
                children: activityList.map((e) {
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(e.image.toString(), style: secondaryTextStyle(size: 18), maxLines: 2),
                        4.height,
                        Text(e.name.toString(), style: secondaryTextStyle(color: textPrimaryColorGlobal, size: 12), maxLines: 2),
                      ],
                    ),
                  );
                }).toList(),
              ),
              if (!widget.mMoodList.note!.isEmptyOrNull) 16.height,
              if (!widget.mMoodList.note!.isEmptyOrNull) Text('NOTE', style: secondaryTextStyle(letterSpacing: 1)),
              if (!widget.mMoodList.note!.isEmptyOrNull) Divider(color: primaryColor),
              if (!widget.mMoodList.note!.isEmptyOrNull) 8.height,
              if (!widget.mMoodList.note!.isEmptyOrNull) Text(widget.mMoodList.note.validate(), style: secondaryTextStyle(color: textPrimaryColorGlobal)),
              if (!widget.mMoodList.note!.isEmptyOrNull) 16.height,
              if (!widget.mMoodList.voiceNote!.isEmptyOrNull) 16.height,
              if (!widget.mMoodList.voiceNote!.isEmptyOrNull) Text('AUDIO', style: secondaryTextStyle(letterSpacing: 1)),
              if (!widget.mMoodList.voiceNote!.isEmptyOrNull) Divider(color: primaryColor),
              if (!widget.mMoodList.voiceNote!.isEmptyOrNull) 8.height,
              if (!widget.mMoodList.voiceNote!.isEmptyOrNull) AudioPlayComponent(isHome: true, data: widget.mMoodList, audioUrl: widget.mMoodList.voiceNote!),
              if (!widget.mMoodList.photos!.first.isEmptyOrNull) 16.height,
              if (!widget.mMoodList.photos!.first.isEmptyOrNull) Text('IMAGES', style: secondaryTextStyle(letterSpacing: 1)),
              if (!widget.mMoodList.photos!.first.isEmptyOrNull) Divider(color: primaryColor),
              if (!widget.mMoodList.photos!.first.isEmptyOrNull) 8.height,
              if (!widget.mMoodList.photos!.first.isEmptyOrNull)
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: widget.mMoodList.photos!.map((e) {
                    return Image.file(File(e), width: (context.width() - 64) / 5, height: 60, fit: BoxFit.cover).cornerRadiusWithClipRRect(8).onTap(() {
                      ImageViewScreen(e).launch(context);
                    });
                  }).toList(),
                ),
            ],
          ),
        ),
      );
    }, hoverColor: Colors.transparent, highlightColor: Colors.transparent, splashColor: Colors.transparent);
  }
}
