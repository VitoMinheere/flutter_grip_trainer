import 'package:flutter/material.dart';
import 'package:grip_trainer/data/level.dart';
import 'package:grip_trainer/data/personal_record.dart';
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
  List<Map> levels = List<Map>();
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

    List<int> levelIds = _levels.map((m) => m.id).toList().toSet().toList();
    final _exercises = await DatabaseProvider.db.getExercisesForLevel(levelIds);

    List<int> exerciseIds =
        _exercises.map((m) => m.id).toList().toSet().toList();
    final _personalRecords =
        await DatabaseProvider.db.getPersonalRecordsForExercise(exerciseIds);

    for (var i = 0; i < _levels.length; i++) {
      var item = Map();
      item['level'] = _levels[i];
      item['exercise'] = _exercises[i];

      var pr = _personalRecords
          .where((record) => record.exerciseId == _exercises[i].id);
      if (pr.length == 1) {
        item['record'] = pr.first;
      } else {
        item['record'] =
            PersonalRecord(exerciseId: _exercises[i].id, seconds: 0);
      }
      levels.insert(i, item);
    }

    setState(() {
      if (_levels == null) {
        _showError = true;
        _loadingData = false;
      } else {
        // levels = _levels;
        // exercisesForLevels = _exercises;
        // personalRecords = _personalRecords;
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
            itemCount: levels.length,
            itemBuilder: (context, index) {
              return LevelCard(
                currentLevel: levels[index]['level'],
                exerciseForLevel: levels[index]['exercise'],
                recordForLevel: levels[index]['record'],
              );
            }, //category.levels[index]),
          ),
        ),
      ),
    );
  }
}
