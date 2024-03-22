import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:linkify/controller/static_store.dart';
// import 'package:linkify/controller/youtube_player.dart';

class PlayerButtons extends StatelessWidget {
  PlayerButtons({
    Key? key,
    // required this.audioPlayer,
  }) : super(key: key);

  // final AudioPlayer audioPlayer;
  // YoutubeSongPlayer _youtubePlay = YoutubeSongPlayer();
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
              onPressed:(){},
        //           // audioPlayer.hasPrevious ? audioPlayer.seekToPrevious : null,
        //       // iconSize: 45,
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
                  onPressed: () async {}, 
                  iconSize: 75,
                  icon: const Icon(
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
              onPressed: (){},
              iconSize: 45,
              icon: const Icon(
                Icons.skip_next,
                color: Colors.white,
              ),
            ),
        //   },
        // ),
      ],
    );
  }
}
