

import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:linkify/controller/notification_player.dart/background.dart';
import 'package:linkify/controller/notification_player.dart/play_song.dart';
import 'package:linkify/controller/static_store.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';



class YoutubeSongPlayer{
  // AudioPlayer player = AudioPlayer();
  Future<void> youtubePlay(String? songName,String artist) async {
    if(songName==null){
      print("Song name is not given to youtube play function");
      return;
    }
    if(songName!=""){
      // await initializeService();
      songName+=" $artist lyrical";
      // songName+=" lyrics";
        try{
          final yt = YoutubeExplode();
          // final querySuggestions = (await yt.search.getQuerySuggestions(songName)).first;
          final video = (await yt.search.search(songName)).first;
          // print(video);
          final videoId = video.id.value;
          var manifest = await yt.videos.streamsClient.getManifest(videoId);
          var audio = await manifest.audioOnly.first;
          var audioUrl = await audio.url;
          print(audioUrl);



          playSong(audioUrl);
          // StaticStore.player.

          // await StaticStore.player.setUrl(audioUrl.toString());
          // StaticStore.player.play();
          StaticStore.nextPlay=1;





        }
        catch(e){
          print("Error: $e");
          print("Youtube player can't play songs");
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