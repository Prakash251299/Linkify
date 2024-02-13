

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class YoutubeSongPlayer extends StatelessWidget{
  AudioPlayer player = AudioPlayer();
  // import 'package:just_audio/just_audio.dart';

// final player = AudioPlayer();                   // Create a player
// final duration = await player.setUrl(           // Load a URL
//     'https://foo.com/bar.mp3');                 // Schemes: (https: | file: | asset: )
// player.play();   
  Future<void> playUrl()async{
    var videoId = "";

    // var audio = await manifest.audioOnly.first;
    // var audio = await videoId.audioOnly.first;
    // var audioid = await audio.audioOnly.first;
    //  await player.play(UrlSource("https://www.youtube.com/watch?v=BBAyRBTfsOU"));
  }
  Widget build(BuildContext context){
    return Container();
  }
}