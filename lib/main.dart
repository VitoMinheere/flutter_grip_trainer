import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:grip_trainer/screens/menu_screen.dart';
import 'package:grip_trainer/screens/levels_screen.dart';
import 'package:grip_trainer/screens/timer_screen.dart';
import 'package:grip_trainer/screens/set_done_screen.dart';

import 'package:grip_trainer/data/training_data.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TrainingData(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Grip Training',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: MenuScreen.id,
        routes: {
          MenuScreen.id: (context) => MenuScreen(),
          LevelsScreen.id: (context) => LevelsScreen(),
          SetDoneScreen.id: (context) => SetDoneScreen(),
          TimerScreen.id: (context) => TimerScreen(),
        });
  }
}
