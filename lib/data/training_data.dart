import 'package:flutter/material.dart';
import 'dart:collection';

import 'package:grip_trainer/data/category.dart';
import 'package:grip_trainer/data/level.dart';

class TrainingData extends ChangeNotifier {
  List<GripCategory> _gripCategories = [];

  void setGripCategories(List categories) {
    _gripCategories = categories;
  }

  GripCategory _currentCategory;
  Level _currentLevel;
  int _secondsToPass;
  int _secondsDone;
  int _currentRecord;

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

  void setCurrentRecord(int seconds) {
    _currentRecord = seconds;
  }

  int get currentRecord => _currentRecord;

  void finishSet(Level level, int seconds) {
    level.updateSeconds(seconds);
    notifyListeners();
  }
}
