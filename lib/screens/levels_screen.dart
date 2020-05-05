import 'package:flutter/material.dart';
import 'package:grip_trainer/widgets/level_card.dart';

import 'package:grip_trainer/data/categories.dart';
import 'package:provider/provider.dart';

class LevelsScreen extends StatelessWidget {
  static String id = 'LevelsScreen';

  @override
  Widget build(BuildContext context) {
    GripCategory category = Provider.of<GripCategoryData>(context, listen: true)
        .currentGripCategory;

    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: ListView.builder(
            itemCount: category.levels.length,
            itemBuilder: (context, index) =>
                LevelCard(currentLevel: category.levels[index]),
          ),
        ),
      ),
    );
  }
}
