

import 'dart:io';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
// import 'package:audioplayers/audioplayers.dart';

import 'package:linkify/controller/local_songs/song_data_contoller.dart';
import 'package:linkify/controller/static_store.dart';

class SongPlayerController extends GetxController{
  static var player = AudioPlayer();
  // var playing = false;
  static RxBool playing = false.obs;
  // var totalTime = 0.obs;
  // var currentTime = 0;
  static var currentTime = Duration(seconds:0).obs;
  static var totalTime = Duration(seconds:0).obs;
  static var paused = false;

  var completed = false;
  static RxString songName = SongDataController.songList[SongDataController.currSong].title.obs;

  // void initState() {
  //   print("heeee");
  //   this.initState();
  // }



  static Future<void> updatePosition()async{
    try{
      StaticStore.player.durationStream.listen((d) {
        totalTime.value = d!;
        // print(totalTime.value);
      });
      StaticStore.player.positionStream.listen((p) {
        // currentTime = p.toString().split(".")[0];
        currentTime.value = p;
        // print(currentTime.value);
      });
    }
    catch(e){
      print("SongDataController error while updatePositon() is called");
    }

  }

  Future<int> playLocalSong(String url,String? artists,String songName) async {
    File(url);
    try{
    StaticStore.player.setAudioSource(AudioSource.uri(
        // Uri.parse(songUrl),
        // Uri.fromFile('')),

        Uri.parse(url),
        tag: MediaItem(
        // Specify a unique ID for each media item:
        id: '1',
        artist: artists,
        title: songName,
        artUri: null,
      ),
      ));
      StaticStore.player.play().then((value) {
        StaticStore.currentSong = songName;
        StaticStore.currentArtists = [artists];
        StaticStore.currentSongImg = "";
        StaticStore.playing=true;
        StaticStore.pause=false;
      });
    }catch(e){
      print("Song format is not appropriate");
      return 0;
    }
    return 1;
  }

  Future<void> pauseLocalSong() async {
    await StaticStore.player.pause();
    // paused = true;
    // StaticStore.pause = true;
    // StaticStore.playing = false;
  }

  Future<void> stopLocalSong() async {
    await StaticStore.player.stop().then((value) {

    // StaticStore.pause = false;
    // StaticStore.playing = false;
    });
  }

  Future<void> resumeLocalSong() async {
    StaticStore.player.play();
    // StaticStore.pause = false;
    // StaticStore.playing = true;
  }


  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }


}