// import 'package:cached_network_image/cached_network_image.dart';

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:just_audio/just_audio.dart';
// import 'package:line_icons/line_icons.dart';
// import 'package:linkify/controller/queue_track.dart';
// import 'package:get/get.dart';
// import 'package:just_audio/just_audio.dart';
import 'package:linkify/controller/variables/static_store.dart';
import 'package:linkify/view/music_screen/carousel_player_button.dart';
import 'package:linkify/view/local_music/local_seekbar.dart';
import 'package:linkify/view/local_music/songplayer_buttons.dart';
import 'package:linkify/view/music_screen/queue_screen.dart';
// import 'package:linkify/widgets/player_buttons.dart';
import 'package:linkify/view/music_screen/seekbar.dart';
import 'package:linkify/view/sticky/sticky_widgets.dart';
import 'package:on_audio_query/on_audio_query.dart';
// import 'package:linkify/widgets/uis/screens/home/home_screen.dart';
// import 'package:linkify/widgets/uis/screens/library/library.dart';
// import 'package:linkify/widgets/uis/screens/search_page/search_page.dart';
// import 'package:linkify/widgets/uis/methods/log.dart';
// import 'package:linkify/widgets/uis/models/song_model.dart';
// import 'package:rxdart/rxdart.dart' as rxdart;

class LocalSongScreen extends StatefulWidget {
  // SongModel songs;
  // widget.name[position],
  // widget.albumImg[position],
  // widget.trackId[position],
  // widget.trackArtists[position],
  List<SongModel> songList = [];
  var name;
  // var albumImg;
  var trackId;
  var trackArtists;
  var trackImg;

  LocalSongScreen(
      this.songList,
      this.name,
      // this.albumImg,
      this.trackId,
      this.trackArtists,
      this.trackImg);
  // SongScreen({Key? key}) : super(key: key),this.songs;

  @override
  // State<SongScreen> createState() => _SongScreenState(songs);
  State<LocalSongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<LocalSongScreen> {
  // SongModel songs;
  // _SongScreenState(this.songs);
  // AudioPlayer audioPlayer = AudioPlayer();
  // Song song = Get.arguments ?? Song.songs[0];

  @override
  void initState() {
    StaticStore.musicScreenEnabled = true;
    log('CheckState: initState');
    super.initState();
  }

  @override
  void dispose() {
    // audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // log('CheckState: build');
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_outlined, color: Colors.white),
            onPressed: () {
              setState(() {
                StaticStore.musicScreenEnabled = false;
              });
              Navigator.pop(context);
            }),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: StreamBuilder<Object>(
          stream: StaticStore.player.playerStateStream,
          builder: (context, snapshot) {
            return Stack(
              fit: StackFit.expand,
              children: [
                const _BackgroundFilter(),
                _MusicPlayer(
                    widget.songList,
                    widget.name,
                    // widget.albumImg,
                    widget.trackId,
                    widget.trackArtists,
                    widget.trackImg),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 270.0,
                    left: 20,
                    right: 20,
                    // vertical: 200.0,
                  ),
                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 45 / 100,
                      // width: MediaQuery.of(context).size.height/2,

                      //   child:
                      // ClipRect(

                      child:
                          // StaticStore.myQueueTrack.length>StaticStore.queueIndex?

                          StaticStore.currentSongImg != ""
                              ? Image.network(
                                  StaticStore.currentSongImg,
                                  // "",

                                  // widget.trackImg,
                                  // fit: BoxFit.fill,
                                  // width: 300 - _counter < 70 ? 70 : 300 - _counter,
                                  // height: 300 - _counter < 70 ? 70 : 300 - _counter,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                                )
                              : Container(
                                  height: MediaQuery.of(context).size.height *
                                      60 /
                                      100,
                                  // height:100,
                                  // width: 1000,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            (AssetImage('icon/linkify.jpeg')),
                                        fit: BoxFit.fitHeight),
                                  ),
                                ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}

class _MusicPlayer extends StatelessWidget {
  // SongModel songs;
  List<SongModel> songList = [];
  var trackName;
  // var albumImg;
  var trackId;
  var trackArtists;
  var trackImg;
  _MusicPlayer(
      this.songList,
      this.trackName,
      // this.albumImg,
      this.trackId,
      this.trackArtists,
      this.trackImg);
  @override
  Widget build(BuildContext context) {
    // StaticStore.currentArtists.add(trackArtists);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        // vertical: 10.0,
      ),
      child: StreamBuilder<Object>(
          stream: StaticStore.player.playerStateStream,
          // stream: null,
          builder: (context, snapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  StaticStore.currentSong,
                  // StaticStore.myQueueTrack.length>StaticStore.queueIndex?
                  // "${StaticStore.myQueueTrack[StaticStore.queueIndex].name}":trackName,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  StaticStore.currentArtists.isEmpty
                      ? "unknown"
                      : StaticStore.currentArtists[0],
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
                // SeekBar(),
                LocalSeekBar(songList),
                // LocalSee
                //   },
                // ),
                SongPlayerButtons(
                  this.songList,
                  this.trackName,
                  this.trackId,
                  this.trackArtists,
                  this.trackImg,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    StreamBuilder<Object>(
                        stream: StaticStore.player.loopModeStream,
                        builder: (context, snapshot) {
                          return IconButton(
                            iconSize: 35,
                            onPressed: () {
                              print(StaticStore.player.loopMode);
                              if (StaticStore.player.loopMode == LoopMode.one) {
                                StaticStore.player.setLoopMode(LoopMode.off);
                              } else {
                                StaticStore.player.setLoopMode(LoopMode.one);
                              }
                            },
                            icon: StaticStore.player.loopMode == LoopMode.one
                                ? Icon(
                                    Icons.loop,
                                    color: Colors.green,
                                  )
                                : Icon(
                                    Icons.loop,
                                    color: Colors.white,
                                  ),
                          );
                        }),
                    // IconButton(
                    //   iconSize: 35,
                    //   onPressed: () async {
                    //     // await fetchQueueTrack(trackId);
                    //     // print(StaticStore.myQueueTrack[0].imgUrl);

                    //     // print(StaticStore.myQueueTrack[0].name);
                    //     // await fetchQueueTrack(trackName,trackId,trackArtists,trackImg);

                    //     Navigator.pop(context);
                    //     Navigator.of(context).push(MaterialPageRoute(
                    //         builder: (context) => QueueScreen()));

                    //     // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>QueueScreen()));
                    //     // Navigator.pop(context).then((v)=>{});
                    //   },
                    //   icon: const Icon(
                    //     Icons.menu,
                    //     color: Colors.grey,
                    //   ),
                    // ),
                  ],
                ),
                footer(context),
              ],
            );
          }),
    );
  }
}

class _BackgroundFilter extends StatelessWidget {
  const _BackgroundFilter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRect(), // put song image here for background

      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.brown,
            Colors.black,
          ],
        ),
      ),
    );
  }
}
