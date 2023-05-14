import 'package:emoji_alert/arrays.dart';
import 'package:emoji_alert/emoji_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../utils/Extensions/AppButton.dart';
import '../component/BodyWidget.dart';
import '../main.dart';
import '../screen/AboutUsScreen.dart';
import '../screen/MoodActivityLibraryScreen.dart';
import '../screen/MoodTagLibraryScreen.dart';
import '../utils/Extensions/Colors.dart';
import '../utils/Extensions/Widget_extensions.dart';
import '../utils/Extensions/context_extensions.dart';
import '../utils/Extensions/decorations.dart';
import '../utils/Extensions/int_extensions.dart';
import '../utils/Extensions/shared_pref.dart';
import '../utils/constant.dart';
import '../component/SettingItemWidget.dart';
import '../utils/Extensions/Commons.dart';
import '../utils/Extensions/text_styles.dart';
import '../utils/colors.dart';
import 'GameZoneScreen.dart';

class ProfileScreen extends StatefulWidget {
  static String tag = '/ProfileScreen';

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  bool isDailyRemanderOn = false;
  TextEditingController nameController = TextEditingController();
  int? pickedHour = 0;
  int? pickedMin = 0;
  String? pickedTime = '';
  DateTime date = DateTime.now();

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return BodyWidget(
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBarWidget("Settings", textColor: Colors.white, showBack: false, color: transparentColor, elevation: 0),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: AnimationConfiguration.toStaggeredList(
              duration: Duration(milliseconds: 600),
              childAnimationBuilder: (widget) => SlideAnimation(verticalOffset: 20, child: FadeInAnimation(child: widget)),
              children: [
                SettingItemWidget(
                  title: "Nickname",
                  onTap: () {
                    nameController.text = getStringAsync(NICK_NAME);
                    EmojiAlert(
                      alertTitle: Text("Edit Nick Name", style: boldTextStyle()).paddingTop(20),
                      description: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Yeah, want to edit nick name?", style: secondaryTextStyle()),
                          16.height,
                          TextField(
                            controller: nameController,
                            decoration: inputDecoration1("Nick Name"),
                          ),
                          16.height,
                          AppButtonWidget(
                            elevation: 0,
                            color: primaryColor,
                            width: context.width(),
                            shapeBorder: RoundedRectangleBorder(borderRadius: radius(8), side: BorderSide(color: primaryColor)),
                            child: Text('Done', style: boldTextStyle(color: Colors.white)).fit(),
                            onTap: () {
                              appStore.setNikName(nameController.text);
                              log(nameController.text);
                              finish(context);
                            },
                          )
                        ],
                      ),
                      enableMainButton: false,
                      cancelable: true,
                      background: cardColor,
                      mainButtonColor: primaryColor,
                      buttonSize: context.width(),
                      emojiType: EMOJI_TYPE.JOYFUL,
                      height: 345,
                      cancelButtonColorOpacity: 1,
                      secondaryButtonColor: primaryColor.withOpacity(0.2),
                      animationType: ANIMATION_TYPE.FADEIN,
                      cornerRadiusType: CORNER_RADIUS_TYPES.ALL_CORNERS,
                    ).displayAlert(context);
                  },
                  leading: Icon(FontAwesome.user_o, size: 22),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
                SettingItemWidget(
                  title: "Mood Tag Library",
                  onTap: () {
                    MoodTagLibraryScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Slide);
                  },
                  leading: Icon(MaterialIcons.tag_faces, size: 22),
                  trailing: Icon(Icons.keyboard_arrow_right, size: 22),
                ),
                SettingItemWidget(
                  title: "Activity Library",
                  onTap: () {
                    MoodActivityLibraryScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Slide);
                  },
                  leading: Icon(Icons.sentiment_satisfied_alt, size: 22),
                  trailing: Icon(Icons.keyboard_arrow_right, size: 22),
                ),
                SettingItemWidget(
                  title: "Game Zone",
                  onTap: () {
                    GameZoneScreen().launch(context);
                  },
                  leading: Icon(Ionicons.ios_game_controller_outline, size: 22),
                  trailing: Icon(Icons.keyboard_arrow_right, size: 22),
                ),
                SettingItemWidget(
                  title: "About",
                  onTap: () async {
                    AboutUsScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Slide);
                  },
                  leading: Icon(Ionicons.information_circle_outline, size: 22),
                  trailing: Icon(Icons.keyboard_arrow_right, size: 22),
                  isDivider: false,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
