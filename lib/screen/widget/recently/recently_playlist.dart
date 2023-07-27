import 'package:flutter/material.dart';
import 'package:music/functions/recentlydb/recently.dart';
import 'package:music/screen/lists/listview/listview.dart';
import 'package:on_audio_query/on_audio_query.dart';


class RecentlyPlayedScreen extends StatefulWidget {
  const RecentlyPlayedScreen({super.key});

  @override
  State<RecentlyPlayedScreen> createState() => _RecentlyPlayedScreenState();
}

class _RecentlyPlayedScreenState extends State<RecentlyPlayedScreen> {
  final OnAudioQuery audioQuery =OnAudioQuery();
  static List<SongModel>recentSong =[];

  @override
  void initState() {
    RecentsongPlayed.getRecentSongs();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Recenely Played',
          style: TextStyle(color:Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body:SafeArea(
        child:Column(
          children: [
            const Padding(padding:EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Songs",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                ),
                ),
              ],
            ),
            ),
            Expanded(child: FutureBuilder(
              future: RecentsongPlayed.getRecentSongs(),
              builder: (context,items){
                return ValueListenableBuilder(
                  valueListenable:RecentsongPlayed.recentsongNotifier,
                   builder: (context, List<SongModel> value, child) {
                      if (value.isEmpty) {
                        return const Center(
                          child: Text(
                            'No Songs',
                            style: TextStyle(color: Colors.black),
                          ),
                        );
                      } else {
                        recentSong = value.reversed.toSet().toList();
                        
                        return FutureBuilder<List<SongModel>>(
                          future: audioQuery.querySongs(
                            sortType: null,
                            orderType: OrderType.ASC_OR_SMALLER,
                            uriType: UriType.EXTERNAL,
                            ignoreCase: true,
                          ),
                          builder: (context, item) {
                            if (item.data == null) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (item.data!.isEmpty) {
                              return const Center(
                                child: Text('No available songs'),
                              );
                            }
                            return ScreenListView(
                              songModel: recentSong,
                              isRecent: true,
                              recentlength:
                                  recentSong.length > 8 ? 8 : recentSong.length,
                            );
                          },
                        );
                      }
                    },
                  );
                },
             
             ),
           ),
         ],
        ),
      ),
    );
  }
}