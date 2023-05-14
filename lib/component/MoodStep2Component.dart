import 'dart:io';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../model/Mood.dart';
import '../utils/Extensions/Colors.dart';
import '../utils/Extensions/Commons.dart';
import '../utils/Extensions/context_extensions.dart';
import '../utils/Extensions/string_extensions.dart';
import '../database/MoodActivityDBHelper.dart';
import '../main.dart';
import '../model/Activity.dart';
import '../utils/Extensions/Widget_extensions.dart';
import '../utils/Extensions/int_extensions.dart';
import '../utils/Extensions/decorations.dart';
import '../utils/Extensions/text_styles.dart';
import '../utils/colors.dart';

class MoodStep2Component extends StatefulWidget {
  static String tag = '/MoodStep2Component';
  final bool? isUpdate;
  final Mood? moodCard;
  final int? id;

  MoodStep2Component({this.isUpdate = false, this.moodCard, this.id = 0});

  @override
  MoodStep2ComponentState createState() => MoodStep2ComponentState();
}

class MoodStep2ComponentState extends State<MoodStep2Component> {
  bool emojiShowing = false;
  TextEditingController? mNote = TextEditingController();
  String? mEmojiName;
  String? addTagImg;
  String? mEmojiIcon;
  int index = 0;

  List<Activity> activityList = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    if (widget.isUpdate == true) {
      getActivityData();
    }
  }

  getActivityData() {
    List<int> id = [];
    List<String> img = [];
    List<String> name = [];
    widget.moodCard!.activityId!.forEach((shop) => id.add(shop.toInt()));
    widget.moodCard!.activityName!.forEach((shop) => name.add(shop));
    widget.moodCard!.activityImg!.forEach((shop) => img.add(shop));

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
    healthStore.addActivityItem(activityList);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  _onEmojiSelected(Emoji emoji) {
    print('_onEmojiSelected: ${emoji.emoji}');
    print('_onEmojiSelected: ${emoji.name}');
    print('_onEmojiSelected: ${emoji.toJson().toString()}');
    mEmojiName = emoji.name;
    mEmojiIcon = emoji.emoji;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            20.height,
            Text("What makes you feel that way?", style: boldTextStyle(size: 20, weight: FontWeight.w500, color: Colors.white)).paddingOnly(left: 16, right: 16, top: 16, bottom: 0),
            16.height,
            Wrap(
              runSpacing: 12,
              spacing: 8,
              children: healthStore.activityList.map((e) {
                return Container(
                    width: (context.width() - 48) / 5,
                    decoration: boxDecorationWithRoundedCornersWidget(borderRadius: radius(16), backgroundColor: Colors.black.withOpacity(0.2)),
                    padding: EdgeInsets.symmetric(vertical: 8),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(e.image!, style: TextStyle(fontSize: 22, decoration: TextDecoration.none, color: Colors.white)),
                        2.width,
                        Icon(Icons.close, size: 16, color: Colors.white),
                      ],
                    )).onTap(() {
                  healthStore.removeActivity(e);
                  setState(() {});
                });
              }).toList(),
            ).paddingOnly(top: 12, bottom: 30),
            16.height,
            FutureBuilder<List>(
                future: MoodActivityDBHelper.getData('moods_activity'),
                initialData: [],
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? Wrap(
                          spacing: 6,
                          runSpacing: 30,
                          children: List.generate(snapshot.data!.length, (index) {
                            int? id = snapshot.data![index]['id'];
                            String? moodName = snapshot.data![index]['moodActivityName'];
                            String? moodImg = snapshot.data![index]['moodActivityImage'];
                            return id == 1
                                ? InkWell(
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    onTap: () async {
                                      emojiShowing = !emojiShowing;
                                      mNote!.text = '';
                                      addTagImg = '';
                                      mEmojiIcon = '';
                                      await showModalBottomSheet<void>(
                                        context: context,
                                        isScrollControlled: true,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0))),
                                        backgroundColor: cardColor,
                                        builder: (context) {
                                          return Observer(builder: (context) {
                                            return appStore.isShowIcon == true
                                                ? Padding(
                                                    padding: EdgeInsets.only(right: 16, top: 16, bottom: MediaQuery.of(context).viewInsets.bottom),
                                                    child: ConstrainedBox(
                                                      constraints: BoxConstraints(maxHeight: 500),
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          BackButton(onPressed: () {
                                                            appStore.isShowIcon = false;
                                                            setState(() {});
                                                          }),
                                                          Padding(
                                                            padding: EdgeInsets.only(left: 16.0),
                                                            child: SizedBox(
                                                              height: 275,
                                                              child: EmojiPicker(
                                                                onEmojiSelected: (Category? category, Emoji emoji) {
                                                                  addTagImg = emoji.emoji;
                                                                  log(category!.index);
                                                                  index = category.index;
                                                                  log(emoji);
                                                                  _onEmojiSelected(emoji);
                                                                  appStore.isShowIcon = false;
                                                                  setState(() {});
                                                                },
                                                                onBackspacePressed: () {
                                                                  appStore.isShowIcon = false;
                                                                  setState(() {});
                                                                },
                                                                config: Config(
                                                                  columns: 7,
                                                                  emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                                                                  verticalSpacing: 0,
                                                                  horizontalSpacing: 0,
                                                                  gridPadding: EdgeInsets.zero,
                                                                  initCategory: Category.RECENT,
                                                                  bgColor: cardColor,
                                                                  indicatorColor: primaryColor,
                                                                  iconColor: Colors.grey,
                                                                  iconColorSelected: primaryColor,
                                                                  backspaceColor: primaryColor,
                                                                  skinToneDialogBgColor: cardColor,
                                                                  skinToneIndicatorColor: Colors.grey,
                                                                  enableSkinTones: true,
                                                                  showRecentsTab: true,
                                                                  recentsLimit: 28,
                                                                  replaceEmojiOnLimitExceed: false,
                                                                  noRecents: const Text('No Recent', style: TextStyle(fontSize: 20, color: Colors.black26), textAlign: TextAlign.center),
                                                                  tabIndicatorAnimDuration: kTabScrollDuration,
                                                                  categoryIcons: const CategoryIcons(),
                                                                  buttonMode: ButtonMode.MATERIAL,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                : Padding(
                                                    padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: MediaQuery.of(context).viewInsets.bottom),
                                                    child: ConstrainedBox(
                                                      constraints: BoxConstraints(maxHeight: 500),
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text("Create Activity Name", style: boldTextStyle(size: 18)).center(),
                                                          Divider(),
                                                          16.height,
                                                          Text('Activity Name', style: primaryTextStyle(size: 14)).paddingSymmetric(horizontal: 4),
                                                          16.height,
                                                          TextField(controller: mNote, decoration: inputDecoration1("Enter Activity name")),
                                                          20.height,
                                                          Text('Activity Icon', style: primaryTextStyle(size: 14)).paddingSymmetric(horizontal: 4),
                                                          8.height,
                                                          Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              if (addTagImg!.isNotEmpty)
                                                                Text(addTagImg!, style: TextStyle(fontSize: 24, decoration: TextDecoration.none, color: Colors.white)).paddingRight(16),
                                                              Container(
                                                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                                                decoration: BoxDecoration(borderRadius: radius(8), border: Border.all(width: 1, color: textSecondaryColor)),
                                                                child: Text('Select Icon', style: secondaryTextStyle()),
                                                              ).onTap(() async {
                                                                appStore.isShowIcon = true;
                                                                setState(() {});
                                                              })
                                                            ],
                                                          ),
                                                          16.height,
                                                          Row(
                                                            children: [
                                                              appCancelButton(context, bgColor: context.cardColor, width: (context.width() / 2) - 20, text: 'Cancel', onTap: () {
                                                                appStore.isShowIcon = false;
                                                                finish(context);
                                                              }),
                                                              8.width,
                                                              appButton(context, width: (context.width() / 2) - 20, bgColor: primaryColor, text: 'Done', onTap: () {
                                                                if (!mEmojiIcon.isEmptyOrNull) {
                                                                  Activity? moodCard = Activity();
                                                                  moodCard.addActivity(DateTime.now().toString(), mEmojiIcon!, mNote!.text.isEmptyOrNull ? mEmojiName! : mNote!.text);
                                                                  Navigator.pop(context);
                                                                  setState(() {});
                                                                }
                                                              }),
                                                            ],
                                                          ),
                                                          16.height,
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                          });
                                        },
                                      );
                                    },
                                    child: Container(
                                        margin: EdgeInsets.only(left: 12, right: 12, top: 10),
                                        decoration:
                                            boxDecorationWithRoundedCornersWidget(borderRadius: radius(8), border: Border.all(width: 1, color: Colors.white), backgroundColor: Colors.transparent),
                                        child: Icon(Icons.add, color: Colors.white)),
                                  )
                                : Container(
                                    width: (context.width() - 46) / 6,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(moodImg!, style: TextStyle(fontSize: 24, decoration: TextDecoration.none, color: Colors.white)),
                                        4.height,
                                        Text(moodName!, style: secondaryTextStyle(size: 12, color: Colors.white), maxLines: 2, textAlign: TextAlign.center),
                                      ],
                                    ).onTap(() {
                                      Activity mActivity = Activity();
                                      mActivity.id = snapshot.data![index]['id'];
                                      mActivity.name = snapshot.data![index]['moodActivityName'];
                                      mActivity.image = snapshot.data![index]['moodActivityImage'];
                                      log(healthStore.isItemInActivityList(id!));
                                      if (healthStore.isItemInActivityList(id)) {
                                        healthStore.removeActivity(mActivity);
                                      } else {
                                        setState(() {
                                          mActivity.isSelected = !mActivity.isSelected!;
                                        });
                                        healthStore.addToActivity(mActivity);
                                      }
                                    }),
                                  );
                          }),
                        )
                      : CircularProgressIndicator().center();
                }),
            SizedBox(height: context.height() * 0.1)
          ],
        ),
      );
    });
  }
}
