import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../component/BodyWidget.dart';
import '../main.dart';
import '../utils/Extensions/Colors.dart';
import '../model/Mood.dart';
import '../model/TalkMoreModel.dart';
import '../utils/Extensions/Commons.dart';
import '../utils/Extensions/Widget_extensions.dart';
import '../utils/Extensions/context_extensions.dart';
import '../utils/colors.dart';
import '../component/MoodStep1Component.dart';
import '../component/MoodStep2Component.dart';
import '../component/MoodStep3Component.dart';
import '../utils/Extensions/decorations.dart';
import '../utils/common.dart';

class AddHealthScreen extends StatefulWidget {
  static String tag = '/AddHealthScreen';

  final Mood? moodCard;
  final bool? isUpdate;
  final Function? onCall;

  AddHealthScreen({this.moodCard, this.isUpdate = false, this.onCall});

  @override
  AddHealthScreenState createState() => AddHealthScreenState();
}

class AddHealthScreenState extends State<AddHealthScreen> {
  PageController? _controller;
  int? _currentIndex = 0;

  String? datepicked;
  String? timepicked;
  String? dateonly;
  String? datetime;
  DateTime? d;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
    _controller = PageController(initialPage: 0);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  saveData() {
    TalkMoreModel talkMoreList = TalkMoreModel();
    talkMoreList.note = healthStore.note;
    talkMoreList.moodTag = healthStore.moodTagList;
    healthStore.clearTalkMore();
    healthStore.addToTalkMore(talkMoreList);

    Mood? moodCard = Mood();
    List<String>? mImg = [];
    List<String>? mName = [];
    List<int>? mId = [];
    healthStore.activityList.forEach((element) {
      mId.add(element.id!);
      mImg.add(element.image!);
      mName.add(element.name!);
    });

    List<String>? mTagImg = [];
    List<String>? mTagName = [];
    List<int>? mTagId = [];
    healthStore.moodTagList.forEach((element) {
      mTagId.add(element.id!);
      mTagImg.add(element.image!);
      mTagName.add(element.name!);
    });
    if (dateonly == null) {
      var outputFormat = DateFormat('yyyy-MM-dd hh:mm a');
      var outputDate = outputFormat.format(DateTime.now());
      datepicked = outputDate;
      dateonly = DateTime.now().toString();
      DateTime d = DateTime.parse(dateonly.toString());
      DateFormat formatter = DateFormat('dd-MM-yyyy');
      dateonly = formatter.format(d);
    }

    print("dateonly-->" + dateonly.toString());
    print("datepicked-->" + datepicked.toString());

    // I/flutter ( 1866): dateonly-->07-02-2023
    // I/flutter ( 1866): datepicked-->2023-02-07 14:23:06.273205
    List<String>? mPhotos = [];
    healthStore.mMoodPhotos.forEach((element) {
      mPhotos.add(element);
    });
    String? audiNote = healthStore.audioNote;

    if (widget.isUpdate == true) {
      log(widget.isUpdate);
      moodCard.updateMood(
        id: widget.moodCard!.id,
        datetime: dateonly,
        date: datepicked,
        moodid: healthStore.moodList.isNotEmpty ? healthStore.moodList[0].id : mMoodList.first.id,
        mood: healthStore.moodList.isNotEmpty ? healthStore.moodList[0].name : mMoodList.first.name,
        image: healthStore.moodList.isNotEmpty ? healthStore.moodList[0].image : mMoodList.first.image,
        actid: mId.join('_'),
        actimage: mImg.join('_'),
        actname: mName.join('_'),
        note: healthStore.talkMoreList[0].note.toString(),
        tagId: mTagId.join('_'),
        tag: mTagName.join('_'),
        tagImage: mTagImg.join('_'),
        voiceNote: audiNote,
        photos: mPhotos.join('mood-image'),
      );
    } else {
      moodCard.addMood(
        datetime: dateonly,
        date: datepicked,
        moodid: healthStore.moodList.isNotEmpty ? healthStore.moodList[0].id : mMoodList.first.id,
        mood: healthStore.moodList.isNotEmpty ? healthStore.moodList[0].name : mMoodList.first.name,
        image: healthStore.moodList.isNotEmpty ? healthStore.moodList[0].image : mMoodList.first.image,
        actid: healthStore.activityList.isNotEmpty ? mId.join('_') : '',
        actimage: healthStore.activityList.isNotEmpty ? mImg.join('_') : '',
        actname: healthStore.activityList.isNotEmpty ? mName.join('_') : '',
        note: healthStore.talkMoreList[0].note.toString(),
        tagId: healthStore.moodTagList.isNotEmpty ? mTagId.join('_') : '',
        tag: healthStore.moodTagList.isNotEmpty ? mTagName.join('_') : '',
        tagImage: healthStore.moodTagList.isNotEmpty ? mTagImg.join('_') : '',
        voiceNote: audiNote,
        photos: mPhotos.join('mood-image'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BodyWidget(
      Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: appBarWidget(
          "",
          showBack: true,
          textColor: whiteColor,
          color: transparentColor,
          elevation: 0,
          backWidget: InkWell(
            onTap: () {
              if (_currentIndex == 0) {
                finish(context);
              } else {
                _controller!.animateToPage(_controller!.page!.toInt() - 1, duration: Duration(milliseconds: 400), curve: Curves.easeIn);
              }
            },
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            child: Container(
              margin: EdgeInsets.all(12),
              decoration: boxDecorationWithRoundedCornersWidget(border: Border.all(width: 1, color: primaryColor), borderRadius: radius(8)),
              child: Padding(
                padding: EdgeInsets.only(left: 6),
                child: Icon(Icons.arrow_back_ios, color: primaryColor, size: 18),
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2021), lastDate: DateTime.now())
                    .then((date) => {
                          setState(() {
                            d = date;
                            print("date->" + date.toString());
                            DateFormat formatter = DateFormat('yyyy-MM-dd');
                            datepicked = DateFormat().format(d!);
                            DateTime date1 = DateTime.parse(d.toString());
                            dateonly = formatter.format(date1);
                          }),
                        })
                    .whenComplete(() {
                  showTimePicker(context: context, initialTime: TimeOfDay.now(), initialEntryMode: TimePickerEntryMode.dial).then((time) => {
                        setState(() {
                          timepicked = time!.format(context).toString();
                          // datepicked = datepicked! + ' ' + timepicked!;
                          datepicked = dateonly.toString() + ' ' + timepicked.toString();
                          dateonly = dateonly;
                        }),
                      });
                });
              },
              icon: Icon(Icons.calendar_today, color: Colors.white),
            ),
          ],
        ),
        body: Stack(
          children: [
            PageView(
              controller: _controller,
              onPageChanged: (value) {
                _currentIndex = value;
                setState(() {});
              },
              children: [
                MoodStep1Component(isUpdate: widget.isUpdate, id: widget.moodCard != null ? widget.moodCard!.moodId : 1),
                MoodStep2Component(isUpdate: widget.isUpdate, moodCard: widget.moodCard),
                MoodStep3Component(isUpdate: widget.isUpdate, moodCard: widget.moodCard),
              ],
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: SizedBox(
                width: context.width(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _currentIndex! > 0
                        ? Container(
                                child: Icon(Icons.chevron_left, size: 28, color: whiteColor),
                                padding: EdgeInsets.all(10),
                                decoration: boxDecorationWithRoundedCornersWidget(backgroundColor: primaryColor, borderRadius: radius(16)))
                            .onTap(() {
                            if (_currentIndex == 1) {
                              _controller!.jumpToPage(0);
                            } else {
                              _controller!.jumpToPage(1);
                            }
                          }, highlightColor: Colors.transparent, splashColor: transparentColor, hoverColor: Colors.transparent)
                        : SizedBox(),
                    Container(
                      child: Icon(_currentIndex != 2 ? Icons.keyboard_arrow_right : Icons.check, size: 28, color: whiteColor),
                      padding: EdgeInsets.all(10),
                      decoration: boxDecorationWithRoundedCornersWidget(backgroundColor: primaryColor, borderRadius: radius(16)),
                    ).onTap(() {
                      if (_currentIndex! <= 1) {
                        _controller!.nextPage(duration: Duration(milliseconds: 100), curve: Curves.bounceIn);
                      } else {
                        saveData();
                        finish(context);
                        widget.onCall!();
                      }
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
