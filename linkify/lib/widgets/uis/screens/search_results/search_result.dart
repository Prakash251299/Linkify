import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:linkify/controller/static_store.dart';
import 'package:linkify/controller/youtube_player.dart';
import 'package:linkify/widgets/music_screen.dart';
// import '../../controllers/main_controller.dart';
import '../../models/loading_enum.dart';
// import '../artist_profile/artist_profile.dart';
import '../../utils/botttom_sheet_widget.dart';
import '../../utils/loading.dart';
// import '../../utils/recent_search.dart';

import 'cubit/search_results_cubit.dart';

class SearchResultsPage extends StatefulWidget {
  const SearchResultsPage({super.key});

  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

// class SearchResultsPage extends StatelessWidget {
  // final MainController con;
  // SearchResultsPage({
  //   Key? key,
  //   // required this.con,
  // }) : super(key: key);

  SearchResultsCubit _searchResultsCubit = SearchResultsCubit();
  String artists = "";
  YoutubeSongPlayer _youtubePlayer = YoutubeSongPlayer();

  @override
  Widget build(BuildContext context) {
    final devicePexelRatio = MediaQuery.of(context).devicePixelRatio;

    return BlocProvider(
        create: (context) => SearchResultsCubit(),
        child: BlocBuilder<SearchResultsCubit, SearchResultsState>(
            builder: (context, state) {
          // print("called again");
          // if (state.songs.length != 0) {
            // print(state.songs[0].artists.toString());
            // artists = state.songs[i].artists.toString().replaceAll('[', "");
            // artists = artists.replaceAll(']', "");
            // print(artists);
            // state.replaceAll(RegExp('['), ''),
            // if(state.songs[0].artists.length>=2){
            //   artists = state.songs[0].artists[0]+state.songs[0].artists[1];
            // }else{
            //   artists = state.songs[0].artists[0];
            // }
            // print(artists);
          // }
          return
              // SizedBox();
              Scaffold(
                  appBar: CustomAppBar(
                    onPressed: () {
                      // BlocProvider.of<SearchResultsCubit>(context).isSongToggle();
                    },
                    onChanged: (String? s) async {
                      // print(s);
                      if (s == '' || s == null) {
                        // BlocProvider.of<SearchResultsCubit>(context).isNullToggle();
                      } else {
                        // if (state.isNull) {
                        //   BlocProvider.of<SearchResultsCubit>(context)
                        //       .isNullToggle();
                        // }

                        BlocProvider.of<SearchResultsCubit>(context)
                            .searchSongs(s);
                        // sea
                        // await _searchResultsCubit.searchSongs(s);
                      }
                    },
                    // isSong: state.isSong,
                  ),
                  body: Builder(
                    builder: (context) {
                      if (state.status == LoadPage.loading) {
                        // print("Loading");
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state.status == LoadPage.loaded) {
                        // if (state.isNull) {
                        //   return RecentSearch();
                        // } else if (state.isSong) {
                        // print("Loaded");
                        return
                            // SizedBox();
                            ListView.builder(
                                itemCount: state.songs.length,
                                itemBuilder: (context, i) {
                                  artists = state.songs[i].artists
                                      .toString()
                                      .replaceAll('[', "");
                                  artists = artists.replaceAll(']', "");
                                  // bool isPlaying = con.player.getCurrentAudioTitle ==
                                  //     state.songs[i].songname;
                                  return InkWell(
                                    onTap: () async {
                                      // print("Clicked searching.....");
                                      if (state.songs.length > 0) {
                                        if (StaticStore.playing == false) {
                                          // if(StaticStore.pause==true){
                                          // StaticStore.pause=false;
                                          if (StaticStore.currentSong ==
                                              state.songs[i].name) {
                                            await _youtubePlayer
                                                .youtubeResume();
                                          } else {
                                            await _youtubePlayer.youtubeStop();
                                            // _youtubePlayer.youtubePlay(state.songs[i].name);
                                            await _youtubePlayer.youtubePlay(
                                                state.songs[i].name);
                                            StaticStore.currentSong =
                                                state.songs[i].name;
                                          }
                                          setState(() {
                                            StaticStore.playing = true;
                                          });
                                          // StaticStore.pause=false;
                                        } else {
                                          if (StaticStore.currentSong ==
                                              state.songs[i].name) {
                                            await _youtubePlayer.youtubePause();
                                            // StaticStore.pause = true;
                                            // print("same");
                                            setState(() {
                                              StaticStore.playing = false;
                                            });
                                          } else {
                                            // StaticStore.pause = true;
                                            // }else{
                                            await _youtubePlayer.youtubeStop();
                                            await _youtubePlayer.youtubePlay(
                                                state.songs[i].name);
                                            StaticStore.currentSong =
                                                state.songs[i].name;
                                            setState(() {
                                              StaticStore.playing = true;
                                            });
                                          }
                                          // setState(() {
                                          //   StaticStore.playing = false;
                                          // });
                                          // }
                                        }

                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SongScreen(
                                                        state.songs[i])));
                                      }

                                      // if(StaticStore.playing==false){
                                      //   // if(StaticStore.pause==true){
                                      //     // StaticStore.pause=false;
                                      //     // if(StaticStore.currentSong==state.songs[i].name){
                                      //     //   await _youtubeSongPlayer.youtubeResume();
                                      //     // }
                                      //   // }else{
                                      //     // await _youtubeSongPlayer.youtubeStop();
                                      //     _youtubeSongPlayer.youtubePlay(state.songs[i].name);
                                      //     StaticStore.currentSong = state.songs[i].name;
                                      //     StaticStore.playing = true;
                                      //   // }
                                      //   // StaticStore.pause=false;
                                      // }else{
                                      //   // if(StaticStore.currentSong==state.songs[i].name){
                                      //     // StaticStore.pause = true;
                                      //     // await _youtubeSongPlayer.youtubePause();
                                      //   // }else{
                                      //     await _youtubeSongPlayer.youtubeStop();
                                      //     await _youtubeSongPlayer.youtubePlay(state.songs[i].name);
                                      //     StaticStore.currentSong = state.songs[i].name;
                                      //   // }
                                      // }

                                      // FocusScope.of(context).unfocus();
                                      // // BlocProvider.of<SearchResultsCubit>(context)
                                      //     // .playSongs(con, i);
                                      // var box = Hive.box('Recentsearch');
                                      // box.put(state.songs[i].name, {
                                      //   "name": state.songs[i].name,
                                      //   // "fullname": state.songs[i].name,
                                      //   // "username": state.songs[i].userid,
                                      //   "image": state.songs[i].imgUrl,
                                      //   // "track": state.songs[i].trackid,
                                      //   "id": state.songs[i].id,
                                      //   // "type": "SONG"
                                      // });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0, bottom: 12.0, top: 12.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        state.songs[i].imgUrl,
                                                    width: 50,
                                                    height: 50,
                                                    memCacheHeight: (50 *
                                                            MediaQuery.of(
                                                                    context)
                                                                .devicePixelRatio)
                                                        .round(),
                                                    memCacheWidth: (50 *
                                                            MediaQuery.of(
                                                                    context)
                                                                .devicePixelRatio)
                                                        .round(),
                                                    progressIndicatorBuilder:
                                                        (context, url, l) =>
                                                            const LoadingImage(),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          state.songs[i].name,
                                                          maxLines: 1,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyText1!
                                                              .copyWith(
                                                                  color:
                                                                      // isPlaying ?
                                                                      Colors.lightGreenAccent[
                                                                          700]
                                                                  // : Colors.white,
                                                                  // overflow:
                                                                  //     TextOverflow
                                                                  //         .ellipsis
                                                                  ),
                                                        ),
                                                        const SizedBox(
                                                            height: 5),
                                                        Text(
                                                          // state.songs[i].duration!,
                                                          // s.replaceAll(new RegExp(r'[^\w\s]+'),'')
                                                          // state.songs[i].artists.toString(),
                                                          artists,
                                                          // "3:26",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          IconButton(
                                            splashRadius: 20,
                                            padding: const EdgeInsets.all(0),
                                            onPressed: () {
                                              showModalBottomSheet(
                                                  useRootNavigator: true,
                                                  isScrollControlled: true,
                                                  elevation: 100,
                                                  backgroundColor:
                                                      Colors.black38,
                                                  context: context,
                                                  builder: (context) {
                                                    return
                                                        // SizedBox();
                                                        /* For shoowing search result song name with options */
                                                        BottomSheetWidget(
                                                            //     // con: con,
                                                            //     // song: state.songs[i]
                                                            );
                                                  });
                                            },
                                            icon: const Icon(
                                              Icons.more_vert,
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                });
                        // } else {
                        //   return ListView.builder(
                        //       itemCount: state.users.length,
                        //       itemBuilder: (context, i) {
                        //         return InkWell(
                        //           onTap: () {
                        //             FocusScope.of(context).unfocus();
                        //             var box = Hive.box('Recentsearch');
                        //             box.put(state.users[i].name, {
                        //               "songname": state.users[i].name,
                        //               "fullname": state.users[i].username,
                        //               "username": '',
                        //               "cover": state.users[i].avatar,
                        //               "track": '',
                        //               "id": '',
                        //               "type": "ARTIST"
                        //             });
                        //             Navigator.push(
                        //                 context,
                        //                 CupertinoPageRoute(
                        //                     builder: (context) =>
                        //                     SizedBox(),
                        //                     // ArtistProfile(
                        //                     //     username: state.users[i].username!,
                        //                     //     con: con)
                        //                     ));
                        //           },
                        //           child: Padding(
                        //             padding: const EdgeInsets.only(
                        //                 left: 12.0, bottom: 12.0, top: 12.0),
                        //             child: Row(
                        //               children: [
                        //                 ClipRRect(
                        //                   borderRadius: BorderRadius.circular(3),
                        //                   child: CachedNetworkImage(
                        //                     imageUrl: state.users[i].avatar!,
                        //                     width: 50,
                        //                     height: 50,
                        //                     memCacheHeight:
                        //                         (70 * devicePexelRatio).round(),
                        //                     memCacheWidth:
                        //                         (70 * devicePexelRatio).round(),
                        //                     maxHeightDiskCache:
                        //                         (70 * devicePexelRatio).round(),
                        //                     maxWidthDiskCache:
                        //                         (70 * devicePexelRatio).round(),
                        //                     progressIndicatorBuilder:
                        //                         (context, url, l) =>
                        //                             const LoadingImage(),
                        //                     fit: BoxFit.cover,
                        //                   ),
                        //                 ),
                        //                 Flexible(
                        //                   child: Padding(
                        //                     padding: const EdgeInsets.all(8.0),
                        //                     child: Column(
                        //                       crossAxisAlignment:
                        //                           CrossAxisAlignment.start,
                        //                       children: [
                        //                         Text(
                        //                           state.users[i].name!,
                        //                           maxLines: 1,
                        //                           style: Theme.of(context)
                        //                               .textTheme
                        //                               .bodyText1!
                        //                               .copyWith(
                        //                                   color: Colors.white,
                        //                                   overflow: TextOverflow
                        //                                       .ellipsis),
                        //                         ),
                        //                         const SizedBox(height: 5),
                        //                         Text(
                        //                           state.users[i].username!,
                        //                           style: Theme.of(context)
                        //                               .textTheme
                        //                               .bodyText1!
                        //                               .copyWith(
                        //                                 color: Colors.grey,
                        //                               ),
                        //                         ),
                        //                       ],
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //         );
                        //       });
                        // }
                      }
                      if (state.status == LoadPage.error) {
                        return const Center(
                          child: Text(
                            "Error",
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }

                      return Container();
                    },
                  ));
        }));
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final void Function(String? s) onChanged;
  // final bool isSong;
  final void Function() onPressed;
  const CustomAppBar({
    Key? key,
    required this.onChanged,
    // required this.isSong,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.grey.shade800,
        height: 60,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Container(
                color: Colors.grey.shade800,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Expanded(
                child: TextField(
                  autofocus: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Search",
                    filled: true,
                    hintStyle: const TextStyle(color: Colors.grey),
                    fillColor: Colors.grey.shade800,
                    border: InputBorder.none,
                  ),
                  onChanged: onChanged,
                ),
              ),
              Container(
                color: Colors.grey.shade800,
                child: IconButton(
                  splashRadius: 20,
                  icon:
                      // isSong ?
                      const Icon(
                    LineIcons.music,
                    color: Colors.white,
                  ),
                  // : const Icon(
                  //     LineIcons.user,
                  //     color: Colors.white,
                  //   ),
                  onPressed: onPressed,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
