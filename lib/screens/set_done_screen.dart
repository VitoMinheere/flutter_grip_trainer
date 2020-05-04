import 'package:flutter/material.dart';

import 'package:grip_trainer/constants/strings.dart' as StringConst;

class SetDoneScreen extends StatefulWidget {
  //final int repsCompleted;
  final int secondsCompleted;

  SetDoneScreen({this.secondsCompleted});

  @override
  _SetDoneScreenState createState() =>
      _SetDoneScreenState(this.secondsCompleted);
}

class _SetDoneScreenState extends State<SetDoneScreen> {
  int value;

  _SetDoneScreenState(this.value);

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
          //crossAxisAlignment: CrossAxisAlignment.center,
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
                        value = widget.secondsCompleted;
                      });
                    }),
                FloatingActionButton.extended(
                    heroTag: null, label: Text("Done"), onPressed: null),
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
