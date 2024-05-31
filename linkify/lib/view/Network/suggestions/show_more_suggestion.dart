import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:linkify/controller/store_to_firebase/firebase_call.dart';
import 'package:linkify/controller/variables/static_store.dart';
import 'package:linkify/model/user_info.dart';
import 'package:linkify/view/Network/chatting/loading_user_img.dart';
import 'package:linkify/view/home/loading.dart';

class ShowmoreSuggestion extends StatefulWidget {
  List<UserInfo>?totalUsers;
  String title="";
  ShowmoreSuggestion(this.totalUsers,this.title,{super.key});
  @override
  State<ShowmoreSuggestion> createState() => _ShowmoreSuggestionState();
}

class _ShowmoreSuggestionState extends State<ShowmoreSuggestion> {
  Friends _friends = Friends();

  @override
  Widget build(BuildContext context) {
    final devicePexelRatio = MediaQuery.of(context).devicePixelRatio;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,),onPressed: (){
          Navigator.pop(context);
        },),
        title:Text("Recommendation (${widget.title})",style:TextStyle(color:Colors.white)),

      ),
      body: ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          // physics: NeverScrollableScrollPhysics(),
                                          // itemCount: _recommendedUserInfo!.length<=2?_recommendedUserInfo.length:2,
                                          itemCount:
                                              // widget.totalUsers!=null?widget.totalUsers!.length:0,
                                              widget.totalUsers!=null?widget.totalUsers?.length:0,
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
                                                        child: 
                                                        widget.totalUsers?[i].image?.length==0?
                    
                                                          Container(
                                                            width: 55,
                                                            height: 55,
                                                            child:
                                                            const LoadingUserImage(),
                                                          )
                                                          :
                                                        CachedNetworkImage(
                                                          // imageUrl: user.avatar!,
                  
                                                          // imageUrl: "${widget._albumTracks?[position].imgUrl}",
                                                          imageUrl: widget
                                                                      .totalUsers?[i]
                                                                      .image
                                                                      ?.length !=
                                                                  0
                                                              ? "${widget.totalUsers?[i].image?[0]['url']}"
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
                                                      "${widget.totalUsers?[i].displayName}",
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    subtitle: Text(
                                                      "${widget.totalUsers?[i].spotifyBasedGenre}",
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
                  
                                                              await storeFriendRequest(widget.totalUsers?[i].id);
                  
                                                              await _friends
                                                                  .friendStatusStore(
                                                                      widget
                                                                          .totalUsers?[
                                                                              i]
                                                                          .id)
                                                                  .then((value) {
                                                                setState(() {
                                                                  StaticStore
                                                                          .requestStatusValue?[
                                                                      2]?[i] = widget
                                                                          .totalUsers![
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
    );
  }
}