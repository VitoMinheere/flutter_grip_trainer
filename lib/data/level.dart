import 'package:flutter/material.dart';

import 'package:grip_trainer/data/exercise.dart';

class Level {
  int id;
  int categoryId;
  int exerciseId;
  int number;
  int secondsToPass;
  int setsToPass;
  bool completed;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'category_id': categoryId,
      'exercise_id': exerciseId,
      'number': number,
      'seconds_to_pass': secondsToPass,
      'sets_to_pass': setsToPass,
      'completed': completed ? 1 : 0,
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  Level.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    categoryId = map['category_id'];
    exerciseId = map['exercise_id'];
    number = map['number'];
    secondsToPass = map['seconds_to_pass'];
    setsToPass = map['sets_to_pass'];
    completed = map['completed'] == 1;
  }

  Level(
      {this.id,
      @required this.categoryId,
      @required this.exerciseId,
      @required this.number,
      @required this.secondsToPass,
      @required this.setsToPass,
      this.completed});

  void complete() {
    completed = true;
  }

  // void completeSet() {
  //   this.setsDone++;
  //   if (this.setsDone == this.setsToPass) {
  //     complete();
  //   }
  // }

  void updateSeconds(int seconds) {
    // this.secondsDone = seconds;
    if (seconds >= this.secondsToPass) {
      //completeSet();
      complete();
    }
  }
}

var horizontalHangGripLevels = [
  Level(
      categoryId: 1,
      number: 1,
      secondsToPass: 3,
      setsToPass: 4,
      exerciseId: horizontalHang1.id,
      completed: false),
  Level(
      categoryId: 1,
      number: 2,
      secondsToPass: 60,
      setsToPass: 3,
      exerciseId: horizontalHang2.id,
      completed: false),
  Level(
      categoryId: 1,
      number: 3,
      secondsToPass: 60,
      setsToPass: 3,
      exerciseId: horizontalHang3.id,
      completed: false),
  Level(
      categoryId: 1,
      number: 4,
      secondsToPass: 60,
      setsToPass: 3,
      exerciseId: horizontalHang4.id,
      completed: false),
  Level(
      categoryId: 1,
      number: 5,
      secondsToPass: 60,
      setsToPass: 3,
      exerciseId: horizontalHang5.id,
      completed: false),
  Level(
      categoryId: 1,
      number: 6,
      secondsToPass: 60,
      setsToPass: 2,
      exerciseId: horizontalHang6.id,
      completed: false),
  Level(
      categoryId: 1,
      number: 7,
      secondsToPass: 60,
      setsToPass: 2,
      exerciseId: horizontalHang7.id,
      completed: false),
  Level(
      categoryId: 1,
      number: 8,
      secondsToPass: 300,
      setsToPass: 1,
      exerciseId: horizontalHang7.id,
      completed: false),
];

var verticalHangGripLevels = [
  Level(
      categoryId: 2,
      number: 1,
      secondsToPass: 60,
      setsToPass: 4,
      exerciseId: verticalHang1.id,
      completed: false),
  Level(
      categoryId: 2,
      number: 2,
      secondsToPass: 60,
      setsToPass: 3,
      exerciseId: verticalHang2.id,
      completed: false),
  Level(
      categoryId: 2,
      number: 3,
      secondsToPass: 60,
      setsToPass: 3,
      exerciseId: verticalHang3.id,
      completed: false),
  Level(
      categoryId: 2,
      number: 4,
      secondsToPass: 60,
      setsToPass: 3,
      exerciseId: verticalHang4.id,
      completed: false),
  Level(
      categoryId: 2,
      number: 5,
      secondsToPass: 60,
      setsToPass: 3,
      exerciseId: verticalHang5.id,
      completed: false),
  Level(
      categoryId: 2,
      number: 6,
      secondsToPass: 60,
      setsToPass: 2,
      exerciseId: verticalHang6.id,
      completed: false),
  Level(
      categoryId: 2,
      number: 7,
      secondsToPass: 60,
      setsToPass: 2,
      exerciseId: verticalHang7.id,
      completed: false),
  Level(
      categoryId: 2,
      number: 8,
      secondsToPass: 300,
      setsToPass: 1,
      exerciseId: verticalHang7.id,
      completed: false),
];
