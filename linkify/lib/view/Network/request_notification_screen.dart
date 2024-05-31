import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:linkify/controller/Network/fetch_friends.dart';
import 'package:linkify/controller/notification/notification_functions.dart';
import 'package:linkify/view/Network/chatting/widget/chat_screen.dart';
import 'package:linkify/controller/variables/static_store.dart';
import 'package:linkify/model/user_info.dart';
import 'package:linkify/view/Network/chatting/loading_user_img.dart';
import 'package:linkify/view/sticky/sticky_widgets.dart';

class RequestNotificationScreen extends StatefulWidget {
  // List<UserInfo>?friendRequests;
  // String title;
  RequestNotificationScreen({super.key});

  @override
  State<RequestNotificationScreen> createState() => RequestNotificationScreenState();
}

class RequestNotificationScreenState extends State<RequestNotificationScreen> {


  final streamController = StreamController(
    onPause: () => print('Paused'),
    onResume: () => print('Resumed'),
    onCancel: () => print('Cancelled'),
    onListen: () => print('Listens'),
  );


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final devicePexelRatio = MediaQuery.of(context).devicePixelRatio;
    return 
    SafeArea(child: 
      Scaffold(
        backgroundColor: Colors.black,
        appBar: 
        AppBar(
          leading: IconButton(icon:Icon(Icons.arrow_back),color: Colors.white,onPressed: (){
            Navigator.pop(context);
          },),
          title: Text("Friends requests",style:TextStyle(color:Colors.white)),
          backgroundColor: Colors.black,

        ),
        body: 

        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            StreamBuilder(
              stream: FetchRequestNotifications().asStream(),
              // stream: FirebaseFirestore.instance.collection('friendRequest').doc('${StaticStore.currentUserId}').snapshots(),
              builder: (context, snapshot) {
                if(snapshot.connectionState==ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator(),);
                }
                // print(snapshot.data?.first.displayName);
                List<UserInfo>?friendRequests = snapshot.data;
                // print("fetching request data from snapshot");
                // // print(snapshot.data?.doc('sad').get());
                // List<dynamic>? friendRequests = snapshot.data?.data()?['users'];
                // List<UserInfo>? _userInfo;
                // // _userInfo = 
                // // (friendRequests.length!=0?
                // FetchRequestNotifications(friendRequests).then((value) {
                //   _userInfo = value;
                //   print("userInfo fetching from request_notification_screen");
                //   // print("userInfo fetching from request_notification_screen");
                // });
                // print("$_userInfo");
                return 
                // SizedBox();
                // return 
                friendRequests!= null && friendRequests.length!=0?
                ListView.builder(
                              scrollDirection: Axis.vertical,
                              physics: AlwaysScrollableScrollPhysics(),
                              itemCount: friendRequests.length,
                
                              itemBuilder: (context, index) {
                                return Column(children: [
                                  Card(
                                    color: Colors.black,
                                    child: Column(children: [
                
                                      InkWell(
                                        borderRadius: BorderRadius.circular(15),
                                        onTap: () async {
                                          List<String?> s = [StaticStore.currentUserId,friendRequests[index].id];
                                          s.sort();
                                          String messageId = "${s[0]}_${s[1]}";
                                          
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ChatScreen(friendRequests[index],messageId)));
                                        },
                                        child: ListTile(
                                          leading: Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(3),
                                                    bottomLeft: Radius.circular(3),
                                                  ),
                                                  child:
                                                  // StaticStore.currentSongImg==""?
                                                      // CachedNetworkImage(imageUrl: ""),
                                                      friendRequests[index].image?.length==0?
                
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
                
                                                    imageUrl: friendRequests[index].image?.length==2?"${friendRequests[index].image?[1]['url']}":"${friendRequests[index].image?[0]['url']}",
                
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
                                          title: Text(
                                            
                                            "${friendRequests[index].displayName}",
                                            // "${friendRequests[index]?.id}",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          subtitle: Text(
                                            "${friendRequests[index].spotifyBasedGenre}",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(color: Colors.grey),
                                          ),
                                          isThreeLine: true,
                                          trailing: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // widget.title=="Requests"?
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [



                                            Container(
                                              // width: 30,
                                              child: 
                                              // StreamBuilder(
                                              //   stream: FetchRequestNotifications().asStream(),
                                              //   builder: (context, snapshot) {
                                              //     return 
                                                  IconButton(
                                                    onPressed: () async {


                                                      // streamController.stream.listen(
                                                      //   (event) => print('Event: $event'),
                                                      //   onDone: () => print('Done'),
                                                      //   onError: (error) => print(error),
                                                      // );






                                                      await rejectFriendRequest(friendRequests[index].id);
                                                      StaticStore.notificationCounts--;
                                                      setState(() {});


                                                      
                                                      // friendRequests.remove(friendRequests[index]);
                                                    }, 
                                                    icon: const Icon(Icons.delete,color: Colors.grey,)
                                                  )
                                                // }
                                              // ),
                                            ),
                                            IconButton(
                                              onPressed: () async {
                                                await acceptFriendRequest(friendRequests[index].id);
                                                StaticStore.notificationCounts--;
                                                // friendRequests.remove(friendRequests[index]);
                                                setState(() {});

                                              }, 
                                              icon: const Icon(Icons.add,color: Colors.grey,)
                                            ),
                                          ],),
                                          // :SizedBox(),

                                        ]),
                                        ),
                                      ),
                                    ]),
                                  ),
                                ]);
                              },
                            ):
                            Center(child: Text("No Requests"),);
              }
            ),
            footer(context),
          ],
        ),
                    
      )
    );
  }
}