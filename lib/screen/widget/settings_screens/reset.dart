import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music/functions/favouritedb/favourite.dart';
import 'package:music/models/model_music.dart';
import 'package:music/screen/splash/splash_screen.dart';

Future<void> reset(context)async{
  final playlistDb =Hive.box<Music>("playlistDb");
  final musicDb =Hive.box<int>("FavouriteDB");
  final recentDb=await Hive.openBox("recentPlayedSong");

await musicDb.clear();
await recentDb.clear();
await playlistDb.clear();
 FavouriteDb.favouriteSongs.value.clear();
 Navigator.of(context).pushAndRemoveUntil(
  MaterialPageRoute(builder: (context)=>const SplashScreen()),
   (route) => false);

}