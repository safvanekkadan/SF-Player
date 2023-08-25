import 'package:flutter/foundation.dart';

class MiniPlayerStateProvider extends ChangeNotifier {
  bool firstSong = false;
  bool isPlaying = false;

  void setFirstSong(bool value) {
    firstSong = value;
    notifyListeners();
  }

  void toggleIsPlaying() {
    isPlaying = !isPlaying;
    notifyListeners();
  }
}