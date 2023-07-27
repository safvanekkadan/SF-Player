import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music/functions/playlistdb/playlist.dart';
import 'package:music/models/model_music.dart';
import 'package:music/screen/home/home_screen.dart';
import 'package:music/screen/widget/playlists/playlistGridview.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

GlobalKey<FormState> formKey = GlobalKey<FormState>();
TextEditingController nameController = TextEditingController();

class _PlaylistScreenState extends State<PlaylistScreen> {
  
  void iniState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<Music>('PlaylistDb').listenable(),
       builder: (context ,Box<Music>musicList,child){
        
    //access the musicList Box to get data  Hive
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Playlist",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                newplaylist(context, formKey);
              },
              icon:const  Icon(
                Icons.playlist_add,
                color: Colors.black,
              ))
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const HomeScreen()));
          },
          icon:const  Icon(Icons.arrow_back),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Hive.box<Music>("playlistDb").isEmpty
        ?Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  nameController.clear();
                  newplaylist(context, formKey);
                },
                child: const Icon(
                  Icons.add_box_outlined,
                  size: 50,
                  color: Colors.black,
                ),
              ),
              const Text(
                "Add Playlist",
                style: TextStyle(color: Colors.black),
              )
            ],
          ),
        )
        :PlaylistGridView(
          musicList: musicList),
      ),
    );
       },
    );
  }
}

//new
Future newplaylist(BuildContext context, formKey) {
  return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            backgroundColor: Colors.black,
            children: [
              const SimpleDialogOption(
                  child: Text(
                "New create  Playlist",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              )),
              const SizedBox(
                height: 10,
              ),
              SimpleDialogOption(
                  child: Form(
                    key: formKey,
                child: TextFormField(
                  controller: nameController,
                  maxLength: 25,
                  decoration: InputDecoration(
                      counterStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(25)),
                      contentPadding: const EdgeInsets.only(left: 15, right: 5)),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter playlist name";
                    } else {
                      return null;
                    }
                  },
                ),
              )),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SimpleDialogOption(
                    onPressed: (){
                      Navigator.pop(context);
                      nameController.clear();
                      
                    },
                    child: const  Text("Cancel",
                    style:TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500
                    ) ,),
                  ),
                  SimpleDialogOption(
                    onPressed: (){
                      if(formKey.currentState!.validate()){
                      savebutton(context);
                      }  
                    },
                    child:  const Text("Create",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                    ),
                    ),
                  )
                ],
              )
            ],
          )
          );
}

//save

Future<void> savebutton(context)async{
  final name =nameController.text.trim();
  final  music = Music(name,[]);
  final datas =PlaylistDB.playlistDb.values.map((e) => e.name.trim()).toList();// storing string with music name
 if(name.isEmpty){
  return;
 } 
 else if
  (datas.contains(music.name)){
    final snackbar2 =SnackBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      width:MediaQuery.of(context).size.width * 3.5 / 5,
      behavior: SnackBarBehavior.floating,
      duration:  const Duration(milliseconds: 1750),
      backgroundColor: Colors.white,
      content: const Text("Playlist already exist",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black
      ),));
      ScaffoldMessenger.of(context).showSnackBar(snackbar2);
      Navigator.of(context).pop();
  }else{
    PlaylistDB.addPlaylist(music);
    final snackbar5 =SnackBar(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
         width:MediaQuery.of(context).size.width * 3.5 / 5,
         behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 750),
        backgroundColor: Colors.white,
      content:  const Text("Playlist created succesfully ",
      textAlign: TextAlign.center,
      style: TextStyle(color:Colors.black,)));
      ScaffoldMessenger.of(context).showSnackBar(snackbar5);
    Navigator.of(context).pop();
    nameController.clear();
  }
  }
 
