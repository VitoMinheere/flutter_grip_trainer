import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:collection';

import 'package:grip_trainer/data/exercises.dart';

class GripCategoryData extends ChangeNotifier {
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

  int amountOfLevels() {
    return _currentCategory.levels.length;
  }

  void finishSet(Level level, int seconds) {
    level.updateSeconds(seconds);
    notifyListeners();
  }
}

class GripCategory {
  String name;
  String image;
  List<Level> levels;

  GripCategory({this.name, this.image, this.levels});

  Map toJson() {
    Map levels = this.levels != null ? this.levels.toJson() : null;
  }

  int levelsCompleted() {
    int completed = 0;
    this.levels.forEach((level) {
      if (level.completed) {
        completed++;
      }
    });
    return completed;
  }
}

class Level {
  int number;
  int secondsToPass;
  int secondsDone = 0;
  //int repsToPass;
  //int repsDone = 0;
  int setsToPass;
  int setsDone = 0;
  Exercise exercise;
  bool completed;

  Map toJson() {
    return {
      'number': this.number,
      'secondsToPass': this.secondsToPass,
      'secondsDone': this.secondsDone,
      'setsToPass': this.setsToPass,
      'setsDone': this.setsDone,
    };
  }

  Level(
      {@required this.number,
      @required this.secondsToPass,
      //this.repsToPass,
      @required this.setsToPass,
      @required this.exercise,
      this.completed});

  void complete() {
    completed = true;
  }

  void completeSet() {
    this.setsDone++;
    if (this.setsDone == this.setsToPass) {
      complete();
    }
  }

  void updateSeconds(int seconds) {
    this.secondsDone = seconds;
    if (seconds >= this.secondsToPass) {
      //completeSet();
      complete();
    }
  }
}

var horizontalHangGrip =
    GripCategory(name: "Horizontal Hang Grip", image: "", levels: [
  Level(
      number: 1,
      secondsToPass: 3,
      setsToPass: 4,
      exercise: horizontalHang1,
      completed: false),
  Level(
      number: 2,
      secondsToPass: 60,
      setsToPass: 3,
      exercise: horizontalHang2,
      completed: false),
  Level(
      number: 3,
      secondsToPass: 60,
      setsToPass: 3,
      exercise: horizontalHang3,
      completed: false),
  Level(
      number: 4,
      secondsToPass: 60,
      setsToPass: 3,
      exercise: horizontalHang4,
      completed: false),
  Level(
      number: 5,
      secondsToPass: 60,
      setsToPass: 3,
      exercise: horizontalHang5,
      completed: false),
  Level(
      number: 6,
      secondsToPass: 60,
      setsToPass: 2,
      exercise: horizontalHang6,
      completed: false),
  Level(
      number: 7,
      secondsToPass: 60,
      setsToPass: 2,
      exercise: horizontalHang7,
      completed: false),
  Level(
      number: 8,
      secondsToPass: 300,
      setsToPass: 1,
      exercise: horizontalHang7,
      completed: false),
]);

var verticalHangGrip =
    GripCategory(name: "Vertical Hang Grip", image: "", levels: [
  Level(
      number: 1,
      secondsToPass: 60,
      setsToPass: 4,
      exercise: verticalHang1,
      completed: false),
  Level(
      number: 2,
      secondsToPass: 60,
      setsToPass: 3,
      exercise: verticalHang2,
      completed: false),
  Level(
      number: 3,
      secondsToPass: 60,
      setsToPass: 3,
      exercise: verticalHang3,
      completed: false),
  Level(
      number: 4,
      secondsToPass: 60,
      setsToPass: 3,
      exercise: verticalHang4,
      completed: false),
  Level(
      number: 5,
      secondsToPass: 60,
      setsToPass: 3,
      exercise: verticalHang5,
      completed: false),
  Level(
      number: 6,
      secondsToPass: 60,
      setsToPass: 2,
      exercise: verticalHang6,
      completed: false),
  Level(
      number: 7,
      secondsToPass: 60,
      setsToPass: 2,
      exercise: verticalHang7,
      completed: false),
  Level(
      number: 8,
      secondsToPass: 300,
      setsToPass: 1,
      exercise: verticalHang7,
      completed: false),
]);
