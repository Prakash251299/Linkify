import 'package:flutter/material.dart';
// import 'package:http/http.dart';
import 'package:just_audio/just_audio.dart';
import 'package:linkify/controller/local_storing/read_write.dart';
import 'package:linkify/controller/variables/static_store.dart';
import 'package:linkify/controller/Authorization/webview.dart';
import 'package:linkify/controller/player/youtube_player.dart';
import 'package:linkify/main.dart';

Future<void> callSignOutApi(context)async{
  ReadWrite _readWrite = ReadWrite();
  YoutubeSongPlayer _player = YoutubeSongPlayer();
  try {
    // var a = await get(Uri.parse('https://accounts.spotify.com/en/logout'));
    // print("logoutStatuscode: ${a.statusCode}");

    await _readWrite.writeAccessToken("");
    // await _readWrite.writeRefreshToken("");
    await _player.youtubeStop();
    await deleteAllStaticData();
    Navigator.pushAndRemoveUntil<void>(
      context,
      MaterialPageRoute<void>(builder: (BuildContext context) => WebContainer()),
      ModalRoute.withName('/'),
    );
    return ;
  } catch (e) {
    print("Error while login after logout");
  }
}

Future<void> deleteAllStaticData()async{
  StaticStore.trackInfo=[
    [],
    [],
    [],
    [],
    [],
    []
  ];
  StaticStore.userGenre=null;
  StaticStore.dateStored = "1-1-2024";
  StaticStore.dateStored2 = "1-1-2024";
  StaticStore.carouselInd = -10;
  StaticStore.playingCarouselInd = -10;
  StaticStore.playing = false;
  StaticStore.currentSong = "";
  StaticStore.currentSongImg = "";
  StaticStore.currentArtists = [];
  StaticStore.pause = false;
  StaticStore.player = AudioPlayer();
  StaticStore.musicScreenEnabled = false;
  StaticStore.userSelectedArtists=""; // this string is comma separated artists name
  StaticStore.currentUserGenreId="";
  StaticStore.currentUserId="";
  StaticStore.currentUserName="";
  StaticStore.currentUserEmail="";
  StaticStore.currentUserCountry="";
  StaticStore.currentUserImage=[];
  StaticStore.videoPlayingIndex = -1;
  StaticStore.categoryInfo=[];
  StaticStore.myQueueTrack=[];
  StaticStore.queueIndex = 0;
  StaticStore.queueLoaded = 0;
  StaticStore.nextPlay=1;
  StaticStore.screen = 0;
  StaticStore.requestStatusValue=[];
  StaticStore.userGenreWithCount = null;
}