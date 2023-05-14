import 'package:animated_text_kit/animated_text_kit.dart';
import '../utils/Extensions/Constants.dart';
import '../utils/Extensions/context_extensions.dart';
import '../component/BodyWidget.dart';
import '../screen/WalkThorughScreen.dart';
import '../utils/Extensions/Widget_extensions.dart';
import '../utils/Extensions/decorations.dart';
import '../utils/Extensions/int_extensions.dart';
import 'package:flutter/material.dart';
import '../utils/Extensions/shared_pref.dart';
import '../utils/constant.dart';
import '../utils/images.dart';
import 'DashboardScreen.dart';

class SplashScreen extends StatefulWidget {
  static String tag = '/SplashScreen';

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    await 3.seconds.delay.whenComplete(() {
      if (getBoolAsync(IS_FIRST_TIME) == true) {
        DashboardScreen().launch(context, isNewTask: true);
      } else {
        WalkThroughScreen().launch(context, isNewTask: true);
      }
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Widget _wavy() {
    return DefaultTextStyle(
      style: TextStyle(fontSize: 25.0),
      child: AnimatedTextKit(
        animatedTexts: [
          WavyAnimatedText(AppName, speed: Duration(milliseconds: 200)),
        ],
        isRepeatingAnimation: true,
        repeatForever: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BodyWidget(
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(ic_splashImage, fit: BoxFit.cover, width: context.width(), height: context.height()).cornerRadiusWithClipRRect(defaultRadius),
            Positioned(
              bottom: 100,
              child:    _wavy(),)

          ],
        ).center(),
      ),
    );
  }
}
