import 'dart:math';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:just_audio/just_audio.dart';
import 'package:linkify/controller/local_songs/player/prev_next_play.dart';
import 'package:linkify/controller/variables/static_store.dart';
import 'package:linkify/controller/player/youtube_player.dart';
import 'package:on_audio_query/on_audio_query.dart';


class LocalSeekBar extends StatefulWidget {
  // final Duration position;
  // final Duration duration;
  // final ValueChanged<Duration>? onChanged;
  // final ValueChanged<Duration>? onChangeEnd;
  List<SongModel>songList;

  LocalSeekBar(
    this.songList,
    {
    Key? key,
    // required this.position,
    // required this.duration,
    // this.onChanged,
    // this.onChangeEnd,
  }) : super(key: key);

  @override
  State<LocalSeekBar> createState() => Local_SeekBarState();
}

class Local_SeekBarState extends State<LocalSeekBar> {
  // double? _dragValue;

  // String _formatDuration(Duration? duration) {
  //   if (duration == null) {
  //     return '--:--';
  //   } else {
  //     String minutes = duration.inMinutes.toString().padLeft(2, '0');
  //     String seconds =
  //         duration.inSeconds.remainder(60).toString().padLeft(2, '0');
  //     return '$minutes:$seconds';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: StaticStore.player.positionStream,
        builder: (context, snapshot1) {
          if (StaticStore.player.processingState == ProcessingState.completed) {
            print("song completed");
            play_next_local(widget.songList);
          }
          return StreamBuilder(
              stream:
                  // StaticStore.player.bufferedPositionStream,
                  StaticStore.player.currentIndexStream,
              builder: (context, snapshot2) {
                if (StaticStore.player.playing == true) {
                  StaticStore.playing = true;
                }

                if (StaticStore.player.processingState ==
                    ProcessingState.completed) {
                  // YoutubeSongPlayer _player = YoutubeSongPlayer();
                  // StaticStore.pause = false;
                  if (StaticStore.queueIndex ==
                      StaticStore.myQueueTrack.length - 1) {
                    StaticStore.playing = false;
                  }
                }
                Duration bufferedDuration = StaticStore.player.position;
                return Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.all(16),
                          child: Container(
                            width: MediaQuery.of(context).size.width - 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                )
                              ],
                            ),
                          ))
                      ,
                    ],
                  ),
                  SizedBox(
                    // height: 10,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ProgressBar(
                          progress: StaticStore.player.position,
                          thumbGlowColor: Colors.red,
                          // bufferedBarColor: Colors.grey,
                          total: StaticStore.player.duration != null
                              ? StaticStore.player.duration as Duration
                              : const Duration(seconds: 0),
                          buffered: bufferedDuration,
                          timeLabelPadding: -1,
                          timeLabelTextStyle: const TextStyle(
                              fontSize: 14, color: Colors.white),
                          progressBarColor: Colors.red,
                          baseBarColor: Colors.grey[200],
                          // bufferedBarColor: Colors.grey[350],
                          bufferedBarColor: Colors.grey,
                          thumbColor: Colors.red,
                          //                             onSeek: (duration) {
                          //   print('User selected a new time: $duration');
                          // },
                          onSeek:
                              // SongDataController.loaded
                              // ?
                              (d) async {
                            await StaticStore.player.seek(d);
                          }
                          // : null,
                          ),
                    ),
                  ),
                ]);
              });
        });
  }
}
