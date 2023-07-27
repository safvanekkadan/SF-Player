import 'package:flutter/material.dart';
import 'package:music/screen/home/home_screen.dart';
import 'package:music/screen/lists/listview/listview.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ScreenSearch extends StatefulWidget {
  const ScreenSearch({super.key});

  @override
  State<ScreenSearch> createState() => _ScreenSearchState();
}

List<SongModel> allsongs = [];
List<SongModel> searchSongs = [];
final OnAudioQuery onAudioQuery = OnAudioQuery();


class _ScreenSearchState extends State<ScreenSearch> {
  @override
  void initState() {
    songLoading();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
        backgroundColor:Colors.white,
        leading: IconButton(
          onPressed: () {
           Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const HomeScreen()));
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: TextField(
          textAlign: TextAlign.start,
          onChanged: (value) => updateSearchList(value),
          style: const TextStyle(color:Colors.black, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            hintText: 'Search Songs',
            hintStyle: const TextStyle(color: Colors.black),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
      body: searchSongs.isNotEmpty
          ? ScreenListView(songModel: searchSongs)
          : const Center(
              child: Text(
                'No Songs',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
    );
  }

  void songLoading() async {
    allsongs = await onAudioQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
    setState(() {
      searchSongs = allsongs;
    });
  }

  void updateSearchList(String enteredText) {
    List<SongModel> results = [];
    if (enteredText.isEmpty ) {
      results = allsongs;
    } else {
      results = allsongs
          .where(
            (element) => element.displayNameWOExt.toLowerCase().trim().contains(
                  enteredText.toLowerCase().trim(),
                ),
          )
          .toList();
    }
    setState(() {
      searchSongs = results;
    });
  }
 
 
}
