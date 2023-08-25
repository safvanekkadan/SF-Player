import 'package:flutter/material.dart';

class PlayControlsStateProvider extends ChangeNotifier {
  bool isPlaying = true;
  bool isShuffling = false;

  void togglePlaying() {
    isPlaying = !isPlaying;
    notifyListeners();
  }

  void toggleShuffle() {
    isShuffling = !isShuffling;
    notifyListeners();
  }

  
}