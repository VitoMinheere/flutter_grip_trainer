import 'package:flutter/material.dart';
import 'package:grip_trainer/data/level.dart';
import 'package:grip_trainer/widgets/level_card.dart';

import 'package:grip_trainer/data/training_data.dart';
import 'package:grip_trainer/data/category.dart';
import 'package:grip_trainer/data/exercise.dart';
import 'package:grip_trainer/data/database_provider.dart';
import 'package:provider/provider.dart';

class LevelsScreen extends StatefulWidget {
  static String id = 'LevelsScreen';

  @override
  _LevelsScreenState createState() => _LevelsScreenState();
}

class _LevelsScreenState extends State<LevelsScreen> {
  GripCategory category;
  List<Level> levels;
  List<Exercise> exercisesForLevels;
  bool _loadingData = true;
  bool _showError = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_loadingData) {
      loadData();
    }
  }

  void loadData() async {
    setState(() {
      _loadingData = true;
      _showError = false;
    });
    category =
        Provider.of<TrainingData>(context, listen: true).currentGripCategory;
    final _levels = await DatabaseProvider.db.getLevelsForCategory(category.id);

    //TODO drops the last exercise which has the same exercise id as the one before it
    List<int> exerciseIds =
        _levels.map((m) => m.exerciseId).toList().toSet().toList();
    print(exerciseIds);
    final exercises = await DatabaseProvider.db.getExercises(exerciseIds);
    for (var x in exercises) {
      print(x.name);
    }
    setState(() {
      if (_levels == null) {
        _showError = true;
        _loadingData = false;
      } else {
        levels = _levels;
        exercisesForLevels = exercises;
        print(exercisesForLevels.length);
        _showError = false;
        _loadingData = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loadingData) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (_showError) {
      return Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Something went wrong',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          RaisedButton(
            child: Text(
              'Retry',
              style: Theme.of(context)
                  .textTheme
                  .button
                  .copyWith(color: Colors.white),
            ),
            elevation: 0.0,
            onPressed: loadData,
          )
        ],
      ));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: exercisesForLevels.length,
            itemBuilder: (context, index) => LevelCard(
              currentLevel: levels[index],
              exerciseForLevel: exercisesForLevels[index],
            ), //category.levels[index]),
          ),
        ),
      ),
    );
  }
}
