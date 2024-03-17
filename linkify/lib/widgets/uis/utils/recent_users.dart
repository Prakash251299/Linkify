import 'dart:convert';
import 'dart:ui';

// import 'package:b/models/category.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:linkify/controller/play_spotify_song.dart';
import 'package:linkify/model/album.dart';
import 'package:marquee/marquee.dart';
import '../controllers/main_controller.dart';
import '../methods/get_greeting.dart';

import '../models/user.dart';
import '../screens/artist_profile/artist_profile.dart';
import 'loading.dart';


class RecentUsers extends StatefulWidget {
  // var m = {};
  Map<String, List<dynamic>>?m={};
  RecentUsers(this.m,{super.key});

  @override
  State<RecentUsers> createState() => _RecentUsersState();
}

class _RecentUsersState extends State<RecentUsers> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
// class RecentUsers extends StatelessWidget {
  // final List<User> users;
  // final MainController con;
  // RecentUsers({
    // Key? key,
    // required this.users,
    // required this.con,
  // }) : super(key: key);


  PlaySpotifySong _playSpotifySong = PlaySpotifySong();


  List<String> s = [];
  Future<void> fun()async{
    await getCategories();
  }
  void initState(){
    // fun();
    super.initState();
  }

  Future<List<String>> getCategories()async{
    int lim = 6;
    List<Categories> c=[];
    s=[];
    /* Fectch categories from spotify using api */
    var res = await get(Uri.parse("")); 
    var data = jsonDecode(res.body);
    c.add(data);
    for(int i=0;i<lim;i++){
      // s.insert(i%6, data['items'][i]['name']);
      // s.add(data['items'][i]['name']);
      s.insert(i%6, data['items'][i]['name']);
    }
    return s;
  }
  var _useRtlText = false;

  @override
  Widget build(BuildContext context) {
    final devicePexelRatio = MediaQuery.of(context).devicePixelRatio;

    final greet = greeting();
    // print(widget.m?['image']);
    // s = getCategories();
    return Stack(
      children: [
        // CachedNetworkImage(
        //   // imageUrl: users[0].avatar!,
        //   // imageUrl: null,
        //   imageUrl: "",
        //   fit: BoxFit.cover,
        //   height: MediaQuery.of(context).size.height * .15,
        //   width: MediaQuery.of(context).size.width * .67,
        //   memCacheHeight: ((MediaQuery.of(context).size.height * .15) *
        //           MediaQuery.of(context).devicePixelRatio)
        //       .round(),
        //   memCacheWidth: ((MediaQuery.of(context).size.width * .67) *
        //           MediaQuery.of(context).devicePixelRatio)
        //       .round(),
        //   alignment: Alignment.topLeft,
        // ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  greet,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runSpacing: 8,
                  spacing: 8,
                  children: [
                    // ...users
                    //     .map((user) => 
                    // s = getCategories();
                    for(int i=0;i<6;i++)...{
                    InkWell(
                              onTap: () {
                                _playSpotifySong.playTrack(widget.m?['name']?[i]);
                                // print("Clicked");
                                // Navigator.push(
                                //     context,
                                //     CupertinoPageRoute(
                                //         builder: (context) => 
                                //         Text("${widget.m?['name']}"),
                                //         // Text(s[i]),
                                //         // SizedBox()
                                //         // ArtistProfile(
                                //               // username: user.username!,
                                //               // con: con,
                                //             // )
                                //             ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white12,
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                width:
                                    ((MediaQuery.of(context).size.width * .5) -
                                        21.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(3),
                                        bottomLeft: Radius.circular(3),
                                      ),
                                      child: CachedNetworkImage(
                                        // imageUrl: user.avatar!,
                                        imageUrl: widget.m?['image']?[i]??"",
                                        // imageUrl: "",
                                        
                                        width: 55,
                                        height: 55,
                                        memCacheHeight:
                                            (55 * devicePexelRatio).round(),
                                        memCacheWidth:
                                            (55 * devicePexelRatio).round(),
                                        maxHeightDiskCache:
                                            (55 * devicePexelRatio).round(),
                                        maxWidthDiskCache:
                                            (55 * devicePexelRatio).round(),
                                        progressIndicatorBuilder:
                                            (context, url, l) =>
                                                const LoadingImage(),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height:30,
                                          // width:auto,
                                          child: 
                                          // Text("hello",style:TextStyle(color:Colors.white)),
                                        // Marquee(
                                        //   text: '${widget.m?['name']?[i]}',style:TextStyle(color:Colors.white),
                                        //   velocity: 4,
                                        // ),

                                        Marquee(
                                          key: Key("$_useRtlText"),
                                          text: "${widget.m?['name']?[i]}",
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                          scrollAxis: Axis.horizontal,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          blankSpace: 20,
                                          velocity: 10,
                                          // pauseAfterRound: Duration(seconds: 1),
                                          showFadingOnlyWhenScrolling: true,
                                          fadingEdgeStartFraction: 0.1,
                                          fadingEdgeEndFraction: 0.1,
                                          // numberOfRounds: 3,
                                          startPadding: 10,
                                          // accelerationDuration: Duration(seconds: 1),
                                          // accelerationCurve: Curves.linear,
                                          // decelerationDuration: Duration(milliseconds: 500),
                                          // decelerationCurve: Curves.easeOut,
                                          // textDirection: _useRtlText ? TextDirection.rtl : TextDirection.ltr,
                                          textDirection: TextDirection.ltr,
                                        )


                                        ),
                                        // Text(
                                        //   // user.name!,
                                        //   widget.m['name'][i],
                                        //   style:TextStyle(color: Colors.white),
                                        //   // style: Theme.of(context)
                                        //       // .textTheme
                                        //       // .bodyText1,
                                        // ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    // )
                    //     .toList(),
                    }
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
