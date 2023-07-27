import 'package:flutter/material.dart';
import 'package:music/functions/playlistdb/playlist.dart';
import 'package:music/models/model_music.dart';
import 'package:on_audio_query/on_audio_query.dart';


class PlaylistAddSong extends StatefulWidget {
  const PlaylistAddSong({super.key, required this.playlist});
  final Music playlist;
  @override
  State<PlaylistAddSong> createState() => _PlaylistAddSongState();
}

class _PlaylistAddSongState extends State<PlaylistAddSong> {
  bool isPlaying = true;
  final OnAudioQuery audioQuery = OnAudioQuery();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Add Songs",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon:  const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: FutureBuilder<List<SongModel>>(
          future: audioQuery.querySongs(
              sortType: null,
              orderType: OrderType.ASC_OR_SMALLER,
              uriType: UriType.EXTERNAL,
              ignoreCase: true),
          builder: (context, item) {
            if (item.data == null) {
              return const  Center(
                child: CircularProgressIndicator(),
              );
            }
            if (item.data!.isEmpty) {
              return  const Center(
                child: Text("No Songs available"),
              );
            }
            return ListView.separated(
                shrinkWrap: true,
                padding:  const EdgeInsets.all(12),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                    child: ListTile(
                      leading: const CircleAvatar(
                          backgroundImage: AssetImage("assets/VOX-1.webp")),
                      title: Text(
                        item.data![index].displayNameWOExt,
                        maxLines: 1,
                        style: const TextStyle(color: Colors.black),
                      ),
                      subtitle: Text(item.data![index].artist.toString(),
                      maxLines: 1,
                      style:const  TextStyle(
                        color: Colors.black
                      ),),
                      trailing: SizedBox(
                        height: 60,
                        width: 60,
                        child: Container(
                            child:
                                !widget.playlist.isValueIn(item.data![index].id)
                                    ? IconButton(
                                        onPressed: () {
                                          setState(() {
                                            songAddToPlaylist(
                                              item.data![index],
                                            );
                                            PlaylistDB.playlistNotifier
                                                .notifyListeners();
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.add,
                                          color: Colors.black,
                                        ))
                                    : IconButton(
                                        onPressed: () {
                                          setState(() {
                                            songDeleteFromPlaylist(
                                                item.data![index],);
                                          },
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.remove,
                                          color: Colors.black,
                                        ))),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: item.data!.length);
          },
          ),
    );
    
  }
  void songDeleteFromPlaylist(SongModel data ) {
  widget.playlist.deleteData(data.id);
  final removePlaylist = SnackBar(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25),
    ),
    width: MediaQuery.of(context).size.width * 3.5 / 5,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.white,
    content:  const Text(
      "Song removed from playlist",
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black),
    ),
    duration:  const Duration(milliseconds: 550),
  );
  ScaffoldMessenger.of(context).showSnackBar(removePlaylist);
}

void songAddToPlaylist(SongModel data ) {
  
  widget.playlist.add(data.id);
  final addedToPlaylist = SnackBar(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25),
    ),
    width: MediaQuery.of(context).size.width * 3.5 / 5,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.white,
    content: const Text(
      "Song Added To playlist",
      style: TextStyle(color: Colors.black),
    ),
    duration: const Duration(milliseconds: 550),
  );
  ScaffoldMessenger.of(context).showSnackBar(addedToPlaylist);
}
}

