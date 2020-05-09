import 'package:flutter/material.dart';
import 'dart:collection';

import 'package:grip_trainer/data/category.dart';
import 'package:grip_trainer/data/level.dart';

class TrainingData extends ChangeNotifier {
  List<GripCategory> _gripCategories = [
    horizontalHangGrip,
    verticalHangGrip,
  ];

  GripCategory _currentCategory;
  Level _currentLevel;
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

  // int amountOfLevels() {
  //   return _currentCategory.levels.length;
  // }

  // int levelsCompleted() {
  //   int completed = 0;
  //   this.levels.forEach((level) {
  //     if (level.completed) {
  //       completed++;
  //     }
  //   });
  //   return completed;
  // }

  void finishSet(Level level, int seconds) {
    level.updateSeconds(seconds);
    notifyListeners();
  }
}
