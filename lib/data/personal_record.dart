import 'package:flutter/material.dart';

class PersonalRecord {
  int id;
  DateTime date = DateTime.now();
  int exerciseId;
  int seconds;

  PersonalRecord(
      {this.id, this.date, @required this.exerciseId, @required this.seconds});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'date': date,
      'exercise_id': exerciseId,
      'seconds_done': seconds,
    };

    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  PersonalRecord.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    date = DateTime.parse(map['date']);
    exerciseId = map['exercise_id'];
    seconds = map['seconds_done'];
  }
}
