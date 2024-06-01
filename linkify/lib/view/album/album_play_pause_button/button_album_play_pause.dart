import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:linkify/controller/variables/static_store.dart';
import 'package:linkify/controller/player/youtube_player.dart';
import 'package:linkify/model/album_track.dart';
import 'package:linkify/view/sticky/sticky_widgets.dart';

Future<void> playMine() async {
  YoutubeSongPlayer _player = YoutubeSongPlayer();
  if (StaticStore.nextPlay == 1) {
          StaticStore.nextPlay = 0;
          // }
          StaticStore.queueIndex++;
          if (StaticStore.queueIndex <= StaticStore.myQueueTrack.length - 1) {
            // setState(() {
            // });
            await _player.youtubeStop().then((value) async {
              // if(StaticStore.queueIndex>=StaticStore.myQueueTrack.length){
              //   StaticStore.queueIndex--;
              //   return;
              // }
    
              await _player
                  .youtubePlay(
                      StaticStore.myQueueTrack[StaticStore.queueIndex].name,
                      StaticStore
                          .myQueueTrack[StaticStore.queueIndex].trackArtists?[0])
                  .then((value) {
                StaticStore.currentSong =
                    StaticStore.myQueueTrack[StaticStore.queueIndex].name!;
                StaticStore.currentArtists =
                    StaticStore.myQueueTrack[StaticStore.queueIndex].trackArtists??[];
                StaticStore.currentSongImg =
                    StaticStore.myQueueTrack[StaticStore.queueIndex].imgUrl!;
                StaticStore.playing = true;
                StaticStore.pause = false;
              });
            });
            // setState(() {});
          } else {
            StaticStore.queueIndex--;
            StaticStore.nextPlay = 1;
          }
        }
}
Widget playPauseAlbumButton(List<AlbumTrack>? _albumTracks,int position){
  return StreamBuilder<Object>(
    stream: StaticStore.player.playerStateStream,
    builder: (context, snapshot) {
      if(StaticStore.player.processingState==ProcessingState.completed){
        playMine();
        return Icon(Icons.play_arrow,color: Colors.grey,);
      }
      return _albumTracks?[position].name!=StaticStore.currentSong?Icon(Icons.play_arrow,color: Colors.grey,):StaticStore.playing == true?Icon(Icons.pause,color: Colors.white,):Icon(Icons.play_arrow,color: Colors.yellow,);
    }
  );
}


Widget playPauseAlbumButtonTop(List<AlbumTrack>? _albumTracks,int position){
  return StreamBuilder<Object>(
    stream: StaticStore.player.playerStateStream,
    builder: (context, snapshot) {
      if(StaticStore.player.processingState==ProcessingState.completed){
        playMine();
        return Icon(Icons.play_circle,size:49,color: Colors.grey,);
      }
      // _albumTracks!=null?
      if(_albumTracks==null){
        return Icon(Icons.play_circle,size:49,color:Colors.white);
      }
      var condition = false;
      // condition = _albumTracks.contains(StaticStore.currentSong);
      for(int i=0;i<_albumTracks.length;i++){
        if(_albumTracks[i].name==StaticStore.currentSong){
          condition = true;
          break;
        }
      }
      // print("Contains: $condition");
      // return condition==true?Icon(Icons.pause,size:49,color: Colors.green,):Icon(Icons.play_circle,size:49,color: Colors.white,);
      return condition==true?(StaticStore.playing==true?Icon(Icons.pause,size:49,color: Colors.green,):Icon(Icons.play_circle,size:49,color: Colors.green,)):Icon(Icons.play_circle,size:49,color: Colors.white,);




      // return _albumTracks?[position].name!=StaticStore.currentSong?Icon(Icons.play_circle,size:49,color: Colors.grey,):StaticStore.playing == true?Icon(Icons.pause,size:49,color: Colors.white,):Icon(Icons.play_circle,size:49,color: Colors.yellow,);
    }
  );
}