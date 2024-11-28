import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linkify/controller/local_songs/player/prev_next_play.dart';
import 'package:linkify/controller/local_songs/player/songPlayerController.dart';
import 'package:linkify/controller/variables/static_store.dart';
import 'package:linkify/controller/player/youtube_player.dart';
import 'package:linkify/view/music_screen/carousel_song_screen.dart';
import 'package:linkify/view/search/genreTag.dart';
import 'package:on_audio_query/on_audio_query.dart';

Widget local_miniplayer(BuildContext context,songList) {
  // var c = [Color.fromARGB(221, 66, 37, 37),Color.fromARGB(221, 146, 72, 72),];
  // var random = Random().nextInt(34)-1;
  // if(8 in List)
  List<dynamic> excludedColorList = [2, 5, 8, 11, 14, 19, 22, 27, 29, 31, 32];
  int d = StaticStore.currentSong.length * 4 % 34;
  // int d = StaticStore.currentSong.length * 4 % 34;
  YoutubeSongPlayer _player = YoutubeSongPlayer();
  int e = d + 1;
  while (excludedColorList.contains(d)) {
    d++;
    d = d % 34;
  }
  while (excludedColorList.contains(e) || e == d) {
    e++;
    e = e % 34;
  }
  int color = int.parse(tags[d]['color'].toString());
  int color2 = int.parse(tags[e]['color'].toString());
  // print(d);
  return GestureDetector(
    child: Stack(
      // mainAxisAlignment: MainAxisAlignment.end,
      alignment: Alignment.bottomCenter,
      children: [
        // _BackgroundFilter(),
        Container(
          // height:100,
          // padding: EdgeInsets.only(bottom:50),
          margin: EdgeInsets.only(bottom: StaticStore.miniplayerMargin),

          // color: Color(tags[0]['color']),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            // color: Color(color).withOpacity(1),
            // decoration: BoxDecoration(
            gradient: LinearGradient(
              // begin: Alignment.topCenter,
              // end: Alignment.bottomCenter,
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                // Colors.brown,
                Color(color2).withOpacity(1),
                Color(color).withOpacity(1),
              ],
            ),
            // ),
          ),
          // color:Colors.red,
          // width: 360,
          // width: MediaQuery.of(context).size.width,
          height: 60,
          // height: 110,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            // itemCount: list.length,
            itemCount: 1,
            itemBuilder: ((context, index) {
              // bool last = list.length == (index + 1);
              return Container(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 8,
                    // right: last ? 16 : 0,
                    // right: 16,
                  ),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        // padding: EdgeInsets.only(right:80),
                        width: 45,
                        height: 45,
                        // decoration: TextDecoration.none,
                        decoration: StaticStore.currentSongImg != ""
                            ? BoxDecoration(
                                // color: Colors.red,
                                // decoration: TextDecoration.none
                                image: DecorationImage(
                                    image: NetworkImage(
                                        StaticStore.currentSongImg),
                                    fit: BoxFit.cover),
                              )
                            :BoxDecoration(
                              image: DecorationImage(
                                image: (AssetImage('icon/linkify.jpeg')),
                              )
                            )
                      ),
                      SizedBox(width: 8),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // img

                            // Container(
                            //   // width: 150,
                            //   // height: 80,

                            //   decoration: BoxDecoration(
                            //     color: Colors.red,

                            //     // image: DecorationImage(
                            //     // image: NetworkImage(list[index].img),
                            //     // fit: BoxFit.cover),
                            //   ),
                            // ),
                            const SizedBox(
                              height: 8,
                            ),
                            // name
                            SizedBox(
                              // width: MediaQuery.of(context).size.width / 1.5,
                              width: 100,
                              child: Text(
                                  // "hello",
                                  "${StaticStore.currentSong}",
                                  // list[index].title,
                                  style: const TextStyle(
                                    decoration: TextDecoration.none,
                                    color: Color(0xffffffff),
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Raleway",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 13.0,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  textAlign: TextAlign.left),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            // show-creator
                            SizedBox(
                              // width: MediaQuery.of(context).size.width / 1.5,
                              width: MediaQuery.of(context).size.width / 1.5,
                              child: Text(
                                  // list[index].creator ?? '',

                                  // "jasjkd",

                                  StaticStore.currentArtists.length > 1
                                      ? "${StaticStore.currentArtists[0]}, ${StaticStore.currentArtists[1]}"
                                      : StaticStore.currentArtists.length > 0 &&
                                              StaticStore
                                                      .currentArtists.length <=
                                                  1
                                          ? "${StaticStore.currentArtists[0]}"
                                          : "unknown",
                                  style: const TextStyle(
                                      decoration: TextDecoration.none,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Raleway",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 13.0,
                                      overflow: TextOverflow.ellipsis),
                                  maxLines: 1,
                                  textAlign: TextAlign.left),
                            ),
                          ]),
                      // Spacer(),

                      // Icon(Icons.menu),
                      Container(
                        // height: 20,
                        width: 20,
                        // color: Colors.grey,
                        child: IconButton(
                            onPressed: () async {
                              if (StaticStore.pause == true) {
                                await _player.youtubeResume();
                                StaticStore.pause = false;
                                StaticStore.playing = true;
                              } else {
                                await _player.youtubePause();
                                StaticStore.pause = true;
                                StaticStore.playing = false;
                              }
                            },
                            icon: StaticStore.pause == true
                                ? Icon(
                                    CupertinoIcons.play,
                                    color: Colors.white,
                                  )
                                : Icon(
                                    CupertinoIcons.pause,
                                    color: Colors.white,
                                  )),
                      ),
                      // SizedBox(width:13),
                      Container(
                          // height: ,
                          width: 40,
                          // color: Colors.amber,
                          child: playNextWidget(_player,songList)),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
        // Spacer(),
        indicator(context),
      ],
    ),
    onTap: () {
      // print(StaticStore.currentSong.length);
      // return;
      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewScreen()));

      Navigator.of(context).push(MaterialPageRoute(
          builder: ((context) => CarouselSongScreen(
              StaticStore.currentSong,
              "",
              StaticStore.currentArtists,
              ""))));
    },
  );
}

var curve = Curves.ease;
var duration = const Duration(seconds: 1);

Widget playNextWidget(_player,List<SongModel>songList) {
  // index = index%songList.length;
  SongPlayerController _songPlayerController = SongPlayerController();
  return IconButton(
    onPressed: () async {
      await play_next_local(songList);
    },
    // iconSize: 45,
    icon: const Icon(
      Icons.skip_next,
      color: Colors.white,
    ),
    // ),
  );
}

Widget indicator(BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;
  final track = _buildTrack(context, colorScheme);
  // final knob = _buildKnob(context, colorScheme);

  return StreamBuilder<Object>(
      stream: StaticStore.player.playerStateStream,
      builder: (context, snapshot) {
        return Container(
          margin: EdgeInsets.only(bottom: StaticStore.miniplayerMargin),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [track],
          ),
        );
      });
}


Widget _buildTrack(BuildContext context, ColorScheme colorScheme) {
  // final borderRadius = BorderRadius.circular(trackHeight / 4);
  // final borderColor = Theme.of(context).colorScheme.onSurface;
  var trackHeight = 10.0;
  final bar = _buildBar(context, trackHeight * 5 / 6, colorScheme);
  // final icon = _buildIcon();

  final children = [bar];

  return Container(
    // height: trackHeight,
    height: 2,
    // color: Colors.red,
    // width: trackHeight * trackAspectRatio,
    width: MediaQuery.of(context).size.width,
    // width: 100,
    // decoration: BoxDecoration(
    //   borderRadius: borderRadius,
    //   border: Border.all(color: borderColor),
    // ),
    child: Stack(
      children: children,
    ),
  );
}

Widget _buildBar(
  BuildContext context,
  double barHeight,
  ColorScheme colorScheme,
) {
  // final barWidth = trackHeight * trackAspectRatio;
  final borderRadius = barHeight / 5;
  var wid = MediaQuery.of(context).size;

  // final currentColor = status.getBatteryColor(colorScheme);

  return
      // Padding(
      //   padding: EdgeInsets.all(trackHeight / 12),
      //   child:
      StreamBuilder<Object>(
          stream: StaticStore.player.positionStream,
          builder: (context, snapshot) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: Stack(
                children: [
                  const SizedBox.expand(),
                  AnimatedContainer(
                    duration: duration,
                    width: StaticStore.player.duration == null
                        ? 0
                        : (StaticStore.player.position.inSeconds * wid.width) /
                            StaticStore.player.duration!.inSeconds,
                    // width: barWidth * status.value / 100,
                    // width: barWidth*1/2,
                    // width:MediaQuery.of(context).size.width,
                    height: double.infinity,
                    curve: curve,
                    decoration: BoxDecoration(
                      // color: currentColor,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              // ),
            );
          });
}
