// import 'package:cached_network_image/cached_network_image.dart';

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
// import 'package:get/get.dart';
// import 'package:just_audio/just_audio.dart';
import 'package:linkify/controller/static_store.dart';
import 'package:linkify/widgets/carousel_player_button.dart';
// import 'package:linkify/widgets/player_buttons.dart';
import 'package:linkify/widgets/seekbar.dart';
import 'package:linkify/widgets/sticky_widgets.dart';
import 'package:linkify/widgets/uis/screens/home/home_screen.dart';
import 'package:linkify/widgets/uis/screens/library/library.dart';
import 'package:linkify/widgets/uis/screens/search_page/search_page.dart';
// import 'package:linkify/widgets/uis/methods/log.dart';
// import 'package:linkify/widgets/uis/models/song_model.dart';
// import 'package:rxdart/rxdart.dart' as rxdart;

class CarouselSongScreen extends StatefulWidget {
  // SongModel songs;
  // widget.name[position],
  // widget.albumImg[position],
  // widget.id[position],
  // widget.trackArtists[position],
  var name;
  // var albumImg;
  var id;
  var trackArtists;
  var trackImg;

  CarouselSongScreen(
      this.name,
      // this.albumImg,
      this.id,
      this.trackArtists,
      this.trackImg);
  // SongScreen({Key? key}) : super(key: key),this.songs;

  @override
  // State<SongScreen> createState() => _SongScreenState(songs);
  State<CarouselSongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<CarouselSongScreen> {
  // SongModel songs;
  // _SongScreenState(this.songs);
  // AudioPlayer audioPlayer = AudioPlayer();
  // Song song = Get.arguments ?? Song.songs[0];

  @override
  void initState() {
    StaticStore.musicScreenEnabled = true;
    log('CheckState: initState');
    super.initState();

    // audioPlayer.setAudioSource(
    //   ConcatenatingAudioSource(
    //     children: [
    //       // AudioSource.uri(
    //       //   Uri.parse('asset:///${song.url}'),
    //       // ),
    //     ],
    //   ),
    // );
  }

  @override
  void dispose() {
    // audioPlayer.dispose();
    super.dispose();
  }

  // Stream<SeekBarData> get _seekBarDataStream =>
  //     rxdart.Rx.combineLatest2<Duration, Duration?, SeekBarData>(
  //         audioPlayer.positionStream, audioPlayer.durationStream, (
  //       Duration position,
  //       Duration? duration,
  //     ) {
  //       return SeekBarData(
  //         position,
  //         duration ?? Duration.zero,
  //       );
  //     });

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
      body: Stack(
        fit: StackFit.expand,
        children: [
          const _BackgroundFilter(),
          _MusicPlayer(
              widget.name,
              // widget.albumImg,
              widget.id,
              widget.trackArtists,
              widget.trackImg),

          Padding(
            padding: const EdgeInsets.only(
              bottom: 270.0,
              left: 20,
              right: 20,
              // vertical: 200.0,
            ),
            child: Container(
              // height:30,
              //   child:
              // ClipRect(

              child: Image.network(
                widget.trackImg,
                // fit: BoxFit.fill,
                // width: 300 - _counter < 70 ? 70 : 300 - _counter,
                // height: 300 - _counter < 70 ? 70 : 300 - _counter,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
            ),
          ),
          // ClipRect(
          //   child: CachedNetworkImage(imageUrl: song.coverUrl),
          // ),
          // Image.asset(
          //   song.coverUrl,
          //   fit: BoxFit.cover,
          // ),
        ],
      ),
    );
  }
}

class _MusicPlayer extends StatelessWidget {
  // SongModel songs;
  var name;
  // var albumImg;
  var id;
  var trackArtists;
  var trackImg;
  _MusicPlayer(
      this.name,
      // this.albumImg,
      this.id,
      this.trackArtists,
      this.trackImg);

  //   Widget footer(var context){
  //   return Container(
  //     padding: EdgeInsets.only(left:20,right:20),
  //               color:Colors.black,
  //               child:
  //             Row(children: [
  //                 IconButton(icon:const Icon(LineIcons.home,color: Colors.white,),onPressed: (){
  //                   Navigator.of(context).push(
  //                   MaterialPageRoute(
  //                       builder: (_) => HomeScreen(),
  //                       )).then((value) => Navigator.pop(context));
  //                 },),
  //                 Spacer(),
  //                 IconButton(icon:const Icon(CupertinoIcons.search,color: Colors.white,),onPressed: (){
  //                   Navigator.of(context).push(
  //                   MaterialPageRoute(
  //                       builder: (_) => SearchPage(),
  //                       )).then((value) => Navigator.pop(context));
  //                 },),
  //                 Spacer(),
  //                 IconButton(icon:const Icon(CupertinoIcons.music_albums,color: Colors.white,),onPressed: (){
  //                   Navigator.of(context).push(
  //                   MaterialPageRoute(
  //                       builder: (_) => Library(),
  //                       )).then((value) => Navigator.pop(context));
  //                 },),
  //             ])
  //             );
  // }

  @override
  Widget build(BuildContext context) {
    // StaticStore.currentArtists.add(trackArtists);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        // vertical: 10.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            // song.title,
            // "Song name",
            // songs.name,
            this.name,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            // song.description,
            // "Beautiful Artist name",
            trackArtists.length > 1
                ? "${trackArtists[0]}, ${trackArtists[1]}"
                : "${trackArtists[0]}",
            maxLines: 2,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.white),
            overflow: TextOverflow.ellipsis,
          ),
          // const SizedBox(height: 30),
          // StreamBuilder<SeekBarData>(
          //   stream: _seekBarDataStream,
          //   builder: (context, snapshot) {
          //     final positionData = snapshot.data;
          //     return
          // create the seekbar here
          // SizedBox(),
          SeekBar(),
          //   },
          // ),
          AlbumPlayerButtons(
            this.name,
            // this.albumImg,
            this.id,
            this.trackArtists,
            this.trackImg,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                iconSize: 35,
                onPressed: () {},
                icon: const Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
              ),
              IconButton(
                iconSize: 35,
                onPressed: () {},
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          footer(context),
        ],
      ),
    );
  }
}

class _BackgroundFilter extends StatelessWidget {
  const _BackgroundFilter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        Container(
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