import 'package:flutter/material.dart';
import '../utils/Extensions/Constants.dart';
import '../utils/Extensions/Widget_extensions.dart';
import '../utils/Extensions/int_extensions.dart';
import '../utils/Extensions/context_extensions.dart';
import '../utils/common.dart';
import '../utils/constant.dart';
import '../component/BodyWidget.dart';
import '../utils/Extensions/text_styles.dart';
import '../utils/images.dart';

class AboutUsScreen extends StatefulWidget {
  static String tag = '/AboutUsScreen';

  @override
  AboutUsScreenState createState() => AboutUsScreenState();
}

class AboutUsScreenState extends State<AboutUsScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
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
            Opacity(opacity: 0.05, child: Image.asset(ic_bgPatter, width: context.width(), height: context.height(), fit: BoxFit.cover)),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(ic_logo, height: 150, width: 150).cornerRadiusWithClipRRect(defaultRadius),
                20.height,
                Text(AppName, style: boldTextStyle(size: 24, color: Colors.white)),
                16.height,
                Text(AppDescription, style: primaryTextStyle(color: Colors.white), textAlign: TextAlign.center),
              ],
            ).paddingAll(16),
            Positioned(
              top: context.statusBarHeight + 4,
              left: 8,
              child: SizedBox(height: 55, width: 55, child: backButton(context)),
            ),
          ],
        ),
      ),
    );
  }
}
