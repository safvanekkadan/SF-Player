import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music/controller/favouritecontroller.dart';
import 'package:music/controller/providerhomescreen.dart';
import 'package:music/controller/recentlycontroller.dart';
import 'package:music/controller/searchprovider.dart';
// import 'package:just_audio_background/just_audio_background.dart';
import 'package:music/models/model_music.dart';
import 'package:provider/provider.dart';

import 'screen/splash/splash_screen.dart';

Future<void>main()async{
  // await JustAudioBackground.init(
  // androidNotificationChannelId: "com.ryanheise.bg_demo.channel.audio",
  // androidNotificationChannelName: "Music playback",
  // androidNotificationOngoing: true,
  // );
 WidgetsFlutterBinding.ensureInitialized();
  if(!Hive.isAdapterRegistered(MusicAdapter().typeId)){
    Hive.registerAdapter(MusicAdapter());
  }
  await Hive.initFlutter();
  await Hive.openBox<int>("FavoriteDB");
  await Hive.openBox<Music>('playlistDb');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeScreenController(),),
        ChangeNotifierProvider(create: (context) => SearchScreenController(),),
        ChangeNotifierProvider(create: (context) => RecentlyPlayerController(),),
       ChangeNotifierProvider(create: (context) => FavouriteController(),),
      ],
    
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Music',
        theme: ThemeData(
          useMaterial3: true,
         visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

