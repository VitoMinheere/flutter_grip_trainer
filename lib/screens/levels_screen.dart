import 'package:flutter/material.dart';
import 'package:grip_trainer/data/level.dart';
import 'package:grip_trainer/widgets/level_card.dart';

import 'package:grip_trainer/data/training_data.dart';
import 'package:grip_trainer/data/category.dart';
import 'package:grip_trainer/data/database_provider.dart';
import 'package:provider/provider.dart';

class LevelsScreen extends StatelessWidget {
  static String id = 'LevelsScreen';

  @override
  Widget build(BuildContext context) {
    GripCategory category =
        Provider.of<TrainingData>(context, listen: true).currentGripCategory;
    List<Level> levels;
    DatabaseProvider.db.getLevelsForCategory(category.id).then((levelList) =>
        levels = levelList); //print(levelList[0].secondsToPass.toString()));

    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: ListView.builder(
            itemCount: category.amountOfLevels,
            itemBuilder: (context, index) => LevelCard(
                currentLevel:
                    horizontalHangGripLevels[0]), //category.levels[index]),
          ),
        ),
      ),
    );
  }
}
