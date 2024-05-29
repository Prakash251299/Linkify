import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:linkify/controller/local_songs/songPlayerController.dart';
import 'package:linkify/controller/static_store.dart';
import 'package:linkify/widgets/album_play_pause_button/button_album_play_pause.dart';
import 'package:linkify/widgets/carousel_song_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

Widget playPauseAlbumButton(List<SongModel> _albumTracks, int position) {
  return StreamBuilder<Object>(
      stream: StaticStore.player.playerStateStream,
      builder: (context, snapshot) {
        if (StaticStore.player.processingState == ProcessingState.completed) {
          // playMine();
          return Icon(
            Icons.play_arrow,
            color: Colors.grey,
          );
        }
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
      await _songPlayerController.playLocalSong(songList[index].data,songList[index].artist,songList[index].uri,name).then((value) {
        StaticStore.currentArtists = [songList[index].artist];
        StaticStore.currentSong = name;
        StaticStore.playing = true;
        StaticStore.pause = false;
      });
      Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CarouselSongScreen(
                name,
                "",
                [songList[index].artist],
                ""
                )));
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

      await _songPlayerController.playLocalSong(
        songList[index].data,songList[index].artist,songList[index].uri,name)
          .then((value) {
        // });
        // StaticStore.myQueueTrack = widget._albumTracks!;
        // StaticStore.queueLoaded = 1;
        // StaticStore.queueIndex = index;
        StaticStore.currentArtists = [songList[index].artist];
        StaticStore.currentSong = name;
        // StaticStore.currentSongImg = widget._albumTracks![index].imgUrl!;
        // StaticStore.currentArtists =
        //     List.from(widget._albumTracks![index].trackArtists);
        StaticStore.playing = true;
        StaticStore.pause = false;

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CarouselSongScreen(
                name,
                "",
                [songList[index].artist],
                ""
                )));
      });
    });
    }
  }
}
