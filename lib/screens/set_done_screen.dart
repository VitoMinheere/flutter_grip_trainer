import 'package:flutter/material.dart';
import 'package:grip_trainer/screens/levels_screen.dart';
import 'package:grip_trainer/screens/menu_screen.dart';

import 'package:provider/provider.dart';

import 'package:grip_trainer/data/training_data.dart';
import 'package:grip_trainer/data/level.dart';

import 'package:grip_trainer/constants/strings.dart' as StringConst;

class SetDoneScreen extends StatefulWidget {
  static String id = 'SetDoneScreen';

  @override
  _SetDoneScreenState createState() => _SetDoneScreenState();
}

class _SetDoneScreenState extends State<SetDoneScreen> {
  int value;
  Level currentLevel;

  @override
  void initState() {
    super.initState();
    value = Provider.of<TrainingData>(context, listen: false).secondsDone;
    currentLevel =
        Provider.of<TrainingData>(context, listen: false).currentLevel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringConst.SECONDS_COMPLETED),
      ),
      backgroundColor: Colors.white10,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                arrowIconButton(
                  iconData: Icons.keyboard_arrow_up,
                  onTap: () {
                    setState(() {
                      value = value + 10;
                    });
                  },
                ),
                arrowIconButton(
                  iconData: Icons.keyboard_arrow_up,
                  onTap: () {
                    setState(() {
                      value = value + 1;
                    });
                  },
                ),
              ],
            ),
            Text(
              value.toString(),
              style: TextStyle(fontSize: 112.0, color: Colors.white),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                arrowIconButton(
                  iconData: Icons.keyboard_arrow_down,
                  onTap: () {
                    setState(
                      () {
                        if (value > 0 && value >= 10) {
                          value -= 10;
                        }
                      },
                    );
                  },
                ),
                arrowIconButton(
                  iconData: Icons.keyboard_arrow_down,
                  onTap: () {
                    setState(() {
                      if (value > 0) {
                        value--;
                      }
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FloatingActionButton.extended(
                    heroTag: null,
                    label: Text("Restore"),
                    icon: null,
                    onPressed: () {
                      setState(() {
                        value =
                            Provider.of<TrainingData>(context, listen: false)
                                .secondsDone;
                      });
                    }),
                FloatingActionButton.extended(
                  heroTag: null,
                  label: Text("Done"),
                  onPressed: () {
                    Provider.of<TrainingData>(context, listen: false)
                        .finishSet(currentLevel, value);
                    Navigator.pushNamedAndRemoveUntil(context, LevelsScreen.id,
                        ModalRoute.withName(MenuScreen.id));
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget arrowIconButton({IconData iconData, Function onTap}) {
  return IconButton(
    alignment: Alignment.center,
    iconSize: 80,
    icon: Ink(
      decoration: const ShapeDecoration(
        color: Colors.lightBlue,
        shape: CircleBorder(),
      ),
      child: Icon(
        iconData,
        color: Colors.white,
      ),
    ),
    onPressed: onTap,
  );
}
