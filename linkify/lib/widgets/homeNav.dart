

import 'package:flutter/material.dart';
import 'package:linkify/controller/song_data_contoller.dart';
import 'package:linkify/widgets/homepage.dart';

class HomeNav extends StatefulWidget {
  const HomeNav({super.key});

  @override
  State<HomeNav> createState() => _HomeNavState();
}

class _HomeNavState extends State<HomeNav> {

  SongDataController songDataController = SongDataController();

  void loadMusic() async {
    try {
      await songDataController.getLocalSongs();
      setState(() {
        SongDataController.loaded = true;
      });
    } catch (e) {
      print("Nothing found");
    }
  }

  void initState(){
    if(!SongDataController.loaded){
      loadMusic();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Homepage();
  }
}