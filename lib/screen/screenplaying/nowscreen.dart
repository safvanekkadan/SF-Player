import 'package:flutter/material.dart';
import 'package:music/controller/nowscreencontroller.dart';
import 'package:music/screen/screenplaying/miniplayer.dart';

import 'package:music/screen/screenplaying/playcontrols.dart';
import 'package:music/screen/widget/songcontroller/song_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';


class NowScreenPLaying extends StatefulWidget {
  const NowScreenPLaying({super.key,
  // required this.songModel, 
  // this.count = 0,
  });
  
  // final List<SongModel> songModel;
  // final int count;

  @override
  State<NowScreenPLaying> createState() => _NowScreenPLayingState();
}

class _NowScreenPLayingState extends State<NowScreenPLaying> {
  
  // Duration _duration = const Duration();
  // Duration _position = const Duration();
  // int large = 0;
  // int currentIndex = 0;
  // bool firstSong=false;
  // bool lastSong=false;

  // @override
  // void initState() {
  //   SongController.audioPlayer.currentIndexStream.listen(
  //     (index) {
  //       if (index != null) {
  //         if (mounted) {
  //           nowPlayingProvider.updateIndex(index);
            
  //           // nowPlayingProvider.updateSongStatus(isFirst: firstSong, isLast: lastSong);
  //           // setState(
  //           //   () {
  //           //     large = widget.count - 1;
  //           //     currentIndex = index;
  //           //     index == 0 ? firstSong = true : firstSong = false;
  //           //     index == large ? lastSong = true : lastSong = false;
  //           //   },
  //           // );
  //         }
  //       }
  //     },
  //   );

  //   // super.initState();
  //   // playSong();
   
  // }
  void playSong() {
    SongController.audioPlayer.play();
    SongController.audioPlayer.durationStream.listen((d) {
      if (mounted) {
        
      nowPlayingProvider.updateDuration(d);
      
      
        // setState(
        //   () {
        //     _duration = d!;
        //   },
        // );
      }
    },
    );
    
    SongController.audioPlayer.positionStream.listen((p) {
       nowPlayingProvider.updatePosition(p); 
      // if (mounted) {
      //   nowPlayingProvider.updatePosition(p);
      //   // setState(() {
      //   //   _position = p;
      //   // });
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    final  nowPlayingProvider=Provider.of<NowPlayingProvider>(context,listen: false);
    return Consumer(
      builder: (context,nowscreenPlaying , child) {
        
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title:const  Text(
            "Now PLaying",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        body: SafeArea(
            child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 8),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.width * .35,
                    backgroundImage:const  AssetImage("assets/VOX-1.webp"),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
               Padding(
                  padding: const EdgeInsets.only(left: 16,right: 5),
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    nowPlayingProvider.songModel[nowPlayingProvider.currentIndex].displayNameWOExt,
                    style: const TextStyle(color: Colors.black,
                    fontSize: 25),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              Text(
                nowPlayingProvider.songModel[nowPlayingProvider.currentIndex].artist.toString() == 
                        '<unknown>'
                    ? "Unknown Artist"
                    : nowPlayingProvider.songModel[nowPlayingProvider.currentIndex].artist.toString(),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(color: Colors.black,
                fontSize: 15),
              ),
              const SizedBox(
                height: 20,
              ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      thumbColor: Colors.transparent,
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 7,
                        elevation: 5,
                        pressedElevation: 5,
                      ),
                    ),
                    child: Slider(
                      activeColor: const Color.fromARGB(255, 62, 74, 62),
                      inactiveColor: Colors.black,
                      value: nowPlayingProvider.position.inSeconds.toDouble(),
                      max: nowPlayingProvider.duration.inSeconds.toDouble(),
                      min: const Duration(microseconds: 0).inSeconds.toDouble(),
                      onChanged: (value) {
                        if (mounted) {
                          setState(
                            () {
                              changeToSeconds(
                                value.toInt());
                              value = value;
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
                 Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatDuration(nowPlayingProvider.position),
                        style: const TextStyle(color:Colors.black),
                      ),
                      Text(
                        _formatDuration(nowPlayingProvider.duration),
                        style: const TextStyle(color:Colors.black),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: PlayControls(
                    count: nowPlayingProvider.count,
                    lastSong: nowPlayingProvider.lastSong,
                    firstSong: nowPlayingProvider.firstSong,
                    favouriteSongModel: nowPlayingProvider.songModel[nowPlayingProvider.currentIndex],
                  ),
                ),
            ],
          ),
        ),
        ),
        
      );
      },
    );
  }
  void changeToSeconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
    SongController.audioPlayer.seek(duration);
  }
  String _formatDuration(Duration? duration) {
    if (duration == null) {
      return '--:--';
    } else {
      String minutes = duration.inMinutes.toString().padLeft(2, '0');
      String seconds =
          duration.inSeconds.remainder(60).toString().padLeft(2, '0');
      return "$minutes:$seconds";
    }
  }
}
