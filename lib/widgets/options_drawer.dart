import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:grip_trainer/data/options.dart';

class OptionsDrawer extends StatefulWidget {
  @override
  _OptionsDrawerState createState() => _OptionsDrawerState();
}

class _OptionsDrawerState extends State<OptionsDrawer> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences prefs;
  Options options = Options();

  @override
  void initState() {
    super.initState();
    getPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100),
        child: Column(
          children: <Widget>[
            Text('PreTimer seconds'),
            Row(
              children: <Widget>[
                for (var item in options.preTimerOptions) preTimerButton(item)
              ],
            ),
            Text('Music'),
            // TODO Return music selections as radio buttons
          ],
        ),
      ),
    );
  }

  Widget preTimerButton(int seconds) {
    var selected = prefs.getInt('preTimer');

    return Expanded(
      flex: 5,
      child: FlatButton(
          color: selected == seconds ? Colors.lightBlue : Colors.grey,
          onPressed: () {
            setState(() {
              prefs.setInt('preTimer', seconds);
            });
          },
          child: Text(seconds.toString())),
    );
  }

  void getPrefs() async {
    var result = await _prefs;
    setState(() {
      prefs = result;
    });
  }
}
