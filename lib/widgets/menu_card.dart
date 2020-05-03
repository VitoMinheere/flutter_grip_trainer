import 'package:flutter/material.dart';
import 'dart:math';

import 'package:grip_trainer/data/categories.dart';
import 'package:grip_trainer/constants/theme.dart';

import 'package:grip_trainer/screens/levels_screen.dart';

class ExerciseCard extends StatelessWidget {
  ExerciseCard(
      {@required this.colour,
      @required this.category,
      this.onPress,
      this.currentLevel,
      this.icon});

  final Color colour;
  final GripCategory category;
  final IconData icon;
  final Function onPress;
  final int currentLevel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return LevelsScreen(category);
            },
          ),
        );
      },
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Transform.rotate(
                  angle: 270 * pi / 180,
                  child: Icon(
                    icon,
                    size: 40,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      currentLevel.toString() +
                          "/" +
                          category.levels.length.toString(),
                      style: cardtext,
                    ),
                    Icon(Icons.trending_up, color: Colors.white)
                  ],
                ),
                Text(
                  category.name,
                  style: cardtext,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "0/" +
                          category.levels[currentLevel - 1].secondsToPass
                              .toString(),
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
        ),
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: colour,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
