// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'dart:io';

import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';


import 'dart:io' as io;

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_file_manager/flutter_file_manager.dart';
// import 'package:path_provider_ex/path_provider_ex.dart';

class SongDataController extends GetxController{
  final audioQuery = OnAudioQuery();
  // RxList<SongModel> songList = <SongModel>[].obs;
  final songList = <SongModel>[].obs;



  Future<RxList<SongModel>> getLocalSongs()async{
    print("hi");
    await getPermission();
    return songList;
  }

/* Readin file */
  Future<void> read() async {
    songList.value = await audioQuery.querySongs(
      ignoreCase: false,
      orderType: OrderType.ASC_OR_SMALLER,
      sortType: null,
      uriType: UriType.EXTERNAL,
      // uriType: UriType.INTERNAL,
    );
    for(int i=0;i<songList.length;i++){
      if(songList.value[i].fileExtension=="mp3"){
        print(songList.value[i].fileExtension);
        print(songList.length);
      }
    }
    // print(songList.value[0].fileExtension);
  }

  /* Getting permission */
  Future<void> getPermission() async {
    try{
      var perm = await Permission.storage.request();
      if(perm.isGranted){
        print("permission granted");
        await read();
      }else{
        print("Permission denied");
      }
    }
    catch(e){
      print("Error");
    }
  }
}