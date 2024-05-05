
// // line where navigator can be called are 104 193 

// import 'package:flutter/material.dart';
// // import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:get/instance_manager.dart';
// import 'package:linkify/controller/caller.dart';
// import 'package:linkify/controller/read_write.dart';
// import 'package:linkify/controller/songPlayerController.dart';
// import 'package:linkify/controller/song_data_contoller.dart';
// import 'package:linkify/controller/spotify_caller.dart';
// import 'package:linkify/controller/web_controller.dart';
// import 'package:linkify/controller/webview.dart';
// import 'package:linkify/widgets/local_songs.dart';
// // import 'package:linkify/widgets/webview.dart';
// // import 'package:linkify/widgets/web_view.dart';
// import 'package:on_audio_query/on_audio_query.dart';
// // import 'package:webview_flutter/webview_flutter.dart';
// // import 'package:webview_flutter_android/webview_flutter_android.dart';
// // import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

// class CloudPlay extends StatefulWidget {
//   // const Homepage({super.key});

//   @override
//   State<CloudPlay> createState() => _HomepageState();
// }

// enum PlayerState { playing, paused }

// class _HomepageState extends State<CloudPlay> {
//   // String musicUrl = "Users/amankumarsaw/Downloads"; // Insert your music URL
// // String musicUrl = "/Users/amankumarsaw/Downloads/Main-Dhoondne-Ko-Zamaane-Mein_320(PaglaSongs).mp3"; // Insert your music URL
// // var musicUrl1 = "https://www.jiosaavn.com/song/one-way-ticket/Cl9daz4EQ2I"; // Insert your music URL
//   String thumbnailImgUrl = ""; // Insert your thumbnail URL
//   var title = "Music Player";
// // var player = AudioPlayer();
//   PlayerState playerState = PlayerState.paused;
//   // bool SongDataController.loaded = false;
//   bool playing = false;
// // var currSong.value = 0;
//   SongPlayerController songPlayerController = Get.put(SongPlayerController());
//   SongDataController songDataController = Get.put(SongDataController());
//   RxList<SongModel> songList = <SongModel>[].obs;
//   int showSearch=0;
//   final TextEditingController _textController = TextEditingController();
//   SpotifyHandler spotifyPlayer = SpotifyHandler();


//   // WebViewController _controller = WebViewController();

// // var player = songPlayerController.player;

// // void playMusic(String url) async {
// //   playing = true;
// //   await player.setAudioSource(AudioSource.uri(Uri.parse(url)));
// //   player.play();
// // }

//   // void loadMusic() async {
//   //   try {
//   //     // songList = await songDataController.getLocalSongs();
//   //     songList = SongDataController.songList;
//   //     setState(() {
//   //       // SongDataController.loaded = true;
//   //     });
//   //   } catch (e) {
//   //     print("Nothing found");
//   //   }
//   // }

//   @override
//   void initState() {
//     // await read();
//     // loadMusic();
// // print(player.playerState);
// // if(player.playerState==ProcessingState.completed){

// // }
//     super.initState();
//   }

// // @override
// // void dispose() {
// // songPlayerController.player.dispose();
// // super.dispose();
// // }

// // Future<int> stopper()async{
// //   setState(() {
// //     SongPlayerController.playing.value = false;
// //     // songPlayerController.completed = true;
// //   });
// //   return 1;
// // }



//   // var mWebviewPop = WebView();

//   // Future<WebViewController> _getController() async {
//   //   PlatformWebViewControllerCreationParams params =
//   //   const PlatformWebViewControllerCreationParams();

//   //   if (WebViewPlatform.instance is WebKitWebViewPlatform) {
//   //     params = WebKitWebViewControllerCreationParams
//   //         .fromPlatformWebViewControllerCreationParams(
//   //       params,
//   //     );
//   //   } else if (WebViewPlatform.instance is AndroidWebViewPlatform) {
//   //     params = AndroidWebViewControllerCreationParams
//   //         .fromPlatformWebViewControllerCreationParams(
//   //       params,
//   //     );
//   //   }

//   //   final WebViewController webViewController =
//   //       WebViewController.fromPlatformCreationParams(
//   //     params,
//   //   );
//   //   // final String USER_AGENT = "Mozilla/5.0 (Linux; Android 4.1.1; Galaxy Nexus Build/JRO03C) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.166 Mobile Safari/535.19";
//   //   // mwebView.getSettings().setUserAgentString(USER_AGENT);
//   //   await webViewController.setJavaScriptMode(JavaScriptMode.unrestricted);
//   //   await webViewController.loadRequest(Uri.parse( "https://webauthspotify.web.app/" ));
//   //   return webViewController;
//   // }








//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("${title}"),
//         actions: <Widget>[
//           IconButton(
//             onPressed: () async {
//               // _controller = await _getController();
//               if(_textController.text!=""){
//                 SpotifyHandler.songName = _textController.text;
//                 Navigator.of(context).push(MaterialPageRoute(builder: (context) => Caller()));
//                 // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Web()));
//                 // Navigator.of(context).push(MaterialPageRoute(builder: (context) => WebContainer()));
//                 // Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyWebView(_controller)));
//                 // spotifyPlayer.spotify_conn();
//               }
//               setState(() {
//                 showSearch=1;
//               });
//             }, 
//             icon: Icon(Icons.search),
//           ),
//           IconButton(
//             icon: Icon(
//               Icons.more_vert,
//               color: Colors.black,
//             ),
//             onPressed: () {
//               // do something
//               // print(songList[0].title);
//               Navigator.pop(context);
//               Navigator.of(context).pushReplacement(MaterialPageRoute(
//                   builder: (context) => LocalSongList(songList: songList)));
//             },
//           )
//         ],
//       ),
//       body: Column(
//         children: [
//           if(showSearch==1)...{
//             Stack(children: [
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 height:40,
//                 color: Colors.grey,
//                 child: TextField(
//                   controller: _textController,
                  
//                   decoration: const InputDecoration(
//                     hintText: "Song name...",
//                   ),
//                   onChanged: (val) {
//                     setState(() {
//                       _textController.text = val.toString();
//                     });
//                   },
//                 ),
//               ),
              
//             ],),
//           },
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//             IconButton(
//                   onPressed: SongDataController.loaded
//                       ? () async {
//                           if (SpotifyHandler.player.position.inSeconds > 10){
//                           // if ((await SpotifyHandler.player.getCurrentPosition())!.inSeconds > 10) {
//                             await SpotifyHandler.player.seek(Duration(
//                                 seconds: SongPlayerController
//                                         .player.position.inSeconds -
//                                     10));
//                           } else {
//                             await SongPlayerController.player
//                                 .seek(const Duration(seconds: 0));
//                           }
//                         }
//                       : null,
//                   icon: const Icon(Icons.fast_rewind_rounded)),
//               songPlayerController.completed == false
//                   ? Container(
//                       height: 50,
//                       width: 50,
//                       decoration: const BoxDecoration(
//                           shape: BoxShape.circle, color: Colors.red),
//                       child: IconButton(
//                           ///// Icon for playing songs
//                           onPressed: () async {
//                             // _controller = await _getController();
//                             setState(() {
//                               if (SpotifyHandler.playing == true) {
//                                 // songPlayerController.pauseLocalSong();
//                                 SpotifyHandler.player.pause();
//                                 SpotifyHandler.playing = false;
//                                 SpotifyHandler.paused = true;
//                               } else {
//                                 if (SpotifyHandler.playing == false) {
//                                   if(SpotifyHandler.paused==true){
//                                     // SpotifyHandler.player.resume();
//                                     SpotifyHandler.player.play();
//                                     SpotifyHandler.paused = false;
//                                   }else{
//                                     // spotifyPlayer.spotify_conn();
//                                     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>Caller()));
//                                     // Navigator.of(context).pushReplacement(MaterialPageRoute(
//                   // builder: (context) =>MyWebView(_controller)));
//                                     // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>WebContainer()));
//                                   }
//                                   // songPlayerController.playLocalSong(
//                                   //     songList[SpotifyHandler.currSong.value]
//                                   //         .data);
//                                   SpotifyHandler.playing = true;
//                                   // SongPlayerController.paused = false;
//                                 }
//                               }
//                             });
//                           },
//                           icon: Icon(
//                             SpotifyHandler.playing == true
//                                 ? Icons.pause
//                                 : Icons.play_arrow,
//                             color: Colors.white,
//                           )),
//                     )
//                   : Container(),
//               IconButton(
//                   onPressed: SongDataController.loaded
//                       ? () async {
//                           // if ((await SpotifyHandler.player.getCurrentPosition())!.inSeconds +
//                           //         10 <=
//                           //     (await SpotifyHandler.player.getDuration())!.inSeconds) {
//                           //   await SpotifyHandler.player.seek(Duration(
//                           //       seconds: (await SpotifyHandler.player.getCurrentPosition())!.inSeconds +
//                           //           10));
//                           if (SpotifyHandler.player.position.inSeconds +
//                                   10 <=
//                               SpotifyHandler.player.position.inSeconds) {
//                             await SpotifyHandler.player.seek(Duration(
//                                 seconds: (await SpotifyHandler.player.position.inSeconds +
//                                     10)));
//                           } else {
//                             await SpotifyHandler.player
//                                 .seek(const Duration(seconds: 0));
//                           }
//                         }
//                       : null,
//                   icon: const Icon(Icons.fast_forward_rounded)),
//           ],)
//       //     const Spacer(
//       //       flex: 2,
//       //     ),

//       //     ////////  UNCOMMENT IT  //////////
//       //     // ClipRRect(
//       //     // 	borderRadius: BorderRadius.circular(8),
//       //     // 	child: Image.network(
//       //     // 	thumbnailImgUrl,
//       //     //   // songList[SongDataController.currSong.value].uri!,
//       //     // 	height: 350,
//       //     // 	width: 350,
//       //     // 	fit: BoxFit.cover,
//       //     // 	),
//       //     // ),
//       //     const Spacer(),


          

//       //     // Row(
//       //     //   mainAxisAlignment: MainAxisAlignment.start,
//       //     //   children: [
//       //     //     // SongDataController.loaded?
//       //     //     // Flexible(
//       //     //     //   child: Text(songList.length>0?
//       //     //     //     "${songList[SongDataController.currSong.value].title}":"",
//       //     //     //     maxLines: 1,
//       //     //     //     style: Theme.of(context).textTheme.bodyLarge,
//       //     //     //   ),
//       //     //     // )
//       //     //     songList.length > 0
//       //     //         ? 
//       //     //         Padding(
//       //     //             padding: EdgeInsets.all(16),
//       //     //             child: Container(
//       //     //               width: MediaQuery.of(context).size.width - 100,
//       //     //               child: Column(
//       //     //                 crossAxisAlignment: CrossAxisAlignment.start,
//       //     //                 children: [
//       //     //                   SingleChildScrollView(
//       //     //                     scrollDirection: Axis.horizontal,
//       //     //                     // padding: EdgeInsets.only(top: 50),
//       //     //                     child:
//       //     //                         // Text("sad"),
//       //     //                         // Obx(() =>
//       //     //                         Text(
//       //     //                             "${songList[SongDataController.currSong.value].title}", ////// Title
//       //     //                             // "${SongPlayerController.songName.value}",
//       //     //                             style: TextStyle(
//       //     //                                 fontSize: 18,
//       //     //                                 fontWeight: FontWeight.bold)),

//       //     //                         // ),
//       //     //                     // ],
//       //     //                   ),
//       //     //                   SingleChildScrollView(
//       //     //                     scrollDirection: Axis.horizontal,
//       //     //                     // padding: EdgeInsets.only(top: 50),
//       //     //                     child: Text(
//       //     //                         "${songList[SongDataController.currSong.value].artist}",
//       //     //                         style: TextStyle(fontSize: 14)),
//       //     //                     // ],
//       //     //                   )
//       //     //                 ],
//       //     //               ),
//       //     //             ))
//       //     //         : Container()
//       //     //     // :Container()
//       //     //     ,
//       //     //   ],
//       //     // ),

//       //     // const Spacer(),

//       //     Padding(
//       //       padding: const EdgeInsets.symmetric(horizontal: 8),
//       //       child: StreamBuilder(
//       //           stream: SongPlayerController.player.positionStream,
//       //           builder: (context, snapshot1) {
//       //             // setState(() {

//       //             // });
//       //             /* Returning to start after completion */
//       //             // setState(() {

//       //             // if(SongPlayerController.player.position==(SongPlayerController.player.duration)){
//       //             //   print("completed");
//       //             //   SongPlayerController.playing = false;
//       //             // }

//       //             if (SongPlayerController.player.processingState ==
//       //                 ProcessingState.completed) {


//       //                   // Future.delayed(Duration(milliseconds: 10)).then((value) => SongPlayerController.playing.value=false,);


//       //               ////// Add code for loop and shuffle
//       //               /* After completion song name not updating */

//       //               // SongPlayerController.playing.value = false;
//       //               // SongPlayerController.player.seek(Duration(milliseconds: 0));




//       //               SongPlayerController.player.stop();
//       //               SongPlayerController.paused = false;
//       //               SongPlayerController.playing.value = false;
//       //               // SongDataController.currSong.value =
//       //               //     (SongDataController.currSong.value + 1) % songList.length;

//       //               // try {
//       //               //   // playNext();
//       //               //   songPlayerController.playLocalSong(
//       //               //       songList[SongDataController.currSong.value].data);
//       //               //   // if (SongPlayerController.playing.value == false) {
//       //               //   //   ++SongDataController.currSong.value;
//       //               //   //   title = "Not playing";
//       //               //   // }

//       //               //   // Navigator.pop(context);
//       //               //   // Navigator.of(context).push(MaterialPageRoute(
//       //               //   //   builder: (context) => HomeNav(),
//       //               //   // ));

//       //               // } catch (e) {
//       //               //   SongDataController.currSong.value =
//       //               //       (SongDataController.currSong.value + 1) % songList.length;
//       //               // }

//       //             }





//       //             // ;
//       //             // });

//       //             // print(songPlayerController.player.playerState);
//       //             // if(songPlayerController.player.playerState.playing){
//       //             //   songPlayerController.playing = true;
//       //             //   // print("object");
//       //             // }



//       //             Duration duration = SongPlayerController.totalTime.value;
//       //             // print(duration);
//       //             // const Duration duration = Duration(seconds: 0);
//       //             // final Duration duration = SongDataController.loaded
//       //             //     ? snapshot1.data as Duration
//       //             //     : const Duration(seconds: 0);



//       //                 // : Duration(seconds: SongPlayerController.player.duration!.inSeconds);
//       //             return StreamBuilder(
//       //                 stream:
//       //                     SongPlayerController.player.bufferedPositionStream,
//       //                 builder: (context, snapshot2) {
//       //                   // if(snapshot2.data?.inMilliseconds==songList[SongDataController.currSong.value].duration){
//       //                   //   print("end it");
//       //                   //   SongPlayerController.playing.value = false;
//       //                   // }



//       //                   //  },

//       //                   // if (SongPlayerController.player.processingState == ProcessingState.completed){
//       //                   // this.setState(() {
//       //                   //   var a = stopper();
//       //                   // });
//       //                   // SongPlayerController.playing = false;
//       //                   // }



//       //                   Duration bufferedDuration = SongPlayerController.currentTime.value;
//       //                   // Duration(seconds: 0);
//       //                   // final Duration bufferedDuration = SongDataController.loaded
//       //                   //     ? snapshot2.data as Duration
//       //                   //     : const Duration(seconds: 0);
//       //                       // print(SongPlayerController.currentTime);
//       //                   return 
                        
                        
                        
                        
                        
//       //                   Column(children: [

//       //                     Row(
//       //                       mainAxisAlignment: MainAxisAlignment.start,
//       //                       children: [
//       //                         // SongDataController.loaded?
//       //                         // Flexible(
//       //                         //   child: Text(songList.length>0?
//       //                         //     "${songList[SongDataController.currSong.value].title}":"",
//       //                         //     maxLines: 1,
//       //                         //     style: Theme.of(context).textTheme.bodyLarge,
//       //                         //   ),
//       //                         // )
//       //                         songList.length > 0
//       //                             ? 
//       //                             Padding(
//       //                                 padding: EdgeInsets.all(16),
//       //                                 child: Container(
//       //                                   width: MediaQuery.of(context).size.width - 100,
//       //                                   child: Column(
//       //                                     crossAxisAlignment: CrossAxisAlignment.start,
//       //                                     children: [
//       //                                       SingleChildScrollView(
//       //                                         scrollDirection: Axis.horizontal,
//       //                                         // padding: EdgeInsets.only(top: 50),
//       //                                         child:
//       //                                             // Text("sad"),
//       //                                             // Obx(() =>
//       //                                             Text(
//       //                                                 "${songList[SongDataController.currSong.value].title}", ////// Title
//       //                                                 // "${SongPlayerController.songName.value}",
//       //                                                 style: TextStyle(
//       //                                                     fontSize: 18,
//       //                                                     fontWeight: FontWeight.bold)),

//       //                                             // ),
//       //                                         // ],
//       //                                       ),
//       //                                       SingleChildScrollView(
//       //                                         scrollDirection: Axis.horizontal,
//       //                                         // padding: EdgeInsets.only(top: 50),
//       //                                         child: Text(
//       //                                             "${songList[SongDataController.currSong.value].artist}",
//       //                                             style: TextStyle(fontSize: 14)),
//       //                                         // ],
//       //                                       )
//       //                                     ],
//       //                                   ),
//       //                                 ))
//       //                             : Container()
//       //                         // :Container()
//       //                         ,
//       //                       ],
//       //                     ),


//       //                   SizedBox(
//       //                     height: 30,
//       //                     child: Padding(
//       //                       padding: const EdgeInsets.symmetric(horizontal: 16),
//       //                       child: ProgressBar(
//       //                         progress: duration,
//       //                         total: 
//       //                         // SongPlayerController.totalTime.value,
//       //                         SongPlayerController.player.duration ??
//       //                             // Duration(seconds: songList[SongDataController.currSong.value].duration!),
//       //                             Duration(seconds: songList[0].duration!),

//       //                         // total: SongPlayerController.player.duration ??
//       //                         //     const Duration(seconds: 100),
//       //                         buffered: bufferedDuration,
//       //                         timeLabelPadding: -1,
//       //                         timeLabelTextStyle: const TextStyle(
//       //                             fontSize: 14, color: Colors.black),
//       //                         progressBarColor: Colors.red,
//       //                         baseBarColor: Colors.grey[200],
//       //                         bufferedBarColor: Colors.grey[350],
//       //                         thumbColor: Colors.red,
//       //                         onSeek: 
//       //                         SongDataController.loaded
//       //                             ? (duration) async {
//       //                                 await SongPlayerController.player
//       //                                     .seek(duration);
//       //                               }
//       //                             : null,
//       //                       ),
//       //                     ),
//       //                   ),




//       //                   Row(
//       //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       //       children: [
//       //         const SizedBox(
//       //           width: 10,
//       //         ),
//       //         IconButton(
//       //             onPressed: SongDataController.loaded
//       //                 ? () async {
//       //                     if (SongPlayerController.player.position.inSeconds >
//       //                         10) {
//       //                       await SongPlayerController.player.seek(Duration(
//       //                           seconds: SongPlayerController
//       //                                   .player.position.inSeconds -
//       //                               10));
//       //                     } else {
//       //                       await SongPlayerController.player
//       //                           .seek(const Duration(seconds: 0));
//       //                     }
//       //                   }
//       //                 : null,
//       //             icon: const Icon(Icons.fast_rewind_rounded)),
//       //         songPlayerController.completed == false
//       //             ? Container(
//       //                 height: 50,
//       //                 width: 50,
//       //                 decoration: const BoxDecoration(
//       //                     shape: BoxShape.circle, color: Colors.red),
//       //                 child: IconButton(
//       //                     ///// Icon for playing songs
//       //                     onPressed: () {
//       //                       setState(() {
//       //                         if (SongPlayerController.playing.value == true) {
//       //                           songPlayerController.pauseLocalSong();
//       //                           // SongPlayerController.playing = false;
//       //                           // SongPlayerController.paused = true;
//       //                         } else {
//       //                           if (SongPlayerController.playing.value == false) {
//       //                             songPlayerController.playLocalSong(
//       //                                 songList[SongDataController.currSong.value]
//       //                                     .data);
//       //                             // SongPlayerController.playing = true;
//       //                             // SongPlayerController.paused = false;
//       //                           }
//       //                         }
//       //                       });
//       //                     },
//       //                     icon: Icon(
//       //                       SongPlayerController.playing.value == true
//       //                           ? Icons.pause
//       //                           : Icons.play_arrow,
//       //                       color: Colors.white,
//       //                     )),
//       //               )
//       //             : Container(),
//       //         IconButton(
//       //             onPressed: SongDataController.loaded
//       //                 ? () async {
//       //                     if (SongPlayerController.player.position.inSeconds +
//       //                             10 <=
//       //                         SongPlayerController.player.duration!.inSeconds) {
//       //                       await SongPlayerController.player.seek(Duration(
//       //                           seconds: SongPlayerController
//       //                                   .player.position.inSeconds +
//       //                               10));
//       //                     } else {
//       //                       await SongPlayerController.player
//       //                           .seek(const Duration(seconds: 0));
//       //                     }
//       //                   }
//       //                 : null,
//       //             icon: const Icon(Icons.fast_forward_rounded)),
//       //         const SizedBox(
//       //           width: 10,
//       //         ),
//       //       ],
//       //     ),






                        

//       //   ]);














//       //                 });
//       //           }),
//       //     ),
//       //     const SizedBox(
//       //       height: 8,
//       //     ),









//       //     const Spacer(
//       //       flex: 2,
//       //     )
//         ],
//       ),
//     );
//   }

//   //   );
//   // }
// }














































// // import 'dart:async';
// // import 'dart:ffi';

// // import 'package:flutter/material.dart';
// // // import 'package:get/get_core/src/get_main.dart';
// // import 'package:get/get.dart';
// // // import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// // // import 'package:get/instance_manager.dart';
// // import 'package:just_audio/just_audio.dart';
// // import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
// // import 'package:linkify/controller/songPlayerController.dart';
// // import 'package:linkify/controller/song_data_contoller.dart';
// // import 'package:linkify/main.dart';
// // import 'package:linkify/widgets/homeNav.dart';
// // import 'package:linkify/widgets/local_songs.dart';
// // import 'package:marquee/marquee.dart';
// // import 'package:on_audio_query/on_audio_query.dart';
// // // var index=0;

// // // class SongPlayer extends GetxController{
// // //   final player = AudioPlayer();
// // //   void playMusic(String url) async {
// // //   await player.setAudioSource(AudioSource.uri(Uri.parse(url)));
// // //   player.play();
// // // }
// // // }

// // class Homepage extends StatefulWidget {
// //   // const Homepage({super.key});

// //   @override
// //   State<Homepage> createState() => _HomepageState();
// // }

// // enum PlayerState { playing, paused }

// // class _HomepageState extends State<Homepage> {
// //   // String musicUrl = "Users/amankumarsaw/Downloads"; // Insert your music URL
// // // String musicUrl = "/Users/amankumarsaw/Downloads/Main-Dhoondne-Ko-Zamaane-Mein_320(PaglaSongs).mp3"; // Insert your music URL
// // // var musicUrl1 = "https://www.jiosaavn.com/song/one-way-ticket/Cl9daz4EQ2I"; // Insert your music URL
// //   String thumbnailImgUrl = ""; // Insert your thumbnail URL
// //   var title = "Music Player";
// // // var player = AudioPlayer();
// //   PlayerState playerState = PlayerState.paused;
// //   // bool SongDataController.loaded = false;
// //   bool playing = false;
// // // var currSong.value = 0;
// //   SongPlayerController songPlayerController = Get.put(SongPlayerController());
// //   SongDataController songDataController = Get.put(SongDataController());
// //   // RxList<SongModel> songList = <SongModel>[].obs;
// //   RxList<SongModel> songList = SongDataController.songList;
// // // var player = songPlayerController.player;

// // // void playMusic(String url) async {
// // //   playing = true;
// // //   await player.setAudioSource(AudioSource.uri(Uri.parse(url)));
// // //   player.play();
// // // }

// //   void loadMusic() async {
// //     try {
// //       songList = await songDataController.getLocalSongs();
// //       setState(() {
// //         SongDataController.loaded = true;
// //       });
// //     } catch (e) {
// //       print("Nothing found");
// //     }
// //   }

// //   @override
// //   void initState() {
// //     // loadMusic();
// //     // await read();
// // // print(player.playerState);
// // // if(player.playerState==ProcessingState.completed){

// // // }
// //     super.initState();
// //   }

// // // @override
// // // void dispose() {
// // // songPlayerController.player.dispose();
// // // super.dispose();
// // // }

// // // Future<int> stopper()async{
// // //   setState(() {
// // //     SongPlayerController.playing.value = false;
// // //     // songPlayerController.completed = true;
// // //   });
// // //   return 1;
// // // }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("${title}"),
// //         actions: <Widget>[
// //           IconButton(
// //             icon: Icon(
// //               Icons.more_vert,
// //               color: Colors.black,
// //             ),
// //             onPressed: () {
// //               // do something
// //               // print(songList[0].title);
// //               Navigator.pop(context);
// //               Navigator.of(context).pushReplacement(MaterialPageRoute(
// //                   builder: (context) => LocalSongList(songList: songList)));
// //             },
// //           )
// //         ],
// //       ),
// //       body: Column(
// //         children: [
// //           const Spacer(
// //             flex: 2,
// //           ),

// //           ////////  UNCOMMENT IT  //////////
// //           // ClipRRect(
// //           // 	borderRadius: BorderRadius.circular(8),
// //           // 	child: Image.network(
// //           // 	thumbnailImgUrl,
// //           //   // songList[SongDataController.currSong.value].uri!,
// //           // 	height: 350,
// //           // 	width: 350,
// //           // 	fit: BoxFit.cover,
// //           // 	),
// //           // ),
// //           const Spacer(),


          

// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.start,
// //             children: [
// //               // SongDataController.loaded?
// //               // Flexible(
// //               //   child: Text(songList.length>0?
// //               //     "${songList[SongDataController.currSong.value].title}":"",
// //               //     maxLines: 1,
// //               //     style: Theme.of(context).textTheme.bodyLarge,
// //               //   ),
// //               // )
// //               songList.length > 0
// //                   ? 
// //                   Padding(
// //                       padding: EdgeInsets.all(16),
// //                       child: Container(
// //                         width: MediaQuery.of(context).size.width - 100,
// //                         child: Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             SingleChildScrollView(
// //                               scrollDirection: Axis.horizontal,
// //                               // padding: EdgeInsets.only(top: 50),
// //                               child:
// //                                   // Text("sad"),
// //                                   // Obx(() =>
// //                                   Text(
// //                                       "${songList[SongDataController.currSong.value].title}", ////// Title
// //                                       // "${SongPlayerController.songName.value}",
// //                                       style: TextStyle(
// //                                           fontSize: 18,
// //                                           fontWeight: FontWeight.bold)),

// //                                   // ),
// //                               // ],
// //                             ),
// //                             SingleChildScrollView(
// //                               scrollDirection: Axis.horizontal,
// //                               // padding: EdgeInsets.only(top: 50),
// //                               child: Text(
// //                                   "${songList[SongDataController.currSong.value].artist}",
// //                                   style: TextStyle(fontSize: 14)),
// //                               // ],
// //                             )
// //                           ],
// //                         ),
// //                       ))
// //                   : Container()
// //               // :Container()
// //               ,
// //             ],
// //           ),

// //           // const Spacer(),

// //           Obx(() => 
// //           // SongPlayerController.playing.value == true?Container():Container(height:20,width:20,color:Colors.red)

// //           Padding(
// //             padding: const EdgeInsets.symmetric(horizontal: 8),
// //               child:
// //                 SizedBox(
// //                           height: 30,
// //                           child: Padding(
// //                             padding: const EdgeInsets.symmetric(horizontal: 16),
// //                             child: ProgressBar(
// //                               progress: SongPlayerController.currentTime.value,
// //                               total: SongPlayerController.player.duration ??
// //                                   const Duration(seconds: 0),
// //                               buffered: SongPlayerController.totalTime.value,
// //                               timeLabelPadding: -1,
// //                               timeLabelTextStyle: const TextStyle(
// //                                   fontSize: 14, color: Colors.black),
// //                               progressBarColor: Colors.red,
// //                               baseBarColor: Colors.grey[200],
// //                               bufferedBarColor: Colors.grey[350],
// //                               thumbColor: Colors.red,
// //                               onSeek: SongDataController.loaded
// //                                   ? (duration) async {
// //                                       await SongPlayerController.player
// //                                           .seek(duration);
// //                                     }
// //                                   : null,
// //                             ),
// //                           ),
// //                         ),
















// //             // child: StreamBuilder(
// //             //     stream: SongPlayerController.player.positionStream,
// //             //     builder: (context, snapshot1) {
// //             //       // setState(() {

// //             //       // });
// //             //       /* Returning to start after completion */
// //             //       // setState(() {

// //             //       // if(SongPlayerController.player.position==(SongPlayerController.player.duration)){
// //             //       //   print("completed");
// //             //       //   SongPlayerController.playing = false;
// //             //       // }

// //             //       if (SongPlayerController.player.processingState ==
// //             //           ProcessingState.completed) {
// //             //         ////// Add code for loop and shuffle
// //             //         /* After completion song name not updating */

// //             //         // SongPlayerController.playing.value = false;
// //             //         // SongPlayerController.player.seek(Duration(milliseconds: 0));
// //             //         SongPlayerController.player.stop();
// //             //         SongPlayerController.paused = false;
// //             //         SongDataController.currSong.value =
// //             //             (SongDataController.currSong.value + 1) % songList.length;

// //             //         try {
// //             //           // playNext();
// //             //           songPlayerController.playLocalSong(
// //             //               songList[SongDataController.currSong.value].data);
// //             //           // if (SongPlayerController.playing.value == false) {
// //             //           //   ++SongDataController.currSong.value;
// //             //           //   title = "Not playing";
// //             //           // }

// //             //           // Navigator.pop(context);
// //             //           // Navigator.of(context).push(MaterialPageRoute(
// //             //           //   builder: (context) => HomeNav(),
// //             //           // ));

// //             //         } catch (e) {
// //             //           SongDataController.currSong.value =
// //             //               (SongDataController.currSong.value + 1) % songList.length;
// //             //           // songPlayerController.playLocalSong(
// //             //           //     songList[SongDataController.currSong.value].data);


// //             //           // Navigator.of(context).push(MaterialPageRoute(
// //             //           //   builder: (context) => HomeNav(),
// //             //           // ));
// //             //         }


// //             //         // Navigator.pop(context);

// //             //         // songPlayerController.completed=true;

// //             //         // Future.wait([
// //             //         //     stopper(),
// //             //         //   ]);

// //             //         // this.setState(() {
// //             //         // SongPlayerController.playing = false;
// //             //         // });
// //             //         // stopper();
// //             //         // SongPlayerController.completed = true;
// //             //       }
// //             //       // ;
// //             //       // });

// //             //       // print(songPlayerController.player.playerState);
// //             //       // if(songPlayerController.player.playerState.playing){
// //             //       //   songPlayerController.playing = true;
// //             //       //   // print("object");
// //             //       // }

// //             //       final Duration duration = SongDataController.loaded
// //             //           ? snapshot1.data as Duration
// //             //           : const Duration(seconds: 0);
// //             //       // return StreamBuilder(
// //             //       //     stream:
// //             //       //         SongPlayerController.player.bufferedPositionStream,
// //             //       //     builder: (context, snapshot2) {




// //             //             // if(snapshot2.data?.inMilliseconds==songList[SongDataController.currSong.value].duration){
// //             //             //   print("end it");
// //             //             //   SongPlayerController.playing.value = false;
// //             //             // }



// //             //             //  },

// //             //             // if (SongPlayerController.player.processingState == ProcessingState.completed){
// //             //             // this.setState(() {
// //             //             //   var a = stopper();
// //             //             // });
// //             //             // SongPlayerController.playing = false;
// //             //             // }

// //             //             Duration bufferedDuration = Duration(seconds:0);
// //             //             //  = SongDataController.loaded
// //             //             //     ? songList[SongDataController.currSong.value].duration
// //             //             //     : const Duration(seconds: 0);


// //             //             return 




                        
// //             //             SizedBox(
// //             //               height: 30,
// //             //               child: Padding(
// //             //                 padding: const EdgeInsets.symmetric(horizontal: 16),
// //             //                 child: ProgressBar(
// //             //                   progress: duration,
// //             //                   total: SongPlayerController.player.duration ??
// //             //                       const Duration(seconds: 0),
// //             //                   buffered: bufferedDuration,
// //             //                   timeLabelPadding: -1,
// //             //                   timeLabelTextStyle: const TextStyle(
// //             //                       fontSize: 14, color: Colors.black),
// //             //                   progressBarColor: Colors.red,
// //             //                   baseBarColor: Colors.grey[200],
// //             //                   bufferedBarColor: Colors.grey[350],
// //             //                   thumbColor: Colors.red,
// //             //                   onSeek: SongDataController.loaded
// //             //                       ? (duration) async {
// //             //                           await SongPlayerController.player
// //             //                               .seek(duration);
// //             //                         }
// //             //                       : null,
// //             //                 ),
// //             //               ),
// //             //             );



// //             //           // }
// //             //           // );
// //             //     }),
// //           ),),
// //           const SizedBox(
// //             height: 8,
// //           ),



// //           Obx(() => 
// //           // if(SongPlayerController.player.processingState == ProcessingState.completed){
// //           //       Row(children: [Text("hello")],),
// //           //     }
// //               // SongPlayerController.player.processingState == ProcessingState.completed?:
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //             children: [
// //               const SizedBox(
// //                 width: 10,
// //               ),



// //               // if(SongPlayerController.player.processingState == ProcessingState.completed)...{
// //               //   Row(children: [Text("hello")],),
// //               // },



// //               IconButton(
// //                   onPressed: SongDataController.loaded
// //                       ? () async {
// //                           if (SongPlayerController.player.position.inSeconds >
// //                               10) {
// //                             await SongPlayerController.player.seek(Duration(
// //                                 seconds: SongPlayerController
// //                                         .player.position.inSeconds -
// //                                     10));
// //                           } else {
// //                             await SongPlayerController.player
// //                                 .seek(const Duration(seconds: 0));
// //                           }
// //                         }
// //                       : null,
// //                   icon: const Icon(Icons.fast_rewind_rounded)),
// //               songPlayerController.completed == false
// //                   ? Container(
// //                       height: 50,
// //                       width: 50,
// //                       decoration: const BoxDecoration(
// //                           shape: BoxShape.circle, color: Colors.red),
// //                       child: IconButton(
// //                           ///// Icon for playing songs
// //                           onPressed: () async {
// //                             // Future.delayed(Duration(seconds: 4)).then((value) => print("hhhiiiiii"),);
// //                             setState(() {
// //                               if (SongPlayerController.playing.value == true) {
// //                                 songPlayerController.pauseLocalSong();
// //                                 // SongPlayerController.playing = false;
// //                                 // SongPlayerController.paused = true;
// //                               } else {
// //                                 if (SongPlayerController.playing.value == false) {
                                    

// //                                   songPlayerController.playLocalSong(
// //                                       songList[SongDataController.currSong.value]
// //                                           .data);
// //                                   // SongPlayerController.playing = true;
// //                                   // SongPlayerController.paused = false;
// //                                 }
// //                               }
// //                             });
// //                           },
// //                           icon: Icon(
// //                             SongPlayerController.playing.value == true
// //                                 ? Icons.pause
// //                                 : Icons.play_arrow,
// //                             color: Colors.white,
// //                           ),
                          
                          
// //                           ),
// //                     )
// //                   : Container(),
// //               IconButton(
// //                   onPressed: SongDataController.loaded
// //                       ? () async {
// //                           if (SongPlayerController.player.position.inSeconds +
// //                                   10 <=
// //                               SongPlayerController.player.duration!.inSeconds) {
// //                             await SongPlayerController.player.seek(Duration(
// //                                 seconds: SongPlayerController
// //                                         .player.position.inSeconds +
// //                                     10));
// //                           } else {
// //                             await SongPlayerController.player
// //                                 .seek(const Duration(seconds: 0));
// //                           }
// //                         }
// //                       : null,
// //                   icon: const Icon(Icons.fast_forward_rounded)),
// //               const SizedBox(
// //                 width: 10,
// //               ),
// //             ],
// //           ),
// //           ),







          
// //           const Spacer(
// //             flex: 2,
// //           )
// //         ],
// //       ),
// //     );
// //   }

// //   //   );
// //   // }
// // }
