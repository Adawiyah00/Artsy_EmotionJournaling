import 'dart:io';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/Extensions/Commons.dart';
import '../model/Mood.dart';
import '../utils/Extensions/Colors.dart';
import '../utils/Extensions/context_extensions.dart';
import '../utils/Extensions/string_extensions.dart';
import 'package:record/record.dart';
import '../database/MoodTagDBHelper.dart';
import '../main.dart';
import '../model/MoodTagModel.dart';
import '../utils/Extensions/Widget_extensions.dart';
import '../utils/Extensions/decorations.dart';
import '../utils/Extensions/int_extensions.dart';
import '../utils/Extensions/AppTextField.dart';
import '../utils/Extensions/text_styles.dart';
import '../utils/colors.dart';
import 'AudioPlayComponent.dart';
import 'VoiceNoteRecordWidget.dart';

class MoodStep3Component extends StatefulWidget {
  static String tag = '/MoodStep3Component';
  final bool? isUpdate;
  final Mood? moodCard;
  final int? id;

  MoodStep3Component({this.isUpdate = false, this.moodCard, this.id = 0});

  @override
  MoodStep3ComponentState createState() => MoodStep3ComponentState();
}

class MoodStep3ComponentState extends State<MoodStep3Component> {
  TextEditingController? mTagController = TextEditingController();
  TextEditingController? mNote = TextEditingController();
  bool emojiShowing = false;
  String? mEmojiName;
  String? mEmojiIcon;
  String? addTagImg;

  final record = Record();

  List<String> img = [];
  List<String> imgList = [''];

  String? audioPath;

  List<MoodTagModel> moodList = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    if (widget.isUpdate == true) {
      getTagData();
    } else {
      healthStore.clearMoodTag();
      healthStore.setMoodPhotosClear();
      healthStore.clearAudioNote();
      healthStore.note = '';
    }
  }

  getTagData() {
    List<int> id = [];
    List<String> img1 = [];
    List<String> name = [];

    widget.moodCard!.tagId!.forEach((shop) => id.add(shop.toInt()));
    widget.moodCard!.tagName!.forEach((shop) => name.add(shop));
    widget.moodCard!.tagImg!.forEach((shop) => img1.add(shop));

    for (int i = 0; i < id.length; i++) {
      MoodTagModel mood = MoodTagModel();
      mood.id = id[i].toInt();
      mood.name = name[i];
      mood.image = img1[i];
      moodList.add(mood);
    }

    var seen1 = Set<String>();
    List<MoodTagModel> mTagUniqueList = moodList.where((listId) => seen1.add(listId.id.toString())).toList();
    mTagUniqueList.forEach((element) {
      log(element);
      moodList = mTagUniqueList;
    });
    mNote!.text = widget.moodCard!.note!;
    audioPath = widget.moodCard!.voiceNote;
    audioPath = widget.moodCard!.voiceNote;
    widget.moodCard!.photos!.forEach((element) {
      img.add(element);
      imgList.add(element);
    });
    widget.moodCard!.photos!.forEach((element) {
      log("data" + element.toString());
    });
    healthStore.addMoodTagItem(moodList);
    healthStore.setMoodPhotosClear();
    healthStore.setMoodPhotos(img);
  }

  _onEmojiSelected(Emoji emoji) {
    print('_onEmojiSelected: ${emoji.emoji}');
    print('_onEmojiSelected: ${emoji.name}');
    print('_onEmojiSelected: ${emoji.toJson().toString()}');
    mEmojiName = emoji.name;
    mEmojiIcon = emoji.emoji;
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    16.height,
                    Text("Would you like to discuss it further?", style: boldTextStyle(size: 20, color: Colors.white), textAlign: TextAlign.center),
                    30.height,
                    AppTextField(
                        controller: mNote,
                        textFieldType: TextFieldType.OTHER,
                        textStyle: primaryTextStyle(color: Colors.white),
                        decoration: inputDecoration(context, label: "Note", radius: 16, color: Colors.white),
                        onChanged: (v) {
                          healthStore.note = mNote!.text;
                          setState(() {});
                        }),
                    30.height,
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text("Specify your feeling with #moodtags", style: secondaryTextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.start,
                    children: healthStore.moodTagList.map((e) {
                      return Container(
                          width: (context.width() - 58) / 5,
                          decoration: boxDecorationWithRoundedCornersWidget(borderRadius: radius(16), backgroundColor: Colors.black.withOpacity(0.2)),
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(e.image!, style: TextStyle(fontSize: 22, decoration: TextDecoration.none, color: Colors.white)),
                              2.width,
                              Icon(Icons.close, size: 16, color: Colors.white),
                            ],
                          )).onTap(() {
                        healthStore.removeMoodTag(e);
                        setState(() {});
                      });
                    }).toList(),
                  ).paddingLeft(12),
                  24.height,
                  FutureBuilder<List>(
                    future: MooTagDBHelper.getData('mood_tag'),
                    initialData: [],
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? Wrap(
                              spacing: 6,
                              runSpacing: 30,
                              children: List.generate(
                                snapshot.data!.length,
                                (index) {
                                  int? id = snapshot.data![index]['id'];
                                  String? tagName = snapshot.data![index]['moodTagName'];
                                  String? tagImg = snapshot.data![index]['moodTagImage'];
                                  return id == 1
                                      ? InkWell(
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          splashColor: Colors.transparent,
                                          onTap: () async {
                                            mTagController!.text = '';
                                            addTagImg = '';
                                            mEmojiIcon = '';
                                            await showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0))),
                                              backgroundColor: cardColor,
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
                                                                Text("Create #moodtag", style: boldTextStyle(size: 18)).center(),
                                                                16.height,
                                                                Text('Tag Name', style: primaryTextStyle()).paddingSymmetric(horizontal: 4),
                                                                8.height,
                                                                TextField(controller: mTagController, decoration: inputDecoration1("Enter tag name")),
                                                                20.height,
                                                                Text('Tag Icon', style: primaryTextStyle()),
                                                                8.height,
                                                                Row(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    addTagImg.isEmptyOrNull
                                                                        ? SizedBox()
                                                                        : Text(addTagImg!, style: TextStyle(fontSize: 24, decoration: TextDecoration.none, color: Colors.white)).paddingRight(16),
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
                                                                        moodCard.addMoodTag(
                                                                            DateTime.now().toString(), mEmojiIcon!, mTagController!.text.isEmptyOrNull ? mEmojiName! : mTagController!.text);
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
                                          child: Container(
                                            margin: EdgeInsets.only(left: 12, right: 12),
                                            decoration:
                                                boxDecorationWithRoundedCornersWidget(borderRadius: radius(8), border: Border.all(width: 1, color: Colors.white), backgroundColor: Colors.transparent),
                                            child: Icon(Icons.add, color: Colors.white),
                                          ),
                                        )
                                      : Container(
                                          width: (context.width() - 46) / 6,
                                          child: Column(
                                            children: [
                                              Text(tagImg!, style: TextStyle(fontSize: 24, decoration: TextDecoration.none, color: Colors.white)),
                                              2.height,
                                              Text("#" + tagName!, style: secondaryTextStyle(size: 12, color: Colors.white), maxLines: 2,textAlign: TextAlign.center,),
                                            ],
                                          ).onTap(
                                            () {
                                              MoodTagModel mMoodTagModel = MoodTagModel();
                                              mMoodTagModel.id = snapshot.data![index]['id'];
                                              mMoodTagModel.name = snapshot.data![index]['moodTagName'];
                                              mMoodTagModel.image = snapshot.data![index]['moodTagImage'];
                                              if (healthStore.isItemInMoodTagList(mMoodTagModel.id!)) {
                                                healthStore.removeMoodTag(mMoodTagModel);
                                              } else {
                                                healthStore.addToMoodTag(mMoodTagModel);
                                              }
                                              setState(() {});
                                            },
                                          ),
                                        );
                                },
                              ),
                            ).paddingLeft(8)
                          : CircularProgressIndicator().center();
                    },
                  ),
                ],
              ),
              12.height,
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text("Voice note", style: boldTextStyle(letterSpacing: 1, color: Colors.white), textAlign: TextAlign.start),
                    ),
                    16.height,
                    audioPath.isEmptyOrNull
                        ? AudioRecorder(
                            onStop: (path) {
                              setState(() {
                                audioPath = path;
                              });
                              healthStore.setAudioNote(audioPath!);
                              setState(() {});
                            },
                          )
                        : Align(
                            alignment: Alignment.topLeft,
                            child: Stack(
                              alignment: Alignment.topRight,
                              clipBehavior: Clip.none,
                              children: [
                                AudioPlayComponent(data: widget.moodCard, audioUrl: audioPath),
                                Positioned(
                                  top: -10,
                                  right: -10,
                                  child: InkWell(
                                    onTap: () {
                                      audioPath = null;
                                      healthStore.clearAudioNote();
                                      log(audioPath);
                                      setState(() {});
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: boxDecorationWithRoundedCornersWidget(backgroundColor: Colors.black26.withOpacity(0.2)),
                                      child: Icon(Icons.close, color: Colors.white, size: 18),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                    30.height,
                    Align(alignment: Alignment.topLeft, child: Text("Add Photos", style: boldTextStyle(letterSpacing: 1, color: Colors.white))),
                    16.height,
                    imageWidget(),
                    80.height,
                  ],
                ),
              ),
              SizedBox(height: context.height() * 0.1)
            ],
          ),
        );
      },
    );
  }

  Widget imageWidget() {
    return Wrap(
      runSpacing: 8,
      spacing: 8,
      children: List.generate(
        imgList.length,
        (index) {
          if (index == 0) {
            return Container(
              height: 60,
              width: (context.width() - 64) / 5,
              decoration: boxDecorationDefaultWidget(color: cardColor, borderRadius: radius(16)),
              child: IconButton(
                onPressed: () async {
                  healthStore.setMoodPhotosClear();
                  try {
                    final XFile? pickedFile = await _picker.pickImage(
                      source: ImageSource.gallery,
                    );
                    setState(() {
                      //_setImageFileListFromFile(pickedFile);
                      img.add(pickedFile!.path);
                      healthStore.setMoodPhotos(img);
                      imgList.add(pickedFile.path);
                      setState(() {});
                    });
                  } catch (e) {
                    setState(() {
                      print("error" + e.toString());
                    });
                  }
                },
                icon: Icon(Icons.add),
              ),
            );
          }
          return !imgList[index].isEmptyOrNull
              ? Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Image.file(File(imgList[index]), height: 60, width: (context.width() - 64) / 5, fit: BoxFit.cover, alignment: Alignment.center).cornerRadiusWithClipRRect(16),
                    Positioned(
                      top: -10,
                      right: -10,
                      child: InkWell(
                        onTap: () {
                          img.remove(imgList[index]);
                          healthStore.setMoodPhotos(img);
                          imgList.remove(imgList[index]);
                          setState(() {});
                        },
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: boxDecorationWithRoundedCornersWidget(backgroundColor: Colors.black26.withOpacity(0.2)),
                          child: Icon(Icons.close, color: Colors.white, size: 18),
                        ),
                      ),
                    )
                  ],
                )
              : SizedBox();
        },
      ),
    );
  }
}
