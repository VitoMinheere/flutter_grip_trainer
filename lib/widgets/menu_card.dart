import 'package:flutter/material.dart';
import 'dart:math';

import 'package:grip_trainer/data/category.dart';
import 'package:grip_trainer/constants/theme.dart';

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
      onTap: onPress,
      child: Container(
        height: 150,
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
                Text(
                  category.name,
                  style: cardText,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      '${category.levelsCompleted}/${category.amountOfLevels}',
                      style: cardText,
                    ),
                    Icon(Icons.trending_up, color: Colors.white)
                  ],
                ),
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
