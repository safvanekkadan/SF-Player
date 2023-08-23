import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:music/controller/favouritecontroller.dart';
import 'package:music/screen/lists/listview/listview.dart';
import 'package:music/screen/home/home_screen.dart';
import 'package:provider/provider.dart';


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
      body: Consumer<FavouriteController>(
        
        builder: (context,  favouriteData, Widget? child) {
          if (favouriteData.favouriteSongs.isEmpty) {
            return const Center(
              child: Text(
                'No data ',
                style: TextStyle(color: Colors.black),
              ),
            );

          }else{
           favouriteData.favouriteSongs.reversed.toList();
            // favouriteData=favouriteData.favouriteSongs.toSet().toList();
            return ScreenListView(songModel: favouriteData.favouriteSongs);
          }
        },
      ),
    );
  }
}