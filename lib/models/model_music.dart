

import 'package:hive_flutter/hive_flutter.dart';

part 'model_music.g.dart';

@HiveType(typeId: 1)
class Music extends HiveObject {
  Music(
     this.name,
     this.songId
  );
  @HiveField(0)
  String name;

  @HiveField(1)
  List<int> songId ;
add(int id)  {
    songId.add(id);
    save();
  }
   deleteData(int id) {
    songId.remove(id);
    save();
  
  }

  bool isValueIn(int id) {
    return songId.contains(id);
  }
  
}


