import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:linkify/controller/Network/user_network_functions.dart';
import 'package:linkify/controller/store_to_firebase/user_info/get_user_info.dart';
import 'package:linkify/controller/variables/static_store.dart';
import 'package:linkify/model/user_info.dart';

class FirebaseCall{
  // Future<void> readData()async{
  //   /* Read data */
  //   var document = FirebaseFirestore.instance.collection('users');

  //   await document.get().then((v){
  //     print(v.docs[0]['name']);
  //   });
  // }

  List<dynamic> getTopThreeGenres(var topGenre){
    List<dynamic> topThreeGenre = [];
    if(topGenre.length>2){
      topThreeGenre.add(topGenre[0]);
      topThreeGenre.add(topGenre[1]);
      topThreeGenre.add(topGenre[2]);
    }
    if(topGenre.length==2){
      topThreeGenre.add(topGenre[0]);
      topThreeGenre.add(topGenre[1]);
    }
    if(topGenre.length==1){
      topThreeGenre.add(topGenre[0]);
    }
    topThreeGenre.sort();
    return topThreeGenre;
  }

  /* Write data */
  Future<void> writeUserData(UserInfo _userInfo,var topGenre)async{
    var db = FirebaseFirestore.instance;
    List<dynamic> topThreeGenres = getTopThreeGenres(topGenre);
    await db
    .collection("users")
    .doc(StaticStore.currentUserId)
    .set({
      "name":_userInfo.displayName,
      "id":_userInfo.id,
      "email":_userInfo.email,
      "country":_userInfo.country,
      "images":_userInfo.image,
      "spotifyGenre":topThreeGenres,
    })
    .onError((e, _) => print("Error writing user info in firebase: $e"));
    return;
  }

  Future<void> writeSpotifyGenreData(var topGenre)async{
    List<dynamic>topThreeGenres = getTopThreeGenres(topGenre);
    var db = FirebaseFirestore.instance;
    /* For new user */
    if(topThreeGenres.length==0){
      print("No genres availabe for the user");
      return;
    }
    String genreId = "";
    for(int i=0;i<topThreeGenres.length;i++){
      genreId+="_${topThreeGenres[i]}";
    }
    genreId = genreId.replaceAll(' ','');

    // After finding current genreId, checking it with the previous one
    if(StaticStore.currentUserGenreId == genreId){
      return;
    }
    StaticStore.currentUserGenreId = genreId;
    List<dynamic> tempUserList=[];
    
    await db
    .collection("spotifyBasedGenreUsers")
    .get().then((value) async {

      // print("CheckState: spotifyBasedGenreUsers get");
      if(value.docs[0]['genreList'][genreId]!=null){
        await db
        .collection("spotifyBasedGenreUsers")
        .doc("genre")
        .set({'genreList':{genreId:FieldValue.arrayUnion([StaticStore.currentUserId])}},SetOptions(merge: true))
        .onError((e, _) => print("Error writing spotifyUserGenre info in firebase: $e"));

      }else{
        tempUserList.add(StaticStore.currentUserId);
        await db
        .collection("spotifyBasedGenreUsers")
        .doc("genre")
        .set({'genreList':{genreId:tempUserList}},SetOptions(merge: true))
        .onError((e, _) => print("Error writing spotifyUserGenre info in firebase: $e"));
      }
    },
    );
  }

  Future<void> storeChats(var mesId, Map<String, Object?> mes)async{
    var db = FirebaseFirestore.instance;
    await db
        .collection("chats")
        .doc(mesId)
        .set({"messageInfo":FieldValue.arrayUnion([mes])},SetOptions(merge: true))
        .onError((e, _) => print("Error Storing message info in firebase: $e"));
  }

}





String requestIdGenerator(String otherUser){
  List<String?> s = [StaticStore.currentUserId,otherUser];
  s.sort();
  String requestId = "${s[0]}_${s[1]}";
  return requestId;
}











class Friends extends StatefulWidget {
  const Friends({super.key});

  Future<String>friendStatusStore(requestReceiver)async{

  var requestId = requestIdGenerator(requestReceiver);
  var db = FirebaseFirestore.instance;
  try{
  await db
        .collection("friendStatus")
        .doc(requestId)
        .set({"requestStatus":"${StaticStore.currentUserId}"},SetOptions(merge: true));
        print("friend status fetcher");
        
        // StaticStore.requestStatusValue = "1";
        return "1";
  // return 1;
        // .onError((e, _) => print("Error Storing message info in firebase: $e"));
        // .get().then((value) {
        //   print(value.exists);
        // });
  }catch(e){
    return "0";
  }
}
  @override
  State<Friends> createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {




  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

// Future<String>freindStatusStore(requestReceiver)async{
//   var requestId = requestIdGenerator(requestReceiver);
//   var db = FirebaseFirestore.instance;
//   try{
//   await db
//         .collection("friendStatus")
//         .doc(requestId)
//         .set({"requestStatus":"${StaticStore.currentUserId}"},SetOptions(merge: true));
//         return "1";
//   // return 1;
//         // .onError((e, _) => print("Error Storing message info in firebase: $e"));
//         // .get().then((value) {
//         //   print(value.exists);
//         // });
//   }catch(e){
//     return "0";
//   }
// }


// Future<String>getFreindStatus(requestReceiver)async{
//   var requestId = requestIdGenerator(requestReceiver);
//   var db = FirebaseFirestore.instance;
//   try{
//   await db
//         .collection("friendStatus")
//         .doc(requestId)
//         .get().then((value) {
//           if(value.exists){
//             print(value.data()?['requestStatus']);
//           }
//         });
//         return "1";
//   }catch(e){
//     return "0";
//   }
//         // .get().then((value) {
//         //   print(value.exists);
//         // });
// }


Future<String>getFriendStatus(requestReceiver)async{
  var requestId = requestIdGenerator(requestReceiver);
  var db = FirebaseFirestore.instance;
  try{
  var a = await db
        .collection("friendStatus")
        .doc(requestId)
        .get();
        return a['requestStatus'];
  }catch(e){
    return "";
  }
}






Future<void>storeFriendRequest(requestReceiverId)async{
  // var requestId = requestIdGenerator(requestReceiver);
  // if(requestReceiverId==StaticStore.currentUserId){
  //   return;
  // }
  var db = FirebaseFirestore.instance;
  print("Storing friend request: $requestReceiverId");
  try{
  var a = await db
        .collection("friendRequest")
        .doc(requestReceiverId)
        .set({"users":FieldValue.arrayUnion([StaticStore.currentUserId])},SetOptions(merge: true))
        .onError((e, _) => print("Error Storing message info in firebase: $e"));
        return;
  }catch(e){
    return;
  }
}












Future<List<dynamic>?> fetchFriendRequests()async{
  StoreUserInfo _storeUserInfo = StoreUserInfo();
  StaticStore.currentUserId==""?
  await _storeUserInfo.fetchCurrentUserInfo():null;
  var db = FirebaseFirestore.instance;
  try{
    var a = await db
        .collection("friendRequest")
        .doc(StaticStore.currentUserId)
        .get();
    if(a.exists){
      return a['users'];
    }
    return null;
  }catch(e){
    print("fetch friend request error occured");
    return null;
  }
}

Future<void> updateRequestStatus(requestStatus,userId)async{
  var requestId = requestIdGenerator(userId);
  var db = FirebaseFirestore.instance;
  var a = await db
        .collection("friendStatus")
        .doc(requestId)
        .set({'requestStatus':'$requestStatus'});
}







Future<void> deleteFriendRequest(String userId)async{
  print("delete from firebase called");
  var db = FirebaseFirestore.instance;
  var a = await db
        .collection("friendRequest")
        .doc(StaticStore.currentUserId)
        .get();
        if(a.exists){
          print(a['users']);
          List<dynamic> friendRequests = a['users'];
          friendRequests.remove(userId);
          await db
                .collection("friendRequest")
                .doc(StaticStore.currentUserId)
                .set({"users":friendRequests});
                // .delete();
                // .delete({"users":FieldValue.arrayRemove([])},SetOptions(merge: true));
        }else{
          print("user doesn't exist");
        }
}












Future<void> addFriend(userId)async{
  var db = FirebaseFirestore.instance;
  await db
  .collection("friends")
  .doc(StaticStore.currentUserId)
  .set({"users":FieldValue.arrayUnion([userId])},SetOptions(merge: true));
  await db
  .collection("friends")
  .doc(userId)
  .set({"users":FieldValue.arrayUnion([StaticStore.currentUserId])},SetOptions(merge: true));
}

















Future<List<UserInfo>> fetchFriends()async{
  List<UserInfo>? friends=[];
  List<dynamic> friendIds=[];
  NetworkFunction _networkFunction = NetworkFunction();
  var db = FirebaseFirestore.instance;
  
  var a = await db
  .collection("friends")
  .doc(StaticStore.currentUserId)
  .get();
  if(a.exists){
    friendIds = a['users'];
    // List<UserInfo> friends = [];
      UserInfo temp;
      for (int i = 0; i < friendIds.length; i++) {
        temp = await _networkFunction.fetchUserInfo(friendIds[i]);
        friends.add(temp);
      }


    // print("friends");
    // print(friends);
    return friends;
  }
  return [];
}