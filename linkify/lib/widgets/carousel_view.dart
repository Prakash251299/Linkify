// // 375 402

// import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
// import 'package:http/http.dart';
// import 'package:linkify/controller/accesstoken_error.dart';
// import 'package:linkify/controller/read_write.dart';
import 'package:linkify/controller/static_store.dart';
import 'package:linkify/controller/youtube_player.dart';
import 'package:linkify/model/album_track.dart';
import 'package:linkify/widgets/album_play_pause_button/button_album_play_pause.dart';
import 'package:linkify/widgets/carousel_song_screen.dart';
// import 'package:linkify/widgets/music_screen.dart';
// import 'package:linkify/widgets/uis/models/song_model.dart';
import 'package:linkify/widgets/uis/utils/loading.dart';



class CarouselView extends StatefulWidget {
  var albumImg;
  var albumName;
  // List<String> name;
  // List<String> id;
  // List<List<String>> trackArtists;
  // List<String> trackImg;
  List<AlbumTrack> trackInfo=[];
  CarouselView(this.albumImg,this.albumName,this.trackInfo);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  // final String title;

  @override
  State<CarouselView> createState() => CarouselViewState();
}

class CarouselViewState extends State<CarouselView> {
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
  //                                       // 'id':widget.id[position],
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
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.black,
          child: SafeArea(
            child: Stack(alignment: Alignment.topCenter, children: [
              _counter < 200
                  ? Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(3),
                            bottomLeft: Radius.circular(3),
                          ),
                          // opacity: AlwaysStoppedAnimation(.5),
                          child: Opacity(
                            opacity: 1 - _counter / 200,
                            // opacity:0.7,
                            child:
                            Image.network(
                              widget.albumImg,
                              fit: BoxFit.fill,
                              width: 300 - _counter < 70 ? 70 : 300 - _counter,
                              height: 300 - _counter < 70 ? 70 : 300 - _counter,
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

                           
                          )))
                  : SizedBox(),

              _counter >= 190
                  ? Opacity(
                      opacity: _counter >= 240 ? 1 : (_counter - 190) * 2 / 100,
                      // opacity:0.7,
                      child:
                          // PreferredSize(
                          //   preferredSize: Size.fromHeight(0.0),
                          //   child:
                          // Expanded(child:
                          AppBar(
                        // leading: Icon(Icons.arrow_back,color: Colors.white,),
                        leading: SizedBox(),
                        title: Text(
                          "${widget.albumName}",overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.black,
                      ))
                  // Container(
                  //   height:60,
                  //   color: Colors.black,
                  //   child: Row(children:[Text("Hello mottal!",style:TextStyle(color: Colors.white)),]),
                  // // ),
                  // ))
                  : SizedBox(),
              // ),

              Container(
                // color: Colors.red,
                padding: EdgeInsets.only(
                    top: 300 - _counter < 70 ? 57 : 300 - _counter - 13),
                // padding:EdgeInsets.only(top:_counter==0?330-_counter:330-_counter<0?0:_counter/10),
                child: Container(
                  color: Colors.black,
                  // padding: EdgeInsets.only(top: _counter*5/100),
                  // padding: EdgeInsets.only(top: _counter),
                  // margin: EdgeInsets.only(top: 100),

                  child: NotificationListener(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      // shrinkWrap: true,
                      // physics: ClampingScrollPhysics(),
                      // physics: BouncingScrollPhysics(),
                      physics: AlwaysScrollableScrollPhysics(),
                      // itemCount: 100,
                      // itemCount: widget.name.length,
                      itemCount: widget.trackInfo.length,
                      // itemCount: m['name'].length!=0?m['name'].length:10,
                      controller: _scrollController,

                      itemBuilder: (context, position) {
                        // print(position);
                        // print("hi");
                        // print(_scrollController.position);
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


                                  // await _player.youtubePlay(widget.trackInfo[position].name,widget.trackInfo[position].trackArtists[0]);






                                  if (StaticStore.playing == true) {
                                      if(StaticStore.currentSong==widget.trackInfo[position].name){
                                        await _player.youtubePause();
                                        // setState(() {
                                          StaticStore.playing = false;
                                          StaticStore.pause = true;
                                        // });
      
                                      }else{
                                        // print(widget.trackInfo[position].name);
                                        await _player.youtubeStop();
                                        // Navigator.pop(context);
                                        // await _player.youtubePlay(widget.trackInfo[position].name,widget.trackInfo[position].trackArtists[0]);
                                        await _player.youtubePlay(widget.trackInfo[position].name,widget.trackInfo[position].trackArtists[0]).then((value) {

                                        // },);
                                        /* For queue */
                                        StaticStore.myQueueTrack = widget.trackInfo;
                                        StaticStore.queueLoaded=1;
                                        StaticStore.queueIndex = position;
                                        // StaticStore.pause = false;
                                        
                                        StaticStore.currentSong = widget.trackInfo[position].name!;
                                        StaticStore.currentSongImg = widget.trackInfo[position].imgUrl!;
                                        StaticStore.currentArtists = List.from(widget.trackInfo[position].trackArtists);
                                        // setState(() {
                                          StaticStore.playing = true;
                                          StaticStore.pause = false;
                                        // });
                                        Navigator.pop(context);
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => CarouselSongScreen(
                                          widget.trackInfo[position].name,
                                          // widget.albumImg[position],
                                          widget.trackInfo[position].id,
                                          widget.trackInfo[position].trackArtists,
                                          // widget.trackImg[position]
                                          widget.trackInfo[position].imgUrl
                                        )));
                                        },);
                                        // Navigator.pop(context);
                                      }
                                    }else{
                                      // if(StaticStore.pause==true){
      
                                      // }
                                      StaticStore.playing=true;
                                      StaticStore.pause=false;
                                      if(StaticStore.currentSong==widget.trackInfo[position].name){
                                        await _player.youtubeResume();
                                      }else{
                                        await _player.youtubeStop();
      
                                        await _player.youtubePlay(widget.trackInfo[position].name, widget.trackInfo[position].trackArtists[0]).then((value){

                                          // });
                                          /* For queue */
                                          StaticStore.myQueueTrack = widget.trackInfo;
                                          StaticStore.queueLoaded=1;
                                          StaticStore.queueIndex = position;
                                          StaticStore.currentSong = widget.trackInfo[position].name!;
                                          StaticStore.currentSongImg = widget.trackInfo[position].imgUrl!;
                                          StaticStore.currentArtists = List.from(widget.trackInfo[position].trackArtists);
                                          Navigator.pop(context);
        
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => CarouselSongScreen(
                                            widget.trackInfo[position].name,
                                            // widget.albumImg[position],
                                            widget.trackInfo[position].id,
                                            widget.trackInfo[position].trackArtists,
                                            // widget.trackImg[position]
                                            widget.trackInfo[position].imgUrl
                                          )));
                                        });
                                      }
      
                                    }








                                  // if (StaticStore.playing == true) {
                                  //   // stop song
                                  //   if (ind == position) {
                                  //     await _player.youtubePause();
                                  //     // setState(() {
                                  //       StaticStore.playing = false;
                                  //       StaticStore.pause = true;
                                  //     // });
                                  //   } else {
                                  //     await _player.youtubeStop();
                                  //     await _player.youtubePlay(widget.trackInfo[position].name,widget.trackInfo[position].trackArtists[0]);
                                  //     StaticStore.currentSong = widget.trackInfo[position].name!;
                                  //     StaticStore.currentSongImg = widget.trackInfo[position].imgUrl!;
                                  //     StaticStore.currentArtists = List.from(widget.trackInfo[position].trackArtists);

                                  //     // SongModel s = getSongModel(
                                  //     // StaticStore.currentArtists.add(widget.trackArtists[position]);
                                  //     //   widget.name[position],
                                  //     //   widget.albumImg[position],
                                  //     //   widget.id[position],
                                  //     //   widget.trackArtists[position],
                                  //     // );

                                  //     // print(StaticStore.player.playerState);
                                  //     // return;

                                  //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => CarouselSongScreen(
                                  //       widget.trackInfo[position].name,
                                  //       // widget.albumImg[position],
                                  //       widget.trackInfo[position].id,
                                  //       widget.trackInfo[position].trackArtists,
                                  //       // widget.trackImg[position]
                                  //       widget.trackInfo[position].imgUrl
                                  //     )));
                                  //   }
                                  // } else {

                                  //   // print(StaticStore.player.playerState);
                                  //   // return;
                                  //   // play song
                                  //   if (ind == position) {
                                  //     await _player.youtubeResume();
                                  //   } else {
                                  //     // await _player.youtubePlay(widget.name[position]);
                                  //     //     StaticStore.currentSong = widget.name[position];
                                  //     // StaticStore.currentSongImg = widget.trackImg[position];
                                  //     //     StaticStore.currentArtists = List.from(widget.trackArtists[position]);

                                  //         // SongModel s = getSongModel(
                                  //           // widget.name[position],
                                  //           // widget.albumImg[position],
                                  //           // widget.id[position],
                                  //           // widget.trackArtists[position],
                                  //         // );
                                  //     //     print(StaticStore.player.playerState);
                                  //     // return;



                                  //     StaticStore.player.playerStateStream.listen((state) {
                                  //       if (state.playing){} else
                                  //       switch (state.processingState) {
                                  //         case ProcessingState.idle: {
                                  //           Scaffold(
                                  //             body: Center(
                                  //               child: CircularProgressIndicator(),
                                  //             ),
                                  //           );
                                  //         }
                                  //         case ProcessingState.loading: {
                                  //           Scaffold(
                                  //             body: Center(
                                  //               child: CircularProgressIndicator(),
                                  //             ),
                                  //           );
                                  //         }
                                  //         case ProcessingState.buffering: {
                                  //           Scaffold(
                                  //             body: Center(
                                  //               child: CircularProgressIndicator(),
                                  //             ),
                                  //           );
                                  //         }
                                  //         case ProcessingState.ready: {
                                  //           Navigator.of(context).push(MaterialPageRoute(builder: (context) => CarouselSongScreen(
                                  //           widget.trackInfo[position].name,
                                  //       // widget.albumImg[position],
                                  //       widget.trackInfo[position].id,
                                  //       widget.trackInfo[position].trackArtists,
                                  //       // widget.trackImg[position]
                                  //       widget.trackInfo[position].imgUrl
                                  //         )));
                                  //         }
                                  //         case ProcessingState.completed: {}
                                  //       }
                                  //     });



                                  //     // StaticStore.player.playerStateStream.listen((state) {
                                  //     //   if(state.processingState!=ProcessingState.ready){
                                  //     //     Scaffold(
                                  //     //       body: Center(
                                  //     //         child: CircularProgressIndicator(),
                                  //     //       ),
                                  //     //     );
                                  //     //     // _player.youtubePlay(widget.name[position]);
                                  //     //     // StaticStore.currentSong = widget.name[position];
                                  //     // StaticStore.currentSongImg = widget.trackImg[position];
                                  //     //     // StaticStore.currentArtists = List.from(widget.trackArtists[position]);
                                  //     //   }else{
                                  //     //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => AlbumSongScreen(
                                  //     //       widget.name[position],
                                  //     //       widget.albumImg[position],
                                  //     //       widget.id[position],
                                  //     //       widget.trackArtists[position],
                                  //     //       widget.trackImg[position]
                                  //     //     )));

                                  //     //   }
                                  //     // });



                                  //     // _player.youtubePlay(widget.name[position]);
                                  //     _player.youtubePlay(widget.trackInfo[position].name,widget.trackInfo[position].trackArtists[0]);
                                  //     StaticStore.currentSong = widget.trackInfo[position].name!;
                                  //     StaticStore.currentSongImg = widget.trackInfo[position].imgUrl!;
                                  //     StaticStore.currentArtists = List.from(widget.trackInfo[position].trackArtists);

                                  //         // Navigator.of(context).push(MaterialPageRoute(builder: (context) => AlbumSongScreen(
                                  //         //   widget.name[position],
                                  //         //   widget.albumImg[position],
                                  //         //   widget.id[position],
                                  //         //   widget.trackArtists[position],
                                  //         //   widget.trackImg[position]
                                  //         // )));
                                  //   }
                                  //   // setState(() {
                                  //     StaticStore.playing = true;
                                      
                                  //   // });
                                  //   // }
                                  // }
                                  // // setState(() {
                                  //   StaticStore.playingCarouselInd = StaticStore.carouselInd;
                                  //   ind = position;
                                  // // });
                                  // // Navigator.push(context,MaterialPageRoute(builder: ((context) => ChatScreen(user:widget.user))));

                                  // // print(widget.user.name);
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

                                            // imageUrl: "${widget.trackInfo[position]['trackImg']}",
                                            // imageUrl: "",
                                            imageUrl: widget.trackInfo[position].imgUrl!,

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
                                                    const LoadingImage(),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ]),

                                  // CircleAvatar(
                                  //   child:Image.network("src"),
                                  // ),

                                  // title: Text(widget.user.name),
                                  title: Text(
                                    "${widget.trackInfo[position].name}",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  subtitle: 
                                      widget.trackInfo[position].trackArtists.length>1?
                                      Text('${widget.trackInfo[position].trackArtists[0]}, ${widget.trackInfo[position].trackArtists[1]}',overflow: TextOverflow.ellipsis,
                                      style:TextStyle(color: Colors.white70)
                                              ):
                                      Text('${widget.trackInfo[position].trackArtists[0]}',overflow: TextOverflow.ellipsis,
                                          style:TextStyle(color: Colors.white70)
                                      ),
                                  isThreeLine: true,
                                  trailing: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [


                                          playPauseAlbumButton(widget.trackInfo,position),

                                          // StaticStore.currentSong!=widget.trackInfo[position].name?Icon(Icons.play_arrow,color:Colors.grey):StaticStore.playing == true?Icon(Icons.pause,color:Colors.white):Icon(Icons.play_arrow,color:Colors.yellow),


                                        // Icon(
                                        //   StaticStore.currentSong!=widget.trackInfo[position].name
                                        //     ? Icons.play_arrow
                                        //     : 
                                        //     StaticStore.playing == true
                                        //         ? Icons.pause
                                        //         : Icons.play_arrow   
                                        // ),



                                        // Icon(


                                        //   StaticStore.currentSong!=widget.trackInfo[position].name
                                        //     ? Icons.play_arrow
                                        //     : 
                                        //     StaticStore.playing == true
                                        //         ? Icons.pause
                                        //         : Icons.play_arrow
                                                
                                        // ),


                                      ]),
                                ),
                              ),
                            ]),
                          ),
                          // ),

                          // }),),
                        ]);
                      },
                    ),
                    onNotification: (t) {
                      WidgetsBinding.instance
                          .addPostFrameCallback((_) => setState(() {}));
                      _counter = _scrollController.position.pixels;
                      return true;
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 3, left: 3),
                child: Row(children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  )
                ]),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}