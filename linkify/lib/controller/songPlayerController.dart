import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:just_audio/just_audio.dart';

class SongPlayerController extends GetxController{
  var player = AudioPlayer();
  var playing = false;
  var paused = false;

  // void initState() {
  //   print("heeee");
  //   this.initState();
  // }



  Future<void> playLocalSong(String url) async {
    playing = true;
    if(paused==true){
      player.seek(Duration(milliseconds:player.position.inMilliseconds)); // For resuming
      player.play();
    }else{
      await player.setAudioSource(AudioSource.uri(Uri.parse(url)));
      // player.seek(Duration(milliseconds:player.position.inMilliseconds));
      player.play();
    }
    paused=false;
  }

  Future<void> pauseLocalSong() async {
    player.pause();
    paused = true;
    playing = false;
  }

  @override
  void dispose() {
    player.stop();
    player.dispose();
    super.dispose();
  }


}