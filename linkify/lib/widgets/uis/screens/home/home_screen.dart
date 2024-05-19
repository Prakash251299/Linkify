import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:linkify/controller/Network/user_network_functions.dart';
import 'package:linkify/controller/firebase_call.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:line_icons/line_icons.dart';
import 'package:linkify/controller/get_greeting.dart';
import 'package:linkify/controller/get_user_info.dart';
import 'package:linkify/controller/logout.dart';
import 'package:linkify/controller/notification/notification_functions.dart';
import 'package:linkify/controller/static_store.dart';
import 'package:linkify/model/user_info.dart';
import 'package:linkify/widgets/Network/user_network.dart';
import 'package:linkify/widgets/restart_app.dart';
// import 'package:linkify/widgets/carousel_song_screen.dart';
import 'package:linkify/widgets/sticky_widgets.dart';
import 'package:linkify/widgets/uis/screens/home/notification.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:linkify/widgets/uis/screens/library/library.dart';
// import 'package:linkify/widgets/uis/screens/search_page/search_page.dart';
// import '../../controllers/main_controller.dart';
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
  // void initState(){

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HomeCubit()..getAlbums(),
        // create:(_){},
        child: BlocBuilder<HomeCubit, HomeState>(
            // child: BlocBuilder(
            builder: (context, state) {
          print("homescreen");
          if (state.status == LoadPage.loading) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 10),
                    Text("Loading front page data"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "If it is taking too long check your internet",
                          maxLines: 3,
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          }
          if (state.status == LoadPage.loaded) {
            var greet = greeting();
            return SafeArea(
              child: Scaffold(
                body: Column(children: [
                  Stack(children: [
                    // Text("gsas"),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.0),
                      child: Container(
                        // color: Colors.red,
                        // padding:EdgeInsets.only(bottom: 10),
                        height: 60,
                        child: Row(
                          children: [
                            Text(
                              greet,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            Spacer(),

                            Row(
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    List<dynamic>? friendRequests = await fetchFriendRequests();
                                    List<UserInfo>? _userInfo = friendRequests?.length!=0?
                                    await FetchRequestNotifications(friendRequests):null;
                                    // NetworkFunction _fetchUserInfo = NetworkFunction();

                                    // _fetchUserInfo.fetchUserInfo();
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>NetworkUser(_userInfo,"Requests")));
                                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationScreen(_userInfo)));
                                    // 
                                  }, 
                                  icon: Icon(Icons.notifications,color: Colors.white,)
                                ),
                                IconButton(
                                  onPressed: () async {
                                    print('Sign out called');
                                    // RestartWidget.restartApp(context);
                                    /* Below code is for signout */
                                //                       var appDir = (await getTemporaryDirectory()).path;
                                // new Directory(appDir).delete(recursive: true);
                                    // await DefaultCacheManager().emptyCache();
                                
                                    // StaticStore.player ;
                                
                                    await callSignOutApi(context);
                                    // RestartWidget.restartApp(context);
                                  },
                                  icon: Icon(
                                    Icons.more_vert,
                                    color: Colors.white,
                                  ), // more_vert _icon
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                  ]),

                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        // padding:EdgeInsets.only(bottom: 50),
                        height: MediaQuery.of(context).size.height - 88,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              CarouselSongs(state.carouselSongs),
                              // Spacer(),

                              for (int k = 0; k < 10; k++) ...{
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 7.0,
                                    vertical: 8,
                                  ),
                                  // EdgeInsets.only(top:16,left:7),
                                  child: Row(
                                    children: [
                                      Text(
                                        "${state.categories?[k].name}",
                                        // style: TextStyle(color:Colors.white),
                                        // TextStyle(color: Colors.red),TextTheme(titleMedium: )
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium,
                                      ),
                                    ],
                                  ),
                                ),
                                HorizontalSongList(state.categories?[k]),
                                const SizedBox(height: 12),
                              },
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // StaticStore.player.processingState==ProcessingState.completed?

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

                      // Opacity(
                      //   opacity: 0.5,
                      // child:
                      footer(context),
                    ],
                  ),
                  // ),
                ]),
              ),
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("No data found"),
            ],
          );
        }));
  }
}
