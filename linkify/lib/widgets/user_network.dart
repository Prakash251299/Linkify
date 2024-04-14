import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:linkify/controller/static_store.dart';
import 'package:linkify/model/user_info.dart';
import 'package:linkify/widgets/loading_user_img.dart';
import 'package:linkify/widgets/uis/utils/loading.dart';

class NetworkUser extends StatefulWidget {
  List<UserInfo?>likeUsersInfo;
  NetworkUser(this.likeUsersInfo,{super.key});

  @override
  State<NetworkUser> createState() => _NetworkUserState();
}

// "rules": "firestore.rules",

class _NetworkUserState extends State<NetworkUser> {

  // List<dynamic> allUsersId=[]; // In firebase type is dynamic
  // List<dynamic>? likeUsersId=[]; // In firebase type is dynamic
  // List<UserInfo?> likeUsersInfo=[]; // In firebase type is dynamic
  // List<String> likeUsersName=[]; // In firebase type is dynamic

  // Future<UserInfo?> fetchUserInfo(var id)async{
  //   var db = FirebaseFirestore.instance;
  //   UserInfo? user = UserInfo();
  //   // UserInfo.fromJson(db.collection("users")
  //   // .doc(id)
  //   // .get());
  //   await db.collection("users").doc(id).get().then((v){
  //     // print(v.data());
  //     // var a = UserInfo.fromJson(v.data()!);
  //     print("kyaa ${v.data()}");
  //     user.displayName = v.data()?['name'];
  //     print("CheckName: displayName ${user.displayName}");
  //     user.image = v.data()?['images'];
  //     // print(user?['name']);
  //   });
  //   // print(jsonData);
  //   return user;
  // }

  // Future<UserInfo?> fetchRecommendedUserInfo(var userId) async {
  //   UserInfo? user = UserInfo();
  //   await fetchUserInfo(userId).then((userInfo) {
  //     setState(() {
  //       user = userInfo;
  //     });
  //     return user;
  //   }).catchError((onError){});
  //   // user =  fetchUserInfo(userId);
  //   // print("CheckUser--> ${user.displayName}");
  //   // var e = user?.displayName;
  //   // user.image = userId.image

  //   return user;
  //   // return name;
  // }

  // final UserInfo _u = UserInfo();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  final devicePexelRatio = MediaQuery.of(context).devicePixelRatio;

  // List<dynamic> allUsersId=[]; // In firebase type is dynamic
  // List<dynamic>? likeUsersId=[]; // In firebase type is dynamic
  // List<UserInfo?> likeUsersInfo=[]; // In firebase type is dynamic
  // List<String> likeUsersName=[]; // In firebase type is dynamic
    return 
    SafeArea(child: 
      Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: IconButton(icon:Icon(Icons.arrow_back),color: Colors.white,onPressed: (){
            Navigator.pop(context);
          },),
          title: Text("Connect and talk",style:TextStyle(color:Colors.white)),
          backgroundColor: Colors.black,
          // titleTextStyle:TextStyle(color: Colors.white),

        ),
        body: 

        StreamBuilder(
          stream: FirebaseFirestore.instance.collection('spotifyBasedGenreUsers').snapshots(),
          builder: (context, snapshot) {
            // print(widget.likeUsersInfo[0]?.email);
            // print(snapshot.data?.docs[0]['genreList'][StaticStore.currentUserGenreId]);

            // likeUsersId = snapshot.data?.docs[0]['genreList'][StaticStore.currentUserGenreId];
            // likeUsersId?.remove(StaticStore.currentUserId);
            // print(likeUsersId);
            // for(int i=0;i<1;i++){
            // // a = fetchRecommendedUserInfo(likeUsersId?[i]);
            //   likeUsersInfo.add(fetchRecommendedUserInfo(likeUsersId?[i]));
            // }
            return 
            // SizedBox();
            ListView.builder(
                          scrollDirection: Axis.vertical,
                          // shrinkWrap: true,
                          // physics: ClampingScrollPhysics(),
                          // physics: BouncingScrollPhysics(),
                          physics: AlwaysScrollableScrollPhysics(),
                          itemCount: widget.likeUsersInfo.length,
                          // itemCount: widget.name.length,
                          // itemCount: m['name'].length!=0?m['name'].length:10,
                          // controller: _scrollController,
            
                          itemBuilder: (context, index) {
                            // print(position);
                            // print("hi");
                            // print("CheckUser --> "+likeUsersInfo[index]);
                            
                            // var userData = likeUsersInfo[index];
                            // print("checkMe ${widget.likeUsersInfo[index]?.displayName}");
                            return Column(children: [
                              // Container(
                              //   padding: EdgeInsets.only(top:_counter),
                              //   child:
                              Card(
                                color: Colors.black,
                                child: Column(children: [
                                  // Text("skjhdfkjds"),
            
                                  InkWell(
                                    borderRadius: BorderRadius.circular(15),
                                    onTap: () async {
                                      
                                    },
                                    child: ListTile(
                                      leading: Column(
                                          // mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(3),
                                                bottomLeft: Radius.circular(3),
                                              ),
                                              child:
                                              // StaticStore.currentSongImg==""?
                                                  // CachedNetworkImage(imageUrl: ""),
                                                  widget.likeUsersInfo[index]?.image?.length==0?
            
                                                  Container(
                                                    width: 55,
                                                    height: 55,
                                                    child:
                                                    const LoadingUserImage(),
                                                  )
            
            
                                              /* For user's friends image */
                                              :
                                                  CachedNetworkImage(
                                                // imageUrl: user.avatar!,
            
                                                imageUrl: widget.likeUsersInfo[index]?.image?.length==2?"${widget.likeUsersInfo[index]?.image?[1]['url']}":"${widget.likeUsersInfo[index]?.image?[0]['url']}",
            
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
                                                // progressIndicatorBuilder:
                                                //     (context, url, l) {
                                                //           return const LoadingImage();
                                                //     },
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ]),
            
                                      // CircleAvatar(
                                      //   child:Image.network("src"),
                                      // ),
            
                                      // title: Text(widget.user.name),
                                      title: Text(
                                        
                                        "${widget.likeUsersInfo[index]?.displayName}",
                                        // "hi",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      subtitle: Text(
                                        "${widget.likeUsersInfo[index]?.spotifyBasedGenre}",
                                        // "${widget.name[position]}",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      // Expanded(child:
                                      // Column(children: [
                                        // Expanded(child:
                                        // Column(children: [
                                          // widget.trackArtists[position].length>1?
                                          // Text('${widget.trackArtists[position][0]}, ${widget.trackArtists[position][1]}',overflow: TextOverflow.ellipsis,
                                          // style:TextStyle(color: Colors.white70)
                                          //         ):
                                          // Text('${widget.trackArtists[position][0]}',overflow: TextOverflow.ellipsis,
                                          //     style:TextStyle(color: Colors.white70)
                                          // ),
                                        // ]),
                                        // ),
                                      // ]),
                                      // ),
                                      isThreeLine: true,
                                      trailing: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            // Icon(
                                              // StaticStore.playingCarouselInd!=StaticStore.carouselInd?
                                              // Icons.play_arrow:
                                              // ind != position
                                              //   ? Icons.play_arrow
                                              //   : StaticStore.playing == true
                                              //       ? Icons.pause
                                              //       : Icons.play_arrow),
                                          ]),
                                      // :(ind==position && playing==false?Icons.play_arrow:playing==false?Icons.play_arrow:null),),
                                      // Icons.play_arrow,color: Colors.white,),
            
                                      // onPressed: (){
                                      //   if(playing==true){
                                      //     // stop song
                                      //     // setState(() {
                                      //     //   playing = false;
                                      //     // });
            
                                      //   }else{
                                      //     // play song
                                      //     setState(() {
                                      //       playing = true;
                                      //     });
                                      //   }
                                      // },
                                      // ),
                                    ),
                                  ),
                                ]),
                                // Padding(
                                //   padding: const EdgeInsets.all(20.0),
                                //   child: Text(
                                //     // position.toString(),
                                //     "Hello",
                                //     style: TextStyle(fontSize: 22.0),
                                //   ),
                                // ),
                              ),
                              // ),
            
                              // }),),
                            ]);
                          },
                        );
          }
        ),
                    
        
        
        
        // StreamBuilder(
        //   stream: FirebaseFirestore.instance.collection('users').snapshots(),
        //   builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        //     print(snapshot.data?.docs[0]['name']);
        //     print("hello");
        //     return SizedBox();
        //   },
        // )
      )
    );
  }
}