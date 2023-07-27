import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:music/models/model_music.dart';

class PlaylistDB {
  static ValueNotifier<List<Music>>playlistNotifier =ValueNotifier([]);
  static final playlistDb = Hive.box<Music>("playlistDb");
  
  static Future<void>addPlaylist(Music value)async{
    final playlistDb =Hive.box<Music>("playlistDb");
    await   playlistDb.add(value);
  playlistNotifier.value.add(value);
  }
  //retrieves all the playlists from the playlistDb
  static Future <void>getAllPlaylist()async{
    final playlistDb= Hive.box<Music>("playlistDb");
    playlistNotifier.value.clear();
    playlistNotifier.value.addAll(playlistDb.values);
    playlistNotifier.notifyListeners();
  }
  static Future<void> editList(int index,Music value) async {
    final playlistDb = Hive.box<Music>('playlistDb');
    playlistDb.putAt(index, value);
    getAllPlaylist();
  }
}