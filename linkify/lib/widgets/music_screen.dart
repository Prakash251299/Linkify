// // import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:linkify/controller/static_store.dart';
// import 'package:linkify/widgets/player_buttons.dart';
// import 'package:linkify/widgets/seekbar.dart';
// import 'package:linkify/widgets/uis/models/song_model.dart';
// // import 'package:rxdart/rxdart.dart' as rxdart;

// class SongScreen extends StatefulWidget {
//   SongModel songs;
//   SongScreen(this.songs, {super.key});
//   // SongScreen(this.name, this.image, {super.key});
//   // SongScreen({Key? key}) : super(key: key),this.songs;

//   @override
//   // State<SongScreen> createState() => _SongScreenState(songs);
//   State<SongScreen> createState() => _SongScreenState();
// }

// class _SongScreenState extends State<SongScreen> {
//   // SongModel songs;
//   // _SongScreenState(this.songs);
//   // AudioPlayer audioPlayer = AudioPlayer();
//   // Song song = Get.arguments ?? Song.songs[0];

//   @override
//   void initState() {
//     StaticStore.musicScreenEnabled = true;
//     super.initState();

//     // audioPlayer.setAudioSource(
//     //   ConcatenatingAudioSource(
//     //     children: [
//     //       // AudioSource.uri(
//     //       //   Uri.parse('asset:///${song.url}'),
//     //       // ),
//     //     ],
//     //   ),
//     // );
//   }

//   @override
//   void dispose() {
//     // audioPlayer.dispose();
//     super.dispose();
//   }

//   // Stream<SeekBarData> get _seekBarDataStream =>
//   //     rxdart.Rx.combineLatest2<Duration, Duration?, SeekBarData>(
//   //         audioPlayer.positionStream, audioPlayer.durationStream, (
//   //       Duration position,
//   //       Duration? duration,
//   //     ) {
//   //       return SeekBarData(
//   //         position,
//   //         duration ?? Duration.zero,
//   //       );
//   //     });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon:Icon(Icons.arrow_back_outlined,color: Colors.white),
//           onPressed:(){
//             setState((){
//               StaticStore.musicScreenEnabled = false;
//             });
//             Navigator.pop(context);
//           }
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       extendBodyBehindAppBar: true,
//       body: Stack(
//         alignment: Alignment.topCenter,
//         fit: StackFit.expand,
//         children: [
          
//           // Image.asset(
//           //   widget.songs.imgUrl,
//             // fit: BoxFit.cover,
//           // ),
//           const _BackgroundFilter(),
//           _MusicPlayer(
//             widget.songs,
//             // seekBarDataStream: _seekBarDataStream,
//             // audioPlayer: audioPlayer,
//           ),



//           Padding(
//             padding: const EdgeInsets.only(
//               bottom: 200.0,
//               left:20,
//               right:20,
//               // vertical: 200.0,
//             ),
//             child:
//           Container(
//             // height:30,
//           //   child:
//           // ClipRect(
            
//             child: Image.network(
//                               widget.songs.imgUrl,
//                               // fit: BoxFit.fill,
//                               // width: 300 - _counter < 70 ? 70 : 300 - _counter,
//                               // height: 300 - _counter < 70 ? 70 : 300 - _counter,
//                               loadingBuilder: (BuildContext context, Widget child,
//                                   ImageChunkEvent? loadingProgress) {
//                                 if (loadingProgress == null) return child;
//                                 return Center(
//                                   child: CircularProgressIndicator(
//                                     value: loadingProgress.expectedTotalBytes != null
//                                         ? loadingProgress.cumulativeBytesLoaded /
//                                         loadingProgress.expectedTotalBytes!
//                                         : null,
//                                   ),
//                                 );
//                               },
//                             ),
//           ),
//           ),



//           _MusicPlayer(
//             widget.songs,
//             // seekBarDataStream: _seekBarDataStream,
//             // audioPlayer: audioPlayer,
//           ),
//           // const _BackgroundFilter(),
//           // ),
//         ],
//       ),
//     );
//   }
// }

// class _MusicPlayer extends StatelessWidget {
//   SongModel songs;
//   _MusicPlayer(this.songs);
//   @override
//   Widget build(BuildContext context) {
//     // StaticStore.currentArtists.add(songs.artists);
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 20.0,
//         // vertical: 50.0,
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             // song.title,
//             // "Song name",
//             songs.name,
//             overflow: TextOverflow.ellipsis,
//             style: Theme.of(context).textTheme.headlineSmall!.copyWith(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//           ),
//           const SizedBox(height: 10),
//           Text(
//             // song.description,
//             // "Beautiful Artist name",
//             songs.artists.length>1?
//             "${songs.artists[0]}, ${songs.artists[1]}":"${songs.artists[0]}",
//             maxLines: 2,
//             style: Theme.of(context)
//                 .textTheme
//                 .bodySmall!
//                 .copyWith(color: Colors.white),
//                 overflow: TextOverflow.ellipsis,
//           ),
//           // const SizedBox(height: 30),
//           // StreamBuilder<SeekBarData>(
//           //   stream: _seekBarDataStream,
//           //   builder: (context, snapshot) {
//           //     final positionData = snapshot.data;
//           //     return 
//               // create the seekbar here
//               // SizedBox(),
//               SeekBar(
//                 // position: positionData?.position ?? Duration.zero,
//                 // duration: positionData?.duration ?? Duration.zero,
//                 // onChangeEnd: audioPlayer.seek,
//               ),
//           //   },
//           // ),
//           PlayerButtons(songs),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               IconButton(
//                 iconSize: 35,
//                 onPressed: () {},
//                 icon: const Icon(
//                   Icons.settings,
//                   color: Colors.white,
//                 ),
//               ),
//               IconButton(
//                 iconSize: 35,
//                 onPressed: () {},
//                 icon: const Icon(
//                   Icons.menu,
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _BackgroundFilter extends StatelessWidget {
//   const _BackgroundFilter({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return 
//     // ShaderMask(
//     //   shaderCallback: (rect) {
//         // return 
//         // LinearGradient(
//         //     begin: Alignment.topCenter,
//         //     end: Alignment.bottomCenter,
//         //     colors: [
//         //       // Colors.white,
//         //       // Colors.white,
//         //       // Colors.white.withOpacity(0.5),
//         //       // Colors.white.withOpacity(0.0),

//         //       Colors.black,
//         //       Colors.black.withOpacity(0.5),
//         //       Colors.black.withOpacity(0.0),
//         //     ],
//         //     stops: const [
//         //       0.0,
//         //       0.4,
//         //       0.6
//         //     ]).createShader(rect);

//       // },
//       // blendMode: BlendMode.dstOut,

//       // child: 
//       Container(
//         child:
//         ClipRect(), // put song image here


//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Colors.brown,
//               Colors.black,
//             ],
//           ),
//         ),
        
//         // SizedBox(),
//       // ),
//     );
//   }
// }



















// // import 'package:flutter/material.dart';

// // class MusicScreen extends StatelessWidget {
// //   // const MyApp({super.key});

// //   // This widget is the root of your application.
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Music screen',
// //       theme: ThemeData(
// //         // This is the theme of your application.
// //         //
// //         // TRY THIS: Try running your application with "flutter run". You'll see
// //         // the application has a purple toolbar. Then, without quitting the app,
// //         // try changing the seedColor in the colorScheme below to Colors.green
// //         // and then invoke "hot reload" (save your changes or press the "hot
// //         // reload" button in a Flutter-supported IDE, or press "r" if you used
// //         // the command line to start the app).
// //         //
// //         // Notice that the counter didn't reset back to zero; the application
// //         // state is not lost during the reload. To reset the state, use hot
// //         // restart instead.
// //         //
// //         // This works for code too, not just values: Most code changes can be
// //         // tested with just a hot reload.
// //         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
// //         useMaterial3: true,
// //       ),
// //       home: const MyHomePage(title: 'Music player screen'),
// //     );
// //   }
// // }

// // class MyHomePage extends StatefulWidget {
// //   const MyHomePage({super.key, required this.title});

// //   // This widget is the home page of your application. It is stateful, meaning
// //   // that it has a State object (defined below) that contains fields that affect
// //   // how it looks.

// //   // This class is the configuration for the state. It holds the values (in this
// //   // case the title) provided by the parent (in this case the App widget) and
// //   // used by the build method of the State. Fields in a Widget subclass are
// //   // always marked "final".

// //   final String title;

// //   @override
// //   State<MyHomePage> createState() => _MyHomePageState();
// // }

// // class _MyHomePageState extends State<MyHomePage> {

// //   @override
// //   Widget build(BuildContext context) {
// //     // This method is rerun every time setState is called, for instance as done
// //     // by the _incrementCounter method above
// //     //
// //     // The Flutter framework has been optimized to make rerunning build methods
// //     // fast, so that you can just rebuild anything that needs updating rather
// //     // than having to individually change instances of widgets.
// //     return Scaffold(
// //       appBar: AppBar(
// //         // TRY THIS: Try changing the color here to a specific color (to
// //         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
// //         // change color while the other colors stay the same.
// //         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
// //         // Here we take the value from the MyHomePage object that was created by
// //         // the App.build method, and use it to set our appbar title.
// //         title: Text(widget.title),
// //       ),
// //       body: Center(
// //         // Center is a layout widget. It takes a single child and positions it
// //         // in the middle of the parent.
// //         child: 
// //         Column(children: [

// //                           Row(
// //                             mainAxisAlignment: MainAxisAlignment.start,
// //                             children: [
// //                               // SongDataController.loaded?
// //                               // Flexible(
// //                               //   child: Text(songList.length>0?
// //                               //     "${songList[SongDataController.currSong.value].title}":"",
// //                               //     maxLines: 1,
// //                               //     style: Theme.of(context).textTheme.bodyLarge,
// //                               //   ),
// //                               // )
// //                               // songList.length > 0
// //                                   // ? 
// //                                   Padding(
// //                                       padding: EdgeInsets.all(16),
// //                                       child: Container(
// //                                         width: MediaQuery.of(context).size.width - 100,
// //                                         child: Column(
// //                                           crossAxisAlignment: CrossAxisAlignment.start,
// //                                           children: [
// //                                             SingleChildScrollView(
// //                                               scrollDirection: Axis.horizontal,
// //                                               // padding: EdgeInsets.only(top: 50),
// //                                               child:
// //                                                   // Text("sad"),
// //                                                   // Obx(() =>
// //                                                   Text(
// //                                                     "Heelo",
// //                                                       // songList[SongDataController.currSong.value].title, ////// Title
// //                                                       // // "${SongPlayerController.songName.value}",
// //                                                       // style: const TextStyle(
// //                                                       //     fontSize: 18,
// //                                                       //     fontWeight: FontWeight.bold)),

// //                                                   ),
// //                                               // ],
// //                                             ),
// //                                             SingleChildScrollView(
// //                                               scrollDirection: Axis.horizontal,
// //                                               // padding: EdgeInsets.only(top: 50),
// //                                               child: Text(
// //                                                 "Hello1",
// //                                                   // "${songList[SongDataController.currSong.value].artist}",
// //                                                   // style: TextStyle(fontSize: 14)
// //                                                   ),
// //                                               // ],
// //                                             )
// //                                           ],
// //                                         ),
// //                                       ))
// //                                   // : Container()
// //                               // :Container()
// //                               ,
// //                             ],
// //                           ),


// //                         SizedBox(
// //                           height: 30,
// //                           child: Padding(
// //                             padding: const EdgeInsets.symmetric(horizontal: 16),
// //                             child: 
// //                             SizedBox(),
// //                             // ProgressBar(
// //                             //   // progress: duration,
// //                             //   progress: SongPlayerController.currentTime.value,
// //                             //   total: 
// //                             //   SongPlayerController.totalTime.value,
// //                             //   // SongPlayerController.player.duration ??
// //                             //   //     Duration(seconds: songList[SongDataController.currSong.value].duration!),
// //                             //       // Duration(seconds: songList[0].duration!),

// //                             //   // total: SongPlayerController.player.duration ??
// //                             //   //     const Duration(seconds: 100),
// //                             //   buffered: bufferedDuration,
// //                             //   timeLabelPadding: -1,
// //                             //   timeLabelTextStyle: const TextStyle(
// //                             //       fontSize: 14, color: Colors.black),
// //                             //   progressBarColor: Colors.red,
// //                             //   baseBarColor: Colors.grey[200],
// //                             //   bufferedBarColor: Colors.grey[350],
// //                             //   thumbColor: Colors.red,
// //                             //   onSeek: 
// //                             //   SongDataController.loaded
// //                             //       ? (duration) async {
// //                             //           await SongPlayerController.player
// //                             //               .seek(duration);
// //                             //         }
// //                             //       : null,
// //                             // ),
// //                           ),
// //                         ),




// //                         Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //             children: [
// //               const SizedBox(
// //                 width: 10,
// //               ),
// //               IconButton(
// //                   onPressed: (){},
// //                   // SongDataController.loaded
// //                   //     ? () async {
// //                   //         if (SongPlayerController.player.position.inSeconds >
// //                   //             10) {
// //                   //           await SongPlayerController.player.seek(Duration(
// //                   //               seconds: SongPlayerController
// //                   //                       .player.position.inSeconds -
// //                   //                   10));
// //                   //         } else {
// //                   //           await SongPlayerController.player
// //                   //               .seek(const Duration(seconds: 0));
// //                   //         }
// //                   //       }
// //                   //     : null,
// //                   icon: const Icon(Icons.fast_rewind_rounded)),
// //               // songPlayerController.completed == false
// //               //     ? 
// //                   Container(
// //                       height: 50,
// //                       width: 50,
// //                       decoration: const BoxDecoration(
// //                           shape: BoxShape.circle, color: Colors.red),
// //                       child: IconButton(
// //                           ///// Icon for playing songs
// //                           onPressed: () {
// //                             // setState(() {
// //                             //   if (SongPlayerController.playing.value == true) {
// //                             //     songPlayerController.pauseLocalSong();
// //                             //     // SongPlayerController.playing = false;
// //                             //     // SongPlayerController.paused = true;
// //                             //   } else {
// //                             //     if (SongPlayerController.playing.value == false) {
// //                             //       songPlayerController.playLocalSong(
// //                             //           songList[SongDataController.currSong.value]
// //                             //               .data);
// //                             //       // SongPlayerController.playing = true;
// //                             //       // SongPlayerController.paused = false;
// //                             //     }
// //                             //   }
// //                             // });
// //                           },
// //                           icon: 
// //                           Icon(Icons.play_arrow

// //                             // SongPlayerController.playing.value == true
// //                             //     ? Icons.pause
// //                             //     : Icons.play_arrow,
// //                             // color: Colors.white,
// //                           )
// //                           )
// //                     ),
// //                   // : Container(),
// //               IconButton(
// //                   onPressed: (){},
// //                   // SongDataController.loaded
// //                   //     ? () async {
// //                   //         if (SongPlayerController.player.position.inSeconds +
// //                   //                 10 <=
// //                   //             SongPlayerController.player.duration!.inSeconds) {
// //                   //           await SongPlayerController.player.seek(Duration(
// //                   //               seconds: SongPlayerController
// //                   //                       .player.position.inSeconds +
// //                   //                   10));
// //                   //         } else {
// //                   //           await SongPlayerController.player
// //                   //               .seek(const Duration(seconds: 0));
// //                   //         }
// //                   //       }
// //                   //     : null,
// //                   icon: const Icon(Icons.fast_forward_rounded)),
// //               const SizedBox(
// //                 width: 10,
// //               ),
// //             ],
// //           ),






                        

// //         ]),
// //     ));
// //   }
// // }