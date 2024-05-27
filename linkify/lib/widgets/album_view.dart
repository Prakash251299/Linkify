/*
CustomScrollView widget is better
*/

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
import 'package:linkify/widgets/sticky_widgets.dart';
// import 'package:linkify/widgets/music_screen.dart';
// import 'package:linkify/widgets/uis/models/song_model.dart';
import 'package:linkify/widgets/uis/utils/loading.dart';











class AlbumView extends StatefulWidget {
  String? albumImg="";
  String? albumName="";
  List<AlbumTrack>? _albumTracks=[];
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

    return 
    SafeArea(
      child: Scaffold(
        appBar: 
        AppBar(
          // leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,),onPressed: (){
          //   Navigator.pop(context);
          // },),
          // backgroundColor: Colors.black,
          toolbarHeight: 0,
        ),
        body: 
        Stack(
          alignment: Alignment.bottomCenter,
          children: [

            CustomScrollView(
                slivers: [
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
                      stretchModes:const <StretchMode>[StretchMode.blurBackground],
                      expandedTitleScale: 1,
                      title: Container(
                        padding: EdgeInsets.only(left:7,right: 20),
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
                      background: Image.network(
                        '${widget.albumImg}', // Replace with your image URL 
                        fit: BoxFit.fitHeight, // Ensure the image covers the entire space 
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
                        padding: EdgeInsets.only(left:7,right: 20),
                        // color: Colors.red,
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        child: 
                        Row(
                          children: [
                            Container(
                              width:300,
                              padding: EdgeInsets.only(left:10),
                              child: Text('${widget._albumTracks?[0].name}',style: TextStyle(color: Colors.white,fontSize: 25),overflow: TextOverflow.ellipsis,)
                            ),
                            Spacer(),
                            Container(
                              // padding: EdgeInsets.only(right: 30),
                              child: IconButton(
                                // icon:Icon(Icons.play_circle,color: Colors.white,size:50),
                                icon:playPauseAlbumButtonTop(widget._albumTracks,0),
                                onPressed: () async {
                                if (StaticStore.playing == true) {
                                    if(StaticStore.currentSong==widget._albumTracks![0].name){
                                      await _player.youtubePause();
                                      // setState(() {
                                        StaticStore.playing = false;
                                        StaticStore.pause = true;
                                      // });

                                    }else{
                                      // print(widget._albumTracks?[index].name);
                                      await _player.youtubePlay(widget._albumTracks![0].name,widget._albumTracks![0].trackArtists[0]).then((value){

                                        // });
                                        // StaticStore.pause = false;
                                        StaticStore.myQueueTrack = widget._albumTracks!;
                                        StaticStore.queueLoaded = 1;
                                        StaticStore.queueIndex = 0;
                                        StaticStore.currentSong = widget._albumTracks![0].name!;
                                        StaticStore.currentSongImg = widget._albumTracks![0].imgUrl!;
                                        StaticStore.currentArtists = List.from(widget._albumTracks![0].trackArtists);
                                        // setState(() {
                                          StaticStore.playing = true;
                                          StaticStore.pause = false;
                                        // });
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => CarouselSongScreen(
                                          widget._albumTracks![0].name,
                                          // widget.albumImg[index],
                                          widget._albumTracks![0].id,
                                          widget._albumTracks![0].trackArtists,
                                          // widget.trackImg[index]
                                          widget._albumTracks![0].imgUrl
                                        )));
                                      });
                                    }
                                  }else{
                                    // if(StaticStore.pause==true){

                                    // }
                                    // StaticStore.playing=true;
                                    // StaticStore.pause=false;
                                    if(StaticStore.currentSong==widget._albumTracks![0].name){
                                      StaticStore.playing=true;
                                      StaticStore.pause=false;
                                      await _player.youtubeResume();
                                    }else{
                                      await _player.youtubeStop();

                                      await _player.youtubePlay(widget._albumTracks![0].name, widget._albumTracks![0].trackArtists[0]).then((value) {

                                        // });
                                        StaticStore.myQueueTrack = widget._albumTracks!;
                                        StaticStore.queueLoaded=1;
                                        StaticStore.queueIndex = 0;
                                        StaticStore.currentSong = widget._albumTracks![0].name!;
                                        StaticStore.currentSongImg = widget._albumTracks![0].imgUrl!;
                                        StaticStore.currentArtists = List.from(widget._albumTracks![0].trackArtists);
                                        StaticStore.playing=true;
                                        StaticStore.pause=false;

                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => CarouselSongScreen(
                                          widget._albumTracks![0].name,
                                          // widget.albumImg[index],
                                          widget._albumTracks![0].id,
                                          widget._albumTracks![0].trackArtists,
                                          // widget.trackImg[index]
                                          widget._albumTracks![0].imgUrl
                                        )));
                                      });
                                    }

                                  }
                              },)
                            )
                          ],
                        )), 
                    )),
            
            
            
                    SliverList( 
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) { 
                        
                        return 









                        Column(
                          children: [
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
                                    if(StaticStore.currentSong==widget._albumTracks![index].name){
                                      await _player.youtubePause();
                                      // setState(() {
                                        StaticStore.playing = false;
                                        StaticStore.pause = true;
                                      // });

                                    }else{
                                      // print(widget._albumTracks?[index].name);
                                      await _player.youtubePlay(widget._albumTracks![index].name,widget._albumTracks![index].trackArtists[0]).then((value){

                                        // });
                                        // StaticStore.pause = false;
                                        StaticStore.myQueueTrack = widget._albumTracks!;
                                        StaticStore.queueLoaded = 1;
                                        StaticStore.queueIndex = index;
                                        StaticStore.currentSong = widget._albumTracks![index].name!;
                                        StaticStore.currentSongImg = widget._albumTracks![index].imgUrl!;
                                        StaticStore.currentArtists = List.from(widget._albumTracks![index].trackArtists);
                                        // setState(() {
                                          StaticStore.playing = true;
                                          StaticStore.pause = false;
                                        // });
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => CarouselSongScreen(
                                          widget._albumTracks![index].name,
                                          // widget.albumImg[index],
                                          widget._albumTracks![index].id,
                                          widget._albumTracks![index].trackArtists,
                                          // widget.trackImg[index]
                                          widget._albumTracks![index].imgUrl
                                        )));
                                      });
                                    }
                                  }else{
                                    // if(StaticStore.pause==true){

                                    // }
                                    // StaticStore.playing=true;
                                    // StaticStore.pause=false;
                                    if(StaticStore.currentSong==widget._albumTracks![index].name){
                                      StaticStore.playing=true;
                                      StaticStore.pause=false;
                                      await _player.youtubeResume();
                                    }else{
                                      await _player.youtubeStop();

                                      await _player.youtubePlay(widget._albumTracks![index].name, widget._albumTracks![index].trackArtists[0]).then((value) {

                                        // });
                                        StaticStore.myQueueTrack = widget._albumTracks!;
                                        StaticStore.queueLoaded=1;
                                        StaticStore.queueIndex = index;
                                        StaticStore.currentSong = widget._albumTracks![index].name!;
                                        StaticStore.currentSongImg = widget._albumTracks![index].imgUrl!;
                                        StaticStore.currentArtists = List.from(widget._albumTracks![index].trackArtists);
                                        StaticStore.playing=true;
                                        StaticStore.pause=false;

                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => CarouselSongScreen(
                                          widget._albumTracks![index].name,
                                          // widget.albumImg[index],
                                          widget._albumTracks![index].id,
                                          widget._albumTracks![index].trackArtists,
                                          // widget.trackImg[index]
                                          widget._albumTracks![index].imgUrl
                                        )));
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

                                            imageUrl: "${widget._albumTracks?[index].imgUrl}",
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
                                    "${widget._albumTracks?[index].name}",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  subtitle: 
                                  // Expanded(child:
                                  // Column(children: [
                                    // Expanded(child:
                                    // Column(children: [
                                      widget._albumTracks!=null && widget._albumTracks![index].trackArtists.length > 1?
                                      Text('${widget._albumTracks?[index].trackArtists[0]}, ${widget._albumTracks?[index].trackArtists[1]}',overflow: TextOverflow.ellipsis,
                                      style:TextStyle(color: Colors.white70)
                                              ):
                                      Text('${widget._albumTracks![index].trackArtists[0]}',overflow: TextOverflow.ellipsis,
                                          style:TextStyle(color: Colors.white70)
                                      ),
                                    // ]),
                                    // ),
                                  // ]),
                                  // ),
                                  isThreeLine: true,
                                  trailing: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [



                                          playPauseAlbumButton(widget._albumTracks,index),
                                         
                                      ]),
                                ),
                              ),
                            ]),
                            // Padding(
                            //   padding: const EdgeInsets.all(20.0),
                            //   child: Text(
                            //     // index.toString(),
                            //     "Hello",
                            //     style: TextStyle(fontSize: 22.0),
                            //   ),
                            // ),
                          ),
                          // ),

                          // }),),
                        ]);





























                        // ListTile( 
                        //   title: Text('Item $index'), // Display list item with index 
                        // ); 
                      }, 
                      // childCount: 50, // Number of list items 
                      childCount: widget._albumTracks?.length, // Number of list items 
                    ), 
                  ), 
              ]),
              // Container(
              //   padding: EdgeInsets.only(left: 7),
              //   child: Icon(Icons.arrow_back,color: Colors.white,)
              // ),

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
          ],
        ),
      ),
    );



  }
}
    
    




















    // Scaffold(
    //   body: Center(
    //     child: Container(
    //       color: Colors.black,
    //       child: SafeArea(
    //         child: Stack(alignment: Alignment.topCenter, children: [
    //           _counter < 200
    //               ? Padding(
    //                   padding: const EdgeInsets.only(top: 5),
    //                   child: ClipRRect(
    //                       borderRadius: const BorderRadius.only(
    //                         topLeft: Radius.circular(3),
    //                         bottomLeft: Radius.circular(3),
    //                       ),
    //                       // opacity: AlwaysStoppedAnimation(.5),
    //                       child: Opacity(
    //                         opacity: 1 - _counter / 200,
    //                         // opacity:0.7,
    //                         child:
    //                         Image.network(
    //                           widget.albumImg??"",
    //                           fit: BoxFit.fill,
    //                           width: 300 - _counter < 70 ? 70 : 300 - _counter,
    //                           height: 300 - _counter < 70 ? 70 : 300 - _counter,
    //                           loadingBuilder: (BuildContext context, Widget child,
    //                               ImageChunkEvent? loadingProgress) {
    //                             if (loadingProgress == null) return child;
    //                             return Center(
    //                               child: CircularProgressIndicator(
    //                                 value: loadingProgress.expectedTotalBytes != null
    //                                     ? loadingProgress.cumulativeBytesLoaded /
    //                                     loadingProgress.expectedTotalBytes!
    //                                     : null,
    //                               ),
    //                             );
    //                           },
    //                         ),

                           
    //                       )))
    //               : SizedBox(),

    //           _counter >= 190
    //               ? Opacity(
    //                   opacity: _counter >= 240 ? 1 : (_counter - 190) * 2 / 100,
    //                   // opacity:0.7,
    //                   child:
    //                       // PreferredSize(
    //                       //   preferredSize: Size.fromHeight(0.0),
    //                       //   child:
    //                       // Expanded(child:
    //                       AppBar(
    //                     // leading: Icon(Icons.arrow_back,color: Colors.white,),
    //                     leading: SizedBox(),
    //                     title: Text(
    //                       "${widget.albumName}",overflow: TextOverflow.ellipsis,
    //                       style: TextStyle(color: Colors.white),
    //                     ),
    //                     backgroundColor: Colors.black,
    //                   ))
    //               // Container(
    //               //   height:60,
    //               //   color: Colors.black,
    //               //   child: Row(children:[Text("Hello mottal!",style:TextStyle(color: Colors.white)),]),
    //               // // ),
    //               // ))
    //               : SizedBox(),
    //           // ),

    //           Container(
    //             // color: Colors.red,
    //             padding: EdgeInsets.only(
    //                 top: 300 - _counter < 70 ? 57 : 300 - _counter - 13),
    //             // padding:EdgeInsets.only(top:_counter==0?330-_counter:330-_counter<0?0:_counter/10),
    //             child: Container(
    //               color: Colors.black,
    //               // padding: EdgeInsets.only(top: _counter*5/100),
    //               // padding: EdgeInsets.only(top: _counter),
    //               // margin: EdgeInsets.only(top: 100),

    //               child: NotificationListener(
    //                 child: ListView.builder(
    //                   scrollDirection: Axis.vertical,
    //                   // shrinkWrap: true,
    //                   // physics: ClampingScrollPhysics(),
    //                   // physics: BouncingScrollPhysics(),
    //                   physics: AlwaysScrollableScrollPhysics(),
    //                   // itemCount: 100,
    //                   // itemCount: widget.name.length,
    //                   itemCount: widget._albumTracks?.length,
    //                   controller: _scrollController,

    //                   itemBuilder: (context, index) {
    //                     // print(index);
    //                     // print("hi");
    //                     // print(_scrollController.index);
    //                     return 
    //                     Column(
    //                       children: [
    //                       // Container(
    //                       //   padding: EdgeInsets.only(top:_counter),
    //                       //   child:
    //                       Card(
    //                         color: Colors.black,
    //                         child: Column(children: [
    //                           // Text("skjhdfkjds"),

    //                           InkWell(
    //                             borderRadius: BorderRadius.circular(15),
    //                             onTap: () async {
    //                               if (StaticStore.playing == true) {
    //                                 if(StaticStore.currentSong==widget._albumTracks![index].name){
    //                                   await _player.youtubePause();
    //                                   // setState(() {
    //                                     StaticStore.playing = false;
    //                                     StaticStore.pause = true;
    //                                   // });

    //                                 }else{
    //                                   // print(widget._albumTracks?[index].name);
    //                                   await _player.youtubePlay(widget._albumTracks![index].name,widget._albumTracks![index].trackArtists[0]).then((value){

    //                                     // });
    //                                     // StaticStore.pause = false;
    //                                     StaticStore.myQueueTrack = widget._albumTracks!;
    //                                     StaticStore.queueLoaded = 1;
    //                                     StaticStore.queueIndex = index;
    //                                     StaticStore.currentSong = widget._albumTracks![index].name!;
    //                                     StaticStore.currentSongImg = widget._albumTracks![index].imgUrl!;
    //                                     StaticStore.currentArtists = List.from(widget._albumTracks![index].trackArtists);
    //                                     // setState(() {
    //                                       StaticStore.playing = true;
    //                                       StaticStore.pause = false;
    //                                     // });
    //                                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => CarouselSongScreen(
    //                                       widget._albumTracks![index].name,
    //                                       // widget.albumImg[index],
    //                                       widget._albumTracks![index].id,
    //                                       widget._albumTracks![index].trackArtists,
    //                                       // widget.trackImg[index]
    //                                       widget._albumTracks![index].imgUrl
    //                                     )));
    //                                   });
    //                                 }
    //                               }else{
    //                                 // if(StaticStore.pause==true){

    //                                 // }
    //                                 // StaticStore.playing=true;
    //                                 // StaticStore.pause=false;
    //                                 if(StaticStore.currentSong==widget._albumTracks![index].name){
    //                                   StaticStore.playing=true;
    //                                   StaticStore.pause=false;
    //                                   await _player.youtubeResume();
    //                                 }else{
    //                                   await _player.youtubeStop();

    //                                   await _player.youtubePlay(widget._albumTracks![index].name, widget._albumTracks![index].trackArtists[0]).then((value) {

    //                                     // });
    //                                     StaticStore.myQueueTrack = widget._albumTracks!;
    //                                     StaticStore.queueLoaded=1;
    //                                     StaticStore.queueIndex = index;
    //                                     StaticStore.currentSong = widget._albumTracks![index].name!;
    //                                     StaticStore.currentSongImg = widget._albumTracks![index].imgUrl!;
    //                                     StaticStore.currentArtists = List.from(widget._albumTracks![index].trackArtists);
    //                                     StaticStore.playing=true;
    //                                     StaticStore.pause=false;

    //                                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => CarouselSongScreen(
    //                                       widget._albumTracks![index].name,
    //                                       // widget.albumImg[index],
    //                                       widget._albumTracks![index].id,
    //                                       widget._albumTracks![index].trackArtists,
    //                                       // widget.trackImg[index]
    //                                       widget._albumTracks![index].imgUrl
    //                                     )));
    //                                   });
    //                                 }

    //                               }

    //                             },









    //                             child: ListTile(
    //                               leading: Column(
    //                                   // mainAxisAlignment: MainAxisAlignment.center,
    //                                   children: [
    //                                     ClipRRect(
    //                                       borderRadius: BorderRadius.only(
    //                                         topLeft: Radius.circular(3),
    //                                         bottomLeft: Radius.circular(3),
    //                                       ),
    //                                       child:
    //                                           // CachedNetworkImage(imageUrl: ""),
    //                                           CachedNetworkImage(
    //                                         // imageUrl: user.avatar!,

    //                                         imageUrl: "${widget._albumTracks?[index].imgUrl}",
    //                                         // imageUrl: "",

    //                                         width: 55,
    //                                         height: 55,
    //                                         memCacheHeight:
    //                                             (55 * devicePexelRatio).round(),
    //                                         memCacheWidth:
    //                                             (55 * devicePexelRatio).round(),
    //                                         maxHeightDiskCache:
    //                                             (55 * devicePexelRatio).round(),
    //                                         maxWidthDiskCache:
    //                                             (55 * devicePexelRatio).round(),
    //                                         progressIndicatorBuilder:
    //                                             (context, url, l) =>
    //                                                 const LoadingImage(),
    //                                         fit: BoxFit.cover,
    //                                       ),
    //                                     ),
    //                                   ]),

    //                               // CircleAvatar(
    //                               //   child:Image.network("src"),
    //                               // ),

    //                               // title: Text(widget.user.name),
    //                               title: Text(
    //                                 "${widget._albumTracks?[index].name}",
    //                                 overflow: TextOverflow.ellipsis,
    //                                 style: TextStyle(color: Colors.white),
    //                               ),
    //                               subtitle: 
    //                               // Expanded(child:
    //                               // Column(children: [
    //                                 // Expanded(child:
    //                                 // Column(children: [
    //                                   widget._albumTracks!=null && widget._albumTracks![index].trackArtists.length > 1?
    //                                   Text('${widget._albumTracks?[index].trackArtists[0]}, ${widget._albumTracks?[index].trackArtists[1]}',overflow: TextOverflow.ellipsis,
    //                                   style:TextStyle(color: Colors.white70)
    //                                           ):
    //                                   Text('${widget._albumTracks![index].trackArtists[0]}',overflow: TextOverflow.ellipsis,
    //                                       style:TextStyle(color: Colors.white70)
    //                                   ),
    //                                 // ]),
    //                                 // ),
    //                               // ]),
    //                               // ),
    //                               isThreeLine: true,
    //                               trailing: Column(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.center,
    //                                   children: [



    //                                       playPauseAlbumButton(widget._albumTracks,index),
    //                                       // widget._albumTracks?[index].name!=StaticStore.currentSong?Icon(Icons.play_arrow,color: Colors.grey,):StaticStore.playing == true?Icon(Icons.pause,color: Colors.white,):Icon(Icons.play_arrow,color: Colors.yellow,),




                                          
    //                                     // Icon(
    //                                     //   // StaticStore.playingCarouselInd!=StaticStore.carouselInd?
    //                                     //   // Icons.play_arrow:
    //                                     //   // ind != index
    //                                     //   widget._albumTracks?[index].name!=StaticStore.currentSong
    //                                     //     ? Icons.play_arrow
    //                                     //     : StaticStore.playing == true
    //                                     //         ? Icons.pause
    //                                     //         : Icons.play_arrow),



    //                                     // Icon(
    //                                     //   // StaticStore.playingCarouselInd!=StaticStore.carouselInd?
    //                                     //   // Icons.play_arrow:
    //                                     //   // ind != index
    //                                     //   widget._albumTracks?[index].name!=StaticStore.currentSong
    //                                     //     ? Icons.play_arrow
    //                                     //     : StaticStore.playing == true
    //                                     //         ? Icons.pause
    //                                     //         : Icons.play_arrow),
    //                                   ]),
    //                               // :(ind==index && playing==false?Icons.play_arrow:playing==false?Icons.play_arrow:null),),
    //                               // Icons.play_arrow,color: Colors.white,),

    //                               // onPressed: (){
    //                               //   if(playing==true){
    //                               //     // stop song
    //                               //     // setState(() {
    //                               //     //   playing = false;
    //                               //     // });

    //                               //   }else{
    //                               //     // play song
    //                               //     setState(() {
    //                               //       playing = true;
    //                               //     });
    //                               //   }
    //                               // },
    //                               // ),
    //                             ),
    //                           ),
    //                         ]),
    //                         // Padding(
    //                         //   padding: const EdgeInsets.all(20.0),
    //                         //   child: Text(
    //                         //     // index.toString(),
    //                         //     "Hello",
    //                         //     style: TextStyle(fontSize: 22.0),
    //                         //   ),
    //                         // ),
    //                       ),
    //                       // ),

    //                       // }),),
    //                     ]);
    //                   },
    //                 ),
    //                 onNotification: (t) {
    //                   if (t is ScrollEndNotification) {
    //                     // print(_scrollController.index.pixels);
    //                   }
    //                   // setState(() {

    //                   // });

    //                   if (_scrollController.index.pixels > mq.height) {
    //                     print("hi");
    //                   }
    //                   // print(_scrollController.index.pixels);
    //                   // _scrollController.index.activity?.isScrolling = false;

    //                   print(_scrollController.index);

    //                   // print(_scrollController.index.activity?.velocity);
    //                   // setState(() {});
    //                   WidgetsBinding.instance
    //                       .addPostFrameCallback((_) => setState(() {}));
    //                   _counter = _scrollController.index.pixels;
    //                   print(_counter);
    //                   // });
    //                   //How many pixels scrolled from pervious frame
    //                   // print(t);

    //                   //List scroll index
    //                   // print(t.metrics.pixels);
    //                   return true;
    //                 },
    //               ),
    //             ),
    //           ),
    //           Padding(
    //             padding: EdgeInsets.only(top: 3, left: 3),
    //             child: Row(children: [
    //               IconButton(
    //                 onPressed: () {
    //                   Navigator.pop(context);
    //                 },
    //                 icon: Icon(
    //                   Icons.arrow_back,
    //                   color: Colors.white,
    //                 ),
    //               )
    //             ]),
    //           ),
    //           StaticStore.playing == true ||
    //                                 StaticStore.pause == true
    //                             ?
    //           Container(
    //             padding: EdgeInsets.only(top:MediaQuery.of(context).size.height-137),
    //             child:StreamBuilder<Object>(
    //               stream: StaticStore.player.playerStateStream,
    //               builder: (context, snapshot) {
    //                 return miniplayer(context);
    //               }
    //             ),
    //           ):SizedBox(),

    //           Container(
    //             padding: EdgeInsets.only(top:MediaQuery.of(context).size.height-78),
    //             child:
    //             footer(context),
    //           ),
    //         ]),
    //       ),
    //     ),
    //   ),
    //   // floatingActionButton: FloatingActionButton(
    //   //   onPressed: _incrementCounter,
    //   //   tooltip: 'Increment',
    //   //   child: const Icon(Icons.add),
    //   // ), // This trailing comma makes auto-formatting nicer for build methods.
    // );


