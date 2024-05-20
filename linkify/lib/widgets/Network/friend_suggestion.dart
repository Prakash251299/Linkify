import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:linkify/controller/Network/fetch_friends.dart';
import 'package:linkify/controller/Network/user_network_functions.dart';
import 'package:linkify/controller/firebase_call.dart';
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
  // List<List<String>> requestStatusValue;
  Suggestion(this.bestMatch, this.goodMatch, this.allUsers);
  @override
  State<Suggestion> createState() => _SuggestionState();
}

class _SuggestionState extends State<Suggestion> {
  // String requestStatusValue = "0";
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

  // MyWidget _myWidget = MyWidget();
  Friends _friends = Friends();

  @override
  Widget build(BuildContext context) {
    // StaticStore.requestStatusValue=[List.filled(widget.bestMatch!.length, "0"),null,List.filled(widget.allUsers!.length, "0")];
    print("Called Suggestion");
    final devicePexelRatio = MediaQuery.of(context).devicePixelRatio;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
              // title: Text("Networks",style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.black,
        ),
        body: widget.bestMatch?.length == 0 &&
                widget.goodMatch?.length == 0 &&
                widget.allUsers?.length == 0
            ? Center(
                child: Stack(
                alignment: Alignment.topCenter,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // friendOptions(context, widget.allUsers),
                  friendOptions(context),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("No users available"),
                    ],
                  ),
                ],
              ))
            : ListView.builder(
                itemCount: 1,
                itemBuilder: (context, snapshot) {
                  return Column(
                    children: [
                      // friendOptions(context, widget.allUsers),
                      friendOptions(context),

                      // for (int i = 0; i < 2; i++) ...{
                      if (widget.bestMatch?.length != 0) ...{
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 18, top: 18.0, bottom: 15),
                                child: Text(
                                  "Mostly same",
                                  style: TextStyle(fontSize: 22),
                                ),
                              ),
                              Container(
                                height:
                                    widget.bestMatch?.length == 2 ? 200 : 100,
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    // physics: NeverScrollableScrollPhysics(),
                                    // itemCount: _recommendedUserInfo!.length<=2?_recommendedUserInfo.length:2,
                                    itemCount:
                                        widget.bestMatch?.length == 2 ? 2 : 1,
                                    // itemCount:null,
                                    itemBuilder: (context, i) {
                                      return Card(
                                        color: Colors.black,
                                        child: Column(children: [
                                          InkWell(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            onTap: () async {},
                                            child: ListTile(
                                              leading: Column(children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft: Radius.circular(3),
                                                    bottomLeft:
                                                        Radius.circular(3),
                                                  ),
                                                  child: CachedNetworkImage(
                                                    // imageUrl: user.avatar!,

                                                    // imageUrl: "${widget._albumTracks?[position].imgUrl}",
                                                    imageUrl: widget
                                                                .bestMatch?[i]
                                                                .image
                                                                ?.length !=
                                                            0
                                                        ? "${widget.bestMatch?[i].image?[0]['url']}"
                                                        : "",
                                                    // imageUrl: "",

                                                    width: 55,
                                                    height: 55,
                                                    memCacheHeight:
                                                        (55 * devicePexelRatio)
                                                            .round(),
                                                    memCacheWidth:
                                                        (55 * devicePexelRatio)
                                                            .round(),
                                                    maxHeightDiskCache:
                                                        (55 * devicePexelRatio)
                                                            .round(),
                                                    maxWidthDiskCache:
                                                        (55 * devicePexelRatio)
                                                            .round(),
                                                    progressIndicatorBuilder:
                                                        (context, url, l) =>
                                                            LoadingImage(
                                                                icon: Icon(
                                                                    LineIcons
                                                                        .user)),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ]),
                                              title: Text(
                                                // "${widget._albumTracks?[position].name}",
                                                "${widget.bestMatch?[i].displayName}",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              subtitle: Text(
                                                "${widget.bestMatch?[i].spotifyBasedGenre}",
                                                style: TextStyle(
                                                    color: Colors.white70),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              isThreeLine: true,
                                              trailing: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    IconButton(
                                                      onPressed: () async {
                                                        print(
                                                            "friend request sent");
                                                        // print(
                                                        // "friend request sent");
                                                        await storeFriendRequest(widget.bestMatch?[i].id);
                                                        await _friends
                                                            .friendStatusStore(
                                                                widget
                                                                    .bestMatch?[
                                                                        i]
                                                                    .id)
                                                            .then((value) {
                                                          setState(() {
                                                            StaticStore
                                                                    .requestStatusValue?[
                                                                2]?[i] = widget
                                                                    .bestMatch![
                                                                        i]
                                                                    .id.toString();
                                                          });
                                                          print("updated");
                                                        });
                                                        // print(StaticStore.requestStatusValue?[0][i]);
                                                      },
                                                      icon: StaticStore.requestStatusValue?[
                                                                      0]?[i] ==
                                                                  "0" ||
                                                              StaticStore.requestStatusValue?[
                                                                      0]?[i] ==
                                                                  ""
                                                          ? Icon(Icons.send,
                                                              color:
                                                                  Colors.white)
                                                          : StaticStore.requestStatusValue?[
                                                                      0]?[i] ==
                                                                  "1"?Icon(
                                                              Icons
                                                                  .done_outline,
                                                              color:
                                                                  Colors.white,
                                                            ):Icon(Icons.pending,color:Colors.white),
                                                    )
                                                  ]),
                                            ),
                                          ),
                                        ]),
                                      );
                                    }),
                              ),
                              widget.bestMatch != null
                                  ? (widget.bestMatch!.length > 2
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 18.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                child: Text(
                                                  "show more",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      : SizedBox())
                                  : SizedBox(),
                            ])
                      },

                      if (widget.allUsers?.length != 0) ...{
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 18, top: 18.0, bottom: 15),
                                child: Text(
                                  "All users",
                                  style: TextStyle(fontSize: 22),
                                ),
                              ),
                              Container(
                                height:
                                    widget.allUsers?.length == 2 ? 200 : 100,
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    // physics: NeverScrollableScrollPhysics(),
                                    // itemCount: _recommendedUserInfo!.length<=2?_recommendedUserInfo.length:2,
                                    itemCount:
                                        widget.allUsers?.length == 2 ? 2 : 1,
                                    // itemCount:null,
                                    itemBuilder: (context, i) {
                                      return Card(
                                        color: Colors.black,
                                        child: Column(children: [
                                          InkWell(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            onTap: () async {},
                                            child: ListTile(
                                              leading: Column(children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft: Radius.circular(3),
                                                    bottomLeft:
                                                        Radius.circular(3),
                                                  ),
                                                  child: CachedNetworkImage(
                                                    // imageUrl: user.avatar!,

                                                    // imageUrl: "${widget._albumTracks?[position].imgUrl}",
                                                    imageUrl: widget
                                                                .allUsers?[i]
                                                                .image
                                                                ?.length !=
                                                            0
                                                        ? "${widget.allUsers?[i].image?[0]['url']}"
                                                        : "",
                                                    // imageUrl: "",

                                                    width: 55,
                                                    height: 55,
                                                    memCacheHeight:
                                                        (55 * devicePexelRatio)
                                                            .round(),
                                                    memCacheWidth:
                                                        (55 * devicePexelRatio)
                                                            .round(),
                                                    maxHeightDiskCache:
                                                        (55 * devicePexelRatio)
                                                            .round(),
                                                    maxWidthDiskCache:
                                                        (55 * devicePexelRatio)
                                                            .round(),
                                                    progressIndicatorBuilder:
                                                        (context, url, l) =>
                                                            LoadingImage(
                                                                icon: Icon(
                                                                    LineIcons
                                                                        .user)),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ]),
                                              title: Text(
                                                // "${widget._albumTracks?[position].name}",
                                                "${widget.allUsers?[i].displayName}",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              subtitle: Text(
                                                "${widget.allUsers?[i].spotifyBasedGenre}",
                                                style: TextStyle(
                                                    color: Colors.white70),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              isThreeLine: true,
                                              trailing: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    IconButton(
                                                      onPressed: () async {
                                                        print(
                                                            "friend request sent");

                                                        await storeFriendRequest(widget.allUsers?[i].id);

                                                        await _friends
                                                            .friendStatusStore(
                                                                widget
                                                                    .allUsers?[
                                                                        i]
                                                                    .id)
                                                            .then((value) {
                                                          setState(() {
                                                            StaticStore
                                                                    .requestStatusValue?[
                                                                2]?[i] = widget
                                                                    .allUsers![
                                                                        i]
                                                                    .id.toString();
                                                          });
                                                          print("updated");
                                                        });
                                                        print(StaticStore
                                                                .requestStatusValue?[
                                                            2]?[i]);
                                                      },
                                                      icon:
                                                          StaticStore.requestStatusValue?[
                                                                      2]?[i] ==
                                                                  "0" || StaticStore.requestStatusValue?[
                                                                      2]?[i] ==
                                                                  ""
                                                              ? Icon(Icons.send,
                                                                  color: Colors
                                                                      .white)
                                                              : StaticStore.requestStatusValue?[
                                                                      2]?[i] ==
                                                                  "1"?Icon(
                                                              Icons
                                                                  .done_outline,
                                                              color:
                                                                  Colors.white,
                                                            ):Icon(Icons.pending,color:Colors.white),
                                                              
                                                    )
                                                  ]),
                                            ),
                                          ),
                                        ]),
                                      );
                                    }),
                              ),
                              widget.allUsers != null
                                  ? (widget.allUsers!.length > 2
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 18.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                child: Text(
                                                  "show more",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      : SizedBox())
                                  : SizedBox(),
                            ])
                      }

                      // }
                    ],
                  );
                }),
      ),
    );
  }
}


/* For Connected people */
Widget friendOptions(context) {
  return GestureDetector(
    child: Container(
      height: 40,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        // color: const Color.fromARGB(255, 217, 194, 192),
        color: Colors.white,
      ),
      child: Center(
          child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18),
            child: Text(
              "Go to connections",
              style: TextStyle(color: Colors.red, fontSize: 18),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Icon(
              Icons.navigate_next,
              color: Colors.red,
            ),
          ),
        ],
      )),
    ),
    onTap: () async {
      NetworkFunction _networkFunction = NetworkFunction();
      List<dynamic> friendIds = await fetchFriends();
      List<UserInfo> friends = [];
      UserInfo temp;
      for(int i=0;i<friendIds.length;i++){
        temp = await _networkFunction.fetchUserInfo(friendIds[i]);
        friends.add(temp);
      }
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => NetworkUser(friends,"Friends")));
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>NetworkUser(friends)));
    },
  );
}
