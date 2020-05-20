import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:provider/provider.dart';

import 'package:grip_trainer/data/training_data.dart';
import 'package:grip_trainer/constants/strings.dart' as StringConst;

class TimerScreen extends StatefulWidget {
  static String id = 'TimerScreen';

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen>
    with TickerProviderStateMixin {
  int _countdownTimer;
  AnimationController controller;
  int secondsPassed;

  String get timerString {
    Duration duration = controller.duration * controller.value;
    secondsPassed = duration.inSeconds;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  void goToResultScreen() {
    print("seconds passed " + secondsPassed.toString());
    controller.dispose();
    Provider.of<TrainingData>(context, listen: false)
        .setSecondsDone(secondsPassed);
    Navigator.pushNamed(context, 'SetDoneScreen');
  }

  @override
  void initState() {
    super.initState();
    _countdownTimer =
        Provider.of<TrainingData>(context, listen: false).secondsToPass;
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: _countdownTimer),
    );
    controller.addListener(() {
      if (controller.isCompleted) {
        print(timerString);
        goToResultScreen();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(StringConst.COUNTDOWN_TIMER)),
      backgroundColor: Colors.white10,
      body: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: Colors.green,
                    height: controller.value *
                        (MediaQuery.of(context).size.height -
                            Scaffold.of(context).appBarMaxHeight),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Align(
                          alignment: FractionalOffset.center,
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: CustomPaint(
                                      painter: CustomTimerPainter(
                                    animation: controller,
                                    backgroundColor: Colors.white,
                                    color: themeData.indicatorColor,
                                  )),
                                ),
                                Align(
                                  alignment: FractionalOffset.center,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        StringConst.COUNTDOWN_TIMER,
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        timerString,
                                        style: TextStyle(
                                            fontSize: 112.0,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            AnimatedBuilder(
                                animation: controller,
                                builder: (context, child) {
                                  return FloatingActionButton.extended(
                                    onPressed: () {
                                      if (controller.isAnimating) {
                                        controller.stop();
                                      } else {
                                        controller.forward(
                                            from: controller.value == 1.0
                                                ? 0.0
                                                : controller.value);
                                      }
                                    },
                                    icon: Icon(controller.isAnimating
                                        ? Icons.pause
                                        : Icons.play_arrow),
                                    label: Text(controller.isAnimating
                                        ? StringConst.PAUSE
                                        : StringConst.PLAY),
                                  );
                                }),
                            FloatingActionButton.extended(
                              heroTag: null,
                              onPressed: () {
                                goToResultScreen();
                              },
                              icon: Icon(Icons.stop),
                              label: Text(StringConst.STOP),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}

class CustomTimerPainter extends CustomPainter {
  CustomTimerPainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(CustomTimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}
