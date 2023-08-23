import 'package:flutter/material.dart';

class NowscreenController extends ChangeNotifier{
   Duration _duration = const Duration();
  Duration _position = const Duration();
  int large = 0;
  int currentIndex = 0;
  bool firstSong=false;
  bool lastSong=false;

}