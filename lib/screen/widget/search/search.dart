
import 'package:flutter/material.dart';
import 'package:music/controller/searchprovider.dart';


import 'package:provider/provider.dart';

import '../../home/home_screen.dart';
import '../../lists/listview/listview.dart';

class ScreenSearch extends StatelessWidget {
  const ScreenSearch({super.key});

  
  @override
  Widget build(BuildContext context) {
 Provider.of<SearchScreenController>(context,listen: false).songLoading();
  
        return Consumer<SearchScreenController>(
         
          builder: (context,searchProvider,child) {
//  searchProvider.songLoading();
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
                  onChanged: (value) =>searchProvider.updateSearchList(value),
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
              body: searchProvider.searchSongs.isEmpty ?
               const Center(
                      child: Text(
                        'No Songs',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    )

                  : ScreenListView(songModel: searchProvider.searchSongs)
                  
            );
          }
        );
      }
}

 

