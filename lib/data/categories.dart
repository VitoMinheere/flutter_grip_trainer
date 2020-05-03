import 'package:flutter/material.dart';

import 'package:grip_trainer/data/exercises.dart';

class GripCategory {
  String name;
  String image;
  List<Level> levels;

  GripCategory({this.name, this.image, this.levels});
}

class Level {
  int number;
  int secondsToPass;
  int repsToPass;
  int setsToPass;
  Exercise exercise;

  Level({
    @required this.number,
    @required this.secondsToPass,
    this.repsToPass,
    @required this.setsToPass,
    @required this.exercise,
  });
}

var horizontalHangGrip =
    GripCategory(name: "Horizontal Hang Grip", image: "", levels: [
  Level(number: 1, secondsToPass: 3, setsToPass: 4, exercise: horizontalHang1),
  Level(number: 2, secondsToPass: 60, setsToPass: 3, exercise: horizontalHang2),
  Level(number: 3, secondsToPass: 60, setsToPass: 3, exercise: horizontalHang3),
  Level(number: 4, secondsToPass: 60, setsToPass: 3, exercise: horizontalHang4),
  Level(number: 5, secondsToPass: 60, setsToPass: 3, exercise: horizontalHang5),
  Level(number: 6, secondsToPass: 60, setsToPass: 2, exercise: horizontalHang6),
  Level(number: 7, secondsToPass: 60, setsToPass: 2, exercise: horizontalHang7),
  Level(
      number: 8, secondsToPass: 300, setsToPass: 1, exercise: horizontalHang7),
]);

var verticalHangGrip =
    GripCategory(name: "Vertical Hang Grip", image: "", levels: [
  Level(number: 1, secondsToPass: 60, setsToPass: 4, exercise: verticalHang1),
  Level(number: 2, secondsToPass: 60, setsToPass: 3, exercise: verticalHang2),
  Level(number: 3, secondsToPass: 60, setsToPass: 3, exercise: verticalHang3),
  Level(number: 4, secondsToPass: 60, setsToPass: 3, exercise: verticalHang4),
  Level(number: 5, secondsToPass: 60, setsToPass: 3, exercise: verticalHang5),
  Level(number: 6, secondsToPass: 60, setsToPass: 2, exercise: verticalHang6),
  Level(number: 7, secondsToPass: 60, setsToPass: 2, exercise: verticalHang7),
  Level(number: 8, secondsToPass: 300, setsToPass: 1, exercise: verticalHang7),
]);
