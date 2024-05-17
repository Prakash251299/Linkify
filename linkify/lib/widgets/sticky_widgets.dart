// import 'dart:convert';
// import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:http/http.dart';
import 'package:line_icons/line_icons.dart';
import 'package:linkify/controller/Network/fetch_friends.dart';
import 'package:linkify/controller/firebase_call.dart';
// import 'package:linkify/controller/accesstoken_error.dart';
// import 'package:linkify/controller/firebase_call.dart';
// import 'package:linkify/controller/read_write.dart';
import 'package:linkify/controller/static_store.dart';
import 'package:linkify/controller/get_user_info.dart';
import 'package:linkify/controller/Network/user_network_functions.dart';
import 'package:linkify/controller/youtube_player.dart';
// import 'package:linkify/model/album.dart';
import 'package:linkify/model/user_info.dart';
import 'package:linkify/widgets/Network/friend_suggestion.dart';
import 'package:linkify/widgets/carousel_song_screen.dart';
import 'package:linkify/widgets/uis/models/genreTag.dart';
import 'package:linkify/widgets/uis/screens/home/home_screen.dart';
import 'package:linkify/widgets/uis/screens/library/library.dart';
import 'package:linkify/widgets/uis/screens/search_page/search_page.dart';
import 'package:linkify/widgets/Network/user_network.dart';
// import 'package:youtube_explode_dart/youtube_explode_dart.dart';

// class MyStickyWidgets extends StatelessWidget {

bool _isNumeric(String str) {
  if (str == "") {
    return false;
  }
  return double.tryParse(str) != null;
}
// @override

Widget footer(var context) {
  return Opacity(
    opacity: 1.0,
    // opacity: 0.5,
    child: Container(
        // margin: EdgeInsets.only(top: MediaQuery.of(context).size.height-200),
        height: 50,
        padding: EdgeInsets.only(left: 20, right: 20),
        color: Colors.black.withOpacity(0.7),
        // decoration: BoxDecoration(
        //   color: Colors.black.withOpacity(0.5),
        //   gradient: LinearGradient(
        //     begin: Alignment.bottomCenter,
        //     end: Alignment.topCenter,
        //     colors: [
        //     Colors.black,
        //     Colors.black,
        //   ]

        //   ),
        // ),
        child: Row(children: [
          IconButton(
            icon:StaticStore.screen==0?Icon(Icons.home,color: Colors.white,):Icon(LineIcons.home,color: Colors.white70,),

            // icon: const Icon(
            //   LineIcons.home,
              // color: Colors.white,
            // ),
            onPressed: () {
              StaticStore.screen = 0;


              // Navigator.of(context).push(MaterialPageRoute(
              //       builder: (_) => HomeScreen(),
              //     ));


              Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (_) => HomeScreen(),
                  ));
                  // .then((value) => Navigator.pop(context));
            },
          ),
          const Spacer(),
          IconButton(
            icon: StaticStore.screen==1? Icon(
              Icons.search,
              color: Colors.white,
            ):Icon(Icons.search,color: Colors.white70,),
            onPressed: () {
              StaticStore.screen = 1;
               Navigator.pushReplacement(context,MaterialPageRoute(
                    builder: (_) => SearchPage(),
                  ));
                  // .then((value) => Navigator.pop(context));


              // Navigator.of(context)
              //     .push(MaterialPageRoute(
              //       builder: (_) => SearchPage(),
              //     ))
              //     .then((value) => Navigator.pop(context));
            },
          ),
          Spacer(),
          IconButton(
            icon: StaticStore.screen==2?Icon(
              LineIcons.userPlus,
              color: Colors.white,
            ):Icon(
              LineIcons.userPlus,
              color: Colors.white70,
            ),
            onPressed: () async {
              StaticStore.screen = 2;
              // await fetchAllFriends(context);


              // Navigator.pushReplacement(context,MaterialPageRoute(
              //     builder: (_) => NetworkUser(alluser)),
              //   ));
              StaticStore.requestStatusValue?.clear();
              List<UserInfo>? bestMatch = await fetchBestMatchFriends(3);
              List<UserInfo>? goodMatch = await fetchGoodMatchFriends(3);
              List<UserInfo>? allUsers = await fetchAllFriends(3);
              // print(allUsers?[0].displayName);
              // print(bestMatch?[0].displayName);
              // print(allUsers?[0].image?[0]['url']);



              // List<List<String>> requestStatusValue=[List.filled(bestMatch!.length, "0"),List.filled(goodMatch!.length, "0"),List.filled(3, "0")];


              if(bestMatch!=null){
                print("bestmatch has data");
                List<String>temp=[];
                for(int i=0;i<3 && i<bestMatch.length;i++){
                  temp.add(await getFriendStatus(bestMatch[i].id));
                }
                StaticStore.requestStatusValue?.add(temp);
                // StaticStore.requestStatusValue?.add(List.filled(bestMatch.length, "0"));
              }
              else{
                StaticStore.requestStatusValue?.add([]);
              }
              if(goodMatch!=null){
                print("goodmatch has data");
                List<String>temp=[];
                for(int i=0;i<3 && i<goodMatch.length;i++){
                  temp.add(await getFriendStatus(goodMatch[i].id));
                }
                StaticStore.requestStatusValue?.add(temp);
                // StaticStore.requestStatusValue?.add(List.filled(goodMatch.length, "0"));
              }
              else{
                StaticStore.requestStatusValue?.add([]);
              }
              if(allUsers!=null){
                print("allusers has data");
                List<String>temp=[];
                String a = "";
                for(int i=0;i<3 && i<allUsers.length;i++){
                  a = await getFriendStatus(allUsers[i].id);
                  print("allusersStatus: $a");
                  temp.add(a);
                }
                StaticStore.requestStatusValue?.add(temp);
                // StaticStore.requestStatusValue?.add(List.filled(allUsers.length, "0"));
              }
              else{
                StaticStore.requestStatusValue?.add([]);
              }
              // StaticStore.requestStatusValue=[List.filled(bestMatch!.length, "0"),List.filled(goodMatch!.length, "0"),List.filled(allUsers!.length, "0")];






              print(StaticStore.requestStatusValue);
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Suggestion(bestMatch, goodMatch, allUsers)));




              // Navigator.of(context).push(builder:()=MaterialPageRoute(
              //     builder: (_) => Suggestion(bestMatch,goodMatch,allUsers),
              //   ));

              


              // await fetchFriends(context);

              // NetworkFunction _networkFunction = NetworkFunction();

              // /* If data updation needed in firebase then use the below code */
              // // await s.fetchInfo();

              // var numberOfUsers = 0;
              // // DateTime now = DateTime.now();
              // // var dateToday = now.day.toString();
              // // if(_isNumeric(StaticStore.dateStored[1])){

              // // }

              // // if(StaticStore.dateStored[0]==dateToday[0]){

              // // }

              // /* Get number of users for recommendation */
              // // numberOfUsers = await _networkFunction.getNumberOfUsers();


              // // StoreUserInfo _storeUserInfo = StoreUserInfo();
              // // _storeUserInfo.fetchCurrentUserInfo();
              // if (numberOfUsers >= 10) {
              //   /* If we have more users then like based friend recommendations will be provided */
              //   List<UserInfo?> userHavingSameInterests =
              //       await _networkFunction.fetchRecommendedUsersInfo();
              //   Navigator.pushReplacement(context,MaterialPageRoute(
              //     builder: (_) => NetworkUser(userHavingSameInterests),
              //   ));
               // // Navigator.of(context).push(MaterialPageRoute(
               // //   builder: (_) => NetworkUser(userHavingSameInterests),
               // // ));
              // } else {
              //   /* All users of our application will be recommended */
              //   List<UserInfo?> allUsers =
              //       await _networkFunction.fetchAllUsersInfo();
              //   // print(allUsers[0]?.id);

                // Navigator.pushReplacement(context,MaterialPageRoute(
                //   builder: (_) => NetworkUser(allUsers),
                // ));

              //   // Navigator.of(context).push(MaterialPageRoute(
              //   //   builder: (_) => NetworkUser(allUsers),
              //   // ));
              // }
            },
          ),
        ])),
  );
}

Widget miniplayer(BuildContext context) {
  // var c = [Color.fromARGB(221, 66, 37, 37),Color.fromARGB(221, 146, 72, 72),];
  // var random = Random().nextInt(34)-1;
  // if(8 in List)
  List<dynamic> excludedColorList = [2, 5, 8, 11, 14, 19, 22, 27, 29, 31, 32];
  int d = StaticStore.currentSong.length * 4 % 34;
  // int d = StaticStore.currentSong.length * 4 % 34;
  YoutubeSongPlayer _player = YoutubeSongPlayer();
  int e = d+1;
  while (excludedColorList.contains(d)) {
    d++;
    d = d % 34;
  }
  while (excludedColorList.contains(e) || e==d) {
    e++;
    e = e % 34;
  }
  int color = int.parse(tags[d]['color'].toString());
  int color2 = int.parse(tags[e]['color'].toString());
  // print(d);
  return GestureDetector(
    child: Stack(
      // mainAxisAlignment: MainAxisAlignment.end,
      alignment: Alignment.bottomCenter,
      children: [
        // _BackgroundFilter(),
        Container(
          // height:100,
          // padding: EdgeInsets.only(bottom:50),
          margin: EdgeInsets.only(bottom: 50),

          // color: Color(tags[0]['color']),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            // color: Color(color).withOpacity(1),
            // decoration: BoxDecoration(
            gradient: LinearGradient(
              // begin: Alignment.topCenter,
              // end: Alignment.bottomCenter,
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                // Colors.brown,
                Color(color2).withOpacity(1),
                Color(color).withOpacity(1),
              ],
            ),
            // ),
          ),
          // color:Colors.red,
          // width: 360,
          // width: MediaQuery.of(context).size.width,
          height: 60,
          // height: 110,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            // itemCount: list.length,
            itemCount: 2,
            itemBuilder: ((context, index) {
              // bool last = list.length == (index + 1);
              return Container(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 8,
                    // right: last ? 16 : 0,
                    // right: 16,
                  ),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        // padding: EdgeInsets.only(right:80),
                        width: 45,
                        height: 45,
                        // decoration: TextDecoration.none,
                        decoration: StaticStore.currentSongImg!=""?BoxDecoration(
                          // color: Colors.red,
                          // decoration: TextDecoration.none
                          image: DecorationImage(
                              image: NetworkImage(StaticStore.currentSongImg),
                              fit: BoxFit.cover),
                        ):BoxDecoration(),
                      ),
                      SizedBox(width: 8),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // img

                            // Container(
                            //   // width: 150,
                            //   // height: 80,

                            //   decoration: BoxDecoration(
                            //     color: Colors.red,

                            //     // image: DecorationImage(
                            //     // image: NetworkImage(list[index].img),
                            //     // fit: BoxFit.cover),
                            //   ),
                            // ),
                            const SizedBox(
                              height: 8,
                            ),
                            // name
                            SizedBox(
                              // width: MediaQuery.of(context).size.width / 1.5,
                              width: 100,
                              child: Text(
                                  // "hello",
                                  "${StaticStore.currentSong}",
                                  // list[index].title,
                                  style: const TextStyle(
                                    decoration: TextDecoration.none,
                                    color: Color(0xffffffff),
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Raleway",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 13.0,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  textAlign: TextAlign.left),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            // show-creator
                            SizedBox(
                              // width: MediaQuery.of(context).size.width / 1.5,
                              width: MediaQuery.of(context).size.width/1.5,
                              child: Text(
                                  // list[index].creator ?? '',

                                  // "jasjkd",

                                  StaticStore.currentArtists.length > 1
                                      ? "${StaticStore.currentArtists[0]}, ${StaticStore.currentArtists[1]}"
                                      : StaticStore.currentArtists.length > 0 &&
                                              StaticStore
                                                      .currentArtists.length <=
                                                  1
                                          ? "${StaticStore.currentArtists[0]}"
                                          : "unknown",
                                  style: const TextStyle(
                                      decoration: TextDecoration.none,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Raleway",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 13.0,
                                      overflow: TextOverflow.ellipsis),
                                  maxLines: 1,
                                  textAlign: TextAlign.left),
                            ),
                          ]),
                      // Spacer(),
                      
                      
                      // Icon(Icons.menu),
                      Container(
                        // height: 20,
                        width: 20,
                        // color: Colors.grey,
                        child: IconButton(
                            onPressed: () async {
                              if (StaticStore.pause == true) {
                                await _player.youtubeResume();
                                StaticStore.pause = false;
                                StaticStore.playing = true;
                              } else {
                                await _player.youtubePause();
                                StaticStore.pause = true;
                                StaticStore.playing = false;
                              }
                            },
                            icon: StaticStore.pause == true
                                ? Icon(
                                    CupertinoIcons.play,
                                    color: Colors.white,
                                  )
                                : Icon(
                                    CupertinoIcons.pause,
                                    color: Colors.white,
                                  )),
                      ),
                      // SizedBox(width:13),
                      Container(
                        // height: ,
                        width: 40,
                        // color: Colors.amber,
                        child: playNext(_player)
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
        // Spacer(),
        indicator(context),
      ],
    ),
    onTap: () {
      // print(StaticStore.currentSong.length);
      // return;
      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewScreen()));

      Navigator.of(context).push(MaterialPageRoute(
          builder: ((context) => CarouselSongScreen(
              StaticStore.currentSong,
              StaticStore.currentSong,
              StaticStore.currentArtists,
              StaticStore.currentSongImg))));
    },
  );
}

// @override
// Widget build(BuildContext context) {
//   // TODO: implement build
//   throw UnimplementedError();
// }
// }

// import 'battery_status.dart';
// import 'index.dart';

/// A widget that displays the battery level and status.
// class DefaultBatteryIndicator extends StatelessWidget {
//   DefaultBatteryIndicator({
//     super.key,
//     // required this.status,
// var trackHeight = 10.0;
var curve = Curves.ease;
var duration = const Duration(seconds: 1);
//   });
//   // : assert(trackAspectRatio >= 1, 'width:height must >= 1');

//   /// The battery status.
//   // final DefaultBatteryStatus status;

//   /// The height of the track.
//   final double trackHeight;

//   /// The width of the track.
//   final double trackAspectRatio;

//   /// The curve of the animation.
//   final Curve curve;

//   /// The duration of the animation.
//   final Duration duration;

// @override

Widget playNext(_player) {
  return 
  IconButton(
      onPressed: () async {
        if (StaticStore.nextPlay == 1) {
          StaticStore.nextPlay = 0;
          // }
          StaticStore.queueIndex++;
          if (StaticStore.queueIndex <= StaticStore.myQueueTrack.length - 1) {
            // setState(() {
            // });
            await _player.youtubeStop().then((value) async {
              // if(StaticStore.queueIndex>=StaticStore.myQueueTrack.length){
              //   StaticStore.queueIndex--;
              //   return;
              // }
    
              await _player
                  .youtubePlay(
                      StaticStore.myQueueTrack[StaticStore.queueIndex].name,
                      StaticStore
                          .myQueueTrack[StaticStore.queueIndex].trackArtists[0])
                  .then((value) {
                StaticStore.currentSong =
                    StaticStore.myQueueTrack[StaticStore.queueIndex].name!;
                StaticStore.currentArtists =
                    StaticStore.myQueueTrack[StaticStore.queueIndex].trackArtists;
                StaticStore.currentSongImg =
                    StaticStore.myQueueTrack[StaticStore.queueIndex].imgUrl!;
                StaticStore.playing = true;
                StaticStore.pause = false;
              });
            });
            // setState(() {});
          } else {
            StaticStore.queueIndex--;
            StaticStore.nextPlay = 1;
          }
        }
      },
      // iconSize: 45,
      icon: const Icon(
        Icons.skip_next,
        color: Colors.white,
      ),
    // ),
  );
}

Widget indicator(BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;
  final track = _buildTrack(context, colorScheme);
  // final knob = _buildKnob(context, colorScheme);

  return StreamBuilder<Object>(
      stream: StaticStore.player.playerStateStream,
      builder: (context, snapshot) {
        return Container(
          margin: EdgeInsets.only(bottom: 50),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [track],
          ),
        );
      });
}

Widget _buildTrack(BuildContext context, ColorScheme colorScheme) {
  // final borderRadius = BorderRadius.circular(trackHeight / 4);
  // final borderColor = Theme.of(context).colorScheme.onSurface;
  var trackHeight = 10.0;
  final bar = _buildBar(context, trackHeight * 5 / 6, colorScheme);
  // final icon = _buildIcon();

  final children = [bar];

  return Container(
    // height: trackHeight,
    height: 2,
    // color: Colors.red,
    // width: trackHeight * trackAspectRatio,
    width: MediaQuery.of(context).size.width,
    // width: 100,
    // decoration: BoxDecoration(
    //   borderRadius: borderRadius,
    //   border: Border.all(color: borderColor),
    // ),
    child: Stack(
      children: children,
    ),
  );
}

Widget _buildBar(
  BuildContext context,
  double barHeight,
  ColorScheme colorScheme,
) {
  // final barWidth = trackHeight * trackAspectRatio;
  final borderRadius = barHeight / 5;
  var wid = MediaQuery.of(context).size;

  // final currentColor = status.getBatteryColor(colorScheme);

  return
      // Padding(
      //   padding: EdgeInsets.all(trackHeight / 12),
      //   child:
      StreamBuilder<Object>(
          stream: StaticStore.player.positionStream,
          builder: (context, snapshot) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: Stack(
                children: [
                  const SizedBox.expand(),
                  AnimatedContainer(
                    duration: duration,
                    width: StaticStore.player.duration==null?0:(StaticStore.player.position.inSeconds * wid.width) /
                        StaticStore.player.duration!.inSeconds,
                    // width: barWidth * status.value / 100,
                    // width: barWidth*1/2,
                    // width:MediaQuery.of(context).size.width,
                    height: double.infinity,
                    curve: curve,
                    decoration: BoxDecoration(
                      // color: currentColor,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              // ),
            );
          });
}
