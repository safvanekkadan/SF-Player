import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music/screen/home/home_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class RecentsongPlayed extends ChangeNotifier{
 static ValueNotifier<List<SongModel>>recentsongNotifier =ValueNotifier([]);
 static List<dynamic>recentPlayedSong=[];//list that will store the recently played song IDs 
 static Future<void>addRecentPlayedSong(item)async{
 final recentDb =await Hive.openBox("recentPlayedSong");
 await recentDb.add(item);
 getRecentSongs();
 recentsongNotifier.notifyListeners();
 }
 //retrieves all recently played song 
  static Future<void> getRecentSongs() async{
    final recentDb =await Hive.openBox("recentPlayedSong");
    recentPlayedSong=recentDb.values.toList();
    displayRecentlyPlayed();
    recentsongNotifier.notifyListeners();
  }
  
  static  Future<void> displayRecentlyPlayed()async {
    final recentDb =await Hive.openBox("recentPlayedSong");
    final recentlyPlayedItems =recentDb.values.toList();
    recentsongNotifier.value.clear();
    recentPlayedSong.clear();

    for(int i=0;i<recentlyPlayedItems.length;i++){
      for (int j=0;j<startSongs.length;j++){// all available songs
        if(recentlyPlayedItems[i]==startSongs[j].id){
          recentsongNotifier.value.add(startSongs[j]);//ui changing
          recentPlayedSong.add(startSongs[j]);
        }
      }
    }
    
  }
}