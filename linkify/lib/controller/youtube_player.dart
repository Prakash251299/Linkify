

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';


class YoutubeSongPlayer{
  AudioPlayer player = AudioPlayer();
  Future<void> youtubePlay(String songName) async {
    if(songName!=""){
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
          await player.setUrl(audioUrl.toString());
          player.play();





          // await player.play(UrlSource('https://open.spotify.com/track/2FCXQHugkoHE1K3tiDu8pu'));
        }
        catch(e){
          print("e");
        }
      }
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