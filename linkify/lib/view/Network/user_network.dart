import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:linkify/controller/store_to_firebase/firebase_call.dart';
import 'package:linkify/controller/notification/notification_functions.dart';
import 'package:linkify/view/Network/chatting/widget/chat_screen.dart';
import 'package:linkify/controller/variables/static_store.dart';
import 'package:linkify/model/user_info.dart';
import 'package:linkify/view/Network/chatting/loading_user_img.dart';
import 'package:linkify/view/sticky/sticky_widgets.dart';

class NetworkUser extends StatefulWidget {
  
  String title;
  NetworkUser(this.title,{super.key});

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
    List<dynamic>?friends;
    return 
    StreamBuilder<List<dynamic>>(
      stream: fetchFriends().asStream(),
      builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
          return 
          Center(child:CircularProgressIndicator());
        }
        // print(friends?[0].displayName);
        if(snapshot.hasData){
        friends = snapshot.data;

        //   print("hasdata");
        //   print(snapshot.data?.length);
        //   return SizedBox();
        }
        //   print("no data");
        // return SizedBox();
        return SafeArea(child: 
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
                    friends?.length!=0?
                    ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  itemCount: friends?.length,
                    
                                  itemBuilder: (context, index) {
                                    return Column(children: [
                                      Card(
                                        color: Colors.black,
                                        child: Column(children: [
                    
                                          InkWell(
                                            borderRadius: BorderRadius.circular(15),
                                            onTap: () async {
                                              List<String?> s = [StaticStore.currentUserId,friends?[index].id];
                                              s.sort();
                                              String messageId = "${s[0]}_${s[1]}";
                                              
                                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ChatScreen(friends![index],messageId)));
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
                                                          friends?[index].image?.length==0?
                    
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
                    
                                                        imageUrl: friends?[index].image?.length==2?"${friends?[index].image?[1]['url']}":"${friends?[index].image?[0]['url']}",
                    
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
                                                
                                                "${friends?[index].displayName}",
                                                // "${friends[index]?.id}",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(color: Colors.white),
                                              ),
                                              subtitle: Text(
                                                "${friends?[index].spotifyBasedGenre}",
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
                                              //         await rejectFriendRequest(friends?[index].id);
                                              //         friends?.remove(friends?[index]);
                                              //       }, 
                                              //       icon: const Icon(Icons.delete,color: Colors.grey,)
                                              //     ),
                                              //   ),
                                              //   IconButton(
                                              //     onPressed: () async {
                                              //       await acceptFriendRequest(friends?[index].id);
                                              //       friends?.remove(friends?[index]);
        
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
    );
  }
}