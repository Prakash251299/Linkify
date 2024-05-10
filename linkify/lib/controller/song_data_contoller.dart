

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/state_manager.dart';
import 'package:linkify/controller/songPlayerController.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class SongDataController extends GetxController{
  final audioQuery = OnAudioQuery();
  // RxList<SongModel> songList = <SongModel>[].obs;
  static var songList = <SongModel>[].obs;
  static var loaded = false;
  static RxInt currSong = 0.obs; // static variable stores variable value in local cache, so state iis preserved
  // static var loginHandler = 0;



  // Future<RxList<SongModel>> getLocalSongs()async{
  Future<int> getLocalSongs()async{
    // print("hi");

    // if (platform == TargetPlatform.android) {
      // var androidInfo = await DeviceInfoPlugin().androidInfo;
      // print(androidInfo);
      // print(androidInfo.version.sdkInt);
    // }

    int a = await getPermission();
    if(a==1){
      await read();
      // await SongPlayerController.updatePosition();
      SongDataController.loaded = true;
      return 1;
    }
    // print(Permission.values);
    return 0;
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
  }


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