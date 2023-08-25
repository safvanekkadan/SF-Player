import 'package:flutter/material.dart';
import 'package:music/controller/miniplayercontrols.dart';
import 'package:music/functions/recentlydb/recently.dart';
import 'package:music/screen/screenplaying/nowscreen.dart';
import 'package:music/screen/widget/playlists/1playlist_screen.dart';
import 'package:music/screen/widget/songcontroller/song_controller.dart';
import 'package:provider/provider.dart';

class MiniPLayer extends StatefulWidget {
  const MiniPLayer({Key? key}) : super(key: key);

  @override
  State<MiniPLayer> createState() => _MiniPLayerState();
}

// bool firstSong = false;
// bool isPlaying = false;

class _MiniPLayerState extends State<MiniPLayer> {
  void iniState() {
    SongController.audioPlayer.currentIndexStream.listen((index) {
      if (index != null && mounted) {
        // setState(() {
        //   //firstSong variable based on the current index of the song being played. 
        //   //If the current index is 0,
        //   // firstSong is set to true; otherwise, it is set to false.
        //   index == 0 ? firstSong = true : firstSong = false;
        // });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final miniPlayerState=Provider.of<MiniPlayerStateProvider>(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NowScreenPLaying(
                  songModel: SongController.playingsong,
                    )));
      },
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding:const EdgeInsets.only(left: 3.0, right: 4.0, bottom: 4),
          child: Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 31, 30, 30),
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10)),
            height: 90,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      margin:const  EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 1.5/ 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          StreamBuilder<bool>(
                              stream: SongController.audioPlayer.playingStream,
                              builder: (context, snapshot) {
                                bool? playingStage = snapshot.data;
                                if (playingStage != null && playingStage) {
                                  return Text(
                                    SongController
                                        .playingsong[SongController
                                            .audioPlayer.currentIndex!]
                                        .displayNameWOExt,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(color: Colors.white,
                                    fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  );
                                } else {
                                  return Text(
                                    
                                    SongController
                                        .playingsong[SongController
                                            .audioPlayer.currentIndex!]
                                        .displayNameWOExt,
                                        
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  );
                                }
                              }
                              ),
                          Text(
                            SongController
                                        .playingsong[SongController
                                            .audioPlayer.currentIndex!]
                                        .artist
                                        .toString() ==
                                    "<unknown>"
                                ? "Unknown Artist"
                                : SongController
                                    .playingsong[SongController
                                        .audioPlayer.currentIndex!]
                                    .artist
                                    .toString(),
                            style: const TextStyle(
                                fontSize: 15, color: Colors.white),
                          ),
                        ],
                      ),
                    ),

                    ////previous
                    miniPlayerState.firstSong
                        ? const IconButton(
                            onPressed: null,
                            icon: Icon(Icons.skip_previous),
                            color: Colors.black,
                          )
                        : IconButton(
                            iconSize: 32,
                            onPressed: () async {
                              RecentsongPlayed.addRecentPlayedSong(
                                SongController.playingsong[
                                  SongController.audioPlayer.currentIndex!
                                ].id
                              );
                              //call the audio player's seekToPrevious() and seekToNext() methods,
                              // respectively, to navigate to the previous or next song.
                              if (SongController.audioPlayer.hasPrevious) {
                                await SongController.audioPlayer
                                    .seekToPrevious();
                                await SongController.audioPlayer.play();
                              } else {
                                await SongController.audioPlayer.play();
                              }
                            },
                            icon: const Icon(Icons.skip_previous),
                            color: Colors.white,
                          ),

                    ///play and Pouse
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: const CircleBorder(),
                        ),
                        onPressed: () async {
                          setState(()  {
                            miniPlayerState.isPlaying = !miniPlayerState.isPlaying;
                          });
                          if (SongController.audioPlayer.playing) {
                            await SongController.audioPlayer.pause();
                             setState(() {});
                          } else {
                            await SongController.audioPlayer.play();
                             setState(() {});
                          }
                        },
                        child: StreamBuilder<bool>(
                          stream: SongController.audioPlayer.playingStream,
                          builder: (context, snapshot) {
                            bool? playingStage = snapshot.data;
                            if (playingStage != null && playingStage) {
                              return const Icon(
                                Icons.pause_circle,
                                color: Colors.black,
                                size: 35,
                              );
                            } else {
                              return const Icon(
                                Icons.play_circle,
                                color: Colors.black,
                                size: 35,
                              );
                            }
                          },
                        )),
                    ////next
                    IconButton(
                      iconSize: 35,
                      onPressed: () async {
                        RecentsongPlayed.addRecentPlayedSong(
                          SongController.playingsong[
                            SongController.audioPlayer.currentIndex!].id);
                        if (SongController.audioPlayer.hasNext) {
                          await SongController.audioPlayer.seekToNext();
                          await SongController.audioPlayer.play();
                        } else {
                          await SongController.audioPlayer.play();
                        }
                      },
                      icon:const  Icon(
                        Icons.skip_next,
                        size: 32,
                      ),
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
