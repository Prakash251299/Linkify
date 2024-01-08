// import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
// import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:get/instance_manager.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:linkify/controller/songPlayerController.dart';
import 'package:linkify/controller/song_data_contoller.dart';
import 'package:linkify/main.dart';
import 'package:linkify/widgets/homeNav.dart';
import 'package:linkify/widgets/local_songs.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';
// var index=0;

// class SongPlayer extends GetxController{
//   final player = AudioPlayer();
//   void playMusic(String url) async {
//   await player.setAudioSource(AudioSource.uri(Uri.parse(url)));
//   player.play();
// }
// }

class Homepage extends StatefulWidget {
  // const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

enum PlayerState { playing, paused }

class _HomepageState extends State<Homepage> {
  // String musicUrl = "Users/amankumarsaw/Downloads"; // Insert your music URL
// String musicUrl = "/Users/amankumarsaw/Downloads/Main-Dhoondne-Ko-Zamaane-Mein_320(PaglaSongs).mp3"; // Insert your music URL
// var musicUrl1 = "https://www.jiosaavn.com/song/one-way-ticket/Cl9daz4EQ2I"; // Insert your music URL
  String thumbnailImgUrl = ""; // Insert your thumbnail URL
  var title = "Music Player";
// var player = AudioPlayer();
  PlayerState playerState = PlayerState.paused;
  bool loaded = false;
  bool playing = false;
// var currSong = 0;
  SongPlayerController songPlayerController = Get.put(SongPlayerController());
  SongDataController songDataController = Get.put(SongDataController());
  RxList<SongModel> songList = <SongModel>[].obs;
// var player = songPlayerController.player;

// void playMusic(String url) async {
//   playing = true;
//   await player.setAudioSource(AudioSource.uri(Uri.parse(url)));
//   player.play();
// }

  void loadMusic() async {
    try {
      songList = await songDataController.getLocalSongs();
      setState(() {
        loaded = true;
      });
    } catch (e) {
      print("Nothing found");
    }
  }

  @override
  void initState() {
    // await read();
    loadMusic();
// print(player.playerState);
// if(player.playerState==ProcessingState.completed){

// }
    super.initState();
  }

// @override
// void dispose() {
// songPlayerController.player.dispose();
// super.dispose();
// }

// Future<int> stopper()async{
//   setState(() {
//     SongPlayerController.playing.value = false;
//     // songPlayerController.completed = true;
//   });
//   return 1;
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${title}"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            onPressed: () {
              // do something
              // print(songList[0].title);
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => LocalSongList(songList: songList)));
            },
          )
        ],
      ),
      body: Column(
        children: [
          const Spacer(
            flex: 2,
          ),

          ////////  UNCOMMENT IT  //////////
          // ClipRRect(
          // 	borderRadius: BorderRadius.circular(8),
          // 	child: Image.network(
          // 	thumbnailImgUrl,
          //   // songList[SongDataController.currSong].uri!,
          // 	height: 350,
          // 	width: 350,
          // 	fit: BoxFit.cover,
          // 	),
          // ),
          const Spacer(),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // loaded?
              // Flexible(
              //   child: Text(songList.length>0?
              //     "${songList[SongDataController.currSong].title}":"",
              //     maxLines: 1,
              //     style: Theme.of(context).textTheme.bodyLarge,
              //   ),
              // )
              songList.length > 0
                  ? Padding(
                      padding: EdgeInsets.all(16),
                      child: Container(
                        width: MediaQuery.of(context).size.width - 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              // padding: EdgeInsets.only(top: 50),
                              child:
                                  // Text("sad"),
                                  Text(
                                      "${songList[SongDataController.currSong].title}",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                              // ],
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              // padding: EdgeInsets.only(top: 50),
                              child: Text(
                                  "${songList[SongDataController.currSong].artist}",
                                  style: TextStyle(fontSize: 14)),
                              // ],
                            )
                          ],
                        ),
                      ))
                  : Container()
              // :Container()
              ,
            ],
          ),

          // const Spacer(),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: StreamBuilder(
                stream: SongPlayerController.player.positionStream,
                builder: (context, snapshot1) {
                  // setState(() {

                  // });
                  /* Returning to start after completion */
                  // setState(() {

                  // if(SongPlayerController.player.position==(SongPlayerController.player.duration)){
                  //   print("completed");
                  //   SongPlayerController.playing = false;
                  // }

                  if (SongPlayerController.player.processingState ==
                      ProcessingState.completed) {
                    ////// Add code for loop and shuffle
                    /* After completion song name not updating */

                    // SongPlayerController.playing.value = false;
                    // SongPlayerController.player.seek(Duration(milliseconds: 0));
                    SongPlayerController.player.stop();
                    SongPlayerController.paused = false;
                    SongDataController.currSong =
                        (SongDataController.currSong + 1) % songList.length;

                    try {
                      // playNext();
                      songPlayerController.playLocalSong(
                          songList[SongDataController.currSong].data);
                      if (SongPlayerController.playing.value == false) {
                        ++SongDataController.currSong;
                        title = "Not playing";
                      }
                    } catch (e) {
                      SongDataController.currSong =
                          (SongDataController.currSong + 1) % songList.length;
                      songPlayerController.playLocalSong(
                          songList[SongDataController.currSong].data);
                    }

                    // Navigator.of(context).push(MaterialPageRoute(
                    //   builder: (context) => HomeNav(),
                    // ));

                    // Navigator.pop(context);

                    // songPlayerController.completed=true;

                    // Future.wait([
                    //     stopper(),
                    //   ]);

                    // this.setState(() {
                    // SongPlayerController.playing = false;
                    // });
                    // stopper();
                    // SongPlayerController.completed = true;
                  }
                  ;
                  // });

                  // print(songPlayerController.player.playerState);
                  // if(songPlayerController.player.playerState.playing){
                  //   songPlayerController.playing = true;
                  //   // print("object");
                  // }

                  final Duration duration = loaded
                      ? snapshot1.data as Duration
                      : const Duration(seconds: 0);
                  return StreamBuilder(
                      stream:
                          SongPlayerController.player.bufferedPositionStream,
                      builder: (context, snapshot2) {
                        // if (songPlayerController.player.processingState == ProcessingState.completed) {
                        //   print("Completed");
                        // }
                        //  },

                        // if (SongPlayerController.player.processingState == ProcessingState.completed){
                        // this.setState(() {
                        //   var a = stopper();
                        // });
                        // SongPlayerController.playing = false;
                        // }

                        final Duration bufferedDuration = loaded
                            ? snapshot2.data as Duration
                            : const Duration(seconds: 0);
                        return SizedBox(
                          height: 30,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: ProgressBar(
                              progress: duration,
                              total: SongPlayerController.player.duration ??
                                  const Duration(seconds: 0),
                              buffered: bufferedDuration,
                              timeLabelPadding: -1,
                              timeLabelTextStyle: const TextStyle(
                                  fontSize: 14, color: Colors.black),
                              progressBarColor: Colors.red,
                              baseBarColor: Colors.grey[200],
                              bufferedBarColor: Colors.grey[350],
                              thumbColor: Colors.red,
                              onSeek: loaded
                                  ? (duration) async {
                                      await SongPlayerController.player
                                          .seek(duration);
                                    }
                                  : null,
                            ),
                          ),
                        );
                      });
                }),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                width: 10,
              ),
              IconButton(
                  onPressed: loaded
                      ? () async {
                          if (SongPlayerController.player.position.inSeconds >
                              10) {
                            await SongPlayerController.player.seek(Duration(
                                seconds: SongPlayerController
                                        .player.position.inSeconds -
                                    10));
                          } else {
                            await SongPlayerController.player
                                .seek(const Duration(seconds: 0));
                          }
                        }
                      : null,
                  icon: const Icon(Icons.fast_rewind_rounded)),
              songPlayerController.completed == false
                  ? Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.red),
                      child: IconButton(
                          ///// Icon for playing songs
                          onPressed: () {
                            setState(() {
                              if (SongPlayerController.playing == true) {
                                songPlayerController.pauseLocalSong();
                                // SongPlayerController.playing = false;
                                // SongPlayerController.paused = true;
                              } else {
                                if (SongPlayerController.playing == false) {
                                  songPlayerController.playLocalSong(
                                      songList[SongDataController.currSong]
                                          .data);
                                  // SongPlayerController.playing = true;
                                  // SongPlayerController.paused = false;
                                }
                              }
                            });
                          },
                          icon: Icon(
                            SongPlayerController.playing.value == true
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: Colors.white,
                          )),
                    )
                  : Container(),
              IconButton(
                  onPressed: loaded
                      ? () async {
                          if (SongPlayerController.player.position.inSeconds +
                                  10 <=
                              SongPlayerController.player.duration!.inSeconds) {
                            await SongPlayerController.player.seek(Duration(
                                seconds: SongPlayerController
                                        .player.position.inSeconds +
                                    10));
                          } else {
                            await SongPlayerController.player
                                .seek(const Duration(seconds: 0));
                          }
                        }
                      : null,
                  icon: const Icon(Icons.fast_forward_rounded)),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          const Spacer(
            flex: 2,
          )
        ],
      ),
    );
  }

  //   );
  // }
}
