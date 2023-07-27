import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music/models/model_music.dart';
import 'package:music/screen/widget/playlists/moredailogue.dart';

import '2playlist_screenplylst.dart';

class PlaylistGridView extends StatefulWidget {
  const PlaylistGridView({Key? key,
  required this.musicList
  }):super(key: key);
  final Box<Music>musicList;

  @override
  State<PlaylistGridView> createState() => _PlaylistGridViewState();
}

class _PlaylistGridViewState extends State<PlaylistGridView> {
  final TextEditingController playlistnamectrl = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  
  void iniState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(padding: 
    const EdgeInsets.all(10),
    child: GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount:2,
      childAspectRatio: 1.2,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5, 
    ),
    shrinkWrap: true,
    itemCount: widget.musicList.length,
     itemBuilder: ( (context, index) {
       final data= widget.musicList.values.toList()[index];
       return  ValueListenableBuilder(
        valueListenable: Hive.box<Music>("playlistDb").listenable(),
        builder: (BuildContext context, Box<Music>musicList,
        Widget? child
        ){
         return Padding(padding: const EdgeInsets.all(5),
         child: InkWell(
          onTap: (){
            Navigator.push(
              context, MaterialPageRoute(builder: (context){
              return ScreenPlaylist(
                playlist :data,
                findex:index,
                image: "assets/images.png",
              );
            },
            ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: const DecorationImage(
                        fit: BoxFit.fitHeight,
                        image: AssetImage('assets/images.png'),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(10),
                            height: MediaQuery.of(context).size.height * .9 / 10,
                            width: MediaQuery.of(context).size.height * .9 / 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.90 /
                                      4,
                                  child: Text(
                                    data.name,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: IconButton(
                                    onPressed: () {
                                      moredialogplaylist(
                                          context,
                                          index,
                                          musicList,
                                          formkey,
                                          playlistnamectrl,
                                          data,
                                          
                                          );
                                    },
                                    icon: const Icon(
                                      Icons.more_vert,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
          ),
         ),
         );
        }
       );
     }
     )
     ),
    ) ;
  }
}