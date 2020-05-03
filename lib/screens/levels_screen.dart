import 'package:flutter/material.dart';
import 'package:grip_trainer/widgets/level_card.dart';

import 'package:grip_trainer/data/categories.dart';

class LevelsScreen extends StatelessWidget {
  final GripCategory category;

  LevelsScreen(this.category);

  @override
  Widget build(BuildContext context) {
    List levels = category.levels;

    return Scaffold(
      appBar: AppBar(title: Text(category.name)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: ListView.builder(
            itemCount: levels.length,
            itemBuilder: (context, index) =>
                LevelCard(currentLevel: levels[index]),
          ),
        ),
      ),
    );
  }
}
