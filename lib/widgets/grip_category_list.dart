import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:grip_trainer/data/categories.dart';
import 'package:grip_trainer/widgets/menu_card.dart';

class GripList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GripCategoryData>(
      builder: (context, gripData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final gripCategory = gripData.categories[index];
            return ExerciseCard(
              category: gripCategory,
              currentLevel: 3,
              icon: Icons.thumb_up,
              colour: Colors.grey[800],
              onPress: () {
                gripData.setCurrentCategory(index);
                Navigator.pushNamed(context, 'LevelsScreen');
              },
            );
          },
          itemCount: gripData.amountOfCategories,
        );
      },
    );
  }
}
