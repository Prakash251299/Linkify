import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:linkify/controller/notification/notification_functions.dart';
import 'package:linkify/widgets/Network/chatting/widget/chat_screen.dart';
import 'package:linkify/controller/static_store.dart';
import 'package:linkify/model/user_info.dart';
import 'package:linkify/widgets/loading_user_img.dart';
import 'package:linkify/widgets/sticky_widgets.dart';

class NetworkUser extends StatefulWidget {
  List<dynamic>?friends;
  String title;
  NetworkUser(this.friends,this.title,{super.key});

  @override
  State<NetworkUser> createState() => _NetworkUserState();
}

class _NetworkUserState extends State<NetworkUser> {
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
          title: Text("${widget.title}",style:TextStyle(color:Colors.white)),
          backgroundColor: Colors.black,

        ),
        body: 

        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection('spotifyBasedGenreUsers').snapshots(),
              builder: (context, snapshot) {
                return 
                widget.friends?.length!=0?
                ListView.builder(
                              scrollDirection: Axis.vertical,
                              physics: AlwaysScrollableScrollPhysics(),
                              itemCount: widget.friends?.length,
                
                              itemBuilder: (context, index) {
                                return Column(children: [
                                  Card(
                                    color: Colors.black,
                                    child: Column(children: [
                
                                      InkWell(
                                        borderRadius: BorderRadius.circular(15),
                                        onTap: () async {
                                          List<String?> s = [StaticStore.currentUserId,widget.friends?[index].id];
                                          s.sort();
                                          String messageId = "${s[0]}_${s[1]}";
                                          
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ChatScreen(widget.friends![index],messageId)));
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
                                                      widget.friends?[index].image?.length==0?
                
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
                
                                                    imageUrl: widget.friends?[index].image?.length==2?"${widget.friends?[index].image?[1]['url']}":"${widget.friends?[index].image?[0]['url']}",
                
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
                                            
                                            "${widget.friends?[index].displayName}",
                                            // "${widget.friends[index]?.id}",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          subtitle: Text(
                                            "${widget.friends?[index].spotifyBasedGenre}",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(color: Colors.grey),
                                          ),
                                          isThreeLine: true,
                                          trailing: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // widget.title=="Requests"?
                                          // Row(
                                          //   mainAxisSize: MainAxisSize.min,
                                          //   children: [



                                          //   Container(
                                          //     // width: 30,
                                          //     child: IconButton(
                                          //       onPressed: () async {
                                          //         await rejectFriendRequest(widget.friends?[index].id);
                                          //         widget.friends?.remove(widget.friends?[index]);
                                          //       }, 
                                          //       icon: const Icon(Icons.delete,color: Colors.grey,)
                                          //     ),
                                          //   ),
                                          //   IconButton(
                                          //     onPressed: () async {
                                          //       await acceptFriendRequest(widget.friends?[index].id);
                                          //       widget.friends?.remove(widget.friends?[index]);

                                          //     }, 
                                          //     icon: const Icon(Icons.add,color: Colors.grey,)
                                          //   ),
                                          // ],)
                                          // :SizedBox(),

                                        ]),
                                        ),
                                      ),
                                    ]),
                                  ),
                                ]);
                              },
                            ):
                            Center(child:Text("No friends available"));
              }
            ),
            footer(context),
          ],
        ),
                    
      )
    );
  }
}