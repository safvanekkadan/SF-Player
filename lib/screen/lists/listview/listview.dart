import 'package:flutter/material.dart';
import 'package:music/functions/recentlydb/recently.dart';
import 'package:music/screen/screenplaying/nowscreen.dart';
import 'package:music/screen/widget/playlists/playlist_dailogue.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../../functions/favouritedb/favourite.dart';
import '../../widget/songcontroller/song_controller.dart';

class ScreenListView extends StatefulWidget {
  const ScreenListView({super.key, 
  required this.songModel,
  this.isRecent=false,
  this.recentlength, 
  });
  final  List<SongModel> songModel;
  final dynamic recentlength;
  final  bool isRecent;

  @override
  State<ScreenListView> createState() => _ScreenListViewState();
}

class _ScreenListViewState extends State<ScreenListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics:const  ClampingScrollPhysics(),
        padding: const EdgeInsets.all(10),
        itemBuilder: (context, index) {
          return ListTile(
            leading: const CircleAvatar(
              backgroundImage: AssetImage('assets/VOX-1.webp'),
            ),
            title: Text(
              widget.songModel[index].displayNameWOExt,
              style:const  TextStyle(
                color: Colors.black,
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 1,
            ),
            subtitle: Text(
            widget.songModel[index].artist.toString(),
            style: const TextStyle(color:Colors.black),
          ),
            trailing: PopupMenuButton(
                icon: const Icon(
                  Icons.more_vert, 
                  color: Colors.black),
                itemBuilder: (context) => <PopupMenuEntry>[
                       PopupMenuItem(
                child: TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                    playlistDialogue(context,widget.songModel[index]);
                  },
                  child: const Text("Add to Playlist"),
                )),
                  PopupMenuItem(
                    child: Wrap(
                      children: [
                        ValueListenableBuilder(
                          valueListenable: FavouriteDb.favouriteSongs,
                          builder: (context, List<SongModel> favouriteData,
                              Widget? child) {
                            return TextButton(
                              onPressed: () {
                                if (FavouriteDb.isFavour(widget.songModel[index])) {
                                  FavouriteDb.delete(widget.songModel[index].id);
                                  const remove = SnackBar(
                                    content: Text('song removed from favourite'),
                                    duration: Duration(seconds: 1),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(remove);
                                  Navigator.of(context).pop();
                                } else {
                                  FavouriteDb.add(widget.songModel[index]);
                                  const favadd = SnackBar(
                                    content: Text('song added to favourite'),
                                    duration: Duration(seconds: 1),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(favadd);
                                  Navigator.of(context).pop();
                                }
                                
                              },
                              child: FavouriteDb.isFavour(widget.songModel[index])
                                  ? const Text('Remove from favourite')
                                  : const Text('Add to favourite'),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                    ],
                    ),
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
          );
        },
        separatorBuilder: (context, index) => const Divider(),
        itemCount:widget.isRecent ?widget.recentlength : widget.songModel.length);
        //If widget.isRecent is true, the number of items will be widget.recentlength.
        //If widget.isRecent is false, the number of items will be widget.songModel.length.
  }
}
