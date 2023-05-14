import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../utils/Extensions/Commons.dart';
import '../utils/Extensions/Widget_extensions.dart';
import '../utils/Extensions/decorations.dart';
import '../utils/Extensions/int_extensions.dart';
import '../utils/common.dart';
import '../utils/images.dart';
import '../component/BodyWidget.dart';
import '../component/SettingItemWidget.dart';
import '../utils/Extensions/text_styles.dart';
import 'Games/PacManGame/PacManGame.dart';
import 'Games/TetrisGame/tetris.dart';
import 'Games/TicTacTeo/TicTacTeoScreen.dart';

class GameZoneScreen extends StatefulWidget {
  @override
  _GameZoneScreenState createState() => _GameZoneScreenState();
}

class _GameZoneScreenState extends State<GameZoneScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
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
        appBar: appBarWidget("", backWidget: backButton(context), color: Colors.transparent, elevation: 0),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: AnimationConfiguration.toStaggeredList(
            duration: Duration(milliseconds: 600),
            childAnimationBuilder: (widget) => SlideAnimation(verticalOffset: 20, child: FadeInAnimation(child: widget)),
            children: [
              16.height,
              Text('Game Zone', style: boldTextStyle(size: 24, color: Colors.white)).paddingLeft(16),
              20.height,
              SettingItemWidget(
                title: "Tic Tac Teo Game",
                onTap: () {
                  TicTacTeoScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Slide);
                },
                leading: Image.asset(ic_tic_tac_toe, height: 20, width: 20),
                trailing: Icon(Icons.keyboard_arrow_right, size: 22),
              ),
              SettingItemWidget(
                title: "Pacman Game",
                onTap: () {
                  PacManScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Slide);
                },
                leading: Image.asset(ic_pacman_ghost, height: 20, width: 20),
                trailing: Icon(Icons.keyboard_arrow_right, size: 22),
              ),
              SettingItemWidget(
                title: "Tetris Game",
                onTap: () {
                  Tetris().launch(context, pageRouteAnimation: PageRouteAnimation.Slide);
                },
                leading: Image.asset(ic_tetris, height: 20, width: 20),
                trailing: Icon(Icons.keyboard_arrow_right, size: 22),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
