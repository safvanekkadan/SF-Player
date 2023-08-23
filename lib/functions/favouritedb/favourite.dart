// import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';
// import 'package:hive/hive.dart';
// import 'package:on_audio_query/on_audio_query.dart';

// class FavouriteDb {
//   static bool isIntialized =false;
//   static final musicDb = Hive.box<int>("FavouriteDB");
//   static ValueNotifier<List<SongModel>>favouriteSongs=ValueNotifier([]);
//   // list of SongModel objects as 
//   //input and initializes the favorite songs list
//   static initialize (List<SongModel>songs){
//     for(SongModel song in songs){
//       if (isFavour(song)){
//         favouriteSongs.value.add(song);

//       }
//     }
//     isIntialized=true;
//   }
//   static isFavour(SongModel song){
//     if (musicDb.values.contains(song.id)){
//       return true;
//     }
//     return false;
//   }
//   static add(SongModel song)async{
//     musicDb.add(song.id);
//     favouriteSongs.value.add(song);
//     FavouriteDb.favouriteSongs.notifyListeners();
//   }
//   static delete (int id)async{
//     int deleteKey =0;
//     if (!musicDb.values.contains(id)){
//       return;
//     }
//     final Map<dynamic,int>favourMap=musicDb.toMap();
//     favourMap.forEach((key, value) {
//       if(value==id){
//         deleteKey=key;
//       }
//      });
  
//   musicDb.delete(deleteKey);
//   favouriteSongs.value.removeWhere((song) => song.id==id);
//   }
// static clear()async{
//   FavouriteDb.favouriteSongs.value.clear();
// }
// }