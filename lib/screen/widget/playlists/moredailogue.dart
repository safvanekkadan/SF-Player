import 'package:flutter/material.dart';
import 'package:music/functions/playlistdb/playlist.dart';
import 'package:music/models/model_music.dart';

Future moredialogplaylist(
  
    context,
    index,
    musicList,
    formkey,
    playlistnamectrl,
    Music
    data) {
  return showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
            contentPadding: const EdgeInsets.only(top: 10, bottom: 8),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            backgroundColor: Colors.black,
            children: [
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop();
                  playlistnamectrl.clear();
                  editplaylist(index, context, formkey, playlistnamectrl, data,);
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.edit,
                      color: Colors.indigo,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      "Edit playlist Name",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop();
                  showDialogFunc(
                    context,
                    musicList,
                    index,
                  );
                },
                child: const Row(
                  children: [
                    Icon(Icons.delete, color: Colors.red),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      "Delete",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              )
            ],
          ));
}

Future<dynamic> showDialogFunc(context, musicList, index) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: const Text(
            "Delete playlist",
            style: TextStyle(
                color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600),
          ),
          content: const Text(
            "Are you sure you want  this delete playlist",
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "No",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )),
            TextButton(
                onPressed: () {
                  musicList.deleteAt(index);
                  Navigator.pop(context);
                  final snackBar = SnackBar(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      width: MediaQuery.of(context).size.width * 3.5 / 5,
                      backgroundColor: Colors.white,
                      content: const Text(
                        "Playlist deleted",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black),
                      ),
                      duration: const Duration(milliseconds: 500));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: const Text(
                  "Yes",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ))
          ],
        );
      });
}
Future editplaylist(index, context, formkey, playlistnamectrl, Music data) {
  playlistnamectrl = TextEditingController(text: data.name);
  return showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            backgroundColor: Colors.black,
            children: [
              const SimpleDialogOption(
                child: Text(
                  "Edit Playlist Name",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              SimpleDialogOption(
                child: Form(
                  key: formkey,
                  child: TextFormField(
                    maxLength: 15,
                    controller: playlistnamectrl,
                    decoration: InputDecoration(
                        fillColor: Colors.grey,
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(25)),
                        contentPadding: const EdgeInsets.only(left: 15, right: 5)),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter your playlist name";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SimpleDialogOption(
                    onPressed: () {
                      updateplaylistname(index, formkey, playlistnamectrl);
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Update',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          ),
          );
}



void updateplaylistname(index, formkey, playlistnamectrl) {
  if (formkey.currentState!.validate()) {
    final names = playlistnamectrl.text.trim();
    if (names.isEmpty) {
      return;
    } else {
      // changed
      final playlistname = Music( names, []);
      PlaylistDB.editList(index, playlistname);
    }
  }
}
