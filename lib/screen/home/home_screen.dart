
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/scroll_view.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music/functions/favouritedb/favourite.dart';
import 'package:music/functions/recentlydb/recently.dart';
import 'package:music/screen/lists/gridview/gridview.dart';
import 'package:music/screen/lists/listview/listview.dart';
import 'package:music/container_list/conlist.dart';
import 'package:music/screen/widget/favourite/favorite.dart';
import 'package:music/screen/widget/playlists/1playlist_screen.dart';
import 'package:music/screen/widget/recently/recently_playlist.dart';
import 'package:music/screen/widget/search/search.dart';
import 'package:music/screen/widget/settings_screens/settings_screen.dart';
import 'package:music/screen/widget/songcontroller/song_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

import '../screenplaying/miniplayer.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
List <SongModel> startSongs =[];
//store the list of songs fetched from the audio query
class _HomeScreenState extends State<HomeScreen> {
  //define audio Query plugin
  final  audioQuery = OnAudioQuery();
final audioPlayer = AudioPlayer();

  List<SongModel> allSongs = [];
bool list =true;
  //request permission
  void iniState() {
    super.initState();
    requestPermission(); 
  }


  void requestPermission() async {
    bool permissionStatus = await audioQuery.permissionsStatus();
    if (!permissionStatus) {
      await audioQuery.permissionsRequest();
    }
    setState(() {});
    await Permission.storage.request();
  }
playsong(String? uri) {
    audioPlayer.setAudioSource(
      AudioSource.uri(
        Uri.parse(uri!),
      ),
    );
    audioPlayer.play();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>const  SettingsScreen()),
            );
          },
          icon: const Icon(
            Icons.settings,
            color: Colors.black,
            size: 30,
          ),
        ),
        actions: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              list ==true
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      list=false;
                    });
                  },
                  icon: const Icon(
                    Icons.list,
                    color: Colors.black,
                  ))
             : IconButton(
                onPressed: () {
                  setState(() {
                    list=true;
                  });
                },
                icon: const Icon(
                  Icons.grid_view_rounded,
                  color: Colors.black,
                ),
              ),
              IconButton(onPressed: (){
               Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                const  ScreenSearch()));
              },
               icon: const Icon(Icons.search))
            ],
          )
        ],
      ),
      
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Padding(
                padding:const  EdgeInsets.all(8),
                child: GridView.count(
                  physics:const  NeverScrollableScrollPhysics(),
                  crossAxisCount: 1,
                  crossAxisSpacing: MediaQuery.of(context).size.width * 0.02,
                  mainAxisSpacing: MediaQuery.of(context).size.width * 0.02,
                  childAspectRatio: 5.5,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  FavoriteScreen())),
                      child: const ContainerList(
                        name: "Favourite",
                        icon: Icon(Icons.favorite, color: Colors.white),
                        color: Color.fromARGB(255, 11, 41, 67),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  PlaylistScreen())),
                      child: const ContainerList(
                        name: 'Playlist',
                        icon: Icon(
                          Icons.playlist_add_circle,
                          color: Colors.white,
                        ),
                        color: Color.fromARGB(181, 42, 5, 40),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  RecentlyPlayedScreen())),
                      child: const ContainerList(
                        name: 'Recently played',
                        icon: Icon(
                          Icons.timelapse,
                          color: Colors.white,
                        ),
                        color: Color.fromARGB(255, 91, 106, 94),
                      ),
                    ),
                  
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Stack(
                children: [
                  Container(
                    color: Colors.white,
                    height: double.infinity,
                    width: double.infinity,
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 25,),
                            child: Text(
                              "All Songs",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                       const  SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child:FutureBuilder<List<SongModel>>(
                                future:audioQuery.querySongs(
                              sortType: null,
                              orderType:OrderType.ASC_OR_SMALLER,
                              uriType: UriType.EXTERNAL,
                              ignoreCase: true,
                            ),
                            builder: (context,item) {
                              if (item.data==null) {
                                return  const Center(
                                child: CircularProgressIndicator(),
                                );
                              }
                              if(item.data!.isEmpty){
                                return const  Center(
                                  child: Text("No Songs!!",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  ),
                                );
                              } 
                              startSongs =item.data!;
                              if(!FavouriteDb.isIntialized){
                                FavouriteDb.initialize(item.data!);
                              }
                              SongController.songscopy =item.data!;

                              return list
                              ? ScreenListView(songModel: item.data!)
                              : ScreenGridView(songModel: item.data!);
                            },
                           ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                  
                 bottom: 0,
                  right: 5,
                  left: 5,
                  child: ValueListenableBuilder(
                    valueListenable: RecentsongPlayed.recentsongNotifier,
                    builder: (context, value, child) {
                      return Column(
                        children: [
                          
                          if (SongController.audioPlayer.currentIndex != null)
                            const MiniPLayer()
                          else
                            const SizedBox()
                        ],
                      );
                    },
                  ),
                ),
              ],
              ),
           
            ),
          ],
        ),
      ),
    );
  }
}
