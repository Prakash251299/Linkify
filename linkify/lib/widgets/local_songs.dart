import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:linkify/controller/songPlayerController.dart';
import 'package:linkify/controller/song_data_contoller.dart';
import 'package:linkify/widgets/homepage.dart';
import 'package:on_audio_query/on_audio_query.dart';

final bucketGlobal = PageStorageBucket();

class LocalSongList extends StatefulWidget {
  RxList<SongModel> songList;
  LocalSongList({super.key, required this.songList});

  @override
  State<LocalSongList> createState() => _LocalSongListState(songList: songList);
}

class _LocalSongListState extends State<LocalSongList> {
  _LocalSongListState({required this.songList});
  RxList<SongModel> songList;
  SongDataController songDataController = SongDataController();
  SongPlayerController _songPlayerController = SongPlayerController();

//   SongDataController songDataController = Get.put(SongDataController());
//   bool loaded = false;

//   void loadMusic() async {
//   try{
//     songList = await songDataController.getLocalSongs();
//     setState(() {
//       loaded = true;
//     });
//   }
//   catch(e){
//     print("Nothing found");
//   }
// }

// @override
// void initState(){
// // await loadMusic();
// loadMusic(); // Can be made await
// // loaded = true;
// super.initState();
// }



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
                    return Card(
                      margin: EdgeInsets.symmetric(
                          horizontal: mq.width * 0.04,
                          vertical: mq.height * 0.01),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () {
                          // print(songList[index].title);
                          setState(() {
                            // SongPlayerController.playing=true;

                            if (SongPlayerController.playing == true &&
                                SongDataController.currSong == index) {
                              _songPlayerController.pauseLocalSong();
                              // SongPlayerController.playing = false;
                              // SongPlayerController.paused = true;
                              // SongDataController.currSong = index;
                            } else {
                              if (SongPlayerController.playing == false &&
                                  SongDataController.currSong == index) {
                                _songPlayerController
                                    .playLocalSong(songList[index].data);
                                // SongPlayerController.playing = true;
                                // SongPlayerController.paused = false;
                                // SongDataController.currSong = index;
                              } else {
                                if (SongPlayerController.playing == false &&
                                    SongDataController.currSong != index) {
                                  // SongPlayerController.player.pause();
                                  _songPlayerController.stopLocalSong();
                                  SongPlayerController.paused = false;
                                  SongDataController.currSong = index;
                                  // SongPlayerController.playing==true;
                                  _songPlayerController
                                      .playLocalSong(songList[index].data);
                                  // SongPlayerController.paused = false;
                                } else {
                                  if (SongPlayerController.playing == true &&
                                      SongDataController.currSong != index) {
                                    SongPlayerController.player.stop();
                                    // SongPlayerController.playing==false;
                                    SongPlayerController.paused = false;
                                    SongDataController.currSong = index;
                                    _songPlayerController
                                        .playLocalSong(songList[index].data);
                                    // SongPlayerController.playing==true;
                                  }
                                }
                              }
                            }
                          });
                          // SongPlayerController.playing==true?_songPlayerController.pauseLocalSong():_songPlayerController.playLocalSong(songList[index].data);
                          // });
                          // Navigator.push(context,MaterialPageRoute(builder: ((context) => ChatScreen(user:widget.user))));

                          // print(widget.user.name);
                        },
                        child: ListTile(
                          leading:
                              const CircleAvatar(child: Icon(Icons.person)),

                          // title: Text(widget.user.name),
                          title: Text("${songList[index].title}"),
                          subtitle: Row(children: [
                            Column(children: [
                              Text("${songList[index].artist}")
                              // Text("${widget.user.email}\n${
                              //   // Padding(padding: const EdgeInsets.all(3),child:Text(
                              //     widget.user.about
                              //     // )
                              //   // )
                              //   }"),
                            ]),
                          ]),
                          // isThreeLine: true,
                          trailing: Icon(Icons.play_arrow),
                        ),
                      ),
                      // ),
                    );
                  })
              // ;
              :
              // }else{
              // return
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
              // IndexedStack(   // For storing state of this widget
              //   children: <Widget>[
              //     Homepage(),
              //     // PageOne(),
              //     // PageTwo(),
              //   ],
              //   index: 0,
              // );
              // Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Homepage()));
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
      PageStorage(
        bucket: bucketGlobal,
        child: buildPageOne(),
      ),

          // StreamBuilder(
          //   stream:null,
          //   // stream: FirebaseFirestore.instance.collection('users').snapshots(),
          //   // stream: songList,
          //   builder: (context, AsyncSnapshot snapshot){
          //     switch(snapshot.connectionState){
          //       case ConnectionState.waiting:
          //       case ConnectionState.none:
          //         return const Center(child:CircularProgressIndicator());
          //       case ConnectionState.active:
          //       case ConnectionState.done:

          // final data = snapshot.data?.docs;
          // final data = snapshot.data?.docs;

          // List l = data?.map((e)=>ChatUser.fromJson(e.data())).toList()??[];
          // songList = l.cast<ChatUser>();
          // var k;

          // for(int i=0;i<songList.length;i++){
          //   if(songList[i].email==APIs.user.email){ // For removing the current user
          //     songList.removeAt(i);
          //     break;
          //   }
          // }

          // if(songList.isNotEmpty){





          // songList.isNotEmpty
          //     ?
          //     // return
          //     ListView.builder(
          //         key: PageStorageKey<String>('pageTwo'),
          //         scrollDirection: Axis.vertical,
          //         itemCount: songList.length,
          //         physics: BouncingScrollPhysics(),
          //         itemBuilder: (context, index) {
          //           return Card(
          //             margin: EdgeInsets.symmetric(
          //                 horizontal: mq.width * 0.04,
          //                 vertical: mq.height * 0.01),
          //             shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(15)),
          //             child: InkWell(
          //               borderRadius: BorderRadius.circular(15),
          //               onTap: () {
          //                 // print(songList[index].title);
          //                 setState(() {
          //                   // SongPlayerController.playing=true;

          //                   if (SongPlayerController.playing == true &&
          //                       SongDataController.currSong == index) {
          //                     _songPlayerController.pauseLocalSong();
          //                     // SongPlayerController.playing = false;
          //                     // SongPlayerController.paused = true;
          //                     // SongDataController.currSong = index;
          //                   } else {
          //                     if (SongPlayerController.playing == false &&
          //                         SongDataController.currSong == index) {
          //                       _songPlayerController
          //                           .playLocalSong(songList[index].data);
          //                       // SongPlayerController.playing = true;
          //                       // SongPlayerController.paused = false;
          //                       // SongDataController.currSong = index;
          //                     } else {
          //                       if (SongPlayerController.playing == false &&
          //                           SongDataController.currSong != index) {
          //                         // SongPlayerController.player.pause();
          //                         _songPlayerController.stopLocalSong();
          //                         SongPlayerController.paused = false;
          //                         SongDataController.currSong = index;
          //                         // SongPlayerController.playing==true;
          //                         _songPlayerController
          //                             .playLocalSong(songList[index].data);
          //                         // SongPlayerController.paused = false;
          //                       } else {
          //                         if (SongPlayerController.playing == true &&
          //                             SongDataController.currSong != index) {
          //                           SongPlayerController.player.stop();
          //                           // SongPlayerController.playing==false;
          //                           SongPlayerController.paused = false;
          //                           SongDataController.currSong = index;
          //                           _songPlayerController
          //                               .playLocalSong(songList[index].data);
          //                           // SongPlayerController.playing==true;
          //                         }
          //                       }
          //                     }
          //                   }
          //                 });
          //                 // SongPlayerController.playing==true?_songPlayerController.pauseLocalSong():_songPlayerController.playLocalSong(songList[index].data);
          //                 // });
          //                 // Navigator.push(context,MaterialPageRoute(builder: ((context) => ChatScreen(user:widget.user))));

          //                 // print(widget.user.name);
          //               },
          //               child: ListTile(
          //                 leading:
          //                     const CircleAvatar(child: Icon(Icons.person)),

          //                 // title: Text(widget.user.name),
          //                 title: Text("${songList[index].title}"),
          //                 subtitle: Row(children: [
          //                   Column(children: [
          //                     Text("${songList[index].artist}")
          //                     // Text("${widget.user.email}\n${
          //                     //   // Padding(padding: const EdgeInsets.all(3),child:Text(
          //                     //     widget.user.about
          //                     //     // )
          //                     //   // )
          //                     //   }"),
          //                   ]),
          //                 ]),
          //                 // isThreeLine: true,
          //                 trailing: Icon(Icons.play_arrow),
          //               ),
          //             ),
          //             // ),
          //           );
          //         })
          //     // ;
          //     :
          //     // }else{
          //     // return
          //     Center(
          //         child: Text("No Songs available",
          //             style: TextStyle(fontSize: 20)),
          //       ),
      // ;
      // },

      //     }
      //   }
      // ),
      // */

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Contacts',
        child: const Icon(Icons.add_comment_rounded),
      ),
    );

    //  Card(
    //       margin: EdgeInsets.symmetric(horizontal:mq.width*0.04,vertical:mq.height*0.01),
    //       shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(15)),
    //       child:InkWell(
    //         borderRadius: BorderRadius.circular(15),
    //         onTap:(){
    //           // Navigator.push(context,MaterialPageRoute(builder: ((context) => ChatScreen(user:widget.user))));

    //           // print(widget.user.name);
    //         },
    //         child:
    //         ListTile(
    //           leading: const CircleAvatar(child:Icon(Icons.person)),

    //           // title: Text(widget.user.name),
    //           subtitle:
    //           Row(
    //             children: [
    //               Column(
    //             children:[
    //               Text("${songList[0].title}"),
    //                 // Text("${widget.user.email}\n${
    //                 //   // Padding(padding: const EdgeInsets.all(3),child:Text(
    //                 //     widget.user.about
    //                 //     // )
    //                 //   // )
    //                 //   }"),
    //           ]),
    //           ]),
    //           isThreeLine: true,
    //           trailing:Text('12:00PM'),
    //         ),
    //       ),
    //     // ),
    //   );
  }
}
