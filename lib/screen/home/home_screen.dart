
import 'package:flutter/material.dart';
import 'package:music/controller/favouritecontroller.dart';
import 'package:music/controller/providerhomescreen.dart';
import 'package:music/controller/recentlycontroller.dart';
import 'package:music/container_list/conlist.dart';
import 'package:music/helpers/appcolors.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import '../lists/gridview/gridview.dart';
import '../lists/listview/listview.dart';
import '../screenplaying/miniplayer.dart';
import '../widget/favourite/favorite.dart';
import '../widget/playlists/1playlist_screen.dart';
import '../widget/recently/recently_playlist.dart';
import '../widget/search/search.dart';
import '../widget/settings_screens/settings_screen.dart';
import '../widget/songcontroller/song_controller.dart';

 List <SongModel> startSongs =[];
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
  // Provider.of<HomeScreenController>(context,listen: false).setupAudioQuery();
     Provider.of<HomeScreenController>(context,listen: false).checkAndRequestPermissions();
});
     
      
    return Consumer<HomeScreenController>(

      builder: (context, homescreenProvider,child) {
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
                 homescreenProvider.list ==true
                  ? IconButton(
                      onPressed: () {
                        homescreenProvider.changeList(false);
                        // setState(() {
                        //   list=false;
                        // });
                      },
                      icon: const Icon( 
                        Icons.list,
                        color: Colors.black,
                      ))
                 : IconButton(
                    onPressed: () {
              homescreenProvider.changeList(true);
                      // setState(() {
                      //   list=true;
                      // });
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
                            color: AppColors.favouritecolor
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
                            color: AppColors.playlistcolor
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
                            color:AppColors.recentlycolor 
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
                              child:homescreenProvider.hasPermission == false
                                     ?noAccessToLibraryWidget(context) 
                              :FutureBuilder<List<SongModel>>(
                                    future:homescreenProvider.audioQuery.querySongs(
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
                                  if(!FavouriteController.isIntialized){
                                    Provider.of<FavouriteController>(context).initialize(item.data!);
                                  }
                                  SongController.songscopy =item.data!;
    
                                  return homescreenProvider.list
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
                      child: Consumer<RecentlyPlayerController>(
                      
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
      
    );
  }
   
}
  Widget noAccessToLibraryWidget(context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.redAccent.withOpacity(0.5),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Application doesn't have access to the library"),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => Provider.of<HomeScreenController>(context).checkAndRequestPermissions(retry: true),
            child: const Text("Allow"),
          ),
        ],
      ),
    );
  }