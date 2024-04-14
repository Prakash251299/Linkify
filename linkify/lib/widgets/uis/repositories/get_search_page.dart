// import 'dart:collection';
// import 'dart:convert';
// // import 'dart:math';

// import 'package:http/http.dart';
// import 'package:linkify/controller/accesstoken_error.dart';
// // import 'package:linkify/controller/accesstoken_error.dart';
// import 'package:linkify/controller/read_write.dart';
// import 'package:linkify/controller/static_store.dart';
// // import 'package:linkify/widgets/uis/models/album_model.dart';
// // import '../api/url.dart';
// // import '../methods/get_response.dart';
// // import '../models/song_model.dart';
// // import '../models/user.dart';

// // class GetSearchPage {
  
// //   Future<List<String>> fetchUserGenre() async {
// //   print("fetching user's genre");
// //   List<String>s=[];
// //     // print("$songId");
// //     // List<String>? name = [];
// //     // List<String>? id = [];
// //     // List<String>?imgUrl=[];
// //     Map<String,int>m={};
// //     ReadWrite _readWrite = ReadWrite();
// //     while (true) {
// //       var accessToken = await _readWrite.getAccessToken();
// //       // print("Hhhhh");

// //       /* Fetching album tracks */
// //       var res = await get(Uri.parse('https://api.spotify.com/v1/me/top/artists?time-range=short_term&locale=en-GB%2Cen-US%3Bq%3D0.9%2Cen%3Bq%3D0.8&access_token=$accessToken'));
// //       // var res = await get(Uri.parse('https://api.spotify.com/v1/me/top/artists?limit=30&time_range=short_term&access_token=$accessToken'));
// //       print(res.statusCode);
// //       List<String>genres=[];
// //       if (res.statusCode == 200) {
// //         var data = jsonDecode(res.body);
// //         // print(data['items'][0]['genres'][0]);
// //         for(int i=0;i<data['items'].length;i++){
// //           // print(data['items'][i]['name']);
// //           for(int j=0;j<data['items'][i]['genres'].length;j++){
// //             genres.add(data['items'][i]['genres'][j]);
// //           }
// //         }
// //         // print(genres);
// //         // Map<String,int>m={};
// //         for(int i=0;i<genres.length;i++){
// //           // print(m[genres[i]]);
// //           if(m[genres[i]]==null){
// //             m[genres[i]] = 1;
// //           }else{
// //             m[genres[i]] = m[genres[i]]! + 1;
// //           }
// //           // if(m[genres[i]]==0){

// //           // }
// //         }
// //         await sort(m);
// //         // print(m);
// //         // m = (await sort(m)) as Map<String, int>;
// //         // m = Map<String,int>.from((await sort(m)));
        
// //         // StaticStore.userGenre.add(m);
// //         // print(StaticStore.userGenre[0].entries.elementAt(5).key);
        
// //         for(var k in m.keys){
// //           s.add(k);
// //           StaticStore.userGenre.add(k);
// //         }
// //         // print(StaticStore.userGenre);

// //         // print(StaticStore.userGenre[5].entries.elementAt(4).key);
// //         // for (var k in m.keys) {
// //         //   print("$k\n${m[k]}");
// //         //   // StaticStore.userGenre[k]=m[k];
// //         //   // StaticStore.userGenre.add({k:m[k]});

// //         // }


        
// //         // print(StaticStore.userGenre);
// //         // for (int i = 0; i < 50; i++) {
// //         //   // fetching 50 similar songs
// //         //   name.add(data['tracks'][i]['name']);
// //         //   id.add(data['tracks'][i]['id']);
// //         //   // imgUrl.add(data['items'][i]['track']['album']['images'][2]['url']);
// //         // }
// //         // print(imgUrl);
// //         // DateTime now = DateTime.now(); // 30/09/2021 15:54:30
// //         // var dateToday = now.day.toString();
// //         // dateToday += "-";
// //         // dateToday += now.month.toString();
// //         // dateToday += "-";
// //         // dateToday += now.year.toString();
// //         // if (StaticStore.dateStored != dateToday || StaticStore.m1[ind] == {}) {
// //         //   print(dateToday);
// //           // StaticStore.m1[ind].addEntries({'id': id}.entries);
// //           // StaticStore.m1[ind].addEntries({'name': name}.entries);
// //           // StaticStore.dateStored = dateToday;
// //           // StaticStore.carouselInd = ind;
// //           // m1.addEntries({'date':dateOnly}.entries);
// //         // }
// //         // return;
// //         // print();
// //         // m.addEntries({'image':imgUrl}.entries);
// //         // print(m1['name']);
// //         return s;
// //       } else {
// //         AccessError e = AccessError();
// //         if(await e.handleError(res)!=1){
// //           print("Error is not resolved");
// //           return s;
// //         }
// //       }
// //     }
// //   }

// // Future<void> sort(var m) async {
// //   var sortedKeys = m.keys.toList(growable:false)
// //     ..sort((k1, k2) => (m[k1] as num).compareTo(m[k2] as num));
// //     /* For reverse sorted order just do the below line in place of above line */
// //     // ..sort((k1, k2) => (m[k2] as num).compareTo(m[k1] as num));
// //   LinkedHashMap sortedMap = new LinkedHashMap
// //       .fromIterable(sortedKeys, key: (k) => k, value: (k) => m[k]);
// //   // print(sortedMap);
// //   return;
// // }



// //   // Future<Map<String,List<dynamic>>?> getName() async {
// //   // Future<Map<String,List<dynamic>>?> getLikedSongData() async {
// //   //   Map<String,List<dynamic>>? m={};
// //   //   List<String>id =[];
// //   //   List<String>name=[];
// //   //   List<String>imgUrl=[];
// //   //   List<String>bigImgUrl=[];

// //   //   ReadWrite _readWrite = ReadWrite();
// //   //   while(true){
// //   //     var accessToken = await _readWrite.getAccessToken();
// //   //     // print("Hhhhh");
// //   //     var res = await get(Uri.parse('https://api.spotify.com/v1/me/tracks?limit=30&time_range=short_term&access_token=$accessToken'));
// //   //     print(res.statusCode);
// //   //     if (res.statusCode == 200) {
// //   //       var data = jsonDecode(res.body);
// //   //       for(int i=0;i<data['items'].length;i++){
// //   //         name.add(data['items'][i]['track']['album']['name']);
// //   //         id.add(data['items'][i]['track']['album']['id']);
// //   //         // imgUrl.add(data['items'][i]['track']['album']['images'][2]['url']);
// //   //         imgUrl.add(data['items'][i]['track']['album']['images'][0]['url']);
// //   //       }
// //   //       // print(imgUrl);

// //   //       m.addEntries({'id':id}.entries);
// //   //       m.addEntries({'name':name}.entries);
// //   //       m.addEntries({'image':imgUrl}.entries);
// //   //       // print(m['id']);
// //   //       return m;
// //   //     }else{
// //   //       AccessError e = AccessError();
// //   //       await e.handleError(res);
// //   //     }
// //   //   }

// //   // }


// //   // Future<Map<String,List<dynamic>>?> getLikedSongData() async {
// //   //   Map<String,List<dynamic>>? m={};
// //   //   List<String>id =[];
// //   //   List<String>name=[];
// //   //   List<String>imgUrl=[];
// //   //   ReadWrite _readWrite = ReadWrite();
// //   //   while(true){
// //   //     var accessToken = await _readWrite.getAccessToken();
// //   //     // print("Hhhhh");
// //   //     var res = await get(Uri.parse('https://api.spotify.com/v1/me/tracks?limit=30&time_range=short_term&access_token=$accessToken'));
// //   //     print(res.statusCode);
// //   //     if (res.statusCode == 200) {
// //   //       var data = jsonDecode(res.body);
// //   //       for(int i=0;i<data['items'].length;i++){
// //   //         name.add(data['items'][i]['track']['name']);
// //   //         id.add(data['items'][i]['track']['id']);
// //   //         imgUrl.add(data['items'][i]['track']['album']['images'][2]['url']);
// //   //       }
// //   //       // print(imgUrl);

// //   //       m.addEntries({'id':id}.entries);
// //   //       m.addEntries({'name':name}.entries);
// //   //       m.addEntries({'image':imgUrl}.entries);
// //   //       // print(m['id']);
// //   //       return m;
// //   //     }else{
// //   //       AccessError e = AccessError();
// //   //       await e.handleError(res);
// //   //     }
// //   //   }

// //   // }

// // }
