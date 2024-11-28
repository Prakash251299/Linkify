// my api key:- AIzaSyBERpvDh6R8JMFdBowOTgdqLRKIgXutzBk


import 'dart:convert';
// import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:linkify/controller/notification/background.dart';
import 'package:linkify/controller/player/play_song.dart';
import 'package:linkify/controller/variables/static_store.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
// import 'package:http/http.dart' as http;
// import 'package:html/dom.dart' as dom;



class YoutubeSongPlayer{
  Future<void> youtubePlay(String? songName,String artist) async {
    if(songName==null){
      print("Song name is not given to youtube play function");
      return;
    }
    if(songName!=""){
      songName+=" $artist lyrical";
        try{
          final yt = YoutubeExplode();
          final video = (await yt.search.search(songName)).first;
          final videoId = video.id.value;
          var manifest = await yt.videos.streams.getManifest(videoId);
          var audio = await manifest.audioOnly.first;
          var audioUrl = await audio.url;
          playSong(audioUrl);
          StaticStore.nextPlay=1;
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