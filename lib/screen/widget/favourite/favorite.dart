import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:music/functions/favouritedb/favourite.dart';
import 'package:music/screen/lists/listview/listview.dart';
import 'package:music/screen/home/home_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';


class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Favorites",
        style: TextStyle(color: Colors.black),),
        centerTitle:true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomeScreen()));
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body:ValueListenableBuilder(valueListenable: FavouriteDb.favouriteSongs,
       builder:(context,List<SongModel>favouriteData, Widget?child){
        //list is empty, it displays a message saying "no data." Otherwise, it
        // reverses the order of the songs in the list and removes any duplicate
        if (favouriteData.isEmpty){
          return const Center(
           child: Text("no data",style: TextStyle(
            color: Colors.black
           ),),
          );
        }else{
           final temb=favouriteData.reversed.toList();
           favouriteData=temb.toSet().toList();
           return ScreenListView(songModel: favouriteData);
        }
       })
    );
  }
}