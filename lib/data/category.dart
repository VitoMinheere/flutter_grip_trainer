import 'package:flutter/material.dart';

class GripCategory {
  int id;
  String name;
  String image;

  GripCategory({this.id, this.name, this.image});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'name': name,
      'image': image,
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  int get amountOfLevels => 8;
  int get levelsCompleted => 3;
}

var horizontalHangGrip =
    GripCategory(id: 1, name: "Horizontal Hang Grip", image: "");
var verticalHangGrip =
    GripCategory(id: 2, name: "Vertical Hang Grip", image: "");
