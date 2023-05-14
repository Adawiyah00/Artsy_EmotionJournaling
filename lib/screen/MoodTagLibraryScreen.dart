import 'dart:io';
import 'package:emoji_alert/arrays.dart';
import 'package:emoji_alert/emoji_alert.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../utils/Extensions/Colors.dart';
import '../utils/common.dart';
import '../component/BodyWidget.dart';
import '../main.dart';
import '../utils/Extensions/Commons.dart';
import '../utils/Extensions/Widget_extensions.dart';
import '../utils/Extensions/context_extensions.dart';
import '../utils/Extensions/decorations.dart';
import '../utils/Extensions/int_extensions.dart';
import '../utils/Extensions/string_extensions.dart';
import '../database/MoodTagDBHelper.dart';
import '../model/MoodTagModel.dart';
import '../utils/Extensions/text_styles.dart';
import '../utils/colors.dart';

class MoodTagLibraryScreen extends StatefulWidget {
  static String tag = '/MoodTagLibraryScreen';

  @override
  MoodTagLibraryScreenState createState() => MoodTagLibraryScreenState();
}

class MoodTagLibraryScreenState extends State<MoodTagLibraryScreen> {
  String? mEmojiName;
  String? mEmojiIcon;

  TextEditingController? mNote = TextEditingController();
  TextEditingController? mTagController = TextEditingController();

  bool? isShowIcon = false;

  onEmojiSelected(Emoji emoji, {int? id}) {
    print('_onEmojiSelected: ${emoji.emoji}');
    print('_onEmojiSelected: ${emoji.toJson().toString()}');
    mEmojiIcon = emoji.emoji;
    mEmojiName = emoji.name;
    if (id != null) {
      isShowIcon = false;
      setState(() {});
    }
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
        appBar: appBarWidget("", backWidget: backButton(context), color: Colors.transparent, elevation: 0, textColor: Colors.white, actions: [addTagWidget()]),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.height,
              Text('Mood Tag Library', style: boldTextStyle(size: 24, color: Colors.white)).paddingLeft(16),
              20.height,
              FutureBuilder<List>(
                future: MooTagDBHelper.getData('mood_tag'),
                initialData: [],
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? Wrap(
                          children: List.generate(
                            snapshot.data!.length,
                            (index) {
                              String? tagName = snapshot.data![index]['moodTagName'];
                              int? tagId = snapshot.data![index]['id'];
                              String? tagImg = snapshot.data![index]['moodTagImage'];
                              return AnimationConfiguration.staggeredGrid(
                                position: index,
                                columnCount: 1,
                                duration: Duration(milliseconds: 375),
                                child: FadeInAnimation(
                                  duration: Duration(milliseconds: 375),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(tagImg!, style: TextStyle(fontSize: 24, decoration: TextDecoration.none, color: Colors.white)),
                                          4.width,
                                          Text("#" + tagName!, style: secondaryTextStyle(size: 14, color: Colors.white), maxLines: 2),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(8),
                                            margin: EdgeInsets.only(right: 8),
                                            decoration: boxDecorationWithRoundedCornersWidget(borderRadius: radiusWidget(8), backgroundColor: Colors.white.withOpacity(0.2)),
                                            child: Icon(Icons.edit, size: 20, color: Colors.green),
                                          ).onTap(() {
                                            mNote!.text = snapshot.data![index]['moodTagName'];
                                            mEmojiIcon = '';
                                            showModalBottomSheet(
                                                context: context,
                                                isDismissible: false,
                                                enableDrag: false,
                                                backgroundColor: cardColor,
                                                isScrollControlled: true,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0))),
                                                builder: (context) {
                                                  return Observer(builder: (context) {
                                                    return appStore.isShowIcon == true
                                                        ? Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              BackButton(onPressed: () {
                                                                appStore.isShowIcon = false;
                                                                setState(() {});
                                                              }),
                                                              SizedBox(
                                                                height: 275,
                                                                child: EmojiPicker(
                                                                  onEmojiSelected: (Category? category, Emoji emoji) {
                                                                    onEmojiSelected(emoji, id: tagId!);
                                                                    appStore.isShowIcon = false;
                                                                    tagImg = emoji.emoji;
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
                                                                    noRecents: Text('No Recent', style: TextStyle(fontSize: 20, color: Colors.black26), textAlign: TextAlign.center),
                                                                    tabIndicatorAnimDuration: kTabScrollDuration,
                                                                    categoryIcons: CategoryIcons(),
                                                                    buttonMode: ButtonMode.MATERIAL,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ).paddingAll(16)
                                                        : Padding(
                                                            padding: EdgeInsets.only(top: 16, bottom: MediaQuery.of(context).viewInsets.bottom),
                                                            child: ConstrainedBox(
                                                              constraints: BoxConstraints(maxHeight: 500),
                                                              child: Column(
                                                                mainAxisSize: MainAxisSize.min,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Align(
                                                                      alignment: Alignment.center,
                                                                      child: Text("Edit #" + snapshot.data![index]['moodTagName'], style: boldTextStyle(), textAlign: TextAlign.center)),
                                                                  8.height,
                                                                  Text('Tag Name', style: primaryTextStyle()),
                                                                  8.height,
                                                                  TextField(controller: mNote, decoration: inputDecoration1(snapshot.data![index]['moodTagName'])),
                                                                  20.height,
                                                                  Text('Icon', style: primaryTextStyle()),
                                                                  16.height,
                                                                  Row(
                                                                    children: [
                                                                      tagImg.isEmptyOrNull
                                                                          ? SizedBox()
                                                                          : Text(tagImg!, style: TextStyle(fontSize: 24, decoration: TextDecoration.none, color: Colors.white)),
                                                                      Container(
                                                                        margin: EdgeInsets.only(left: 8),
                                                                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                                        decoration: BoxDecoration(borderRadius: radius(8), border: Border.all(width: 1, color: textSecondaryColor)),
                                                                        child: Text('Select Icon', style: secondaryTextStyle(color: textSecondaryColor)),
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
                                                                      appButton(context, text: 'Done', width: (context.width() / 2) - 20, bgColor: primaryColor, onTap: () {
                                                                        MoodTagModel? activity = MoodTagModel();
                                                                        if (!mEmojiIcon.isEmptyOrNull) {
                                                                          activity.updateMoodTag(tagId!, DateTime.now().toString(), mNote!.text,
                                                                              mEmojiIcon.isEmptyOrNull ? snapshot.data![index]['moodTagImage'] : mEmojiIcon);
                                                                          setState(() {});
                                                                          finish(context);
                                                                        }
                                                                      }),
                                                                    ],
                                                                  ),
                                                                  16.height,
                                                                ],
                                                              ).paddingAll(16),
                                                            ),
                                                          );
                                                  });
                                                });
                                          }),
                                          8.width,
                                          deleteWidget(tagId),
                                        ],
                                      )
                                    ],
                                  ).paddingSymmetric(horizontal: 16, vertical: 8).visible(tagId != 1),
                                ),
                              );
                            },
                          ),
                        )
                      : CircularProgressIndicator().center();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget addTagWidget() {
    String? addTagImg;
    return IconButton(
      onPressed: () async {
        await showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0))),
          backgroundColor: cardColor,
          isScrollControlled: true,
          builder: (context) {
            return Observer(builder: (context) {
              return appStore.isShowIcon == true
                  ? Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: MediaQuery.of(context).viewInsets.bottom),
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
                            SizedBox(
                              height: 275,
                              child: EmojiPicker(
                                onEmojiSelected: (Category? category, Emoji emoji) {
                                  addTagImg = emoji.emoji;
                                  onEmojiSelected(emoji);
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
                          ],
                        ),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 600),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Create #moodtag", style: boldTextStyle(size: 18)).center(),
                            16.height,
                            Text('Tag Name', style: primaryTextStyle()).paddingSymmetric(horizontal: 4),
                            16.height,
                            TextField(controller: mTagController, decoration: inputDecoration1("Enter tag name")),
                            20.height,
                            Text('Tag Icon', style: primaryTextStyle()),
                            8.height,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                addTagImg.isEmptyOrNull ? SizedBox() : Text(addTagImg!, style: TextStyle(fontSize: 24, decoration: TextDecoration.none, color: Colors.white)).paddingRight(16),
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
                                    MoodTagModel? moodCard = MoodTagModel();
                                    moodCard.addMoodTag(DateTime.now().toString(), mEmojiIcon!, mTagController!.text.isEmptyOrNull ? mEmojiName! : mTagController!.text);
                                    Navigator.pop(context, true);
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
      icon: Icon(AntDesign.pluscircleo),
    );
  }

  Widget deleteWidget(tagId) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: boxDecorationWithRoundedCornersWidget(borderRadius: radiusWidget(8), backgroundColor: Colors.white24),
      child: Icon(Icons.delete, size: 20, color: Colors.red),
    ).onTap(() {
      MoodTagModel? mMoodTagModel = MoodTagModel();
      EmojiAlert(
        alertTitle: Text("Delete Tag", style: boldTextStyle()),
        description: Text("Are you sure you want to delete #tag?", style: primaryTextStyle(), textAlign: TextAlign.center),
        enableMainButton: true,
        mainButtonColor: primaryColor,
        mainButtonText: Text('Done', style: boldTextStyle(color: Colors.white)),
        buttonSize: context.width(),
        onMainButtonPressed: () {
          mMoodTagModel.deleteMoodTag(tagId).whenComplete(() {
            toast("Successfully deleted!");
          });
          setState(() {});
          finish(context);
        },
        cancelable: true,
        emojiType: EMOJI_TYPE.SHOCKED,
        enableSecondaryButton: true,
        height: 310,
        onSecondaryButtonPressed: () {
          Navigator.pop(context);
        },
        animationType: ANIMATION_TYPE.FADEIN,
        cornerRadiusType: CORNER_RADIUS_TYPES.ALL_CORNERS,
      ).displayAlert(context);
    });
  }
}
