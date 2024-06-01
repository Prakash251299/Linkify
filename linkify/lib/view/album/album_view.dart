/*
CustomScrollView widget is better
*/

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:just_audio/just_audio.dart';
// import 'package:http/http.dart';
// import 'package:linkify/controller/accesstoken_error.dart';
// import 'package:linkify/controller/read_write.dart';
import 'package:linkify/controller/variables/static_store.dart';
import 'package:linkify/controller/player/youtube_player.dart';
import 'package:linkify/model/album_track.dart';
import 'package:linkify/view/album/album_play_pause_button/button_album_play_pause.dart';
import 'package:linkify/view/home/loading.dart';
import 'package:linkify/view/music_screen/carousel_song_screen.dart';
import 'package:linkify/view/sticky/sticky_widgets.dart';
// import 'package:linkify/widgets/music_screen.dart';
// import 'package:linkify/widgets/uis/models/song_model.dart';

class AlbumView extends StatefulWidget {
  String? albumImg = "";
  String? albumName = "";
  List<AlbumTrack>? _albumTracks = [];
  // List<String> name=[];
  // List<String> id=[];
  // List<List<String>> trackArtists=[];
  // List<String> trackImg=[];
  AlbumView(this.albumImg, this.albumName, this._albumTracks);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  // final String title;

  @override
  State<AlbumView> createState() => AlbumViewState();
}

class AlbumViewState extends State<AlbumView> {
  // var playing = false;
  var ind = -10;
  YoutubeSongPlayer _player = YoutubeSongPlayer();

  // void _incrementCounter() {
  //   setState(() {
  //     // This call to setState tells the Flutter framework that something has
  //     // changed in this State, which causes it to rerun the build method below
  //     // so that the display can reflect the updated values. If we changed
  //     // _counter without calling setState(), then the build method would not be
  //     // called again, and so nothing would appear to happen.
  //     _counter++;
  //   });
  // }

  // ScrollViewTest({Key? key}) : super()
  // {

  // }

  @override
  void initState() {
    // TODO: implement initState
    // fetchAlbumSongs(widget.id);
    // super.initState();
  }

  // SongModel getSongModel(var name, var albumImg, var id, var trackArtists){
  //   return SongModel.fromJson({
  //                                       // 'id':widget.id[index],
  //                                       'name':name,
  //                                       'imgUrl':albumImg,
  //                                       'id':id,
  //                                       'artists':trackArtists,
  //                                       });
  //                                       // return;

  // }

  double _counter = 0;
  @override
  Widget build(BuildContext context) {
    // var _extraScrollSpeed = 0;
    final devicePexelRatio = MediaQuery.of(context).devicePixelRatio;
    ScrollController _scrollController = ScrollController();
    var mq = MediaQuery.of(context).size;
    // var playing = false;

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    // print(widget.trackArtists[0]);
    // return SizedBox();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,),onPressed: (){
          //   Navigator.pop(context);
          // },),
          // backgroundColor: Colors.black,
          toolbarHeight: 0,
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            NotificationListener(
              child: CustomScrollView(controller: _scrollController, slivers: [
                SliverAppBar(
                    // collapsedHeight:50,
                    backgroundColor: Colors.black,
                    toolbarHeight: 0,
                    leading: SizedBox(),
                    // leadingWidth: 1000,
                    // leading: Container(color: Colors.red,width:1000),
                    floating: false,
                    pinned: true,
                    expandedHeight: 250,
                    flexibleSpace: FlexibleSpaceBar(
                      // collapseMode: CollapseMode.parallax,
                      // titlePadding: EdgeInsets.only(left: 20),
                      stretchModes: const <StretchMode>[
                        StretchMode.blurBackground
                      ],
                      expandedTitleScale: 1,
                      title: Container(
                        padding: EdgeInsets.only(left: 7, right: 20),
                        // color: Colors.red,
                        width: MediaQuery.of(context).size.width,
                        // height: 60,
                        // child:
                        // Row(
                        //   children: [
                        //     Text('${widget._albumTracks?[0].name}',style: TextStyle(color: Colors.black),),
                        //     Spacer(),
                        //     Icon(Icons.play_arrow)
                        //   ],
                        // )
                      ),
                      background: Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Image.network(
                          '${widget.albumImg}', // Replace with your image URL
                          fit: BoxFit
                              .fitHeight, // Ensure the image covers the entire space
                          // height: 300,
                          // width: 300,
                        ),
                      ),
                    )),
                SliverAppBar(

                    // collapsedHeight:0,
                    // backgroundColor: Colors.black,
                    // toolbarHeight: 0,
                    expandedHeight: 90,
                    backgroundColor: Colors.black,
                    leading: SizedBox(),
                    // toolbarHeight: 40,
                    // leadingWidth: 1000,
                    // leading: Container(color: Colors.red,width:1000),
                    floating: false,
                    pinned: true,
                    // expandedHeight: 200,
                    flexibleSpace: FlexibleSpaceBar(
                      // collapseMode: CollapseMode.parallax,
                      titlePadding: EdgeInsets.only(left: 0),
                      // stretchModes:const <StretchMode>[StretchMode.zoomBackground],
                      expandedTitleScale: 1,
                      title: Container(
                          padding: EdgeInsets.only(left: 7, right: 20),
                          // color: Colors.red,
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          child: Row(
                            children: [
                              Container(
                                  width: 300 - _counter,
                                  padding: EdgeInsets.only(left: 10 + _counter),
                                  child: Text(
                                    '${widget.albumName}',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25),
                                    overflow: TextOverflow.ellipsis,
                                  )),
                              Spacer(),
                              Container(
                                  // padding: EdgeInsets.only(right: 30),
                                  child: StreamBuilder<Object>(
                                      stream:
                                          StaticStore.player.playerStateStream,
                                      builder: (context, snapshot) {
                                        return IconButton(
                                          // icon:Icon(Icons.play_circle,color: Colors.white,size:50),
                                          icon: playPauseAlbumButtonTop(
                                              widget._albumTracks, 0),
                                          onPressed: () async {
                                            if (StaticStore.playing == true) {
                                              _player
                                                  .youtubePause()
                                                  .then((value) {
                                                StaticStore.pause = true;
                                                StaticStore.playing = false;
                                              });
                                            } else {
                                              if (StaticStore.pause == true) {
                                                _player
                                                    .youtubeResume()
                                                    .then((value) {
                                                  StaticStore.pause = false;
                                                  StaticStore.playing = true;
                                                });
                                              } else {
                                                await _player
                                                    .youtubePlay(
                                                        widget._albumTracks![0]
                                                            .name,
                                                        widget._albumTracks![0]
                                                            .trackArtists?[0])
                                                    .then((value) {
                                                  // });
                                                  // StaticStore.pause = false;
                                                  StaticStore.myQueueTrack =
                                                      widget._albumTracks!;
                                                  StaticStore.queueLoaded = 1;
                                                  StaticStore.queueIndex = 0;
                                                  StaticStore.currentSong =
                                                      widget._albumTracks![0]
                                                          .name!;
                                                  StaticStore.currentSongImg =
                                                      widget._albumTracks![0]
                                                          .imgUrl!;
                                                  StaticStore.currentArtists =
                                                      List.from(widget
                                                          ._albumTracks![0]
                                                          .trackArtists??[]);
                                                  StaticStore.playing = true;
                                                  StaticStore.pause = false;
                                                });
                                              }
                                            }
                                          },
                                        );
                                      }))
                            ],
                          )),
                    )),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Column(children: [
                        // Container(
                        //   padding: EdgeInsets.only(top:_counter),
                        //   child:
                        Card(
                          color: Colors.black,
                          child: Column(children: [
                            // Text("skjhdfkjds"),

                            InkWell(
                              borderRadius: BorderRadius.circular(15),
                              onTap: () async {
                                if (StaticStore.playing == true) {
                                  if (StaticStore.currentSong ==
                                      widget._albumTracks![index].name) {
                                    await _player.youtubePause();
                                    // setState(() {
                                    StaticStore.playing = false;
                                    StaticStore.pause = true;
                                    // });
                                  } else {
                                    // print(widget._albumTracks?[index].name);
                                    await _player
                                        .youtubePlay(
                                            widget._albumTracks![index].name,
                                            widget._albumTracks![index]
                                                .trackArtists?[0])
                                        .then((value) {
                                      // });
                                      // StaticStore.pause = false;
                                      StaticStore.myQueueTrack =
                                          widget._albumTracks!;
                                      StaticStore.queueLoaded = 1;
                                      StaticStore.queueIndex = index;
                                      StaticStore.currentSong =
                                          widget._albumTracks![index].name!;
                                      StaticStore.currentSongImg =
                                          widget._albumTracks![index].imgUrl!;
                                      StaticStore.currentArtists = List.from(
                                          widget._albumTracks![index]
                                              .trackArtists??[]);
                                      // setState(() {
                                      StaticStore.playing = true;
                                      StaticStore.pause = false;
                                      // });
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CarouselSongScreen(
                                                      widget
                                                          ._albumTracks![index]
                                                          .name,
                                                      // widget.albumImg[index],
                                                      widget
                                                          ._albumTracks![index]
                                                          .id,
                                                      widget
                                                          ._albumTracks![index]
                                                          .trackArtists,
                                                      // widget.trackImg[index]
                                                      widget
                                                          ._albumTracks![index]
                                                          .imgUrl)));
                                    });
                                  }
                                } else {
                                  // if(StaticStore.pause==true){

                                  // }
                                  // StaticStore.playing=true;
                                  // StaticStore.pause=false;
                                  if (StaticStore.currentSong ==
                                      widget._albumTracks![index].name) {
                                    StaticStore.playing = true;
                                    StaticStore.pause = false;
                                    await _player.youtubeResume();
                                  } else {
                                    await _player.youtubeStop();

                                    await _player
                                        .youtubePlay(
                                            widget._albumTracks![index].name,
                                            widget._albumTracks![index]
                                                .trackArtists?[0])
                                        .then((value) {
                                      // });
                                      StaticStore.myQueueTrack =
                                          widget._albumTracks!;
                                      StaticStore.queueLoaded = 1;
                                      StaticStore.queueIndex = index;
                                      StaticStore.currentSong =
                                          widget._albumTracks![index].name!;
                                      StaticStore.currentSongImg =
                                          widget._albumTracks![index].imgUrl!;
                                      StaticStore.currentArtists = List.from(
                                          widget._albumTracks![index]
                                              .trackArtists??[]);
                                      StaticStore.playing = true;
                                      StaticStore.pause = false;

                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CarouselSongScreen(
                                                      widget
                                                          ._albumTracks![index]
                                                          .name,
                                                      // widget.albumImg[index],
                                                      widget
                                                          ._albumTracks![index]
                                                          .id,
                                                      widget
                                                          ._albumTracks![index]
                                                          .trackArtists,
                                                      // widget.trackImg[index]
                                                      widget
                                                          ._albumTracks![index]
                                                          .imgUrl)));
                                    });
                                  }
                                }
                              },
                              child: ListTile(
                                leading: Column(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(3),
                                          bottomLeft: Radius.circular(3),
                                        ),
                                        child:
                                            // CachedNetworkImage(imageUrl: ""),
                                            CachedNetworkImage(
                                          // imageUrl: user.avatar!,

                                          imageUrl:
                                              "${widget._albumTracks?[index].imgUrl}",
                                          // imageUrl: "",

                                          width: 55,
                                          height: 55,
                                          memCacheHeight:
                                              (55 * devicePexelRatio).round(),
                                          memCacheWidth:
                                              (55 * devicePexelRatio).round(),
                                          maxHeightDiskCache:
                                              (55 * devicePexelRatio).round(),
                                          maxWidthDiskCache:
                                              (55 * devicePexelRatio).round(),
                                          progressIndicatorBuilder:
                                              (context, url, l) =>
                                              LoadingImage(),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ]),
                                title: Text(
                                  "${widget._albumTracks?[index].name}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.white),
                                ),
                                subtitle: widget._albumTracks != null && widget._albumTracks![index].trackArtists!=null &&
                                        widget._albumTracks![index].trackArtists!
                                                .length >
                                            1
                                    ? Text(
                                        '${widget._albumTracks?[index].trackArtists?[0]}, ${widget._albumTracks?[index].trackArtists?[1]}',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(color: Colors.white70))
                                    : Text(
                                        '${widget._albumTracks![index].trackArtists?[0]}',
                                        overflow: TextOverflow.ellipsis,
                                        style:
                                            TextStyle(color: Colors.white70)),
                                isThreeLine: true,
                                trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      playPauseAlbumButton(
                                          widget._albumTracks, index),
                                    ]),
                              ),
                            ),
                          ]),
                        ),
                      ]);
                    },
                    childCount:
                        widget._albumTracks?.length, // Number of list items
                  ),
                ),
              ]),
              onNotification: (t) {
                // print(_scrollController.offset);
                setState(() {
                  if (_scrollController.offset >= 236) {
                    _counter = _scrollController.offset - 236;
                  }
                  if (_scrollController.offset > 266) {
                    _counter = 30;
                  }
                  if (_scrollController.offset < 236) {
                    _counter = 0;
                  }
                  // print(_counter);
                });
                return true;
              },
            ),
            StreamBuilder(
                stream: StaticStore.player.playerStateStream,
                builder: (context, snapshot1) {
                  return StaticStore.playing == true ||
                          StaticStore.pause == true
                      ?
                      // Text("hi")
                      miniplayer(context)
                      : const SizedBox();
                }),
            footer(context),
            Container(
              padding: EdgeInsets.only(
                top: 3,
              ),
              child: Opacity(
                // opacity: _counter/40,
                opacity: 1,
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}