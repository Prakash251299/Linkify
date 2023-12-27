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
import 'package:linkify/widgets/local_songs.dart';
import 'package:on_audio_query/on_audio_query.dart';

// class SongPlayer extends GetxController{
//   final player = AudioPlayer();
//   void playMusic(String url) async {
//   await player.setAudioSource(AudioSource.uri(Uri.parse(url)));
//   player.play();
// }
// }

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}
  enum PlayerState {playing, paused}

class _HomepageState extends State<Homepage> {



  // String musicUrl = "Users/amankumarsaw/Downloads"; // Insert your music URL 
// String musicUrl = "/Users/amankumarsaw/Downloads/Main-Dhoondne-Ko-Zamaane-Mein_320(PaglaSongs).mp3"; // Insert your music URL 
// var musicUrl1 = "https://www.jiosaavn.com/song/one-way-ticket/Cl9daz4EQ2I"; // Insert your music URL
String thumbnailImgUrl = "https://www.jiosaavn.com/song/one-way-ticket/Cl9daz4EQ2I"; // Insert your thumbnail URL
// var player = AudioPlayer(); 
PlayerState audioplayerstate = PlayerState.paused;
bool loaded = false; 
bool playing = false; 
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
  try{
    songList = await songDataController.getLocalSongs();
    setState(() {
      loaded = true;
    });
  }
  catch(e){
    print("Nothing found");
  }
} 

@override 
void initState(){
loadMusic(); // Can be made await
// print(player.playerState);
// if(player.playerState==ProcessingState.completed){

// }
super.initState(); 
} 

@override 
void dispose() {
songPlayerController.player.dispose();
super.dispose();
}

@override
Widget build(BuildContext context) {
	return Scaffold( 
	appBar: AppBar( 
		title: const Text("Music Player"),
    actions: <Widget>[
      IconButton(
        icon: Icon(
          Icons.more_vert,
          color: Colors.black,
        ),
        onPressed: () {
          // do something
          // print(songList[0].title);
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => LocalSongList(songList:songList)));
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
		// 	height: 350, 
		// 	width: 350, 
		// 	fit: BoxFit.cover, 
		// 	), 
		// ), 
		const Spacer(), 
		Padding( 
			padding: const EdgeInsets.symmetric(horizontal: 8), 
			child: StreamBuilder(
				stream: songPlayerController.player.positionStream,
				builder: (context, snapshot1) {
        /* Returning to start after completion */ 
        if (songPlayerController.player.processingState == ProcessingState.completed){  ////// Add code for loop and shuffle
          songPlayerController.player.seek(Duration(milliseconds: 0));
          songPlayerController.playing = false;
          songPlayerController.player.stop();
        };

        // print(songPlayerController.player.playerState);
        if(songPlayerController.player.playerState.playing){
          songPlayerController.playing = true;
          // print("object");
        }

				final Duration duration = loaded
					? snapshot1.data as Duration 
					: const Duration(seconds: 0); 
				return StreamBuilder(
					stream: songPlayerController.player.bufferedPositionStream, 
					builder: (context, snapshot2) {
            // if (songPlayerController.player.processingState == ProcessingState.completed) {
            //   print("Completed");
            // }
            //  },




						final Duration bufferedDuration = loaded
							? snapshot2.data as Duration 
							: const Duration(seconds: 0); 
						return SizedBox( 
						height: 30, 
						child: Padding( 
							padding: const EdgeInsets.symmetric(horizontal: 16), 
							child: ProgressBar( 
							progress: duration, 
							total: 
								songPlayerController.player.duration ?? const Duration(seconds: 0), 
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
									await songPlayerController.player.seek(duration);
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
						if (songPlayerController.player.position.inSeconds > 10) {
              await songPlayerController.player.seek(Duration(seconds: songPlayerController.player.position.inSeconds-10));
						} else {
							await songPlayerController.player.seek(const Duration(seconds: 0));
						} 
						} 
					: null, 
				icon: const Icon(Icons.fast_rewind_rounded)),
			Container( 
				height: 50, 
				width: 50, 
				decoration: const BoxDecoration( 
					shape: BoxShape.circle, color: Colors.red), 
				child: 
        IconButton(    ///// Icon for playing songs
          onPressed: (){
            // print(songPlayerController.player.duration?.inMilliseconds);
            // loadMusic();
            // songPlayerController.playLocalSongs(songList.value[0].data);
            // songDataController.getLocalSongs();

            // playMusic();

          // print(player.playerState);


          loaded 
          ? (songPlayerController.playing?songPlayerController.pauseLocalSong():songPlayerController.playLocalSong(songList.value[0].data)):null;
						// ? () {
						// 	if (playing) {
						// 	pauseMusic();
						// 	} else { 
						// 	songPlayerController.playLocalSongs(songList.value[0].data);
						// 	}
						// }:
            // null;
          },
					// onPressed: 
					// 	: null, 
					icon: Icon( 
					songPlayerController.playing ? Icons.pause : Icons.play_arrow,
					color: Colors.white, 
					)), 
			), 
			IconButton( 
				onPressed: loaded 
					? () async { 
						if (songPlayerController.player.position.inSeconds + 10 <= 
							songPlayerController.player.duration!.inSeconds) { 
							await songPlayerController.player.seek(Duration( 
								seconds: songPlayerController.player.position.inSeconds + 10));
						} else { 
							await songPlayerController.player.seek(const Duration(seconds: 0));
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