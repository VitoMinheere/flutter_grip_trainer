import 'package:flutter/material.dart';
import 'dart:collection';

import 'package:grip_trainer/data/category.dart';
import 'package:grip_trainer/data/exercise.dart';
import 'package:grip_trainer/data/level.dart';
import 'package:grip_trainer/data/database_provider.dart';
import 'package:grip_trainer/data/personal_record.dart';

import 'database_provider.dart';

class TrainingData extends ChangeNotifier {
  List<GripCategory> _gripCategories = [];

  void setGripCategories(List categories) {
    _gripCategories = categories;
  }

  GripCategory _currentCategory;
  Level _currentLevel;
  PersonalRecord _currentRecord;
  Exercise _currentExercise;

  int _secondsToPass;
  int _secondsDone;

  UnmodifiableListView<GripCategory> get categories =>
      UnmodifiableListView(_gripCategories);

  void setSecondsToPass(int seconds) {
    _secondsToPass = seconds;
  }

  int get secondsToPass => _secondsToPass;

  void setSecondsDone(int seconds) {
    _secondsDone = seconds;
  }

  int get secondsDone => _secondsDone;

  void setCurrentCategory(id) {
    _currentCategory = _gripCategories[id];
  }

  void setCurrentLevel(Level currentLevel) {
    _currentLevel = currentLevel;
  }

  Level get currentLevel => _currentLevel;

  GripCategory get currentGripCategory => _currentCategory;

  int get amountOfCategories => _gripCategories.length;

  void setCurrentRecord(PersonalRecord pr) {
    _currentRecord = pr;
  }

  PersonalRecord get currentRecord => _currentRecord;

  void setCurrentExercise(Exercise currentExercise) {
    _currentExercise = currentExercise;
  }

  Exercise get currentExercise => _currentExercise;

  void finishSet(Level level, int seconds) {
    if (seconds > _currentRecord.seconds) {
      var newRecord =
          PersonalRecord(exerciseId: _currentExercise.id, seconds: seconds);
      DatabaseProvider.db.insertRecord(newRecord);

      this.setCurrentRecord(newRecord);
    }
    level.updateSeconds(seconds);
    if (level.completed) {
      DatabaseProvider.db.setLevelComplete(level.id);
    }
    notifyListeners();
  }
}
