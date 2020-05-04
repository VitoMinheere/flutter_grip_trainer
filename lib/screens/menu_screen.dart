import 'package:flutter/material.dart';

import 'package:grip_trainer/widgets/menu_card.dart';

import 'package:grip_trainer/data/categories.dart';

import 'package:grip_trainer/constants/strings.dart' as StringConst;

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringConst.TITLE),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: ExerciseCard(
              category: horizontalHangGrip,
              currentLevel: 3,
              icon: Icons.thumb_up,
              colour: Colors.grey[800],
            ),
          ),
          Expanded(
            flex: 5,
            child: ExerciseCard(
              category: verticalHangGrip,
              currentLevel: 2,
              icon: Icons.thumb_up,
              colour: Colors.grey[800],
            ),
          ),
          Expanded(
            flex: 5,
            child: ExerciseCard(
              category: horizontalHangGrip,
              currentLevel: 2,
              icon: Icons.thumb_up,
              colour: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }
}
