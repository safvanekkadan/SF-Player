import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music/models/model_music.dart';

import 'screen/splash/splash_screen.dart';

void main() async{
  await JustAudioBackground.init(
  androidNotificationChannelId: "com.ryanheise.bg_demo.channel.audio",
  androidNotificationChannelName: "Music playback",
  androidNotificationOngoing: true,
  );
 WidgetsFlutterBinding.ensureInitialized();
  if(!Hive.isAdapterRegistered(MusicAdapter().typeId)){
    Hive.registerAdapter(MusicAdapter());
  }
  await Hive.initFlutter();
  await Hive.openBox<int>("FavouriteDB");
  await Hive.openBox<Music>('playlistDb');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music',
      theme: ThemeData(
        useMaterial3: true,
       visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SplashScreen(),
    );
  }
}

