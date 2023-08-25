import 'package:flutter/foundation.dart';

class NowPlayingProvider extends ChangeNotifier {
  int currentIndex = 0;
  Duration duration = const Duration();
  Duration position = const Duration();
  bool firstSong = false;
  bool lastSong = false;

  void updateIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void updatePosition(Duration newPosition) {
    position = newPosition;
    notifyListeners();
  }

  void updateDuration(Duration newDuration) {
    duration = newDuration;
    notifyListeners();
  }

  void updateSongStatus({bool isFirst = false, bool isLast = false}) {
    firstSong = isFirst;
    lastSong = isLast;
    notifyListeners();
  }
}
