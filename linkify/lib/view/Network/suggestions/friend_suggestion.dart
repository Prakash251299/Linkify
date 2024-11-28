import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:linkify/controller/Network/fetch_friends.dart';
import 'package:linkify/controller/Network/user_network_functions.dart';
import 'package:linkify/controller/store_to_firebase/firebase_call.dart';
import 'package:linkify/model/home/first_page_categories.dart';
import 'package:linkify/controller/playlist/playlist_track.dart';
import 'package:linkify/controller/home/front_page_data/recommendations.dart';
import 'package:linkify/controller/variables/static_store.dart';
import 'package:linkify/model/album_track.dart';
import 'package:linkify/model/user_info.dart';
import 'package:linkify/view/Network/suggestions/cubit/suggestion_cubit.dart';
import 'package:linkify/view/Network/suggestions/show_more_suggestion.dart';
import 'package:linkify/view/Network/user_network.dart';
import 'package:linkify/view/album/album_view.dart';
import 'package:linkify/view/Network/chatting/loading_user_img.dart';
import 'package:linkify/view/home/loading.dart';
import 'package:linkify/view/sticky/sticky_widgets.dart';
import 'package:linkify/controller/variables/loading_enum.dart';

class Suggestion extends StatefulWidget {
  // const Suggestion({super.key});

  // List<UserInfo>? bestMatch;
  // List<UserInfo>? goodMatch;
  // List<UserInfo>? allUsers;
  // List<List<UserInfo>?> recommendedUsers;
  // Suggestion(this.bestMatch, this.goodMatch, this.allUsers);
  Suggestion();
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
    StaticStore.screen = 2;
    // TODO: implement initState
    // state.recommendedUsers[2] = fetchAllFriends(context) as List<UserInfo>?;
    super.initState();
  }

  // MyWidget _myWidget = MyWidget();
  Friends _friends = Friends();

  @override
  Widget build(BuildContext context) {
    // StaticStore.requestStatusValue=[List.filled(state.recommendedUsers[0]!.length, "0"),null,List.filled(state.recommendedUsers[2]!.length, "0")];
    print("Called Suggestion");
    final devicePexelRatio = MediaQuery.of(context).devicePixelRatio;
    return
        // SizedBox();

        BlocProvider(
            create: (context) => SuggestionCubit()..getRecommendedUsers(),
            // create:(_){},
            child: BlocBuilder<SuggestionCubit, SuggestionState>(
                // child: BlocBuilder(
                builder: (context, state) {
              // print("recommendedUsers:");
              if (state.status == LoadPage.loading) {
                return Center(child: CircularProgressIndicator());
              }
              // print(state.recommendedUsers.length);

              // return
              // SizedBox();
              // }));

              // StaticStore.usersLoaded==1?SizedBox():CircularProgressIndicator();

              // StreamBuilder(
              //     stream: userButtonCaller().asStream(),
              //     builder: (context, snapshot) {
              //       if (snapshot.connectionState == ConnectionState.waiting) {
              //         return Center(child: CircularProgressIndicator());
              //       }
              // print(state.recommendedUsers[2]?[2].displayName);
              // return SizedBox();
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
                  body:
                      state.recommendedUsers[0]?.length == 0 &&
                              state.recommendedUsers[1]?.length == 0 &&
                              state.recommendedUsers[2]?.length == 0
                          ? Center(
                              child: Stack(
                              alignment: Alignment.topCenter,
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // friendOptions(context, state.recommendedUsers[2]),
                                friendOptions(context),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("No users available"),
                                  ],
                                ),
                                // footer(context),
                              ],
                            ))
                          : Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                // friendOptions(context),
                                // Container(
                                //   color: Colors.red,
                                //   child: footer(context)
                                // ),
                                ListView.builder(
                                    itemCount: 1,
                                    itemBuilder: (context1, snapshot1) {
                                      return Stack(
                                        alignment: Alignment.topCenter,
                                        children: [
                                          // friendOptions(context, state.recommendedUsers[2]),

                                          // friendOptions(context),

                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 40),
                                            child: Column(children: [
                                              // for (int i = 0; i < 2; i++) ...{
                                              if (state.recommendedUsers[0]
                                                      ?.length !=
                                                  0) ...{
                                                Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 18,
                                                                top: 18.0,
                                                                bottom: 15),
                                                        child: Text(
                                                          "Mostly same",
                                                          style: TextStyle(
                                                              fontSize: 22),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: state.recommendedUsers[
                                                                        0] !=
                                                                    null &&
                                                                state.recommendedUsers[0]!
                                                                        .length >=
                                                                    2
                                                            ? 200
                                                            : 100,
                                                        child: ListView.builder(
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            physics:
                                                                NeverScrollableScrollPhysics(),
                                                            // itemCount: _recommendedUserInfo!.length<=2?_recommendedUserInfo.length:2,
                                                            itemCount: state.recommendedUsers[
                                                                            0] !=
                                                                        null &&
                                                                    state
                                                                            .recommendedUsers[
                                                                                0]!
                                                                            .length >=
                                                                        2
                                                                ? 2
                                                                : 1,
                                                            // itemCount:null,
                                                            itemBuilder:
                                                                (context, i) {
                                                              return Card(
                                                                color: Colors
                                                                    .black,
                                                                child: Column(
                                                                    children: [
                                                                      InkWell(
                                                                        borderRadius:
                                                                            BorderRadius.circular(15),
                                                                        onTap:
                                                                            () async {},
                                                                        child:
                                                                            ListTile(
                                                                          leading:
                                                                              Column(children: [
                                                                            ClipRRect(
                                                                              borderRadius: BorderRadius.only(
                                                                                topLeft: Radius.circular(3),
                                                                                bottomLeft: Radius.circular(3),
                                                                              ),
                                                                              child: state.recommendedUsers[0]?[i].image?.length == 0
                                                                                  ? Container(
                                                                                      width: 55,
                                                                                      height: 55,
                                                                                      child: const LoadingUserImage(),
                                                                                    )
                                                                                  : CachedNetworkImage(
                                                                                      // imageUrl: user.avatar!,

                                                                                      // imageUrl: "${widget._albumTracks?[position].imgUrl}",
                                                                                      imageUrl: state.recommendedUsers[0]?[i].image?.length != 0 ? "${state.recommendedUsers[0]?[i].image?[0]['url']}" : "",
                                                                                      // imageUrl: "",

                                                                                      width: 55,
                                                                                      height: 55,
                                                                                      memCacheHeight: (55 * devicePexelRatio).round(),
                                                                                      memCacheWidth: (55 * devicePexelRatio).round(),
                                                                                      maxHeightDiskCache: (55 * devicePexelRatio).round(),
                                                                                      maxWidthDiskCache: (55 * devicePexelRatio).round(),
                                                                                      progressIndicatorBuilder: (context, url, l) => LoadingImage(icon: Icon(LineIcons.user)),
                                                                                      fit: BoxFit.cover,
                                                                                    ),
                                                                            ),
                                                                          ]),
                                                                          title:
                                                                              Text(
                                                                            // "${widget._albumTracks?[position].name}",
                                                                            "${state.recommendedUsers[0]?[i].displayName}",
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style:
                                                                                TextStyle(color: Colors.white),
                                                                          ),
                                                                          subtitle:
                                                                              Text(
                                                                            "${state.recommendedUsers[0]?[i].spotifyBasedGenre}",
                                                                            style:
                                                                                TextStyle(color: Colors.white70),
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                          ),
                                                                          isThreeLine:
                                                                              true,
                                                                          trailing: Column(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                IconButton(
                                                                                  onPressed: () async {
                                                                                    print("friend request sent");
                                                                                    // print(
                                                                                    // "friend request sent");
                                                                                    await storeFriendRequest(state.recommendedUsers[0]?[i].id);
                                                                                    await _friends.friendStatusStore(state.recommendedUsers[0]?[i].id).then((value) {
                                                                                      setState(() {
                                                                                        state.recommendedUsers[0] != null ? StaticStore.requestStatusValue?[0]?[i] = state.recommendedUsers[0]![i].id.toString() : null;
                                                                                        // widget
                                                                                        //     .bestMatch![i]
                                                                                        //     .id
                                                                                        //     .toString();
                                                                                        // StaticStore.requestStatusValue?[
                                                                                        //             2]
                                                                                        //         ?[i] =
                                                                                        //     widget
                                                                                        //         .bestMatch![i]
                                                                                        //         .id
                                                                                        //         .toString();
                                                                                      });
                                                                                      print("updated");
                                                                                    });
                                                                                    // print(StaticStore.requestStatusValue?[0][i]);
                                                                                  },
                                                                                  icon: StaticStore.requestStatusValue?[0]?[i] == "0" || StaticStore.requestStatusValue?[0]?[i] == ""
                                                                                      ? Icon(Icons.send, color: Colors.white)
                                                                                      : StaticStore.requestStatusValue?[0]?[i] == "1"
                                                                                          ? Icon(
                                                                                              Icons.done_outline,
                                                                                              color: Colors.white,
                                                                                            )
                                                                                          : Icon(Icons.watch_later_outlined, color: Colors.white),
                                                                                )
                                                                              ]),
                                                                        ),
                                                                      ),
                                                                    ]),
                                                              );
                                                            }),
                                                      ),
                                                      state.recommendedUsers[
                                                                  0] !=
                                                              null
                                                          ? (state.recommendedUsers[0]!
                                                                      .length >
                                                                  2
                                                              ? Padding(
                                                                  padding: const EdgeInsets
                                                                      .only(
                                                                      bottom:
                                                                          18.0),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      InkWell(
                                                                        child:
                                                                            Text(
                                                                          "show more",
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                        ),
                                                                        onTap:
                                                                            () async {
                                                                          print(
                                                                              "show more tapped");
                                                                          List<UserInfo>?
                                                                              bestUsers =
                                                                              await fetchBestMatchFriends(-1);
                                                                          await getRequestStatus(
                                                                              bestUsers,
                                                                              0);
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(builder: (context1) => ShowmoreSuggestion(bestUsers, "Mostly same")));
                                                                        },
                                                                      )
                                                                    ],
                                                                  ),
                                                                )
                                                              : SizedBox())
                                                          : SizedBox(),
                                                    ])
                                              },

                                              if (state.recommendedUsers[1]
                                                      ?.length !=
                                                  0) ...{
                                                Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 18,
                                                                top: 18.0,
                                                                bottom: 15),
                                                        child: Text(
                                                          "Good match",
                                                          style: TextStyle(
                                                              fontSize: 22),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: state.recommendedUsers[
                                                                        1] !=
                                                                    null &&
                                                                state.recommendedUsers[1]!
                                                                        .length >=
                                                                    2
                                                            ? 200
                                                            : 100,
                                                        child: ListView.builder(
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            physics:
                                                                NeverScrollableScrollPhysics(),
                                                            // itemCount: _recommendedUserInfo!.length<=2?_recommendedUserInfo.length:2,
                                                            itemCount: state.recommendedUsers[
                                                                            1] !=
                                                                        null &&
                                                                    state
                                                                            .recommendedUsers[
                                                                                1]!
                                                                            .length >=
                                                                        2
                                                                ? 2
                                                                : 1,
                                                            // itemCount:null,
                                                            itemBuilder:
                                                                (context, i) {
                                                              return Card(
                                                                color: Colors
                                                                    .black,
                                                                child: Column(
                                                                    children: [
                                                                      InkWell(
                                                                        borderRadius:
                                                                            BorderRadius.circular(15),
                                                                        onTap:
                                                                            () async {},
                                                                        child:
                                                                            ListTile(
                                                                          leading:
                                                                              Column(children: [
                                                                            ClipRRect(
                                                                              borderRadius: BorderRadius.only(
                                                                                topLeft: Radius.circular(3),
                                                                                bottomLeft: Radius.circular(3),
                                                                              ),
                                                                              child: state.recommendedUsers[1]?[i].image?.length == 0
                                                                                  ? Container(
                                                                                      width: 55,
                                                                                      height: 55,
                                                                                      child: const LoadingUserImage(),
                                                                                    )
                                                                                  : CachedNetworkImage(
                                                                                      // imageUrl: user.avatar!,

                                                                                      // imageUrl: "${widget._albumTracks?[position].imgUrl}",
                                                                                      imageUrl: state.recommendedUsers[1]?[i].image?.length != 0 ? "${state.recommendedUsers[1]?[i].image?[0]['url']}" : "",
                                                                                      // imageUrl: "",

                                                                                      width: 55,
                                                                                      height: 55,
                                                                                      memCacheHeight: (55 * devicePexelRatio).round(),
                                                                                      memCacheWidth: (55 * devicePexelRatio).round(),
                                                                                      maxHeightDiskCache: (55 * devicePexelRatio).round(),
                                                                                      maxWidthDiskCache: (55 * devicePexelRatio).round(),
                                                                                      progressIndicatorBuilder: (context, url, l) => LoadingImage(icon: Icon(LineIcons.user)),
                                                                                      fit: BoxFit.cover,
                                                                                    ),
                                                                            ),
                                                                          ]),
                                                                          title:
                                                                              Text(
                                                                            // "${widget._albumTracks?[position].name}",
                                                                            "${state.recommendedUsers[1]?[i].displayName}",
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style:
                                                                                TextStyle(color: Colors.white),
                                                                          ),
                                                                          subtitle:
                                                                              Text(
                                                                            "${state.recommendedUsers[1]?[i].spotifyBasedGenre}",
                                                                            style:
                                                                                TextStyle(color: Colors.white70),
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                          ),
                                                                          isThreeLine:
                                                                              true,
                                                                          trailing: Column(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                IconButton(
                                                                                  onPressed: () async {
                                                                                    print("friend request sent");
                                                                                    // print(
                                                                                    // "friend request sent");
                                                                                    await storeFriendRequest(state.recommendedUsers[1]?[i].id);
                                                                                    await _friends.friendStatusStore(state.recommendedUsers[1]?[i].id).then((value) {
                                                                                      setState(() {
                                                                                        state.recommendedUsers[1] != null ? StaticStore.requestStatusValue?[1]?[i] = state.recommendedUsers[1]![i].id.toString() : null;
                                                                                      });
                                                                                      print("updated");
                                                                                    });
                                                                                    // print(StaticStore.requestStatusValue?[0][i]);
                                                                                  },
                                                                                  icon: StaticStore.requestStatusValue?[1]?[i] == "0" || StaticStore.requestStatusValue?[1]?[i] == ""
                                                                                      ? Icon(Icons.send, color: Colors.white)
                                                                                      : StaticStore.requestStatusValue?[1]?[i] == "1"
                                                                                          ? Icon(
                                                                                              Icons.done_outline,
                                                                                              color: Colors.white,
                                                                                            )
                                                                                          : Icon(Icons.watch_later_outlined, color: Colors.white),
                                                                                )
                                                                              ]),
                                                                        ),
                                                                      ),
                                                                    ]),
                                                              );
                                                            }),
                                                      ),
                                                      state.recommendedUsers[
                                                                  1] !=
                                                              null
                                                          ? (state.recommendedUsers[1]!
                                                                      .length >
                                                                  2
                                                              ? Padding(
                                                                  padding: const EdgeInsets
                                                                      .only(
                                                                      bottom:
                                                                          18.0),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      InkWell(
                                                                        child:
                                                                            Text(
                                                                          "show more",
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                        ),
                                                                        onTap:
                                                                            () async {
                                                                          print(
                                                                              "show more tapped");
                                                                          // List<UserInfo>?
                                                                          // totalUsers =
                                                                          //     await fetchAllFriends(
                                                                          //         -1);
                                                                          // await getRequestStatus(
                                                                          //     state.recommendedUsers[1], 1);
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(builder: (context1) => ShowmoreSuggestion(state.recommendedUsers[1], "Good match")));
                                                                        },
                                                                      )
                                                                    ],
                                                                  ),
                                                                )
                                                              : SizedBox())
                                                          : SizedBox(),
                                                    ])
                                              },

                                              if (state.recommendedUsers[2]
                                                      ?.length !=
                                                  0) ...{
                                                Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 18,
                                                                top: 18.0,
                                                                bottom: 15),
                                                        child: Text(
                                                          "All users",
                                                          style: TextStyle(
                                                              fontSize: 22),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: state.recommendedUsers[
                                                                        2] !=
                                                                    null &&
                                                                state.recommendedUsers[2]!
                                                                        .length >=
                                                                    2
                                                            ? 200
                                                            : 100,
                                                        child: ListView.builder(
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            physics:
                                                                NeverScrollableScrollPhysics(),
                                                            // itemCount: _recommendedUserInfo!.length<=2?_recommendedUserInfo.length:2,
                                                            itemCount:
                                                                // state.recommendedUsers[2]!=null?state.recommendedUsers[2]!.length:0,

                                                                state.recommendedUsers[2] !=
                                                                            null &&
                                                                        state.recommendedUsers[2]!.length >=
                                                                            2
                                                                    ? 2
                                                                    : 1,
                                                            // itemCount:null,
                                                            itemBuilder:
                                                                (context, i) {
                                                              return Card(
                                                                color: Colors
                                                                    .black,
                                                                child: Column(
                                                                    children: [
                                                                      InkWell(
                                                                        borderRadius:
                                                                            BorderRadius.circular(15),
                                                                        onTap:
                                                                            () async {},
                                                                        child:
                                                                            ListTile(
                                                                          leading:
                                                                              Column(children: [
                                                                            ClipRRect(
                                                                              borderRadius: BorderRadius.only(
                                                                                topLeft: Radius.circular(3),
                                                                                bottomLeft: Radius.circular(3),
                                                                              ),
                                                                              child: state.recommendedUsers[2]?[i].image?.length == 0
                                                                                  ? Container(
                                                                                      width: 55,
                                                                                      height: 55,
                                                                                      child: const LoadingUserImage(),
                                                                                    )
                                                                                  : CachedNetworkImage(
                                                                                      // imageUrl: user.avatar!,

                                                                                      // imageUrl: "${widget._albumTracks?[position].imgUrl}",
                                                                                      imageUrl: state.recommendedUsers[2]?[i].image?.length != 0 ? "${state.recommendedUsers[2]?[i].image?[0]['url']}" : "",
                                                                                      // imageUrl: "",

                                                                                      width: 55,
                                                                                      height: 55,
                                                                                      memCacheHeight: (55 * devicePexelRatio).round(),
                                                                                      memCacheWidth: (55 * devicePexelRatio).round(),
                                                                                      maxHeightDiskCache: (55 * devicePexelRatio).round(),
                                                                                      maxWidthDiskCache: (55 * devicePexelRatio).round(),
                                                                                      progressIndicatorBuilder: (context, url, l) => LoadingImage(icon: Icon(LineIcons.user)),
                                                                                      fit: BoxFit.cover,
                                                                                    ),
                                                                            ),
                                                                          ]),
                                                                          title:
                                                                              Text(
                                                                            // "${widget._albumTracks?[position].name}",
                                                                            "${state.recommendedUsers[2]?[i].displayName}",
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style:
                                                                                TextStyle(color: Colors.white),
                                                                          ),
                                                                          subtitle:
                                                                              Text(
                                                                            "${state.recommendedUsers[2]?[i].spotifyBasedGenre}",
                                                                            style:
                                                                                TextStyle(color: Colors.white70),
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                          ),
                                                                          isThreeLine:
                                                                              true,
                                                                          trailing: Column(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                IconButton(
                                                                                  onPressed: () async {
                                                                                    print("friend request sent");

                                                                                    await storeFriendRequest(state.recommendedUsers[2]?[i].id);

                                                                                    await _friends.friendStatusStore(state.recommendedUsers[2]?[i].id).then((value) {
                                                                                      setState(() {
                                                                                        state.recommendedUsers[2] != null ? StaticStore.requestStatusValue?[2]?[i] = state.recommendedUsers[2]![i].id.toString() : null;
                                                                                      });
                                                                                      print("updated");
                                                                                    });
                                                                                    print(StaticStore.requestStatusValue?[2]?[i]);
                                                                                  },
                                                                                  icon: StaticStore.requestStatusValue?[2]?[i] == "0" || StaticStore.requestStatusValue?[2]?[i] == ""
                                                                                      ? Icon(Icons.send, color: Colors.white)
                                                                                      : StaticStore.requestStatusValue?[2]?[i] == "1"
                                                                                          ? Icon(
                                                                                              Icons.done_outline,
                                                                                              color: Colors.white,
                                                                                            )
                                                                                          : Icon(Icons.watch_later_outlined, color: Colors.white),
                                                                                )
                                                                              ]),
                                                                        ),
                                                                      ),
                                                                    ]),
                                                              );
                                                            }),
                                                      ),
                                                      state.recommendedUsers[
                                                                  2] !=
                                                              null
                                                          ? (state.recommendedUsers[2]!
                                                                      .length >
                                                                  2
                                                              ? Padding(
                                                                  padding: const EdgeInsets
                                                                      .only(
                                                                      bottom:
                                                                          18.0),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      InkWell(
                                                                        child:
                                                                            Text(
                                                                          "show more",
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                        ),
                                                                        onTap:
                                                                            () async {
                                                                          print(
                                                                              "allusers show more tapped");
                                                                          List<UserInfo>?
                                                                              totalUsers =
                                                                              await fetchAllFriends(-1);
                                                                          await getRequestStatus(
                                                                              totalUsers,
                                                                              2);
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(builder: (context1) => ShowmoreSuggestion(totalUsers, "Allusers")));
                                                                        },
                                                                      )
                                                                    ],
                                                                  ),
                                                                )
                                                              : SizedBox())
                                                          : SizedBox(),
                                                    ])
                                              }
                                            ]),
                                          ),

                                          // }
                                        ],
                                      );
                                    }
                                    //       );
                                    //   // }
                                    // }
                                    ),
                                Container(
                                  margin: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(context).size.height -
                                              120),
                                  // color: Colors.red,
                                  child: friendOptions(context),
                                ),
                                StreamBuilder(
                                    stream:
                                        StaticStore.player.playerStateStream,
                                    builder: (context, snapshot1) {
                                      return StaticStore.playing == true ||
                                              StaticStore.pause == true
                                          ?
                                          // Text("hi")
                                          miniplayer(context)
                                          : const SizedBox();
                                    }),
                                footer(context),
                              ],
                            ),
                ),
              );
            }));
    // }));
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
          Container(
            margin: const EdgeInsets.only(right: 18.0),
            child: Row(
              children: [
                Icon(
                  Icons.navigate_next,
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ],
      )),
    ),
    onTap: () async {
      // NetworkFunction _networkFunction = NetworkFunction();
      // List<dynamic> friendIds = await fetchFriends();
      // List<UserInfo> friends = [];
      // UserInfo temp;
      // for (int i = 0; i < friendIds.length; i++) {
      //   temp = await _networkFunction.fetchUserInfo(friendIds[i]);
      //   friends.add(temp);
      // }
      // print("friends option tapped");
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => NetworkUser("Friends")));
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>NetworkUser(friends)));
    },
  );
}
