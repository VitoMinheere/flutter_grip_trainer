import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:grip_trainer/constants/theme.dart';
import 'package:grip_trainer/data/level.dart';
import 'package:grip_trainer/data/exercise.dart';
import 'package:grip_trainer/data/training_data.dart';

class LevelCard extends StatelessWidget {
  final Level currentLevel;
  final Exercise exerciseForLevel;

  LevelCard({@required this.currentLevel, @required this.exerciseForLevel});

  @override
  Widget build(BuildContext context) {
    Level currentLevel = this.currentLevel;
    Exercise exerciseForLevel = this.exerciseForLevel;

    return InkWell(
      onTap: () {
        Provider.of<TrainingData>(context, listen: false)
            .setCurrentLevel(currentLevel);
        Provider.of<TrainingData>(context, listen: false)
            .setSecondsToPass(currentLevel.secondsToPass);

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
                      //Icon(Icons.check_box_outline_blank),
                      Checkbox(value: currentLevel.completed, onChanged: null),
                    ],
                  ),
                  Text(
                    exerciseForLevel.name,
                    style: cardtext,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    '${currentLevel.setsToPass}x 10/${currentLevel.secondsToPass}',
                    style: cardtext,
                  ),
                  Icon(
                    Icons.hourglass_empty,
                    color: Colors.white,
                  )
                ],
              )
            ],
          )),
    );
  }
}
