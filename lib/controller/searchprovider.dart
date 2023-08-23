import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchScreenController extends ChangeNotifier{
  
 List<SongModel> allsongs = [];
List<SongModel> searchSongs = [];
   List<SongModel> results = [];

final OnAudioQuery onAudioQuery = OnAudioQuery();

 Future<void>songLoading() async {
    allsongs = await onAudioQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
    searchSongs=allsongs;
 }
  void updateSearchList(String enteredText) {
    if (enteredText.isEmpty) {
      results = allsongs;
    } else {
      results = allsongs
          .where(
            (element) => element.displayNameWOExt
                .toLowerCase()
                .trim()
                .contains(enteredText.toLowerCase().trim()),
          )
          .toList();
          
    }
        log(results.toString());
    searchSongs = results;
    notifyListeners();

    
  }

 }
 