import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:grip_trainer/data/training_data.dart';
import 'package:grip_trainer/widgets/menu_card.dart';

import 'package:grip_trainer/data/database_provider.dart';

class GripList extends StatefulWidget {
  @override
  _GripListState createState() => _GripListState();
}

class _GripListState extends State<GripList> {
  bool _loadingData;

  @override
  void initState() {
    super.initState();
    loadGripCategories();
  }

  void loadGripCategories() async {
    setState(() {
      _loadingData = true;
      // _showError = false;
    });
    List gripCategories = await DatabaseProvider.db.getCategories();
    setState(() {
      if (gripCategories == null) {
        // _showError = true;
        _loadingData = false;
      } else {
        Provider.of<TrainingData>(context, listen: false)
            .setGripCategories(gripCategories);
        // _showError = false;
        _loadingData = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TrainingData>(
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
