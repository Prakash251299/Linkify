import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/controller/playlist/playlist_track.dart';
import 'package:linkify/controller/variables/static_store.dart';
import 'package:linkify/model/album_track.dart';
import 'package:linkify/view/album/album_view.dart';
import 'package:linkify/view/home/loading.dart';
import 'package:linkify/view/playlists/playlist_cubit.dart';
import 'package:linkify/view/playlists/playlist_track_screen.dart';
import 'package:linkify/view/sticky/sticky_widgets.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  @override
  void initState() {
    // TODO: implement initState
    StaticStore.screen = 3;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.white,),
            onPressed: (){
              StaticStore.screen=0;
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.black,
          titleSpacing: 0,
          title: Text("Playlists",style:TextStyle(color: Colors.white)),
        ),
        body: 
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            BlocProvider(
              create: (context)=>PlaylistCubit()..getPlaylists(),
              child: BlocBuilder<PlaylistCubit, PlaylistState>(
                builder: (context, state) {
                  print(state.playlists.length);
                  // print(state.playlists[0].imgUrl);
                  return ListView.builder(
                                    itemCount: state.playlists.length,
                                    itemBuilder: (context, i) {
                                      return InkWell(
                                        onTap: () async {
                                          print("playlist opened");
                                          List<AlbumTrack>? _albumTracks= await fetchPlaylistTracks(state.playlists[i].id);
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>AlbumView(state.playlists[i].imgUrl,state.playlists[i].name,_albumTracks)));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20.0,
                                              bottom: 12.0,
                                              top: 12.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                // MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3),
                                                      child: CachedNetworkImage(
                                                        imageUrl: '${state.playlists[i].imgUrl}',
                                                        width: 55,
                                                        height: 55,
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
                                                            const EdgeInsets
                                                                .only(left:18.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              '${state.playlists[i]
                                                                  .name}',
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .copyWith(
                                                                      color:
                                                                          // isPlaying ?
                                                                          Colors.lightGreenAccent[700]
                                                                      // : Colors.white,
                                                                      // overflow:
                                                                      //     TextOverflow
                                                                      //         .ellipsis
                                                                      ),
                                                            ),
                                                            const SizedBox(
                                                                height: 5),
                                                            // Text(
                                                            //   artists,
                                                            //   style: Theme.of(
                                                            //           context)
                                                            //       .textTheme
                                                            //       .bodyMedium!
                                                            //       .copyWith(
                                                            //         color: Colors
                                                            //             .grey,
                                                            //       ),
                                                            //   overflow:
                                                            //       TextOverflow
                                                            //           .ellipsis,
                                                            // ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                }
              ),
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
            // miniplayer(context),
            footer(context),
          ],
        ),
      )
    );
  }
}