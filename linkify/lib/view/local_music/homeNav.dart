

import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:linkify/controller/local_songs/get_local_songs/permission/permission_handler.dart';
import 'package:linkify/view/local_music/homepage.dart';
import 'package:linkify/view/local_music/local_songs.dart';
import 'package:on_audio_query/on_audio_query.dart';
// import 'package:linkify/widgets/uis/models/song_model.dart';

class HomeNav extends StatefulWidget {
  List<SongModel> localSongs=[];
  HomeNav(this.localSongs,{super.key});

  @override
  State<HomeNav> createState() => _HomeNavState();
}

class _HomeNavState extends State<HomeNav> {

  SongDataController songDataController = SongDataController();
  // RxList<SongModel> songList = <SongModel>[].obs;

  // void loadMusic() async {
  //   try {
  //     await songDataController.getLocalSongs();
  //     setState(() {
  //       SongDataController.loaded = true;
  //     });
  //   } catch (e) {
  //     print("Nothing found");
  //   }
  // }

  void initState(){
    if(!SongDataController.loaded){
      // loadMusic();
      // songList = SongDataController.songList
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print()
    // return Homepage(widget.localSongs);
    return LocalSongList(songList: widget.localSongs);
  }
}