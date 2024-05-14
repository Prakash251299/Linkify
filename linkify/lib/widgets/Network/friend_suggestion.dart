// import 'package:flutter/material.dart';

// class Suggestion extends StatelessWidget {
//   const Suggestion({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return
//     SafeArea(
//       child: Scaffold(
//         body: Column(
//           // mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//           Text("Most like you"),
//           // Container(
//           //   child: ListView(
//           //       children: [
//           //         Card(child: Text("bfkjsh"),),
//           //       ],
//           //     ),
//           // ),
//           Text("Good match"),
//           Text("All"),
//         ],),
//       ),
//     );
//     // const Placeholder();
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:linkify/controller/Network/fetch_friends.dart';
import 'package:linkify/controller/first_page_categories.dart';
import 'package:linkify/controller/playlist_track.dart';
import 'package:linkify/controller/recommendations.dart';
import 'package:linkify/controller/static_store.dart';
import 'package:linkify/model/album_track.dart';
import 'package:linkify/model/user_info.dart';
import 'package:linkify/widgets/Network/user_network.dart';
import 'package:linkify/widgets/album_view.dart';
import 'package:linkify/widgets/carousel_view.dart';
import 'package:linkify/widgets/uis/utils/loading.dart';

class Suggestion extends StatefulWidget {
  // const Suggestion({super.key});

  List<UserInfo>? bestMatch;
  List<UserInfo>? goodMatch;
  List<UserInfo>? allUsers;
  Suggestion(this.bestMatch,this.goodMatch,this.allUsers);
  @override
  State<Suggestion> createState() => _SuggestionState();
}

class _SuggestionState extends State<Suggestion> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

// class Suggestion extends StatelessWidget {

  @override
  void initState() {
    // TODO: implement initState
    // widget.allUsers = fetchAllFriends(context) as List<UserInfo>?;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon:Icon(Icons.arrow_back,color: Colors.white,)
          ),
          backgroundColor: Colors.black,
        ),
        body: 
        widget.bestMatch?.length==0 && widget.goodMatch?.length==0 && widget.allUsers?.length==0?
        Center(
          child:Stack(
            alignment: Alignment.topCenter,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            friendOptions(context,widget.allUsers),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("No users available"),
              ],
            ),
          ],
        ))

        :ListView.builder(
            itemCount: 1,
            itemBuilder: (context, snapshot) {
              return Column(
                children: [
                  friendOptions(context,widget.allUsers),

                  widget.bestMatch?.length!=0?
                  suggestionOptons(context, "Most like you",widget.bestMatch):SizedBox(),
                  widget.goodMatch?.length!=0?
                  suggestionOptons(context, "Good match",widget.goodMatch):SizedBox(),
                  widget.allUsers?.length!=0?
                  suggestionOptons(context, "All users",widget.allUsers):SizedBox(),
                ],
              );
            }),
      ),
    );
  }
}

Widget suggestionOptons(context, title, List<UserInfo>? _recommendedUserInfo) {
  final devicePexelRatio = MediaQuery.of(context).devicePixelRatio;

  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Padding(
      padding: const EdgeInsets.only(left: 18, top: 18.0, bottom: 15),
      child: Text(
        "$title",
        style: TextStyle(fontSize: 22),
      ),
    ),
    Container(
      height: _recommendedUserInfo?.length==2?200:100,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          // physics: NeverScrollableScrollPhysics(),
          // itemCount: _recommendedUserInfo!.length<=2?_recommendedUserInfo.length:2,
          itemCount: _recommendedUserInfo?.length==2?2:1,
          // itemCount:null,
          itemBuilder: (context, i) {
            return Card(
              color: Colors.black,
              child: Column(children: [

                InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () async {},
                  child: ListTile(
                    leading: Column(children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(3),
                          bottomLeft: Radius.circular(3),
                        ),
                        child: CachedNetworkImage(
                          // imageUrl: user.avatar!,

                          // imageUrl: "${widget._albumTracks?[position].imgUrl}",
                          imageUrl: _recommendedUserInfo?[i].image?.length!=0?"${_recommendedUserInfo?[i].image?[0]['url']}":"",
                          // imageUrl: "",

                          width: 55,
                          height: 55,
                          memCacheHeight: (55 * devicePexelRatio).round(),
                          memCacheWidth: (55 * devicePexelRatio).round(),
                          maxHeightDiskCache: (55 * devicePexelRatio).round(),
                          maxWidthDiskCache: (55 * devicePexelRatio).round(),
                          progressIndicatorBuilder: (context, url, l) =>
                              LoadingImage(icon: Icon(Icons.man)),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ]),
                    title: Text(
                      // "${widget._albumTracks?[position].name}",
                      "${_recommendedUserInfo?[i].displayName}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text("${_recommendedUserInfo?[i].spotifyBasedGenre}",style: TextStyle(color: Colors.white70),overflow: TextOverflow.ellipsis,),
                    isThreeLine: true,
                    trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: (){
                              print("friend request sent");
                              // send friend request here
                            }, 
                            icon:Icon(Icons.send,color: const Color.fromARGB(179, 210, 172, 172),),
                          )
                        ]),
                  ),
                ),
              ]),
            );
          }),
    ),
    _recommendedUserInfo!=null?(_recommendedUserInfo.length>2?
    Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            child: Text(
              "show more",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    ):SizedBox()):SizedBox(),
  ]);
}


Widget friendOptions(context,List<UserInfo>? friends){
  return 
  GestureDetector(
    child: Container(
      height:40,
      width:MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        // color: const Color.fromARGB(255, 217, 194, 192),
        color: Colors.white,
      ),
      child:Center(child:
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left:18),
            child: Text("Go to connections",style: TextStyle(color: Colors.red,fontSize: 18),),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(right:18.0),
            child: Icon(Icons.navigate_next,color: Colors.red,),
          ),
        ],
      )),
    ),
    onTap: (){
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NetworkUser(friends)));
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>NetworkUser(friends)));
    },
  );
}