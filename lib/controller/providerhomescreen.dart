import 'package:flutter/widgets.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomeScreenController extends ChangeNotifier{
bool list =true;

List<SongModel> allSongs = [];
 bool hasPermission =false;
  final  audioQuery = OnAudioQuery();
final audioPlayer = AudioPlayer();
// void setupAudioQuery() {
//     LogConfig logConfig = LogConfig(logType: LogType.DEBUG);
//     audioQuery.setLogConfig(logConfig);
//    notifyListeners();
//   }
checkAndRequestPermissions({bool retry = false}) async {
    // The param 'retryRequest' is false, by default.
    hasPermission = await audioQuery.checkAndRequest(
      retryRequest: retry,
    );

    // Only call update the UI if application has all required permissions.
    hasPermission ?  notifyListeners() : null;
    notifyListeners();
  }

  
playsong(String? uri) {
    audioPlayer.setAudioSource(
      AudioSource.uri(
        Uri.parse(uri!),
      ),
    );
    audioPlayer.play();
  }
  void changeList(bool value){
    list=value;
    notifyListeners();
  }
}