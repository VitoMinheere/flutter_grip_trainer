import 'package:flutter/material.dart';
import 'package:grip_trainer/data/personal_record.dart';

import 'package:provider/provider.dart';

import 'package:grip_trainer/constants/theme.dart';
import 'package:grip_trainer/data/level.dart';
import 'package:grip_trainer/data/exercise.dart';
import 'package:grip_trainer/data/training_data.dart';

class LevelCard extends StatefulWidget {
  final Level currentLevel;
  final Exercise exerciseForLevel;
  final PersonalRecord recordForLevel;

  LevelCard(
      {@required this.currentLevel,
      @required this.exerciseForLevel,
      this.recordForLevel});

  @override
  _LevelCardState createState() => _LevelCardState();
}

class _LevelCardState extends State<LevelCard> {
  bool showExplanation = false;

  @override
  Widget build(BuildContext context) {
    Level currentLevel = this.widget.currentLevel;
    Exercise exerciseForLevel = this.widget.exerciseForLevel;
    PersonalRecord recordForLevel = this.widget.recordForLevel;

    void goToExercise() {
      Provider.of<TrainingData>(context, listen: false)
          .setCurrentLevel(currentLevel);
      Provider.of<TrainingData>(context, listen: false)
          .setSecondsToPass(currentLevel.secondsToPass);
      Provider.of<TrainingData>(context, listen: false)
          .setCurrentExercise(exerciseForLevel);
      Provider.of<TrainingData>(context, listen: false)
          .setCurrentRecord(recordForLevel);

      Navigator.pushNamed(context, 'TimerScreen');
    }

    return InkWell(
      onTap: () {
        setState(() {
          showExplanation = !showExplanation;
        });
      },
      child: Card(
          color: Colors.grey[500],
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Checkbox(value: currentLevel.completed, onChanged: null),
                  Flexible(
                    child: Text(
                      exerciseForLevel.name,
                      style: cardText,
                    ),
                  ),
                  RawMaterialButton(
                    onPressed: () => goToExercise(),
                    elevation: 2.0,
                    fillColor: Colors.blue,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 15.0,
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(15.0),
                    shape: CircleBorder(),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Visibility(
                      visible: showExplanation,
                      child: Text(
                        exerciseForLevel.explanation,
                        style: explanationText,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      '${recordForLevel.seconds}/${currentLevel.secondsToPass}',
                      style: cardText,
                    ),
                    Icon(
                      Icons.hourglass_empty,
                      color: Colors.white,
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
