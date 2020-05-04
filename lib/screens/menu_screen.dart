import 'package:flutter/material.dart';

import 'package:grip_trainer/widgets/grip_category_list.dart';

import 'package:grip_trainer/constants/strings.dart' as StringConst;

class MenuScreen extends StatelessWidget {
  static String id = 'MenuScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringConst.TITLE),
      ),
      body: Container(
        child: GripList(),
      ),
    );
  }
}
