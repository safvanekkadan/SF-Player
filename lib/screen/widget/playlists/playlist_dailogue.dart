import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music/models/model_music.dart';
import 'package:music/screen/widget/playlists/1playlist_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

playlistDialogue(BuildContext context, SongModel songModel){
  showDialog(context: context,
   builder: (conetxt){
     return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      backgroundColor: Colors.grey,
      title: const Text("Select a Playlist",
      style: TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.w500
      ),),
      content: SizedBox(
        height: 200,
        width: double.maxFinite,
        child: ValueListenableBuilder(
          valueListenable: Hive.box<Music>("playlistDb").listenable(),
           builder: (context, Box<Music>musicList, child){
            return Hive.box<Music>("playlistDb").isEmpty
            ?  const Center(
              child: Text("No playlist found",
              style: TextStyle(
                color: Colors.white,fontSize: 18,
                fontWeight: FontWeight.w600
              ),),
            )
            :ListView.builder(
              itemCount: musicList.length,
              itemBuilder:(context, index){
                final data = musicList.values.toList()[index];
                return Card(
                  color: const Color.fromARGB(255, 24, 66, 85),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(data.name,
                    style: const TextStyle(color: Colors.white),),
                    trailing:  const Icon(Icons.playlist_add,
                    color: Colors.white),
                    onTap:(){ addSongToPlaylist(
                    context,songModel,data,data.name
                    );
                    },
                  ),
                );
              },

               );
           }
           ),
      ),
      actions: [
        TextButton(onPressed: (){
          nameController.clear();
          Navigator.pop(context);
          newplaylist(context, formKey);
        }, child:const  Text("New Playlist",style: TextStyle(color: Colors.black),),
        ),
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child:const  Text("Cancel",
        style: TextStyle(color: Colors.black),))
      ],
     );
   });
}

 void addSongToPlaylist(
  BuildContext context ,SongModel data , datas,String name) {
if (!datas.isValueIn(data.id)) {
    datas.add(data.id);
    final songAddSnackBar = SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.fixed,
        content: Text(
          "Song Added To $name",
          textAlign: TextAlign.center,
        ));
    ScaffoldMessenger.of(context).showSnackBar(songAddSnackBar);
    Navigator.pop(context);
  } else {
    final songAlreadyExist = SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.fixed,
        content: Text(
          "Song Already exist In $name",
          textAlign: TextAlign.center,
        ));
    ScaffoldMessenger.of(context).showSnackBar(songAlreadyExist);
    Navigator.pop(context);
  }
}