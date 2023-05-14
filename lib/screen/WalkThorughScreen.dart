import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../utils/Extensions/Constants.dart';
import '../utils/constant.dart';
import '../utils/Extensions/Widget_extensions.dart';
import '../utils/Extensions/context_extensions.dart';
import '../utils/Extensions/int_extensions.dart';
import '../component/BodyWidget.dart';
import '../model/WalkThroughModel.dart';
import '../utils/Extensions/decorations.dart';
import '../utils/Extensions/text_styles.dart';
import '../utils/colors.dart';
import '../utils/images.dart';
import 'NickNameScreen.dart';

class WalkThroughScreen extends StatefulWidget {
  static String tag = '/WalkThroughScreen';

  @override
  WalkThroughScreenState createState() => WalkThroughScreenState();
}

class WalkThroughScreenState extends State<WalkThroughScreen> {
  num pos = 0;
  Timer? time;

  List<String?> list = [sad_animation, smiley_animation, angry_animation, joy_animation, happy_animation, loving_animation];

  List<WalkThroughModel> mWalkList = [];
  PageController pageController = PageController();
  TextEditingController nameController = TextEditingController();

  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    time = Timer.periodic(new Duration(milliseconds: 2000), (Timer t) {
      setState(() {
        pos = (pos + 1) % list.length;
      });
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
        body: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(ic_walkThroughBg, width: context.width(), height: context.height(), fit: BoxFit.cover),
            Positioned(top: context.statusBarHeight + 120, child: Lottie.asset(list[pos.toInt()]!, width: 150, height: 150)),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: boxDecorationWithRoundedCornersWidget(
                    borderRadius: BorderRadius.only(topRight: radiusCircular(defaultRadius), topLeft: Radius.circular(defaultRadius)), backgroundColor: primaryColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    16.height,
                    Text(AppName, style: boldTextStyle(color: Colors.white, size: 22)),
                    16.height,
                    Text(walkThroughDec, style: secondaryTextStyle(color: Colors.white), textAlign: TextAlign.center).paddingSymmetric(horizontal: 16),
                    30.height,
                    GestureDetector(
                      onTap: () {
                        NickNameScreen().launch(context);
                      },
                      child: Container(
                        child: Text("Get Started", style: boldTextStyle()),
                        padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
                        decoration: boxDecorationRoundedWithShadowWidget(8, backgroundColor: cardColor),
                      ),
                    ),
                    16.height,
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
