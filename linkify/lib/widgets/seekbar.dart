import 'dart:math';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:just_audio/just_audio.dart';
import 'package:linkify/controller/static_store.dart';
import 'package:linkify/controller/youtube_player.dart';

class SeekBarData {
  final Duration position;
  final Duration duration;

  SeekBarData(this.position, this.duration);
}

class SeekBar extends StatefulWidget {
  // final Duration position;
  // final Duration duration;
  // final ValueChanged<Duration>? onChanged;
  // final ValueChanged<Duration>? onChangeEnd;

  const SeekBar({
    Key? key,
    // required this.position,
    // required this.duration,
    // this.onChanged,
    // this.onChangeEnd,
  }) : super(key: key);

  @override
  State<SeekBar> createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
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
    return 


//     ProgressBar(
//   progress: StaticStore.player.position,
//   // buffered: ,
//   total: StaticStore.player.duration as Duration,
//   progressBarColor: Colors.red,
//   baseBarColor: Colors.white.withOpacity(0.24),
//   bufferedBarColor: Colors.white.withOpacity(0.24),
//   thumbColor: Colors.white,
//   barHeight: 3.0,
//   thumbRadius: 5.0,
//   onSeek: (dur) {
//     print(dur);
//     // _player.seek(duration);
//   },
// );




    // Row(
    //   children: [

        // Text(
        //   "${StaticStore.player.position}",
        //   style:TextStyle(color:Colors.white),
        // ),

        // Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children:[ 







            StreamBuilder(
                stream: StaticStore.player.positionStream,
                builder: (context, snapshot1) {






                      
                        if (StaticStore.player.processingState == ProcessingState.completed){
                          YoutubeSongPlayer _player = YoutubeSongPlayer();
                          StaticStore.pause = false;
                          if(StaticStore.queueIndex==StaticStore.myQueueTrack.length-1){
                            StaticStore.playing = false;
                          }
                          if(StaticStore.queueIndex+1<StaticStore.myQueueTrack.length){
                            // _player.youtubeStop();
                            if(StaticStore.nextPlay==1){
                              StaticStore.nextPlay=0;
                            StaticStore.queueIndex++;
                            _player.youtubePlay(StaticStore.myQueueTrack[StaticStore.queueIndex].name, StaticStore.myQueueTrack[StaticStore.queueIndex].trackArtists[0]).then((value) {
                              StaticStore.playing = true;
                              StaticStore.currentSong = StaticStore.myQueueTrack[StaticStore.queueIndex].name!;
                              StaticStore.currentArtists = StaticStore.myQueueTrack[StaticStore.queueIndex].trackArtists;
                              StaticStore.currentSongImg = StaticStore.myQueueTrack[StaticStore.queueIndex].imgUrl!;
                            });
                          }
                          }
                          // print("hi");
                        }
                      // }











                  // setState(() {

                  // });
                  /* Returning to start after completion */
                  // setState(() {

                  // if(StaticStore.player.position==(StaticStore.player.duration)){
                  //   print("completed");
                  //   StaticStore.playing = false;
                  // }

                  // if (StaticStore.player.processingState ==
                  //     ProcessingState.completed) {


                  //       // Future.delayed(Duration(milliseconds: 10)).then((value) => StaticStore.playing.value=false,);


                  //   ////// Add code for loop and shuffle
                  //   /* After completion song name not updating */

                  //   // StaticStore.playing.value = false;
                  //   // StaticStore.player.seek(Duration(milliseconds: 0));




                  //   StaticStore.player.stop();
                  //   StaticStore.paused = false;
                  //   StaticStore.playing.value = false;
                  //   // SongDataController.currSong.value =
                  //   //     (SongDataController.currSong.value + 1) % songList.length;

                  //   // try {
                  //   //   // playNext();
                  //   //   songPlayerController.playLocalSong(
                  //   //       songList[SongDataController.currSong.value].data);
                  //   //   // if (StaticStore.playing.value == false) {
                  //   //   //   ++SongDataController.currSong.value;
                  //   //   //   title = "Not playing";
                  //   //   // }

                  //   //   // Navigator.pop(context);
                  //   //   // Navigator.of(context).push(MaterialPageRoute(
                  //   //   //   builder: (context) => HomeNav(),
                  //   //   // ));

                  //   // } catch (e) {
                  //   //   SongDataController.currSong.value =
                  //   //       (SongDataController.currSong.value + 1) % songList.length;
                  //   // }

                  // }





                  // ;
                  // });

                  // print(songPlayerController.player.playerState);
                  // if(songPlayerController.player.playerState.playing){
                  //   songPlayerController.playing = true;
                  //   // print("object");
                  // }



                  // Duration duration = StaticStore.player.duration as Duration;
                  // print(duration);
                  // const Duration duration = Duration(seconds: 0);
                  // final Duration duration = SongDataController.loaded
                  //     ? snapshot1.data as Duration
                  //     : const Duration(seconds: 0);



                      // : Duration(seconds: StaticStore.player.duration!.inSeconds);
                  return StreamBuilder(
                      stream:
                          // StaticStore.player.bufferedPositionStream,
                          StaticStore.player.currentIndexStream,
                      builder: (context, snapshot2) {




                        if(StaticStore.player.playing==true){
                          StaticStore.playing=true;
                        }

                        if (StaticStore.player.processingState == ProcessingState.completed){
                          // YoutubeSongPlayer _player = YoutubeSongPlayer();
                          // StaticStore.pause = false;
                          if(StaticStore.queueIndex==StaticStore.myQueueTrack.length-1){
                            StaticStore.playing = false;
                          }
                        }





                        // if (StaticStore.player.processingState == ProcessingState.completed){

                        // }








                        // if (StaticStore.player.processingState == ProcessingState.completed){
                        //   YoutubeSongPlayer _player = YoutubeSongPlayer();
                        //   StaticStore.pause = false;
                        //   if(StaticStore.queueIndex==StaticStore.myQueueTrack.length-1){
                        //     StaticStore.playing = false;
                        //   }
                        //   if(StaticStore.queueIndex+1<StaticStore.myQueueTrack.length){
                        //     // _player.youtubeStop();
                        //     // StaticStore.queueIndex++;
                        //     _player.youtubePlay(StaticStore.myQueueTrack[StaticStore.queueIndex].name, StaticStore.myQueueTrack[StaticStore.queueIndex].trackArtists[0]).then((value) {
                        //       StaticStore.playing = true;
                        //       StaticStore.currentSong = StaticStore.myQueueTrack[StaticStore.queueIndex].name!;
                        //       StaticStore.currentArtists = StaticStore.myQueueTrack[StaticStore.queueIndex].trackArtists;
                        //       StaticStore.currentSongImg = StaticStore.myQueueTrack[StaticStore.queueIndex].imgUrl!;
                        //     });
                        //   }
                        //   // print("hi");
                        // }









                        // this.setState(() {
                        //   var a = stopper();
                        // });
                        // StaticStore.playing = false;
                        // }



                        Duration bufferedDuration = StaticStore.player.position;
                        // Duration(seconds: 0);
                        // final Duration bufferedDuration = SongDataController.loaded
                        //     ? snapshot2.data as Duration
                        //     : const Duration(seconds: 0);
                            // print(StaticStore.currentTime);
                        return 
                        
                        
                        
                        
                        
                        Column(children: [

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // SongDataController.loaded?
                              // Flexible(
                              //   child: Text(songList.length>0?
                              //     "${songList[SongDataController.currSong.value].title}":"",
                              //     maxLines: 1,
                              //     style: Theme.of(context).textTheme.bodyLarge,
                              //   ),
                              // )
                              // songList.length > 0
                                  // ? 
                                  Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width - 100,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              // padding: EdgeInsets.only(top: 50),
                                              // child:
                                                  // Text("sad"),
                                                  // Obx(() =>
                                                  // Text(
                                                      // songList[SongDataController.currSong.value].title, ////// Title
                                                      // "${StaticStore.songName.value}",
                                                      // style: const TextStyle(
                                                      //     fontSize: 18,
                                                      //     fontWeight: FontWeight.bold)),

                                                  // ),
                                              // ],
                                            ),
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              // padding: EdgeInsets.only(top: 50),
                                            //   child: Text(
                                            //       "${songList[SongDataController.currSong.value].artist}",
                                            //       style: TextStyle(fontSize: 14)),
                                            //   // ],
                                            )
                                          ],
                                        ),
                                      ))
                                  // : Container()
                              // :Container()
                              ,
                            ],
                          ),


                        SizedBox(
                          // height: 10,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: 
                            
                            ProgressBar(
                              progress: StaticStore.player.position,
                              thumbGlowColor: Colors.red,
                              // bufferedBarColor: Colors.grey,
                              total: 
                              StaticStore.player.duration!=null?
                              StaticStore.player.duration as Duration:const Duration(seconds: 0),
                              // duration:duration,
                              // StaticStore.player.duration ??
                              //     Duration(seconds: songList[SongDataController.currSong.value].duration!),
                                  // Duration(seconds: songList[0].duration!),

                              // total: StaticStore.player.duration ??
                              //     const Duration(seconds: 100),
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
                                      await StaticStore.player
                                          .seek(d);
                                    }
                                  // : null,
                            ),
                          ),
                        ),










                        

        ]);














                      });
                });




            // StreamBuilder(
            //           stream:
            //               StaticStore.player.bufferedPositionStream,
            //           builder: (context, snapshot2) {
            //             return 
            //             ProgressBar(

            //                   // progress: duration,
            //                   progress: StaticStore.player.position,
            //                   // progress: ,
            //                   total: StaticStore.player.duration as Duration,
            //                   // StaticStore.player.,

            //                   // StaticStore.totalTime.value,
            //                   // StaticStore.player.duration ??
            //                       // Duration(seconds: 0),
            //                       // Duration(seconds: songList[0].duration!),

            //                   // total: StaticStore.player.duration ??
            //                   //     const Duration(seconds: 100),
            //                   buffered: StaticStore.player.bufferedPosition,
            //                   timeLabelPadding: -1,
            //                   timeLabelTextStyle: const TextStyle(
            //                       fontSize: 14, color: Colors.white),
            //                   progressBarColor: Colors.red,
            //                   baseBarColor: Colors.grey[200],
            //                   bufferedBarColor: Colors.grey[350],
            //                   thumbColor: Colors.red,
            //                   onSeek: 
            //                   // SongDataController.loaded
            //                       // ? 
            //                       (duration) async {
            //                           await StaticStore.player
            //                               .seek(duration);
            //                         }
            //                       // : null,
            //                 );
            //           }),





        // Container(
        //                   height: 40,
        //                   width: MediaQuery.of(context).size.width*80/100,
        //                   child: 
        //                   Column(
        //                     mainAxisAlignment: MainAxisAlignment.center,
        //                     children: [
        //                   // Padding(
        //                     // padding: const EdgeInsets.symmetric(horizontal: 16),
        //                     // child: 
        //                     // SizedBox(),
                            // ProgressBar(
                            //   // progress: duration,
                            //   progress: StaticStore.player.position,
                            //   // progress: ,
                            //   total: StaticStore.player.duration as Duration,
                            //   // StaticStore.player.,

                            //   // StaticStore.totalTime.value,
                            //   // StaticStore.player.duration ??
                            //       // Duration(seconds: 0),
                            //       // Duration(seconds: songList[0].duration!),

                            //   // total: StaticStore.player.duration ??
                            //   //     const Duration(seconds: 100),
                            //   buffered: StaticStore.player.bufferedPosition,
                            //   timeLabelPadding: -1,
                            //   timeLabelTextStyle: const TextStyle(
                            //       fontSize: 14, color: Colors.white),
                            //   progressBarColor: Colors.red,
                            //   baseBarColor: Colors.grey[200],
                            //   bufferedBarColor: Colors.grey[350],
                            //   thumbColor: Colors.red,
                            //   onSeek: 
                            //   // SongDataController.loaded
                            //       // ? 
                            //       (duration) async {
                            //           await StaticStore.player
                            //               .seek(duration);
                            //         }
                            //       // : null,
                            // ),
        //                   ]),
        //                   // ),
        //                 ),
















        // ]),
        // ),

        // Text("${StaticStore.player.duration}",style:TextStyle(color:Colors.white)),





        // Text(
        //   // current song position
        //   // "0:20",
        //   // _formatDuration(widget.position),
        //   "${StaticStore.player.position}",
        //   style:TextStyle(color:Colors.white),
        // ),
        // Expanded(
        //   child: SliderTheme(
        //     data: SliderTheme.of(context).copyWith(
        //       trackHeight: 4,
        //       thumbShape: const RoundSliderThumbShape(
        //         disabledThumbRadius: 4,
        //         enabledThumbRadius: 4,
        //       ),
        //       overlayShape: const RoundSliderOverlayShape(
        //         overlayRadius: 10,
        //       ),
        //       activeTrackColor: Colors.white.withOpacity(0.2),
        //       inactiveTrackColor: Colors.white,
        //       thumbColor: Colors.white,
        //       overlayColor: Colors.white,
        //     ),
        //     child: Slider(
        //       // max: widget.duration.inMilliseconds.toDouble(),
        //       // value: min(
        //       //   _dragValue ?? widget.position.inMilliseconds.toDouble(),
        //       //   widget.duration.inMilliseconds.toDouble(),
        //       // ),
        //       // min: 0.0,
        //       // max: 3.0,
        //       value: 0.4,
        //       onChanged: (value) {
        //         setState(() {
        //           _dragValue = value;
        //         });
        //         // if (widget.onChanged != null) {
        //         //   widget.onChanged!(
        //         //     Duration(
        //         //       milliseconds: value.round(),
        //         //     ),
        //         //   );
        //         // }
        //       },
        //       onChangeEnd: (value) {
        //         // if (widget.onChangeEnd != null) {
        //         //   widget.onChangeEnd!(
        //         //     Duration(
        //         //       milliseconds: value.round(),
        //         //     ),
        //         //   );
        //         // }
        //         _dragValue = null;
        //       },
        //     ),
        //   ),
        // ),
        // // song duration
        // Text("3:00",style:TextStyle(color:Colors.white)),
        // Text(_formatDuration(widget.duration)),
    //   ],
    // );
  }
}
