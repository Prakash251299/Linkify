import 'dart:math';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:just_audio/just_audio.dart';
import 'package:linkify/controller/variables/static_store.dart';
import 'package:linkify/controller/player/youtube_player.dart';

class SeekBar extends StatefulWidget {

  const SeekBar({
    Key? key,
  }) : super(key: key);

  @override
  State<SeekBar> createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: StaticStore.player.positionStream,
        builder: (context, snapshot1) {
          if (StaticStore.player.processingState == ProcessingState.completed) {
            YoutubeSongPlayer _player = YoutubeSongPlayer();
            StaticStore.pause = false;
            if (StaticStore.queueIndex == StaticStore.myQueueTrack.length - 1) {
              StaticStore.playing = false;
            }
            if (StaticStore.queueIndex + 1 < StaticStore.myQueueTrack.length) {
              // _player.youtubeStop();
              if (StaticStore.nextPlay == 1) {
                StaticStore.nextPlay = 0;
                StaticStore.queueIndex++;
                _player
                    .youtubePlay(
                        StaticStore.myQueueTrack[StaticStore.queueIndex].name,
                        StaticStore.myQueueTrack[StaticStore.queueIndex]
                            .trackArtists?[0])
                    .then((value) {
                  StaticStore.playing = true;
                  StaticStore.currentSong =
                      StaticStore.myQueueTrack[StaticStore.queueIndex].name!;
                  StaticStore.currentArtists = StaticStore
                      .myQueueTrack[StaticStore.queueIndex].trackArtists??[];
                  StaticStore.currentSongImg =
                      StaticStore.myQueueTrack[StaticStore.queueIndex].imgUrl!;
                });
              }
            }
          }
          return StreamBuilder(
              stream:
                  StaticStore.player.currentIndexStream,
              builder: (context, snapshot2) {
                if (StaticStore.player.playing == true) {
                  StaticStore.playing = true;
                }

                if (StaticStore.player.processingState ==
                    ProcessingState.completed) {
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
                          )),
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
                          onSeek:
                              (d) async {
                            await StaticStore.player.seek(d);
                          }
                          ),
                    ),
                  ),
                ]);
              });
        });
  }
}
