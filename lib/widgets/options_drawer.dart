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
  bool _loadingData = true;

  @override
  void initState() {
    super.initState();
    getPrefs();
  }

  @override
  Widget build(BuildContext context) {
    if (_loadingData)
      return Drawer(
        child: CircularProgressIndicator(),
      );
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 80),
        child: Column(
          children: <Widget>[
            Text('PreTimer seconds'),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                for (var item in options.preTimerOptions) preTimerButton(item)
              ],
            ),
            Text('Music'),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [for (var track in options.music) trackButton(track)],
            )
          ],
        ),
      ),
    );
  }

  Widget preTimerButton(int seconds) {
    int selected = prefs.containsKey('preTimer') ? prefs.getInt('preTimer') : 3;

    return Flexible(
      fit: FlexFit.loose,
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
    setState(() {
      _loadingData = true;
    });
    var result = await _prefs;
    setState(() {
      if (result != null) {
        _loadingData = false;
        prefs = result;
      }
    });
  }

  Widget trackButton(track) {
    String selected =
        prefs.containsKey('track') ? prefs.getString('track') : 'None';

    return Flexible(
      fit: FlexFit.loose,
      // flex: 5,
      child: FlatButton(
        color: selected == track.title ? Colors.lightBlue : Colors.grey,
        onPressed: () {
          setState(() {
            prefs.setString('track', track.title);
            prefs.setString('trackFileName', track.fileName);
          });
        },
        child: Text(track.title),
      ),
    );
  }
}
