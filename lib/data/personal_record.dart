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
      'image': exerciseId,
      'seconds': seconds,
    };

    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
}
