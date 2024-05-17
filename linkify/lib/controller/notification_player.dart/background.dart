import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:just_audio/just_audio.dart';
import 'package:linkify/controller/static_store.dart';
import 'package:linkify/controller/youtube_player.dart';

Future<void> initializeService()async{
  final service=FlutterBackgroundService();
  await service.configure(
    iosConfiguration: IosConfiguration(
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
    androidConfiguration: AndroidConfiguration(onStart: onStart, isForegroundMode: true,autoStart: true)
  );
}


@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service)async{
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
void onStart(ServiceInstance service){
  DartPluginRegistrant.ensureInitialized();
  if(service is AndroidServiceInstance){
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });
    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }
    service.on('stopService').listen((event) {
      service.stopSelf();
    });
    Timer.periodic(const Duration(seconds: 1),(timer)async{
      if(service is AndroidServiceInstance){
        // service.
        if(await service.isForegroundService()){

          service.setForegroundNotificationInfo(
            // title: "Ishu",
            title: "Hello",
            content: "How are yuh bro!",
          );
          // Container(
          //   // height: 20,
          //   // width: 20,
          //   child: Text("FKdkfjk"),
          //   color:Colors.red,
          // );
        }
      }
      print("Background service running");
      // YoutubeSongPlayer _player = YoutubeSongPlayer();
      // if(StaticStore.player.playing){
      //   print("background calling song completed");
      // }
      // _player.youtubePlay(songName, artist)
      service.invoke('update');
    });
  
}