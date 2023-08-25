

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music/controller/favouritecontroller.dart';
import 'package:music/controller/playcontrols.dart';
import 'package:music/screen/widget/favourite/favorite.dart';
import 'package:music/screen/widget/playlists/playlist_dailogue.dart';
import 'package:music/screen/widget/songcontroller/song_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
class PlayControls extends StatefulWidget {
  const PlayControls(
      {super.key,
      required this.firstSong,
      required this.count,
      required this.favouriteSongModel,
      required this.lastSong});

  final int count;
  final bool firstSong;
  final bool lastSong;
  final SongModel favouriteSongModel;

  @override
  State<PlayControls> createState() => _PlayControlsState();
}

class _PlayControlsState extends State<PlayControls> {
  // bool isPlaying =true;
  // bool isShuffling =false;
  @override
  Widget build(BuildContext context) {
    final playControlState= Provider.of<PlayControlsStateProvider>(context);
    
    return Consumer(
      builder: (context, value, child) {
      
      return Scaffold(
        body: SafeArea(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // The favorite button, which toggles the favorite status of the currently playing song and displays a snackbar with appropriate messages.
                    //The playlist button, which opens a playlist dialogue to add the currently playing song to a playlist.
                    //The shuffle button, which toggles the shuffle mode on the audio player and displays a shuffle icon based on the shuffle state.
                    //The repeat button, which toggles between single-repeat and all-repeat modes and displays an appropriate icon based on the loop mode.
                    //The previous, play/pause, and next buttons for navigating through the playlist and controlling playback.
                    Consumer<FavouriteController>(
                        
                        builder: (context, favouriteData,
                            Widget? child) {
                          return IconButton(
                            onPressed: () {
                              if (favouriteData.isFavour(
                                  widget.favouriteSongModel)) {
                                favouriteData.delete(widget.favouriteSongModel.id);
                                const remove = SnackBar(
                                  content: Text("remove from favourite"),
                                  duration: Duration(seconds: 1),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(remove);
                              } else {
                                favouriteData.add(widget.favouriteSongModel);
                                const addfavourite = SnackBar(
                                  content: Text("Added to Favourite"),
                                  duration: Duration(seconds: 1),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(addfavourite);
                              }
                              
                              
                            },
                            icon: favouriteData.isFavour(widget.favouriteSongModel)
                                ?const  Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                : const Icon(
                                    Icons.favorite_outline,
                                    color: Colors.black,
                                  ),
                          );
                        }),
                    IconButton(
                      onPressed: () {
                        playlistDialogue(context, widget.favouriteSongModel);
                      },
                      icon:
                         const  Icon(Icons.playlist_add,
                           size: 30,
                            color: Colors.black),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    IconButton(
                      onPressed: () {
                        playControlState.isShuffling ==false
                        ?SongController.audioPlayer
                        .setShuffleModeEnabled(true)
                        :SongController.audioPlayer
                        .setShuffleModeEnabled(false);
                      },
                      icon:StreamBuilder<bool>(
                        stream: SongController.audioPlayer.shuffleModeEnabledStream,
                        builder: (BuildContext context, AsyncSnapshot snapshot){
                          if(snapshot.hasData){
                            playControlState.isShuffling =snapshot.data;
                          }
                          if(playControlState.isShuffling){
                            return const Icon(Icons.shuffle,
                            size: 30,
                            color: Colors.red,);
                          }else{
                            return  const Icon(Icons.shuffle,
                            color: Colors.black,)
                            
                            ;
                          }  
                        },
                      ),
                    ),
                    //repeat button
                    IconButton(
                      onPressed: () {
                        // actions, such as playing/pausing, skipping to the previous/next song, 
                        //toggling shuffle mode, and toggling repeat mode.
                        //The button icons change based on the current state of shuffle mode (isShuffling)
                        // and the loop mode of the audio player (StreamBuilder for loopModeStream).
                        //When the play/pause button is pressed, the isPlaying variable is updated
                        SongController.audioPlayer.loopMode==LoopMode.one
                        ?SongController.audioPlayer.setLoopMode(LoopMode.all)
                        :SongController.audioPlayer.setLoopMode(LoopMode.one);
                      },
                      icon: 
                      StreamBuilder<LoopMode>(
                        stream: SongController.audioPlayer.loopModeStream,
                        builder:(context, snapshot){
                          final loopMode =snapshot.data;
                          if(LoopMode.one== loopMode){
                            return const  Icon(Icons.repeat,
                            size: 30,
                            color: Colors.red,);
                            
                          }else{
                            return const Icon(Icons.repeat,
                            color: Colors.black,);
                          }
                        } ,)
                    ),
           
                  ],
                ),
                    const SizedBox(
                      height: 20
                    ),
                    Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //previous Button
                    widget.firstSong
                        ? const IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.skip_previous,
                              color:Colors.black,
                              size: 40,
                            ),
                          )
                        : IconButton(
                            onPressed: () {
                              if (SongController.audioPlayer.hasPrevious) {
                                SongController.audioPlayer.seekToPrevious();
                              }
                            },
                            icon: const Icon(
                              Icons.skip_previous,
                              color: Colors.black,
                              size: 40,
                            ),
                          ),
                    const SizedBox(
                      width: 25,
                    ),
                    //play and pause
                    Center(
                      child: IconButton(
                        onPressed: () {
                          if (mounted) {
                            setState(() {
                              if (SongController.audioPlayer.playing) {
                                SongController.audioPlayer.pause();
                              } else {
                                SongController.audioPlayer.play();
                              }
                              playControlState.isPlaying = !playControlState.isPlaying;
                            });
                          }
                        },
                        icon: playControlState.isPlaying
                            ? const Icon(
                                Icons.pause,
                                color: Colors.black,
                                size:60,
                              )
                            : const Icon(
                                Icons.play_arrow,
                                color: Colors.black,
                                size: 60,
                              ),
                      ),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    //next button
                    widget.lastSong
                        ? const IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.skip_next,
                              color: Colors.black,
                              size: 30,
                            ),
                          )
                        : IconButton(
                            onPressed: () {
                              if (SongController.audioPlayer.hasNext) {
                                SongController.audioPlayer.seekToNext();
                              }
                            },
                            icon: const Icon(
                              Icons.skip_next,
                              color: Colors.black,
                              size: 40,
                            ),
                          )
                      ],
                    ),
                  ],
                )
              
            ),
          ),
        );
      }
    );
      
    
  }
}
 