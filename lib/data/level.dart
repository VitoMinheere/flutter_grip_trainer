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
      'number': number,
      'seconds_to_pass': secondsToPass,
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
    number = map['number'];
    secondsToPass = map['seconds_to_pass'];
    completed = map['completed'] == 1;
  }

  Level({
    this.id,
    @required this.categoryId,
    @required this.number,
    @required this.secondsToPass,
    this.completed,
  });

  void updateSeconds(int seconds) {
    if (seconds >= this.secondsToPass) {
      this.completed = true;
    }
  }
}
