import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:line_icons/line_icons.dart';
import 'package:linkify/controller/static_store.dart';
import 'package:linkify/widgets/album_song_screen.dart';
import 'package:linkify/widgets/sticky_widgets.dart';
import 'package:linkify/widgets/uis/screens/library/library.dart';
import 'package:linkify/widgets/uis/screens/search_page/search_page.dart';
import '../../controllers/main_controller.dart';
import '../../models/loading_enum.dart';
import '../../utils/horizontal_songs_list.dart';

import '../../../carousel_songs.dart';
import 'cubit/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  // final MainController con;
  const HomeScreen({
    Key? key,
    // required this.con,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
    BlocProvider(
      create: (context) => HomeCubit()..getAlbums(),
      // create:(_){},
      child: BlocBuilder<HomeCubit, HomeState>(
      // child: BlocBuilder(
        builder: (context, state) {
          print("homescreen");
          if (state.status == LoadPage.loading) {
            return 
            Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state.status == LoadPage.loaded) {
            return 
            Scaffold(
              body: 
              Column(
                children: [
                 
                 Expanded(child: 
              SingleChildScrollView(child:Column(
                children: [

                  CarouselSongs(
                    state.likedTrack
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8),
                    child: Text(
                      "Popular Hits",
                      // style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  HorizontalSongList(
                      // con: con, songs: state.songs.sublist(0, 10)),
                      // con: con, songs: state.songs.sublist(0, 0)
                      ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8),
                    child: Text(
                      "Best Picks For You",
                      // style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  HorizontalArtistList(
                      // con: con, users: state.users.sublist(6, 16)),
                      // con: con, users: state.users.sublist(0,0)
                      ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8),
                    child: Text(
                      "New Releases",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  HorizontalSongList(
                      // con: con, songs: state.songs.sublist(10, 20)
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8),
                    child: Text(
                      "You might also like",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  HorizontalArtistList(
                      // con: con, users: state.users.sublist(16)
                      ),
                  const SizedBox(height: 12),

                  



                ],
              ),
              ),
              ),
              
              // StaticStore.player.processingState==ProcessingState.completed?
              StreamBuilder(
                stream: StaticStore.player.playerStateStream,
                builder: (context, snapshot1) {
                  return 
                  StaticStore.playing == true || StaticStore.pause==true?
                  MyStickyWidgets.miniplayer(context)
                  : const SizedBox();
                }
              ),
              MyStickyWidgets.footer(context),
              // StaticStore.player.playerStateStream.listen((event) {},)
              // StaticStore.playing == true || StaticStore.pause==true?
              // miniplayer()
              // : const SizedBox(),
              // Container(color:Colors.red,width: 100,height: 100,),
              
             
              ]),
              
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text("No data found"),
          ],);
          }));
            // }));
          // }
          // if (state.status == LoadPage.error) {
          //   return const Scaffold(
          //     body: Center(
          //       child: Text(
          //         "Error",
          //         style: TextStyle(color: Colors.white),
          //       ),
          //     ),
          //   );
          // }

          // return Container();
        // },
      // ),
    // );
  }


  
  
  // Widget miniplayer(var context) {
  //   return 
  //   GestureDetector(child:
  //   Container(
  //     color: const Color.fromARGB(221, 66, 37, 37),
  //     height: 60,
  //     child: ListView.builder(
  //       scrollDirection: Axis.horizontal,
  //       // itemCount: list.length,
  //       itemBuilder: ((context, index) {
  //         // bool last = list.length == (index + 1);
  //         return Padding(
  //           padding: EdgeInsets.only(
  //             left: 16,
  //             // right: last ? 16 : 0,
  //             // right: 16,
  //           ),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               // img
  //               Container(
  //                 // width: 150,
  //                 // height: 80,
                  
  //                 decoration: BoxDecoration(
  //                   color: Colors.red,
                    
  //                   // image: DecorationImage(
  //                       // image: NetworkImage(list[index].img),
  //                       // fit: BoxFit.cover),
  //                 ),
  //               ),
  //               const SizedBox(
  //                 height: 12,
  //               ),
  //               // name
  //               SizedBox(
  //                 width: MediaQuery.of(context).size.width,
  //                 child: 
  //                 Text(
  //                   // "hello",
  //                   "${StaticStore.currentSong}",
  //                   // list[index].title,
  //                     style: const TextStyle(
  //                         color: Color(0xffffffff),
  //                         fontWeight: FontWeight.w700,
  //                         fontFamily: "Raleway",
  //                         fontStyle: FontStyle.normal,
  //                         fontSize: 13.0,
  //                         overflow: TextOverflow.ellipsis),
  //                     maxLines: 2,
  //                     textAlign: TextAlign.left),
  //               ),
  //               const SizedBox(
  //                 height: 4,
  //               ),
  //               // show-creator
  //               SizedBox(
  //                 width: 135,
  //                 child: Text(
  //                   // list[index].creator ?? '',

  //                   // "jasjkd",



  //                   StaticStore.currentArtists.length>1?
  //                   "${StaticStore.currentArtists[0]}, ${StaticStore.currentArtists[1]}":"${StaticStore.currentArtists[0]}",
  //                     style: const TextStyle(
  //                         color: Color(0xffb3b3b3),
  //                         fontWeight: FontWeight.w500,
  //                         fontFamily: "Raleway",
  //                         fontStyle: FontStyle.normal,
  //                         fontSize: 13.0,
  //                         // overflow: TextOverflow.ellipsis
  //                         ),
  //                     maxLines: 1,
  //                     textAlign: TextAlign.left),
  //               ),
  //             ],
  //           ),
  //         );
  //       }),
  //     ),
  //   ),
  //   onTap: (){
  //     // Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewScreen()));

  //     Navigator.of(context).push(MaterialPageRoute(builder: ((context) => AlbumSongScreen(StaticStore.currentSong, StaticStore.currentSong, StaticStore.currentArtists, StaticStore.currentSongImg))));
  //   },
  //   );
  // }

}
