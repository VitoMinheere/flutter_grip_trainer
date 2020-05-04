import 'package:flutter/material.dart';

import 'package:grip_trainer/data/categories.dart';
import 'package:provider/provider.dart';

import 'package:grip_trainer/constants/theme.dart';
import 'package:grip_trainer/data/categories.dart';

class LevelCard extends StatelessWidget {
  final Level currentLevel;

  LevelCard({@required this.currentLevel});

  //TODO Load the currentlevel from the provider
  @override
  Widget build(BuildContext context) {
    currentLevel =
        Provider.of<GripCategoryData>(context, listen: false).currentLevel;

    return InkWell(
      onTap: () {
        Provider.of<GripCategoryData>(context, listen: false)
            .setSecondsToPass(seconds);

        Navigator.pushNamed(context, 'TimerScreen');
      },
      child: Card(
          color: Colors.grey[600],
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      // Text(currentLevel.number.toString()),
                      Icon(Icons.check_box_outline_blank),
                    ],
                  ),
                  Text(
                    currentLevel.exercise.name,
                    style: cardtext,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        currentLevel.setsToPass.toString() +
                            "x 30/" +
                            currentLevel.secondsToPass.toString(),
                        style: cardtext,
                      ),
                      Icon(
                        Icons.hourglass_empty,
                        color: Colors.white,
                      )
                    ],
                  )
                ],
              )
            ],
          )),
    );
  }
}
