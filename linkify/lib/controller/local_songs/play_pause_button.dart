import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:linkify/controller/local_songs/songPlayerController.dart';
import 'package:linkify/controller/static_store.dart';
import 'package:linkify/widgets/album_play_pause_button/button_album_play_pause.dart';
import 'package:linkify/widgets/carousel_song_screen.dart';
import 'package:linkify/widgets/local_music/local_song_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

Widget playPauseAlbumButton(List<SongModel> _albumTracks, int position) {
  return StreamBuilder<Object>(
      stream: StaticStore.player.playerStateStream,
      builder: (context, snapshot) {
        // if (StaticStore.player.processingState == ProcessingState.completed) {
        //   // playMine();
        //   print("completed bro");
        //   return Icon(
        //     Icons.play_arrow,
        //     color: Colors.grey,
        //   );
        // }
        return _albumTracks[position].displayName != StaticStore.currentSong
            ? Icon(
                Icons.play_arrow,
                color: Colors.grey,
              )
            : StaticStore.playing == true
                ? Icon(
                    Icons.pause,
                    color: Colors.white,
                  )
                : Icon(
                    Icons.play_arrow,
                    color: Colors.yellow,
                  );
      });
}

Future<void> playPauseLocal(name,List<SongModel> songList,index,context) async {
  SongPlayerController _songPlayerController = SongPlayerController();
  int played=0;
  if (StaticStore.playing == true) {
    if (StaticStore.currentSong==name){
      // if(StaticStore.pause==true){
      //   await _songPlayerController.resumeLocalSong();
      // }else{
        await _songPlayerController.pauseLocalSong();
        // setState(() {
        StaticStore.playing = false;
        StaticStore.pause = true;
      // }
      // });
    } else {
      // print(widget._albumTracks?[index].name);
      try{
      played = await _songPlayerController.playLocalSong(songList[index].data,songList[index].artist,name);
      // .then((value){
      //   StaticStore.currentArtists = [songList[index].artist];
      //   StaticStore.currentSong = name;
      //   StaticStore.playing = true;
      //   StaticStore.pause = false;
      //   return value;
      // });
      played==1?Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => LocalSongScreen(
              songList,
                name,
                "",
                [songList[index].artist],
                ""
                ))):null;
      }catch(e){
        print("error occurred while playing new song, may be song format is not appropriate for the platform");
      }
    }
  } else {
    // if(StaticStore.pause==true){

    // }
    // StaticStore.playing=true;
    // StaticStore.pause=false;
    if (StaticStore.currentSong == name) {
      await _songPlayerController.resumeLocalSong()
      .then((value) {
        StaticStore.playing = true;
        StaticStore.pause = false;
      });
    } else {
      await _songPlayerController.stopLocalSong().then((value) async {

        try{

      played = await _songPlayerController.playLocalSong(
        songList[index].data,songList[index].artist,name);

      //     .then((value) {
      //   StaticStore.currentArtists = [songList[index].artist];
      //   StaticStore.currentSong = name;
      //   StaticStore.playing = true;
      //   StaticStore.pause = false;
      //   return value;
      // }
      // );
        played==1?Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => LocalSongScreen(
              songList,
                name,
                "",
                [songList[index].artist],
                ""
                ))):null;
        }catch(e){
           print("error occurred while playing first song, may be song format is not appropriate for the platform");
        }
    });
    }
  }
}
