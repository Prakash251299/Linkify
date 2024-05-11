

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
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
          // SongDataController.songList.add(audio as SongModel);
          var audioUrl = await audio.url;
          print(audioUrl);
          // await player.play(UrlSource(audioUrl.toString()));
          await StaticStore.player.setUrl(audioUrl.toString());
          StaticStore.player.play();
          StaticStore.nextPlay=1;





          // await player.play(UrlSource('https://open.spotify.com/track/2FCXQHugkoHE1K3tiDu8pu'));
        }
        catch(e){
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