import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linkify/controller/static_store.dart';
import 'package:linkify/controller/youtube_player.dart';
import 'package:linkify/model/album_track.dart';
import 'package:linkify/widgets/album_play_pause_button/button_album_play_pause.dart';
import 'package:linkify/widgets/carousel_song_screen.dart';
import 'package:linkify/widgets/uis/utils/loading.dart';

class QueueScreen extends StatefulWidget {
  // BuildContext prevContext;
  QueueScreen({super.key});

  @override
  State<QueueScreen> createState() => _QueueScreenState();
}

class _QueueScreenState extends State<QueueScreen> {
  ScrollController _scrollController = ScrollController();
  List<AlbumTrack> _queueTracks = StaticStore.myQueueTrack;
  YoutubeSongPlayer _player = YoutubeSongPlayer();
  var _counter=0.0;
  late AnimationController _animation_controller;
  

  @override
  void initState() {
    // print(StaticStore.myQueueTrack[0].name);
    // TODO: implement initState
    // Navigator.pop(widget.prevContext);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final devicePexelRatio = MediaQuery.of(context).devicePixelRatio;
    var mq = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Queue",style:TextStyle(color: Colors.white),),
      backgroundColor: Colors.black,
        // backgroundColor: ,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: (){
            Navigator.pop(context);
          },),
      ),
      body: NotificationListener(
                      child: 
                      StaticStore.myQueueTrack.isEmpty?
                      Center(child: Text("No songs in queue"),)
                      :
                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        // shrinkWrap: true,
                        // physics: ClampingScrollPhysics(),
                        // physics: BouncingScrollPhysics(),
                        physics: AlwaysScrollableScrollPhysics(),
                        // itemCount: 100,
                        // itemCount: widget.name.length,
                        itemCount: _queueTracks.length,
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
                                    if (StaticStore.playing == true) {
                                      if(StaticStore.currentSong==_queueTracks[position].name){
                                        await _player.youtubePause();
                                        // setState(() {
                                          StaticStore.playing = false;
                                          StaticStore.pause = true;
                                        // });
      
                                      }else{
                                        // print(_queueTracks?[position].name);
                                        await _player.youtubeStop();
                                        // Navigator.pop(context);
                                        await _player.youtubePlay(_queueTracks[position].name,_queueTracks[position].trackArtists[0]).then((value) {

                                        
                                          // StaticStore.pause = false;
                                          StaticStore.queueIndex = position;
                                          StaticStore.currentSong = _queueTracks[position].name!;
                                          StaticStore.currentSongImg = _queueTracks[position].imgUrl!;
                                          StaticStore.currentArtists = List.from(_queueTracks[position].trackArtists);
                                          // setState(() {
                                            StaticStore.playing = true;
                                            StaticStore.pause = false;
                                          // });
                                          Navigator.pop(context);
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => CarouselSongScreen(
                                            _queueTracks[position].name,
                                            // widget.albumImg[position],
                                            _queueTracks[position].id,
                                            _queueTracks[position].trackArtists,
                                            // widget.trackImg[position]
                                            _queueTracks[position].imgUrl
                                          )));
                                        });
                                        // Navigator.pop(context);
                                      }
                                    }else{
                                      // if(StaticStore.pause==true){
      
                                      // }
                                      StaticStore.playing=true;
                                      StaticStore.pause=false;
                                      if(StaticStore.currentSong==_queueTracks[position].name){
                                        await _player.youtubeResume();
                                      }else{
                                        await _player.youtubeStop();
      
                                        await _player.youtubePlay(_queueTracks[position].name, _queueTracks[position].trackArtists[0]).then((value) {

                                        
                                        StaticStore.queueIndex = position;
                                        StaticStore.currentSong = _queueTracks[position].name!;
                                        StaticStore.currentSongImg = _queueTracks[position].imgUrl!;
                                        StaticStore.currentArtists = List.from(_queueTracks[position].trackArtists);
                                        Navigator.pop(context);
      
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => CarouselSongScreen(
                                          _queueTracks[position].name,
                                          // widget.albumImg[position],
                                          _queueTracks[position].id,
                                          _queueTracks[position].trackArtists,
                                          // widget.trackImg[position]
                                          _queueTracks[position].imgUrl
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
      
                                              imageUrl: "${_queueTracks[position].imgUrl}",
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
                                      "${_queueTracks[position].name}",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    subtitle: 
                                    // Expanded(child:
                                    // Column(children: [
                                      // Expanded(child:
                                      // Column(children: [
                                        _queueTracks!=[] && _queueTracks[position].trackArtists.length > 1?
                                        Text('${_queueTracks[position].trackArtists[0]}, ${_queueTracks[position].trackArtists[1]}',overflow: TextOverflow.ellipsis,
                                        style:TextStyle(color: Colors.white70)
                                                ):
                                        Text('${_queueTracks[position].trackArtists[0]}',overflow: TextOverflow.ellipsis,
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
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [


                                              playPauseAlbumButton(_queueTracks,position),



                                            IconButton(
                                              onPressed: (){
                                                StaticStore.myQueueTrack.removeAt(position);

                                              }, 
                                              icon: const Icon(Icons.delete,color: Colors.grey,)
                                            ),
                                          ],)

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
                        if (t is ScrollEndNotification) {
                          // print(_scrollController.position.pixels);
                        }
                        // setState(() {
      
                        // });
      
                        if (_scrollController.position.pixels > mq.height) {
                          print("hi");
                        }
                        // print(_scrollController.position.pixels);
                        // _scrollController.position.activity?.isScrolling = false;
      
                        print(_scrollController.position);
      
                        // print(_scrollController.position.activity?.velocity);
                        // setState(() {});
                        WidgetsBinding.instance
                            .addPostFrameCallback((_) => setState(() {}));
                        _counter = _scrollController.position.pixels;
                        print(_counter);
                        // });
                        //How many pixels scrolled from pervious frame
                        // print(t);
      
                        //List scroll position
                        // print(t.metrics.pixels);
                        return true;
                      },
                    ),
    );
  }
}