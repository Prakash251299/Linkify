
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:line_icons/line_icons.dart';
import 'package:linkify/controller/local_songs/play_pause_button.dart';
import 'package:linkify/controller/local_songs/songPlayerController.dart';
import 'package:linkify/controller/local_songs/song_data_contoller.dart';
import 'package:linkify/controller/notification_player.dart/play_song.dart';
import 'package:linkify/controller/static_store.dart';
import 'package:linkify/widgets/local_music/homepage.dart';
import 'package:linkify/widgets/sticky_widgets.dart';
import 'package:on_audio_query/on_audio_query.dart';

final bucketGlobal = PageStorageBucket();

class LocalSongList extends StatefulWidget {
  List<SongModel> songList;
  LocalSongList({super.key, required this.songList});

  @override
  State<LocalSongList> createState() => _LocalSongListState(songList: songList);
}

class _LocalSongListState extends State<LocalSongList> {
  _LocalSongListState({required this.songList});
  List<SongModel> songList;
  SongDataController songDataController = SongDataController();
  SongPlayerController _songPlayerController = SongPlayerController();




Widget buildPageOne() {
  var mq = MediaQuery.of(context).size;
  return 
  songList.isNotEmpty
              ?
              // return
              ListView.builder(
                  key: PageStorageKey<String>('pageOne'),
                  scrollDirection: Axis.vertical,
                  itemCount: songList.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return StreamBuilder<Object>(
                      stream: StaticStore.player.playingStream,
                      builder: (context, snapshot) {
                        return Card(
                          color: Colors.black,
                          margin: EdgeInsets.symmetric(
                              horizontal: mq.width * 0.04,
                              vertical: mq.height * 0.01),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(15),
                            onTap: () async {
                              // print(songList[index].artist);
                              // return;
                              await playPauseLocal(songList[index].displayName,songList,index,context);
                              setState(() {});
                            },
                            child: ListTile(
                              leading: const CircleAvatar(child: Icon(LineIcons.music)),
                              title: Text("${songList[index].title}",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white),),
                              subtitle: Text("${songList[index].artist}",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white)),
                              trailing: 
                              StaticStore.player.playing==false?Icon(Icons.play_arrow,color: Colors.white,):songList[index].displayName==StaticStore.currentSong?Icon(Icons.pause,color: Colors.white,):Icon(Icons.play_arrow,color: Colors.white,),
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
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Homepage(songList)));
            },
            icon: Icon(Icons.home)),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        ],
        // title: Text(widget.title),
      ),
      // body: ChatUserCard(),
      // /*
      body:
          PageStorage( // For storing current child state
            bucket: bucketGlobal,
            child: Stack(
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
                                  miniplayer(context)
                                  : const SizedBox();
                            }),
              ],
            ),
          ),);

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   tooltip: 'Contacts',
      //   child: const Icon(Icons.add_comment_rounded),
      // ),
    // );

  }
}
