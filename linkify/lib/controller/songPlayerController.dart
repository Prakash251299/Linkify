

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:just_audio/just_audio.dart';
// import 'package:audioplayers/audioplayers.dart';

import 'package:linkify/controller/song_data_contoller.dart';

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
  static RxString songName = SongDataController.songList[SongDataController.currSong.value].title.obs;

  // void initState() {
  //   print("heeee");
  //   this.initState();
  // }



  static Future<void> updatePosition()async{
    try{
      player.durationStream.listen((d) {
        totalTime.value = d!;
        // print(totalTime.value);
      });
      player.positionStream.listen((p) {
        // currentTime = p.toString().split(".")[0];
        currentTime.value = p;
        // print(currentTime.value);
      });
    }
    catch(e){
      print("SongDataController error while updatePositon() is called");
    }

  }



  Future<void> playLocalSong(String url) async {
    playing.value = true;
    completed = false;
    if(paused==true){
      // player.seek(Duration(milliseconds:player.position.inMilliseconds)); // For resuming
      paused = false;
      try{
        player.play();
        // print(player.duration);
        await updatePosition();
      }
      catch(e){
        // SongDataController.currSong = (SongDataController.currSong+1)%SongDataController.songList.length;
        // playLocalSong(SongDataController.songList[SongDataController.currSong].data);
      }
      // .then((value) => playing = false);
      // playing = false;
    }else{
      try{
        await player.setAudioSource(AudioSource.uri(Uri.parse(url)));
        // player.seek(Duration(milliseconds:player.position.inMilliseconds));
        player.play();
        await updatePosition();
        // .then((value) => playing = false);
        // playing = false;
      }
      catch(e){
        // playing.value = false;
      }
    }
    // paused=false;
  }

  Future<void> pauseLocalSong() async {
    player.pause();
    paused = true;
    playing.value = false;
    completed = false;
  }

  Future<void> stopLocalSong() async {
    player.stop();
    playing.value = false;
    completed = false;
  }


  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }


}