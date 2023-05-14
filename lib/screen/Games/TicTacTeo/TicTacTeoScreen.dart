import 'package:emoji_alert/arrays.dart';
import 'package:emoji_alert/emoji_alert.dart';
import 'package:flutter/material.dart';
import '/../utils/Extensions/context_extensions.dart';
import '../../../component/BodyWidget.dart';
import '../../../utils/Extensions/AppButton.dart';
import '../../../utils/Extensions/Commons.dart';
import '../../../utils/Extensions/Widget_extensions.dart';
import '../../../utils/Extensions/decorations.dart';
import '../../../utils/Extensions/int_extensions.dart';
import '../../../utils/Extensions/text_styles.dart';
import '../../../utils/colors.dart';
import '../../../utils/common.dart';
import 'Game.dart';

class TicTacTeoScreen extends StatefulWidget {
  const TicTacTeoScreen({Key? key}) : super(key: key);

  @override
  _TicTacTeoScreenState createState() => _TicTacTeoScreenState();
}

class _TicTacTeoScreenState extends State<TicTacTeoScreen> {

  String activePlayer = 'X';
  bool gameOver = false;
  int turn = 0;
  String result = '';
  Game game = Game();
  bool isSwitched = false;

  @override
  void initState() {
    super.initState();
    Player.playerX = [];
    Player.playerO = [];
    activePlayer = 'X';
    gameOver = false;
    turn = 0;
    result = '';
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BodyWidget(
      Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBarWidget('', color: Colors.transparent, backWidget: backButton(context), elevation: 0, actions: [
          IconButton(
            onPressed: () {
              setState(() {
                Player.playerX = [];
                Player.playerO = [];
                activePlayer = 'X';
                gameOver = false;
                turn = 0;
                result = '';
              });
            },
            icon: Icon(Icons.replay, color: Colors.white),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Theme.of(context).cardColor),
            ),
          ),
        ]),
        body: MediaQuery.of(context).orientation == Orientation.portrait
            ? Column(
                children: [
                  30.height,
                  Text('It\'s $activePlayer turn', style: boldTextStyle(size: 18, color: Colors.white), textAlign: TextAlign.center),
                  20.height,
                  _expanded(context),
                  ...lastBlock(),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('It\'s $activePlayer turn'.toUpperCase(), style: boldTextStyle(), textAlign: TextAlign.center),
                        20.height,
                        ...lastBlock(),
                      ],
                    ),
                  ),
                  _expanded(context),
                ],
              ),
      ),
    );
  }

  List<Widget> firtBlock() {
    return [
      SwitchListTile.adaptive(
        title: Text('Turn on/off two player', style: secondaryTextStyle(color: Colors.white), textAlign: TextAlign.end),
        value: isSwitched,
        activeColor: primaryColor,
        inactiveThumbColor: Colors.white,
        inactiveTrackColor: Colors.white,
        activeTrackColor: primaryColor,
        onChanged: (bool newValue) {
          setState(() {
            isSwitched = newValue;
          });
        },
      ),
    ];
  }

  List<Widget> lastBlock() {
    return [
      Text(result, style: boldTextStyle(color: Colors.white), textAlign: TextAlign.center),
      10.height,
      10.height,
      ...firtBlock(),
    ];
  }

  Widget _expanded(BuildContext context) {
    return Expanded(
      child: GridView.count(
        padding: EdgeInsets.all(16),
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 1.0,
        crossAxisCount: 3,
        children: List.generate(
          9,
          (index) => InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: gameOver ? null : () => _onTap(index),
            child: Container(
              decoration: boxDecorationRoundedWithShadowWidget(16, backgroundColor: cardColor.withOpacity(0.3)),
              child: Text(
                Player.playerX.contains(index)
                    ? 'X'
                    : Player.playerO.contains(index)
                        ? 'O'
                        : '',
                style: boldTextStyle(size: 50),
              ).center(),
            ),
          ),
        ),
      ),
    );
  }

  _onTap(int index) async {
    if ((Player.playerX.isEmpty || !Player.playerX.contains(index)) && (Player.playerO.isEmpty || !Player.playerO.contains(index))) {
      game.playGame(index, activePlayer);
      updateState();

      if (!isSwitched && !gameOver && turn != 9) {
        await game.autoPlay(activePlayer);
        updateState();
      }
    }
  }

  void updateState() {
    setState(() {
      activePlayer = (activePlayer == 'X') ? 'O' : 'X';
      turn++;

      String winnerPlayer = game.checkWinner();

      if (winnerPlayer != '') {
        gameOver = true;
        result = '$winnerPlayer is the winner';
        EmojiAlert(
          alertTitle: Text("Game Over!", style: primaryTextStyle()),
          description: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$winnerPlayer is the winner', style: boldTextStyle(size: 18)).center(),
              24.height,

              AppButtonWidget(
                elevation: 0,
                color: primaryColor,
                width: context.width(),
                shapeBorder: RoundedRectangleBorder(
                  borderRadius: radius(8),
                  side: BorderSide(color: primaryColor),
                ),
                child: Text('Restart', style: boldTextStyle(color: Colors.white)).fit(),
                onTap: () {
                  setState(() {
                    Player.playerX = [];
                    Player.playerO = [];
                    activePlayer = 'X';
                    gameOver = false;
                    turn = 0;
                    result = '';
                    Navigator.pop(context);
                  });
                },
              )
            ],
          ),
          enableMainButton: false,
          cancelable: true,
          background: cardColor,
          mainButtonColor: primaryColor,
          buttonSize: context.width(),
          emojiType: EMOJI_TYPE.SMILE,
          height: 290,
          cancelButtonColorOpacity: 1,
          secondaryButtonColor: primaryColor.withOpacity(0.2),
          animationType: ANIMATION_TYPE.FADEIN,
          cornerRadiusType: CORNER_RADIUS_TYPES.ALL_CORNERS,
        ).displayAlert(context);
      } else if (!gameOver && turn == 9) {
        result = 'It\'s Draw!';
        EmojiAlert(
          alertTitle: Text("Game Over!", style: primaryTextStyle()),
          description: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('It\'s Draw!', style: boldTextStyle(size: 18)).center(),
              24.height,
              AppButtonWidget(
                elevation: 0,
                color: primaryColor,
                width: context.width(),
                shapeBorder: RoundedRectangleBorder(
                  borderRadius: radius(8),
                  side: BorderSide(color: primaryColor),
                ),
                child: Text('Restart', style: boldTextStyle(color: Colors.white)).fit(),
                onTap: () {
                  setState(() {
                    Player.playerX = [];
                    Player.playerO = [];
                    activePlayer = 'X';
                    gameOver = false;
                    turn = 0;
                    result = '';
                    Navigator.pop(context);
                  });
                },
              )
            ],
          ),
          enableMainButton: false,
          cancelable: true,
          background: cardColor,
          mainButtonColor: primaryColor,
          buttonSize: context.width(),
          emojiType: EMOJI_TYPE.SAD,
          height: 270,
          cancelButtonColorOpacity: 1,
          secondaryButtonColor: primaryColor.withOpacity(0.2),
          animationType: ANIMATION_TYPE.FADEIN,
          cornerRadiusType: CORNER_RADIUS_TYPES.ALL_CORNERS,
        ).displayAlert(context);
      }
    });
  }
}
