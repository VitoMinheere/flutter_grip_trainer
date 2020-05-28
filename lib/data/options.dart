class Options {
  int preTimer;
  List<int> preTimerOptions = [3, 5, 10];
  List music = [
    Music(title: 'Rock', fileName: 'bensound-highoctane.mp3'),
    Music(title: 'Epic', fileName: 'bensound-epic.mp3'),
    Music(title: 'Funky', fileName: 'bensound-badass.mp3'),
    Music(title: 'None', fileName: '')
  ];

  Options();
}

class Music {
  String title;
  String fileName;

  Music({this.title, this.fileName});
}
