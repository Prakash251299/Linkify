
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:just_audio/just_audio.dart';
import 'package:line_icons/line_icons.dart';
import 'package:linkify/controller/local_songs/player/play_pause_button.dart';
import 'package:linkify/controller/local_songs/player/songPlayerController.dart';
import 'package:linkify/controller/local_songs/get_local_songs/permission/permission_handler.dart';
import 'package:linkify/controller/player/play_song.dart';
import 'package:linkify/controller/variables/static_store.dart';
import 'package:linkify/main.dart';
import 'package:linkify/view/local_music/homepage.dart';
import 'package:linkify/view/local_music/local_miniplayer.dart';
import 'package:linkify/view/sticky/sticky_widgets.dart';
import 'package:on_audio_query/on_audio_query.dart';

// final bucketGlobal = PageStorageBucket();

class LocalSongList extends StatefulWidget {
  List<SongModel> songList;
  LocalSongList({super.key, required this.songList});

  @override
  State<LocalSongList> createState() => _LocalSongListState();
}

class _LocalSongListState extends State<LocalSongList> {
  // _LocalSongListState({required this.widget.songList});
  // List<SongModel> widget.songList;
  SongDataController songDataController = SongDataController();
  SongPlayerController _songPlayerController = SongPlayerController();




Widget buildPageOne() {
  var mq = MediaQuery.of(context).size;
  return 
  widget.songList.isNotEmpty
              ?
              // return
              ListView.builder(
                  // key: PageStorageKey<String>('pageOne'),
                  scrollDirection: Axis.vertical,
                  itemCount: widget.songList.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return StreamBuilder<Object>(
                      stream: StaticStore.player.playingStream,
                      builder: (context, snapshot) {

                        if(StaticStore.player.processingState==ProcessingState.completed){
                          print("completed man");
                        }
                        return Card(
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(15),
                            onTap: () async {
                              // print(widget.songList[index].artist);
                              // return;
                              StaticStore.songIndex = index;
                              await playPauseLocal(widget.songList[index].displayName,widget.songList,index,context).then((value) {
                              setState(() {});
                              });
                            },
                            child: ListTile(
                              // leading: const CircleAvatar(child: Icon(LineIcons.music)),
                              leading: CircleAvatar(child:
                              Container(decoration:BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                image: DecorationImage(
                                image: (AssetImage('icon/linkify.jpeg')),
                              )))
                                
                              ),




                              title: Text("${widget.songList[index].title}",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white),),
                              subtitle: Text("${widget.songList[index].artist}",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white)),
                              trailing: 
                              StaticStore.player.playing==false?(widget.songList[index].displayName==StaticStore.currentSong?Icon(Icons.play_arrow,color: Colors.yellow,):Icon(Icons.play_arrow,color: Colors.white,)):widget.songList[index].displayName==StaticStore.currentSong?Icon(Icons.pause,color: Colors.green,):Icon(Icons.play_arrow,color: Colors.white,),
                            ),
                          ),
                          // ),
                        );
                      }
                    );
                  })
              :
              Center(
                  child: Text("No Songs available",
                      style: TextStyle(fontSize: 20)),
                );
  }


  @override
  Widget build(BuildContext context) {
    return
        // const Placeholder();

        Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyApp()));
            },
            icon: Icon(Icons.home,color: Colors.white,)),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search,color: Colors.white)),
        ],
        // title: Text(widget.title),
      ),
      // body: ChatUserCard(),
      // /*
      body:
          // PageStorage( // For storing current child state
          //   // bucket: bucketGlobal,
          //   child: 
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                buildPageOne(),
                StreamBuilder(
                            stream: StaticStore.player.playerStateStream,
                            builder: (context, snapshot1) {
                              return StaticStore.playing == true ||
                                      StaticStore.pause == true
                                  ?
                                  // Text("hi")
                                  // miniplayer(context)
                                  local_miniplayer(context,widget.songList)
                                  : const SizedBox();
                            }),
              ],
            ),
          // ),
          );

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   tooltip: 'Contacts',
      //   child: const Icon(Icons.add_comment_rounded),
      // ),
    // );

  }
}
