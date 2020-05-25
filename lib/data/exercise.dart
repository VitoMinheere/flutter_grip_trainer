import 'package:flutter/material.dart';

class Exercise {
  int id;
  String name;
  String image;
  String explanation;
  int levelId;

  Exercise({
    this.id,
    @required this.name,
    @required this.image,
    @required this.explanation,
    @required this.levelId,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'name': name,
      'image': image,
      'explanation': explanation,
      'level_id': levelId,
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  Exercise.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    image = map['image'];
    explanation = map['explanation'];
    levelId = map['level_id'];
  }
}
