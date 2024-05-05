import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:line_icons/line_icons.dart';
import 'package:linkify/controller/accesstoken_error.dart';
import 'package:linkify/controller/firebase_call.dart';
import 'package:linkify/controller/read_write.dart';
import 'package:linkify/controller/static_store.dart';
import 'package:linkify/controller/get_user_info.dart';
import 'package:linkify/controller/user_network_functions.dart';
import 'package:linkify/controller/youtube_player.dart';
import 'package:linkify/model/album.dart';
import 'package:linkify/model/user_info.dart';
import 'package:linkify/widgets/carousel_song_screen.dart';
import 'package:linkify/widgets/uis/models/catagory.dart';
import 'package:linkify/widgets/uis/screens/home/home_screen.dart';
import 'package:linkify/widgets/uis/screens/library/library.dart';
import 'package:linkify/widgets/uis/screens/search_page/search_page.dart';
import 'package:linkify/widgets/user_network.dart';
// import 'package:youtube_explode_dart/youtube_explode_dart.dart';

// class MyStickyWidgets extends StatelessWidget {

  bool _isNumeric(String str) {
    if(str == "") {
      return false;
    }
    return double.tryParse(str) != null;
  }
  // @override
  
  Widget footer(var context) {
    return 
    Opacity(
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
              icon: const Icon(
                LineIcons.home,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                      builder: (_) => HomeScreen(),
                    ))
                    .then((value) => Navigator.pop(context));
              },
            ),
            Spacer(),
            IconButton(
              icon: const Icon(
                CupertinoIcons.search,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                      builder: (_) => SearchPage(),
                    ))
                    .then((value) => Navigator.pop(context));
              },
            ),
            Spacer(),
            IconButton(
              icon: Icon(
                LineIcons.userPlus,
                color: Colors.white,
              ),
              onPressed: () async {
                NetworkFunction _networkFunction = NetworkFunction();
      
                /* If data updation needed in firebase then use the below code */
                // await s.fetchInfo();
      
              
                var numberOfUsers = 0;
                DateTime now = DateTime.now();
                var dateToday = now.day.toString();
                // if(_isNumeric(StaticStore.dateStored[1])){
      
                // }
      
                // if(StaticStore.dateStored[0]==dateToday[0]){
      
                // }
      
      
      
                /* Get number of users for recommendation */
                // numberOfUsers = await _networkFunction.getNumberOfUsers();
      
                StoreUserInfo _storeUserInfo = StoreUserInfo();
                _storeUserInfo.fetchCurrentUserInfo();
                if(numberOfUsers>=10){
                /* If we have more users then like based friend recommendations will be provided */
                  List<UserInfo?> userHavingSameInterests =
                      await _networkFunction.fetchRecommendedUsersInfo();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => NetworkUser(userHavingSameInterests),
                  ));
                }else{
                /* All users of our application will be recommended */
                List<UserInfo?> allUsers =
                    await _networkFunction.fetchAllUsersInfo();
                    // print(allUsers[0]?.id);
      
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => NetworkUser(allUsers),
                  ));
                }
      
      
              },
            ),
          ])),
    );
  }

  Widget miniplayer(var context) {
    // var c = [Color.fromARGB(221, 66, 37, 37),Color.fromARGB(221, 146, 72, 72),];
    // var random = Random().nextInt(34)-1;
    // if(8 in List)
    List<dynamic> excludedColorList = [2, 5, 8, 11, 14, 19, 22, 27, 29, 31, 32];
    int d = StaticStore.currentSong.length * 4 % 34;
    YoutubeSongPlayer _player = YoutubeSongPlayer();
    while (excludedColorList.contains(d)) {
      d++;
      d = d%34;
    }
    int color = int.parse(tags[d]['color'].toString());
    // print(d);
    return GestureDetector(
      child: 
      Container(
        // height:100,
        // padding: EdgeInsets.only(bottom:50),
        margin: EdgeInsets.only(bottom:50),

        // color: Color(tags[0]['color']),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(color).withOpacity(1),
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
                      decoration: BoxDecoration(
                        color: Colors.red,
                        // decoration: TextDecoration.none
                        image: DecorationImage(
                            image: NetworkImage(StaticStore.currentSongImg),
                            fit: BoxFit.cover),
                      ),
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
                            width: MediaQuery.of(context).size.width/1.5,
                            // width:,
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
                            width: MediaQuery.of(context).size.width/1.5,
                            child: Text(
                                // list[index].creator ?? '',

                                // "jasjkd",

                                StaticStore.currentArtists.length > 1
                                    ? "${StaticStore.currentArtists[0]}, ${StaticStore.currentArtists[1]}"
                                    : StaticStore.currentArtists.length > 0 && StaticStore.currentArtists.length <= 1?"${StaticStore.currentArtists[0]}":"unknown",
                                    
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
                    Spacer(),
                    IconButton(
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

                          // StaticStore.pause==true?await _player.youtubeResume():await _player.youtubePause();
                        },
                        icon: StaticStore.pause == true
                            ? Icon(
                                CupertinoIcons.play,
                                color: Colors.white,
                              )
                            : Icon(
                                CupertinoIcons.pause,
                                color: Colors.white,
                              ))
                  ],
                ),
              ),
            );
          }),
        ),
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
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
// }
