import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:linkify/controller/static_store.dart';
import 'package:linkify/controller/youtube_player.dart';
import 'package:linkify/widgets/uis/models/song_model.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:linkify/controller/static_store.dart';
// import 'package:linkify/controller/youtube_player.dart';

class AlbumPlayerButtons extends StatefulWidget {
  // SongModel songs;
  var name;
  var albumImg;
  var trackId;
  var trackArtists;
  var trackImg;
  AlbumPlayerButtons(this.name,
  // this.albumImg,
  this.trackId,this.trackArtists,this.trackImg);
  // const PlayerButtons({super.key});

  @override
  State<AlbumPlayerButtons> createState() => _PlayerButtonsState();
}

class _PlayerButtonsState extends State<AlbumPlayerButtons> {
// class PlayerButtons extends StatelessWidget {
  // SongModel songs;
  // PlayerButtons(this.songs);
  // PlayerButtons(songs, {
  //   Key? key,
  //   required this.songs,
  // }) : super(key: key);

  // final AudioPlayer audioPlayer;
  YoutubeSongPlayer _youtubePlayer = YoutubeSongPlayer();
  var playing = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // StreamBuilder<SequenceState?>(
        //   // stream: audioPlayer.sequenceStateStream,
        //   stream: null,
        //   builder: (context, index) {
        //     return

        IconButton(
                  onPressed: 
                  // SongDataController.loaded ? 
                      () async {
                          if (StaticStore.player.position.inSeconds >
                              10) {
                            await StaticStore.player.seek(Duration(
                                seconds: StaticStore
                                        .player.position.inSeconds -
                                    10));
                          } else {
                            await StaticStore.player
                                .seek(const Duration(seconds: 0));
                          }
                        },
                      // : null,
                  icon: const Icon(Icons.fast_rewind_rounded,color: Colors.white,)),

        IconButton(
          onPressed: () async {
            // print("position");
            // print(StaticStore.player.position);

            if(StaticStore.queueIndex>0){
              // setState(() {
              StaticStore.queueIndex--;
                
              // });
              StaticStore.currentSong = StaticStore.myQueueTrack[StaticStore.queueIndex].name!;
              StaticStore.currentArtists = StaticStore.myQueueTrack[StaticStore.queueIndex].trackArtists;
              StaticStore.currentSongImg = StaticStore.myQueueTrack[StaticStore.queueIndex].imgUrl!;
              await _youtubePlayer.youtubeStop();
              await _youtubePlayer.youtubePlay(StaticStore.myQueueTrack[StaticStore.queueIndex].name,StaticStore.myQueueTrack[StaticStore.queueIndex].trackArtists[0]);
              StaticStore.playing = true;
              StaticStore.pause = false;
            }

          },
          //           // audioPlayer.hasPrevious ? audioPlayer.seekToPrevious : null,
          //       // iconSize: 45,
          iconSize: 45,
          icon: const Icon(
            Icons.skip_previous,
            color: Colors.white,
          ),
        ),
        //   },
        // ),

        // StreamBuilder<PlayerState>(
        //   // stream: audioPlayer.playerStateStream,
        //   stream: null,
        //   builder: (context, snapshot) {
        //     if (snapshot.hasData) {
        //       final playerState = snapshot.data;
        //       final processingState = playerState!.processingState;

        //       if (processingState == ProcessingState.loading ||
        //           processingState == ProcessingState.buffering) {
        //         return Container(
        //           width: 64.0,
        //           height: 64.0,
        //           margin: const EdgeInsets.all(10.0),
        //           child: const CircularProgressIndicator(),
        //         );
        //       } else if (!playing) {
        //         return
        StreamBuilder<Object>(
          stream: StaticStore.player.playerStateStream,
          builder: (context, snapshot) {
            return IconButton(
              onPressed: () async {

                if(StaticStore.playing==true){
                  _youtubePlayer.youtubePause();
                  StaticStore.playing = false;
                  StaticStore.pause = true;
                }else{
                  _youtubePlayer.youtubeResume();
                  StaticStore.playing = true;
                  StaticStore.pause = false;
                }



                // if (StaticStore.playing == false) {
                //   // if(StaticStore.pause==true){
                //   StaticStore.pause=false;
                //   if (StaticStore.currentSong == widget.name) {
                //     await _youtubePlayer.youtubeResume();
                //   } else {
                //     await _youtubePlayer.youtubeStop();
                //     // _youtubePlayer.youtubePlay(state.songs[i].name);
                //     await _youtubePlayer.youtubePlay(widget.name,widget.trackArtists[0]);
                //     StaticStore.currentSong = widget.name;
                //     StaticStore.currentSongImg = widget.trackImg;
                //     StaticStore.currentArtists = List.from(widget.trackArtists);
            
            
                //   }
                //   // setState(() {
                //     StaticStore.playing = true;
                //   // });
                //   // StaticStore.pause=false;
                // } else {
                //   /* Here is the problem */
                //   if (StaticStore.currentSong == widget.name) { 
                //     await _youtubePlayer.youtubePause();
                //     StaticStore.pause = true;
                //     print("same");
                //     // setState(() {
                //       StaticStore.playing = false;
                //     // });
                //   } else {
                //     // StaticStore.pause = true;
                //     // }else{
                //     await _youtubePlayer.youtubeStop();
                //     await _youtubePlayer.youtubePlay(widget.name,widget.trackArtists[0]);
                //     StaticStore.currentSong = widget.name;
                //     StaticStore.currentSongImg = widget.trackImg;
                //     StaticStore.currentArtists = List.from(widget.trackArtists);
                //     // setState(() {
                //       StaticStore.playing = true;
                //     // });
                //   }
                //   // setState(() {
                //   //   StaticStore.playing = false;
                //   // });
                //   // }
                // }
              },
              iconSize: 75,
              icon: StaticStore.playing == true
                  ? Icon(
                      Icons.pause,
                      color: Colors.white,
                    )
                  : Icon(
                      Icons.play_circle,
                      color: Colors.white,
                    ),
            );
          }
        ),
        IconButton(
          onPressed: () async {

            // if(StaticStore.queueIndex>0){
            //   // setState(() {
            //   StaticStore.queueIndex--;
                
            //   // });
            //   StaticStore.currentSong = StaticStore.myQueueTrack[StaticStore.queueIndex].name!;
            //   StaticStore.currentArtists = StaticStore.myQueueTrack[StaticStore.queueIndex].trackArtists;
            //   await _youtubePlayer.youtubeStop();
            //   await _youtubePlayer.youtubePlay(StaticStore.myQueueTrack[StaticStore.queueIndex].name,StaticStore.myQueueTrack[StaticStore.queueIndex].trackArtists[0]);
            // }





            if(StaticStore.queueIndex<StaticStore.myQueueTrack.length){
              // setState(() {
                StaticStore.queueIndex++;
              // });
              StaticStore.currentSong = StaticStore.myQueueTrack[StaticStore.queueIndex].name!;
              StaticStore.currentArtists = StaticStore.myQueueTrack[StaticStore.queueIndex].trackArtists;
              StaticStore.currentSongImg = StaticStore.myQueueTrack[StaticStore.queueIndex].imgUrl!;
              await _youtubePlayer.youtubeStop();
              await _youtubePlayer.youtubePlay(StaticStore.myQueueTrack[StaticStore.queueIndex].name,StaticStore.myQueueTrack[StaticStore.queueIndex].trackArtists[0]);
              StaticStore.playing = true;
              StaticStore.pause = false;
            }
          },
          iconSize: 45,
          icon: const Icon(
            Icons.skip_next,
            color: Colors.white,
          ),
        ),

        IconButton(
                  onPressed:
                  //  SongDataController.loaded?
                       () async {
                          if (StaticStore.player.position.inSeconds +
                                  10 <=
                              StaticStore.player.duration!.inSeconds) {
                            await StaticStore.player.seek(Duration(
                                seconds: StaticStore
                                        .player.position.inSeconds +
                                    10));
                          } else {
                            await StaticStore.player
                                .seek(const Duration(seconds: 0));
                          }
                        },
                      // : null,
                  icon: const Icon(Icons.fast_forward_rounded,color: Colors.white,))


        //   },
        // ),
      ],
    );
  }
}
