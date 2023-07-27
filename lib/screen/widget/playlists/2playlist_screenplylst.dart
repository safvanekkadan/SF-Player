import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music/models/model_music.dart';
import 'package:music/screen/screenplaying/nowscreen.dart';
import 'package:music/screen/widget/songcontroller/song_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '3playlist_addsong.dart';

class ScreenPlaylist extends StatelessWidget {
  const ScreenPlaylist({
    super.key,
    required this.playlist,
    required this.findex,
    this.image,
  });
  final Music playlist;
  final int findex;

  // ignore: prefer_typing_uninitialized_variables
  final image;
  @override
  Widget build(BuildContext context) {
    late List<SongModel> songPlaylist;
    return ValueListenableBuilder(
        valueListenable: Hive.box<Music>("playlistDB").listenable(),
        builder: (BuildContext context, Box<Music> music, Widget? child) {
          songPlaylist = listPlaylist(music.values.toList()[findex].songId);
          return Scaffold(
            backgroundColor: Colors.white,
            body: CustomScrollView(
              slivers: [
                //popbutton
                SliverAppBar(
                  leading: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 32,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  actions: [
                    // Add song
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlaylistAddSong(
                              playlist: playlist,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.black,
                        size: 32,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    )
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    //Title
                    title: Text(
                      playlist.name,
                      style: const TextStyle(color: Colors.black),
                    ),
                    
                    expandedTitleScale: 1.5,
                    background: Image.asset(
                      image,
                      
                    ),
                  ),
                  expandedHeight: MediaQuery.of(context).size.width * 3.3/ 4,
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
                  songPlaylist.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PlaylistAddSong(
                                        playlist: playlist,
                                      ),
                                    ),
                                  );
                                },
                                child: const Icon(
                                  Icons.add_box,
                                  size: 50,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .02,
                              ),
                              const Center(
                                child: Text(
                                  'Add Songs To Your playlist',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.separated(
                        padding: const EdgeInsets.all(10),
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 10),
                              child: ListTile(
                                leading: const CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/images.png'),
                                ),
                                title: Text(
                                  songPlaylist[index].displayNameWOExt,
                                  maxLines: 1,
                                  style: const TextStyle(color: Colors.black),
                                ),
                                subtitle: Text(
                                  songPlaylist[index].artist.toString(),
                                  maxLines: 1,
                                  style: const TextStyle(color: Colors.black),
                                ),
                                trailing: SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: IconButton(
                                    icon: const Icon(Icons.remove,
                                        color: Colors.black),
                                    onPressed: () {
                                      songDeleteFromPlaylist(
                                          songPlaylist[index], context);
                                    },
                                  ),
                                ),
                                onTap: () {
                                  SongController.audioPlayer.setAudioSource(
                                      SongController.createSongList(
                                          songPlaylist),
                                      initialIndex: index);

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NowScreenPLaying(
                                        songModel: songPlaylist,
                                        count: songPlaylist.length,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: songPlaylist.length,
                        )
                ]))
              ],
            ),
          );
        });
  }

  void songDeleteFromPlaylist(SongModel songPlaylist, BuildContext context) {
    playlist.deleteData(songPlaylist.id);
    final removePlaylist = SnackBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      width: MediaQuery.of(context).size.width * 3.5 / 5,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.white,
      content: const Text("Song removed from Playlist",
          style: TextStyle(color: Colors.black)),
      duration: const Duration(milliseconds: 660),
    );
    ScaffoldMessenger.of(context).showSnackBar(removePlaylist);
  }

  List<SongModel> listPlaylist(List<int> data) {
    List<SongModel> plsongs = [];
    for (int i = 0; i < SongController.songscopy.length; i++) {
      for (int j = 0; j < data.length; j++) {
        if (SongController.songscopy[i].id == data[j]) {
          plsongs.add(SongController.songscopy[i]);
        }
      }
    }
    return plsongs;
  }
}
