import 'package:flutter/material.dart';

class Options {
  int preTimer;
  List<int> preTimerOptions = [1, 3, 5, 10];
  Map music = <String, String>{'Rock': 'bensound-highoctane.mp3'};

  Options({this.preTimer, this.music});
}
