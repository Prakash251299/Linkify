import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';
import 'package:linkify/controller/static_store.dart';
import 'package:linkify/controller/youtube_player.dart';
import 'package:linkify/widgets/uis/models/song_model.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:linkify/controller/static_store.dart';
// import 'package:linkify/controller/youtube_player.dart';

class PlayerButtons extends StatefulWidget {
  SongModel songs;
  PlayerButtons(this.songs);
  // const PlayerButtons({super.key});

  @override
  State<PlayerButtons> createState() => _PlayerButtonsState();
}

class _PlayerButtonsState extends State<PlayerButtons> {
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
                  icon: const Icon(Icons.fast_rewind_rounded),color: Colors.white,),



        IconButton(
          onPressed: () {},
          //           // audioPlayer.hasPrevious ? audioPlayer.seekToPrevious : null,
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
        IconButton(
          onPressed: () async {
            if (StaticStore.playing == false) {
              // if(StaticStore.pause==true){
              // StaticStore.pause=false;
              if (StaticStore.currentSong == widget.songs.name) {
                await _youtubePlayer.youtubeResume();
              } else {
                await _youtubePlayer.youtubeStop();
                // _youtubePlayer.youtubePlay(state.songs[i].name);
                await _youtubePlayer.youtubePlay(widget.songs.name,widget.songs.artists[0]);
                StaticStore.currentSong = widget.songs.name;
                StaticStore.currentSongImg = widget.songs.imgUrl;
                StaticStore.currentArtists = List.from(widget.songs.artists);

              }
              setState(() {
                StaticStore.playing = true;
              });
              // StaticStore.pause=false;
            } else {
              if (StaticStore.currentSong == widget.songs.name) {
                await _youtubePlayer.youtubePause();
                // StaticStore.pause = true;
                print("same");
                setState(() {
                  StaticStore.playing = false;
                });
              } else {
                // StaticStore.pause = true;
                // }else{
                await _youtubePlayer.youtubeStop();
                await _youtubePlayer.youtubePlay(widget.songs.name,widget.songs.artists[0]);
                StaticStore.currentSong = widget.songs.name;
                StaticStore.currentSongImg = widget.songs.imgUrl;
                StaticStore.currentArtists = List.from(widget.songs.artists);
                setState(() {
                  StaticStore.playing = true;
                });
              }
              // setState(() {
              //   StaticStore.playing = false;
              // });
              // }
            }
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
        ),
        //       } else if (processingState != ProcessingState.completed) {
        //         return
        //         IconButton(
        //           icon: const Icon(
        //             Icons.pause_circle,
        //             color: Colors.white,
        //           ),
        //           iconSize: 75.0,
        //           onPressed: ()async{},
        //         );
        //       } else {
        //         return
        //         IconButton(
        //           icon: const Icon(
        //             Icons.replay_circle_filled_outlined,
        //             color: Colors.white,
        //           ),
        //           iconSize: 75.0,
        //           onPressed: () =>
        //           SizedBox()
        //           // audioPlayer.seek(
        //           //   Duration.zero,
        //           //   index: audioPlayer.effectiveIndices!.first,
        //           // ),
        //         );
        //       }
        //     } else {
        //       return const CircularProgressIndicator();
        //     }
        //   },
        // ),

        // StreamBuilder<SequenceState?>(
        //   // stream: audioPlayer.sequenceStateStream,
        //   stream: null,
        //   builder: (context, index) {
        //     return
        IconButton(
          // onPressed: audioPlayer.hasNext ? audioPlayer.seekToNext : null,
          onPressed: () {},
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
