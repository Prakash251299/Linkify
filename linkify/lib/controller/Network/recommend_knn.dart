import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linkify/controller/Network/user_network_functions.dart';
import 'package:linkify/controller/store_to_firebase/firebase_call.dart';
import 'package:linkify/controller/local_storing/read_write.dart';
import 'package:linkify/controller/variables/static_store.dart';
import 'package:linkify/controller/genre/user_genre.dart';
import 'package:linkify/model/user_info.dart';

Future<List<UserInfo>> KNN_recommender() async {
  // print(StaticStore.userGenreWithCount);
  // return;
  Map<dynamic,dynamic> mapOfRecommendedUserIds={};
  if(StaticStore.userGenre==null || StaticStore.userGenre==[]){
    await fetchTopTrackGenres();
  }
  await fetchTopTrackGenresPercentage();
  print("fetchTopTrackGenresPercentage called");
  List<UserInfo> recommendedUsers = await fetchKNearestNeighbours();
  /* remove current user and friends from mapOfRecommendedUserIds */
  // print(mapOfRecommendedUserIds);

  // await filterUsers(mapOfRecommendedUserIds);
  // print(StaticStore.userGenreWithCount);
  return recommendedUsers;
}

Future<void> fetchTopTrackGenresPercentage() async {
  int sum = 0;
  if (StaticStore.userGenreWithCount == null) {
    return;
  }
  for (int k in StaticStore.userGenreWithCount!.values) {
    sum += k;
  }
  // print(sum);
  for (var k in StaticStore.userGenreWithCount!.keys) {
    int a = (StaticStore.userGenreWithCount?[k]*100/sum).round();
    if(a>=8){
      StaticStore.userGenreWithCount?[k] = a;
    }else{
      StaticStore.userGenreWithCount?[k] = 0;
    }
  }
  // print("User genre with count");
  // print(StaticStore.userGenreWithCount);
  // print(StaticStore.userGenre);
  await genreStoreWithPercentage();
}

Future<void> genreStoreWithPercentage() async {
  var db = FirebaseFirestore.instance;
    // List<dynamic> topThreeGenres = getTopThreeGenres(topGenre);
    // for(int i=0;StaticStore.userGenreWithCount!=null && i<StaticStore.userGenreWithCount!.length;i++){
    for (var k in StaticStore.userGenreWithCount!.keys) {
      // print(k);
      // print(StaticStore.userGenreWithCount?[k]);

      if(StaticStore.userGenreWithCount?[k]>0)
      

      await db
      .collection("userPercentageGenrewise")
      .doc("genreUser")
      .set({
        "${k}":{
          "${StaticStore.userGenreWithCount?[k]}":FieldValue.arrayUnion([StaticStore.currentUserId]),
        },
      },SetOptions(merge: true)
      );
      // .onError((e, _) => print("Error writing user info in firebase: $e"));
    }
    return;
}

// Future<void> genreWiseUserWithPercentage() async {}

Future<List<UserInfo>> fetchKNearestNeighbours() async {
  Map<dynamic,dynamic> mapOfRecommendedUserIds={};
  var db = FirebaseFirestore.instance;
  List<List<double>> nearness = [[],[],[]];
  var a = await db
      .collection("userPercentageGenrewise")
      .doc("genreUser").get();
      // print("here");
      // print(StaticStore.userGenreWithCount?[StaticStore.userGenre?[0]].runtimeType);
      // print(StaticStore.userGenreWithCount?[StaticStore.userGenre?[0]]);
      for(int i=0;StaticStore.userGenre!=null && i<StaticStore.userGenre!.length && i<3;i++){
        // for(int j=0;j<a[StaticStore.userGenre![i]].length;j++){
        //   applyKNN(0, StaticStore.userGenre?[i], 0, a[StaticStore.userGenre![i]].keys[j]);
        // }
        List<double> temp=[];
        for(var k in a[StaticStore.userGenre![i]].keys){
          // print("${StaticStore.userGenre?[i]}: $k");
          // print(k);
          // print(StaticStore.userGenre![i].runtimeType);
          // await applyKNN(0, int.parse(k), 0, int.parse(StaticStore.userGenreWithCount![StaticStore.userGenre![i]]));
          // await applyKNN(0, int.parse(k), 0, 0);
          double res = applyKNN(0, double.parse(k), 0, double.parse('${StaticStore.userGenreWithCount?[StaticStore.userGenre?[i]]}'));
          temp.add(res);
        }
        // temp = [43,5,8,56,2,7];
        temp.sort();
        // var t = await sort(temp);
        // print(temp);
        nearness[i] = temp;
      }
  // print(nearness);
  mapOfRecommendedUserIds = await getAllRecommendationUsers(nearness);
  List<UserInfo> recommendedUsers = await getUsers(mapOfRecommendedUserIds);
  return recommendedUsers;
}


double applyKNN(double x1,double y1,double x2,double y2){
  double res = 0.0;
  // print("$x1,$x2,$y1,$y2");

  // print(sqrt(pow((x2-x1),2)+pow(y2-y1,2)));
  res = sqrt(pow((x2-x1),2)+pow(y2-y1,2));
  // print("result: ${res}");
  return res;
}

Future<Map<dynamic,dynamic>> getAllRecommendationUsers(List<List<double>> nearness)async{
  Map<dynamic,dynamic>mapOfRecommendedUserIds = {};
  // List<List<dynamic>> recommendedUsers=[[],[],[]];
  // for(int j=0;StaticStore.userGenre!=null && j<StaticStore.userGenre!.length && j<3;j++){
    for(int i=0;i<nearness[0].length;i++){
      await getUsersByNearness(nearness[0][i],0,mapOfRecommendedUserIds);
      // print(nearness[0][i]);
    }
    
    for(int i=0;i<nearness[1].length;i++){
      await getUsersByNearness(nearness[1][i],1,mapOfRecommendedUserIds);
      // print(nearness[1][i]);
    }

    for(int i=0;i<nearness[2].length;i++){
      await getUsersByNearness(nearness[2][i],2,mapOfRecommendedUserIds);
      // print(nearness[2][i]);
    }
  // }
  // print("map: $mapOfRecommendedUserIds");
  // var timer = Timer(Duration(seconds: 4), () =>   print(recommendedUsers));
  return mapOfRecommendedUserIds;
}

Future<Map<dynamic,dynamic>> getUsersByNearness(double nearness, int topGenreNumber,Map<dynamic,dynamic> mapOfRecommendedUserIds)async{
  if(nearness>30){return {};}
  // if(StaticStore.userGenre?[topGenreNumber]==null){
  //   print("null data found");
  //   return {};
  // }
  var k = nearness-StaticStore.userGenreWithCount?['${StaticStore.userGenre?[topGenreNumber]}'];
  if(k<0){
    k = -1*k;
  }
  // Map<dynamic,dynamic>m = {};
  var db = FirebaseFirestore.instance;
    var genres = await db
    .collection("userPercentageGenrewise")
    .doc('genreUser')
    .get();
    List<dynamic> userIds = [];
    userIds = await genres.data()?['${StaticStore.userGenre?[topGenreNumber]}']['${k.round()}'];
    userIds = await filter(userIds);
    for(var u in userIds){
      if(mapOfRecommendedUserIds[u]==null){
        mapOfRecommendedUserIds[u] = nearness;
      }else{
        var avg = (mapOfRecommendedUserIds[u]+nearness)/2;
        mapOfRecommendedUserIds[u] = avg;
      }
    }
    // print("map: $mapOfRecommendedUserIds");
    return mapOfRecommendedUserIds;
}

Future<List<dynamic>>filter(List<dynamic> userids)async{
  List<dynamic> s = [];
  for(int i=0;i<userids.length;i++){
    if(userids[i]!=StaticStore.currentUserId){
      String status = await getFriendStatus1(userids[i]);
      if(status=='4'){
        print("Error occured while fetching request status for KNN");
      }else{
        if(status=="1"){
          // s.remove(e);
        }else{
          s.add(userids[i]);
        }
      }
      // print("$e: $status");
    }
  }
  userids = s;
  return s;
}

Future<String>getFriendStatus1(requestReceiver)async{
  String requestId = requestIdGenerator(requestReceiver);
  var db = FirebaseFirestore.instance;
  try{
  var a = await db
        .collection("friendStatus")
        .doc('$requestId')
        // .doc('rtfyvjh')
        .get();
        if(a.exists){
          if(a['requestStatus']=="1"){
            return "1";
          }
        }
        return '0';
  }catch(e){
    return "4";
  }
}

Future<List<UserInfo>> getUsers(Map<dynamic,dynamic> mapOfRecommendedUserIds)async{
  Map<dynamic,dynamic> l = await sortMapByValue(mapOfRecommendedUserIds,0);
  NetworkFunction _networkFunction = NetworkFunction();
  // print(l);
  List<UserInfo> users=[];
  for(var k in l.keys){
    users.add(await _networkFunction.fetchUserInfo(k));
  }
  // print(users[0].displayName);
  return users;
}











// Future<List<dynamic>> filterUsers(List<dynamic> listOfrecommendedUserIds)async{
//   // List<String> l=listOfrecommendedUserIds as List<String>;
//   // List<dynamic> s = [...listOfrecommendedUserIds];
//   // print(listOfrecommendedUserIds);
//   List<dynamic> s = List.from(listOfrecommendedUserIds);
//   listOfrecommendedUserIds.forEach( (e) async {
//     if(e==StaticStore.currentUserId){
//       s.remove(e);
//     }else{
    //   String status = await getFriendStatus1(e);
    //   if(status=='4'){
    //     print("Error occured while fetching request status for KNN");
    //   }
    //   if(status=="1"){
    //     s.remove(e);
    //     print("removed");
    //   }
    //   // print("$e: $status");
    // }
//   });
//   // listOfrecommendedUserIds = List.from(s);
//   print(s);
//   listOfrecommendedUserIds = s;
//   // print(listOfrecommendedUserIds);
//   return listOfrecommendedUserIds;
// }