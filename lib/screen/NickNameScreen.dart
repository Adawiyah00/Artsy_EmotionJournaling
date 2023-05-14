import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../utils/Extensions/Widget_extensions.dart';
import '../utils/Extensions/context_extensions.dart';
import '../utils/Extensions/int_extensions.dart';
import '../utils/images.dart';
import '../component/BodyWidget.dart';
import '../main.dart';
import '../utils/Extensions/Colors.dart';
import '../utils/Extensions/Commons.dart';
import '../utils/Extensions/decorations.dart';
import '../utils/Extensions/shared_pref.dart';
import '../utils/Extensions/text_styles.dart';
import '../utils/colors.dart';
import '../utils/constant.dart';
import 'DashboardScreen.dart';

class NickNameScreen extends StatefulWidget {
  @override
  _NickNameScreenState createState() => _NickNameScreenState();
}

class _NickNameScreenState extends State<NickNameScreen> {
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    nameController.text = getStringAsync(NICK_NAME);
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
        floatingActionButton: Container(
          child: Icon(Icons.keyboard_arrow_right, size: 28, color: whiteColor),
          padding: EdgeInsets.all(10),
          decoration: boxDecorationWithRoundedCornersWidget(backgroundColor: nameController.text.isNotEmpty ? primaryColor : Colors.grey, borderRadius: radius(16)),
        ).onTap(() async {
          if (nameController.text.isNotEmpty) {
            appStore.setNikName(nameController.text.trim());
            log(nameController.text.trim());
            await setValue(IS_FIRST_TIME, true);
            DashboardScreen().launch(context, isNewTask: true);
          } else {
            toast("Hey,there Add your Nickname");
          }
        }, splashColor: Colors.transparent, highlightColor: Colors.transparent, hoverColor: Colors.transparent),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Opacity(opacity: 0.05, child: Image.asset(ic_bgPatter, width: context.width(), height: context.height(),fit: BoxFit.cover)),
              Column(
                children: [
                  Text('What should I call you?', style: boldTextStyle(color: Colors.white, size: 24)),
                  SizedBox(height: context.height() * 0.2),
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        height: context.height() * 0.4,
                        width: context.width(),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        margin: EdgeInsets.symmetric(horizontal: 24),
                        decoration: boxDecorationRoundedWithShadowWidget(24, backgroundColor: cardColor),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            16.height,
                            Text("Yeah, Add here your Nickname", style: primaryTextStyle()),
                            16.height,
                            TextField(
                              controller: nameController,
                              decoration: inputDecoration(context,label: "Add you Nick Name"),
                            ),
                          ],
                        ),
                      ),
                      Positioned(top: -70, child: Lottie.asset(happy_animation, height: 150, width: 150))
                    ],
                  )
                ],
              ).paddingTop(context.statusBarHeight + 50),
            ],
          ),
        ),
      ),
    );
  }
}
