// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'dart:io';

// import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';
// import 'dart:js';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linkify/widgets/homepage.dart';
import 'package:on_audio_query/on_audio_query.dart';


// import 'dart:io' as io;

// import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_file_manager/flutter_file_manager.dart';
// import 'package:path_provider_ex/path_provider_ex.dart';

class SongDataController extends GetxController{
  final audioQuery = OnAudioQuery();
  // RxList<SongModel> songList = <SongModel>[].obs;
  static var songList = <SongModel>[].obs;
  static var currSong = 0; // static variable stores variable value in local cache, so state iis preserved
  // static var loginHandler = 0;



  Future<RxList<SongModel>> getLocalSongs()async{
    // print("hi");

    // if (platform == TargetPlatform.android) {
      // var androidInfo = await DeviceInfoPlugin().androidInfo;
      // print(androidInfo);
      // print(androidInfo.version.sdkInt);
    // }

    // await getPermission();
    await read();
    // print(Permission.values);
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
    
    // for(int i=0;i<songList.length;i++){
    //   if(songList.value[i].fileExtension=="mp3"){
    //     print(songList.value[i].fileExtension);
    //     print(songList.length);
    //   }
    // }



    // print(songList.value[0].fileExtension);
  }

  /* Getting permission */

  // Future<void> getPermission() async {
    // // if (platform == TargetPlatform.android) {
      // var androidInfo = await DeviceInfoPlugin().androidInfo;
      // if (androidInfo.version.sdkInt >= 33) return;
      // final status = await Permission.storage.status;
      // if (status != PermissionStatus.granted) {
      //   final result = await Permission.storage.request();
      //   if (result == PermissionStatus.granted) {
      //     await read();
      //     return;
      //   }
      // } else {
      //   await read();
      //   return;
      // }
  //   // } else {
  //   //   return true;
  //   // }
  //   // return;
  // }


  // Future<void> getPermission2() async {
  //       try{
  //         // await read();
  //         // final status = await Permission.manageExternalStorage.status;
  //         final status = await Permission.audio.status;
  //         if (status != PermissionStatus.granted) {
  //           if(status==PermissionStatus.permanentlyDenied){
  //             openAppSettings();
  //             await read();
  //             return;
  //           }else{
  //             var request = await Permission.audio.request();
  //             if(request.isGranted==true){
  //               await read();
  //             }else{
  //               openAppSettings();
  //             }
  //           }
  //         }else{
  //           await read();
  //         }
  //       }catch(e){
  //         await openAppSettings();
  //         await read();
  //       }
  // }



  // Future<void> getPermission1() async {
  //   var androidInfo = await DeviceInfoPlugin().androidInfo;
  //   try{
  //     if(androidInfo.version.sdkInt<33){
  //       final status = await Permission.storage.status;
  //       Permission.audio.status;
  //       if (status != PermissionStatus.granted) {
  //         if(status==PermissionStatus.permanentlyDenied){
  //           openAppSettings();
  //           await read();
  //           return;
  //         }
  //         final result = await Permission.storage.request();
  //         if (result == PermissionStatus.granted) {
  //           await read();
  //         }
  //       } else {
  //         await read();
  //       }
  //     }
  //     else{
  //       // final status = await Permission.manageExternalStorage.status;
  //       // if (status != PermissionStatus.granted) {
  //       //   final result = await Permission.manageExternalStorage.request();
  //       //   if (result == PermissionStatus.granted) {
  //           await read();
  //       //   }
  //       // } else {
  //       //   await read();
  //       // }
  //     }




  //     // var perm = await Permission.manageExternalStorage.request();
  //     // // var perm = await Permission.storage.request();
  //     // if(perm.isGranted){
  //     // // if(await Permission.manageExternalStorage.request().isGranted==true){
  //     // // if(await Permission.manageExternalStorage.isGranted){
  //     //   print("permission granted");
  //     //   await read();
  //     // }else{
  //     //   // print("Permission denied");
  //     // }
  //   }
  //   catch(e){
  //     print("Error");
  //   }
  // }






  Future<int> getPermission() async {
    try{
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      // final status = await Permission.audio.status;
      // var a = DeviceInfoPlugin();

      if(androidInfo.version.sdkInt<33){
        final status1 = await Permission.storage.status;
        if(status1 != PermissionStatus.granted){
          if(status1 == PermissionStatus.permanentlyDenied){
            openAppSettings();
            if(await Permission.storage.status==PermissionStatus.granted){
              return 1;
            }else{
              return 0;
            }
          }
          var s = await Permission.storage.request();
          // await openAppSettings();
          if(await Permission.storage.status.isGranted==true){
            return 1;
          }else{
            return 0;
          }
        }
        return 1;
      }else{
        final status = await Permission.audio.status;
        if (status != PermissionStatus.granted) {
          if(status==PermissionStatus.permanentlyDenied){
              await openAppSettings();
              if(await Permission.audio.status==PermissionStatus.granted){
                // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Homepage(),));
                // Navigator.pop();
                return 1;
              }else{
                return 0;
              }
          }else{
            var a = await Permission.audio.request();
            if(a==PermissionStatus.granted){
              return 1;
            }else{
              return 0;
            }
          }
        }
        return 1;
      }
    }
    catch(e){
      return 0;
    }
  }


}