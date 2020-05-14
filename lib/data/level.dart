import 'package:flutter/material.dart';

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
