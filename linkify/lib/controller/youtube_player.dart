

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:linkify/controller/static_store.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';


class YoutubeSongPlayer{
  // static AudioPlayer player = AudioPlayer();
  Future<void> youtubePlay(String songName,String artist) async {
    if(songName!=""){
      songName+=" $artist lyrics";
      // songName+=" lyrics";
        try{
          final yt = YoutubeExplode();
          // final querySuggestions = (await yt.search.getQuerySuggestions(songName)).first;
          final video = (await yt.search.search(songName)).first;
          // print(video);
          final videoId = video.id.value;
          var manifest = await yt.videos.streamsClient.getManifest(videoId);
          var audio = await manifest.audioOnly.first;
          // SongDataController.songList.add(audio as SongModel);
          var audioUrl = await audio.url;
          print(audioUrl);
          // await player.play(UrlSource(audioUrl.toString()));
          await StaticStore.player.setUrl(audioUrl.toString());
          StaticStore.player.play();





          // await player.play(UrlSource('https://open.spotify.com/track/2FCXQHugkoHE1K3tiDu8pu'));
        }
        catch(e){
          print("e");
        }
      }
  }
  Future<void> youtubePause() async {
    StaticStore.player.pause();
  }
  Future<void> youtubeStop() async {
    StaticStore.player.stop();
  }
  Future<void> youtubeResume() async {
    StaticStore.player.play();
  }

}


// class YoutubeSongPlayer extends StatelessWidget{
//   AudioPlayer player = AudioPlayer();
//   // import 'package:just_audio/just_audio.dart';

// // final player = AudioPlayer();                   // Create a player
// // final duration = await player.setUrl(           // Load a URL
// //     'https://foo.com/bar.mp3');                 // Schemes: (https: | file: | asset: )
// // player.play();   
//   Future<void> playUrl()async{
//     var videoId = "";

//     // var audio = await manifest.audioOnly.first;
//     // var audio = await videoId.audioOnly.first;
//     // var audioid = await audio.audioOnly.first;
//     //  await player.play(UrlSource("https://www.youtube.com/watch?v=BBAyRBTfsOU"));
//   }
//   Widget build(BuildContext context){
//     return Container();
//   }
// }