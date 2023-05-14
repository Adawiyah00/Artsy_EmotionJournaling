import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../../../utils/Extensions/Commons.dart';
import '../../../utils/common.dart';
import '../../../component/BodyWidget.dart';

enum Direction { up, down, left, right }

class SnakeGameScreen extends StatefulWidget {
  const SnakeGameScreen({Key? key}) : super(key: key);

  @override
  State<SnakeGameScreen> createState() => _SnakeGameScreenState();
}

class _SnakeGameScreenState extends State<SnakeGameScreen> {
  List<int> snakePosition = [24, 44, 64];
  int foodLocation = Random().nextInt(700);
  bool start = false;
  Direction direction = Direction.down;
  List<int> totalSpot = List.generate(760, (index) => index);
   FloatingActionButtonLocation? fabLocation;
   NotchedShape? shape;


  startGame() {
    start = true;
    snakePosition = [24, 44, 64];
    Timer.periodic(Duration(milliseconds: 150), (timer) {
      updateSnake();
      if (gameOver()) {
        gameOverAlert();
        timer.cancel();
      }
    });
  }

  updateSnake() {
    setState(() {
      switch (direction) {
        case Direction.down:
          if (snakePosition.last > 740) {
            snakePosition.add(snakePosition.last - 760 + 20);
          } else {
            snakePosition.add(snakePosition.last + 20);
          }
          break;
        case Direction.up:
          if (snakePosition.last < 20) {
            snakePosition.add(snakePosition.last + 760 - 20);
          } else {
            snakePosition.add(snakePosition.last - 20);
          }
          break;
        case Direction.right:
          if ((snakePosition.last + 1) % 20 == 0) {
            snakePosition.add(snakePosition.last + 1 - 20);
          } else {
            snakePosition.add(snakePosition.last + 1);
          }
          break;
        case Direction.left:
          if (snakePosition.last % 20 == 0) {
            snakePosition.add(snakePosition.last - 1 + 20);
          } else {
            snakePosition.add(snakePosition.last - 1);
          }
          break;
        default:
      }
      if (snakePosition.last == foodLocation) {
        totalSpot.removeWhere((element) => snakePosition.contains(element));
        foodLocation = totalSpot[Random().nextInt(totalSpot.length - 1)];
      } else {
        snakePosition.removeAt(0);
      }
    });
  }

  bool gameOver() {
    final copyList = List.from(snakePosition);
    if (snakePosition.length > copyList.toSet().length) {
      return true;
    } else {
      return false;
    }
  }

  endGame() {
    start = false;

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Game Over'),
            content: Text('Score: ${snakePosition.length - 2}', style: TextStyle(fontSize: 20)),
            actions: <Widget>[
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  gameOverAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Game Over'),
          content: Text('your score is ' + (snakePosition.length - 3).toString()),
          actions: [
            TextButton(
                onPressed: () {
                  startGame();
                  Navigator.of(context).pop(true);
                },
                child: Text('Play Again')),
            TextButton(
                onPressed: () {
                  finish(context);
                  finish(context);
                },
                child: Text('Exit'))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return endGame();
      },
      child: BodyWidget(
        Scaffold(
          backgroundColor: Colors.transparent,
         appBar: appBarWidget('', color: Colors.transparent, elevation: 0, backWidget: backButton(context)),
          body: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: 760,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 20, crossAxisSpacing: 16 / 9),
            itemBuilder: (context, index) {
              if (snakePosition.contains(index)) {
                return Container(
                  height: 400,
                  margin: EdgeInsets.all(1),
                  decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                );
              }
              if (index == foodLocation) {
                return Container(color: Colors.red);
              }
              return SizedBox();
            },
          ),
          // bottomNavigationBar: Container(
          //   color: Colors.transparent,
          //   child: Row(
          //     mainAxisSize: MainAxisSize.min,
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Spacer(),
          //       Container(
          //         decoration: boxDecorationWithRoundedCornersWidget(backgroundColor: primaryColor),
          //         child: Row(
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           mainAxisSize: MainAxisSize.min,
          //           children: [
          //             IconButton(
          //                 icon: Icon(Icons.keyboard_arrow_left),
          //                 onPressed: () {
          //                   if (direction != Direction.right) {
          //                     direction = Direction.left;
          //                   }
          //                 }),
          //             Column(
          //               crossAxisAlignment: CrossAxisAlignment.center,
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               mainAxisSize: MainAxisSize.min,
          //               children: [
          //                 IconButton(
          //                     icon: Icon(Icons.keyboard_arrow_up),
          //                     onPressed: () {
          //                       if (direction != Direction.down) {
          //                         direction = Direction.up;
          //                       }
          //                     }),
          //                 IconButton(
          //                     icon: Icon(Icons.keyboard_arrow_down),
          //                     onPressed: () {
          //                       if (direction != Direction.up) {
          //                         direction = Direction.down;
          //                       }
          //                     }),
          //               ],
          //             ),
          //             IconButton(
          //                 icon: Icon(Icons.keyboard_arrow_right),
          //                 onPressed: () {
          //                   if (direction != Direction.left) {
          //                     direction = Direction.right;
          //                   }
          //                 }),
          //           ],
          //         ),
          //       ),
          //       Spacer(),
          //       FloatingActionButton(
          //         onPressed: () {
          //           if (!start)
          //             startGame();
          //           else
          //             endGame();
          //         },
          //         child: start ? Text((snakePosition.length - 3).toString()) : Text('Start'),
          //       ),
          //     ],
          //   ),
          // ),

        ),
      ),
    );
  }
}
