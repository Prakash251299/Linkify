import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:just_audio/just_audio.dart';

class SongPlayerController extends GetxController{
  static var player = AudioPlayer();
  static var playing = false;
  static var paused = false;
  static var completed = false;

  // void initState() {
  //   print("heeee");
  //   this.initState();
  // }



  Future<void> playLocalSong(String url) async {
    playing = true;
    completed = false;
    if(paused==true){
      player.seek(Duration(milliseconds:player.position.inMilliseconds)); // For resuming
      player.play();
      paused = false;
      // .then((value) => playing = false);
      // playing = false;
    }else{
      await player.setAudioSource(AudioSource.uri(Uri.parse(url)));
      // player.seek(Duration(milliseconds:player.position.inMilliseconds));
      player.play();
      // .then((value) => playing = false);
      // playing = false;
    }
    // paused=false;
  }

  Future<void> pauseLocalSong() async {
    player.pause();
    paused = true;
    playing = false;
    completed = false;
  }

  Future<void> stopLocalSong() async {
    player.stop();
    playing = false;
    completed = false;
  }


  @override
  void dispose() {
    player.stop();
    player.dispose();
    super.dispose();
  }


}