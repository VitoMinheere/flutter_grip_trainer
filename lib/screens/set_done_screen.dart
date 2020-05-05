import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:grip_trainer/data/categories.dart';
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
    value = Provider.of<GripCategoryData>(context, listen: false).secondsDone;
    print("set_done_Screen = " + value.toString());
    currentLevel =
        Provider.of<GripCategoryData>(context, listen: false).currentLevel;
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
                ArrowIconButton(
                  iconData: Icons.keyboard_arrow_up,
                  onTap: () {
                    setState(() {
                      value = value + 10;
                    });
                  },
                ),
                ArrowIconButton(
                  iconData: Icons.keyboard_arrow_up,
                  onTap: () {
                    setState(() {
                      value = value + 1;
                      print("value = " + value.toString());
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
                ArrowIconButton(
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
                ArrowIconButton(
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
                        value = Provider.of<GripCategoryData>(context,
                                listen: false)
                            .secondsDone;
                      });
                    }),
                FloatingActionButton.extended(
                  heroTag: null,
                  label: Text("Done"),
                  onPressed: () {
                    Provider.of<GripCategoryData>(context, listen: false)
                        .finishSet(currentLevel, value);
                    Navigator.popUntil(
                        context, ModalRoute.withName('LevelsScreen'));
                    // Navigator.popAndPushNamed(context, 'LevelsScreen');
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

Widget ArrowIconButton({IconData iconData, Function onTap}) {
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
