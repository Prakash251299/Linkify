import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:linkify/controller/static_store.dart';
import 'package:linkify/model/user_info.dart';

class FirebaseCall{
  static Future<void> readData()async{
    // var snapshot = FirebaseFirestore.instance.collection('users').get();
    // print(snapshot);



    /* Read data */
    var document = FirebaseFirestore.instance.collection('users');

    await document.get().then((v){
      print(v.docs[0]['name']);
    });



    //  setState(() {
    //    data = snapshot.data;
    //  });
    // } as FutureOr Function(QuerySnapshot<Map<String, dynamic>> value));
    // print("hi");

    // StreamBuilder(
    //       stream: FirebaseFirestore.instance.collection('users').snapshots(),
    //       builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //         print(snapshot.data?.docs[0]['name']);
    //         print("hello");
    //         return SizedBox();
    //       },
    //     );
  }

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
    db
    .collection("users")
    .doc(StaticStore.currentUserId)
    .set({
      "name":_userInfo.displayName,
      "id":_userInfo.id,
      "email":_userInfo.email,
      "country":_userInfo.country,
      "images":_userInfo.image,
      "spotifyGenre":topThreeGenres,

      // "name":"$name",
      // "id":id,
      // "email":email,
      // "country":country,
      // "userImg":userImg,
      // "spotifyGenre":topThreeGenres,
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

    // After finding current genreId checking it with the previous one
    if(StaticStore.currentUserGenreId == genreId){
      return;
    }else{
      /* Delete user id from spotifyUserBasedGenre collection for updating info */
      /* fetch all users in that list then remove the current user's id */
      
    }
    StaticStore.currentUserGenreId = genreId;
    List<dynamic> tempUserList=[];
    // genreId = "dance";
    // genreId = "genreList";
    // var k = {genreId:tempUserList};
    // print(k);



    // final citiesRef = db.collection("spotifyBasedGenreUsers");
    // final cities = citiesRef.where("genreList", arrayContainsAny: ["hdjshdjk"]);
    // cities.get().then((v){
    //   print(v.docs.length);
    // });
    // var document = FirebaseFirestore.instance.collection('spotifyBasedGenreUsers');

    // await document.get().then((v){
    //   print(v.docs[0]['genreList']['dance']);
    // });


    
    await db
    .collection("spotifyBasedGenreUsers")
    .get().then((value) async {
      // print(value.docs[0]['genreList']['_dance']),
      // print(value.docs[0]['_dance']),

      print("Hi");
      if(value.docs[0]['genreList'][genreId]!=null){
        print("Yes");
        await db
        .collection("spotifyBasedGenreUsers")
        .doc("genre")
        .set({'genreList':{genreId:FieldValue.arrayUnion([StaticStore.currentUserId])}},SetOptions(merge: true))
        .onError((e, _) => print("Error writing spotifyUserGenre info in firebase: $e"));


        // await db
        // .collection("spotifyBasedGenreUsers")
        // .doc("genre")
        // // .set({"genreList":{genreId:tempUserList}})
        // .set({'genreList':{genreId:tempUserList}},SetOptions(merge: true))
        // .onError((e, _) => print("Error writing spotifyUserGenre info in firebase: $e"));

      }else{
        print("No");
        tempUserList.add(StaticStore.currentUserId);
        await db
        .collection("spotifyBasedGenreUsers")
        .doc("genre")
        .set({'genreList':{genreId:tempUserList}},SetOptions(merge: true))
        .onError((e, _) => print("Error writing spotifyUserGenre info in firebase: $e"));
      //   print("No"),
      }



      // print(value.docs[0]['genre']),



    },
    );



    // db
    // .collection("spotifyBasedGenreUsers/genre")
    // .doc(genreId)
    // .set("genre".add(StaticStore.currentUserId))
    // .onError((e, _) => print("Error writing document: $e"));

    // print(genreId);
  }

}