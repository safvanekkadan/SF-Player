import 'package:flutter/material.dart';
import 'package:music/functions/recentlydb/recently.dart';
import 'package:music/screen/screenplaying/nowscreen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../widget/songcontroller/song_controller.dart';


class ScreenGridView extends StatefulWidget {
  const ScreenGridView({super.key,
  required this.songModel});
  final List<SongModel> songModel;
  @override
  State<ScreenGridView> createState() => _GridViewState();
}

class _GridViewState extends State<ScreenGridView> {
  List<SongModel> allSongs = [];
  

  @override
  Widget build(BuildContext context) {
    return  GridView.builder(
      itemCount:widget.songModel.length,
      gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:2,
        mainAxisSpacing: 5.0,//space btwn row
        crossAxisSpacing: 5.0,// ,, clmn
        childAspectRatio: 1.0),// ratio item 
      itemBuilder: (BuildContext context ,int index){
        allSongs.addAll(widget.songModel);
        return Column(
          children: [
            Stack(
              children: [
                GestureDetector(
                  onTap: () {
              SongController.audioPlayer.setAudioSource(
              SongController.createSongList(widget.songModel),
              initialIndex: index,
              );
              RecentsongPlayed.addRecentPlayedSong(widget.songModel[index].id);
              Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NowScreenPLaying(
                  songModel: widget.songModel,
                  count: widget.songModel.length,
                ),
              ),
              
            );
            },
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(300),
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/musicsong.png'),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: PopupMenuButton(
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.black,
                    ),
                    itemBuilder: (context) => <PopupMenuEntry>[
                      PopupMenuItem(
                        child: TextButton(
                          onPressed: () {},
                          child: const Text('Add to Playlist'),
                        ),
                      ),
                      PopupMenuItem(
                        child: TextButton(
                          onPressed: () {},
                          child: const Text('Add to favourite'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 23),
              child: Text(
                widget.songModel[index].displayNameWOExt,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(color:Colors.black),
              ),
            ),
          ],
        );
      }
      );
  }
}