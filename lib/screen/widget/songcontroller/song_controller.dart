import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongController{
  static AudioPlayer audioPlayer =AudioPlayer();
  static List<SongModel> songscopy =[];
  static List<SongModel> playingsong = [];
  static ConcatenatingAudioSource createSongList(List<SongModel> elements) {
    List<AudioSource> songList = [];
    playingsong=elements;
    for (var element in elements) {
      songList.add(
        AudioSource.uri(
          Uri.parse(element.uri!),
          tag: MediaItem(
            id: element.id.toString(),
            album: element.album ?? "No Album",
            title: element.title,
            artist: element.artist,
            artUri: Uri.parse(
              element.id.toString(),
            ),
          ),
        ),
      );
    }
    return ConcatenatingAudioSource(children: songList);
  }
}