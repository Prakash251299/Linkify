import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../controllers/main_controller.dart';
import '../../models/loading_enum.dart';
import '../../utils/horizontal_songs_list.dart';

import '../../utils/recent_users.dart';
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
          // print(state.likedTrack?['name']);
          return
          //  SizedBox();
          // state.songs.sublist(0, 10);
          // return SizedBox();
        // }));
          // if (state.status == LoadPage.loading) {
            // return 
            // Scaffold(
            //   body: Center(
            //     child: CircularProgressIndicator(),
            //   ),
            // );
          // }
          // if (state.status == LoadPage.loaded) {
            // return 
            Scaffold(
              body: ListView(
                children: [
                  RecentUsers(
                    state.likedTrack
                    // con: con,
                    // users: state.users.sublist(0, 6),
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
            );
            }));
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
}
