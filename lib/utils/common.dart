import 'package:emoji_alert/arrays.dart';
import 'package:emoji_alert/emoji_alert.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/Extensions/context_extensions.dart';
import '../utils/Extensions/int_extensions.dart';
import '../utils/Extensions/string_extensions.dart';
import '../model/Activity.dart';
import '../model/MoodModel.dart';
import '../model/MoodTagModel.dart';
import 'Extensions/Colors.dart';
import 'Extensions/Commons.dart';
import 'Extensions/decorations.dart';
import 'Extensions/text_styles.dart';
import 'colors.dart';
import 'images.dart';

List<MoodModel> mMoodList = [
  MoodModel(id: 0, image: scare_animation, name: 'Scared'),
  MoodModel(id: 1, image: sad_animation, name: 'Sad'),
  MoodModel(id: 2, image: angry_animation, name: 'Angry'),
  MoodModel(id: 3, image: smiley_animation, name: 'Smile'),
  MoodModel(id: 4, image: joy_animation, name: 'Cry'),
  MoodModel(id: 5, image: loving_animation, name: 'Loving'),
  MoodModel(id: 6, image: happy_animation, name: 'Happy'),
];

List<Activity> mActivityList = [
  Activity(image: "➕", name: 'Add'),
  Activity(image: "💪", name: 'Sport'),
  Activity(image: "😴", name: 'Sleep'),
  Activity(image: "❤", name: 'Dating'),
  Activity(image: "💼", name: 'Work'),
  Activity(image: "📔", name: 'Read'),
  Activity(image: "🎬", name: 'Movies'),
  Activity(image: "🎮", name: 'Gaming'),
  Activity(image: "👫", name: 'Friends'),
  Activity(image: "🍔", name: 'Food'),
  Activity(image: "👩‍👩‍👦", name: 'Family'),
  Activity(image: "🎻", name: 'Music'),
];

List<MoodTagModel> mMoodTagList = [
  MoodTagModel(image: "➕", name: 'add'),
  MoodTagModel(image: "😡", name: 'angry'),
  MoodTagModel(image: "😁", name: 'happy'),
  MoodTagModel(image: "🤒", name: 'sick'),
  MoodTagModel(image: "😱", name: 'sock'),
  MoodTagModel(image: "😔", name: 'down'),
  MoodTagModel(image: "😅", name: 'awkward'),
  MoodTagModel(image: "🙂", name: 'good'),
];

extension DateTimeExtension on DateTime? {
  bool? isAfterOrEqualTo(DateTime dateTime) {
    final date = this;
    if (date != null) {
      final isAtSameMomentAs = dateTime.isAtSameMomentAs(date);
      return isAtSameMomentAs | date.isAfter(dateTime);
    }
    return null;
  }

  bool? isBeforeOrEqualTo(DateTime dateTime) {
    final date = this;
    if (date != null) {
      final isAtSameMomentAs = dateTime.isAtSameMomentAs(date);
      return isAtSameMomentAs | date.isBefore(dateTime);
    }
    return null;
  }

  bool? isBetween(DateTime? fromDateTime, DateTime? toDateTime) {
    final date = this;
    if (date != null) {
      final isAfter = date.isAfterOrEqualTo(fromDateTime!) ?? false;
      final isBefore = date.isBeforeOrEqualTo(toDateTime!) ?? false;
      return isAfter && isBefore;
    }
    return null;
  }
}

Widget deleteDialog(BuildContext context, Function onMainCall) {
  return EmojiAlert(
    alertTitle: Text("Delete Tag", style: TextStyle(fontWeight: FontWeight.bold)),
    description: Text("Warning, want to Delete ?"),
    enableMainButton: true,
    mainButtonColor: primaryColor,
    mainButtonText: Text('Done', style: boldTextStyle(color: Colors.white)),
    buttonSize: context.width(),
    onMainButtonPressed: () {
      onMainCall();
    },
    onSecondaryButtonPressed: () {
      finish(context);
    },
    cancelable: true,
    emojiType: EMOJI_TYPE.SHOCKED,
    enableSecondaryButton: true,
    secondaryButtonColor: primaryColor.withOpacity(0.2),
    height: 330,
    animationType: ANIMATION_TYPE.FADEIN,
    cornerRadiusType: CORNER_RADIUS_TYPES.ALL_CORNERS,
  ).displayAlert(context);
}

dateStringWidget(String date) {
  DateFormat dateFormat = DateFormat('MMM dd yyyy, hh:mm a');
  DateTime dateTime = DateTime.parse(date);
  var dateValue = dateFormat.format(dateTime);
  return dateValue;
}

Widget iconsBackgroundWidget(BuildContext context, {String? name, IconData? iconData, Color? color}) {
  return Container(
    width: context.width() / 3 - 32,
    color: context.scaffoldBackgroundColor,
    child: Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(child: SizedBox(height: 28, width: 28), backgroundColor: color, radius: 28),
            Positioned(
              top: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(56)),
                      color: Colors.black.withOpacity(0.2),
                    ),
                    width: 28,
                    height: 28,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(56)),
                      color: Colors.black.withOpacity(0.2),
                    ),
                    width: 28,
                    height: 28,
                  ),
                ],
              ),
            ),
            Icon(iconData, size: 28, color: Colors.white),
          ],
        ),
        8.height,
        Text(name.validate(), style: secondaryTextStyle(color: textSecondaryColor)),
      ],
    ),
  );
}

Widget backButton(BuildContext context, {Function? onTap}) {
  return InkWell(
    onTap: () {
      onTap ?? finish(context);
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
  );
}
