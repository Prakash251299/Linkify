import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:linkify/controller/accesstoken_error.dart';
import 'package:linkify/controller/read_write.dart';
import 'dart:collection';

import 'package:linkify/controller/static_store.dart';



Future<List<String>> fetchTopTrackGenres() async {
  print("fetching user's genre");
    // print("$songId");
    // List<String>? name = [];
    // List<String>? id = [];
    // List<String>?imgUrl=[];
    Map<String,int>m={};
    ReadWrite _readWrite = ReadWrite();
    while (true) {
      var accessToken = await _readWrite.getAccessToken();
      // print("Hhhhh");

      /* Fetching album tracks */
      var res = await get(Uri.parse('https://api.spotify.com/v1/me/top/tracks?time_range=long_term&access_token=$accessToken'));
      // var res = await get(Uri.parse('https://api.spotify.com/v1/me/top/artists?limit=30&time_range=short_term&access_token=$accessToken'));
      print(res.statusCode);
      List<String>genres=[];
      List<String>topTracks=[];
      List<String>topArtists=[];
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        // print(data['items'][0]['genres'][0]);
        // print(data['items'].length);



        /* For new user */
        if(data['items'].length==0){
          print("new user");
          // write code for giving user option to select his/her favourite artists
          return [];
        }





        for(int i=0;i<data['items'].length && i<50;i++){
          // print(data['items'][i]['name']);
          // for(int j=0;j<data['items'][i]['name'].length;j++){
            topTracks.add(data['items'][i]['name']);
            for(int j=0;j<data['items'][i]['artists'].length;j++){
              if(topArtists.contains(data['items'][i]['artists'][j]['id'])==false){
                topArtists.add(data['items'][i]['artists'][j]['id']);
              }
            }
          // }
        }
        // print(topArtists);
        String artistIds=topArtists[0];
        for(int i=1;i<topArtists.length;i++){
          artistIds+=",${topArtists[i]}";
        }
        // print(artistIds);
        var allTrackGenres = await getArtistsGenres(artistIds);
        for(int j=0;j<allTrackGenres.length;j++){
          genres.add(allTrackGenres[j]);
        }
        // print(genres);
        for(int i=0;i<genres.length;i++){
          // print(m[genres[i]]);
          if(m[genres[i]]==null){
            m[genres[i]] = 1;
          }else{
            m[genres[i]] = m[genres[i]]! + 1;
          }
          // if(m[genres[i]]==0){

          // }
        }
        var l = await sort(m);
        // print(l);
        List<String> temp=[];
        for(var k in l.keys){
          // print(k);
          temp.add(k);
        }
        StaticStore.userGenre = temp;
        return temp;
      } else {
        AccessError e = AccessError();
        if(await e.handleError(res)!=1){
          print("Error is not resolved");
          return [];
        }
      }
    }
  }

  Future<List<String>> getArtistsGenres(String artistIds)async{
    List<String> genres=[];
    ReadWrite _readWrite = ReadWrite();
    while (true) {
      var accessToken = await _readWrite.getAccessToken();
      // print("Hhhhh");

      /* Fetching album tracks */
      var res = await get(Uri.parse('https://api.spotify.com/v1/artists?ids=$artistIds&access_token=$accessToken'));
      // var res = await get(Uri.parse('https://api.spotify.com/v1/me/top/artists?limit=30&time_range=short_term&access_token=$accessToken'));
      print(res.statusCode);
      // List<String>genres=[];
      // List<String>topTracks=[];
      // List<String>topArtists=[];
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        // print(data['items'][0]['genres'][0]);
        // print(data['items'].length);



        /* For new user */
        // if(data['items'].length==0){
        //   // write code for giving user option to select his/her favourite artists
        //   return [];
        // }



        for(int i=0;i<data['artists'].length;i++){
          for(int j=0;j<data['artists'][i]['genres'].length;j++){
            genres.add(data['artists'][i]['genres'][j]);
          }
        }
        return genres;
      } else {
        AccessError e = AccessError();
        if(await e.handleError(res)!=1){
          print("Error is not resolved");
          return [];
        }
      }
    }
    // return genre;
  }




Future<List<String>> fetchUserTopArtistGenre() async {
  print("fetching user's genre");
    // print("$songId");
    // List<String>? name = [];
    // List<String>? id = [];
    // List<String>?imgUrl=[];
    Map<String,int>m={};
    ReadWrite _readWrite = ReadWrite();
    while (true) {
      var accessToken = await _readWrite.getAccessToken();
      // print("Hhhhh");

      /* Fetching album tracks */
      var res = await get(Uri.parse('https://api.spotify.com/v1/me/top/artists?time-range=short_term&access_token=$accessToken'));
      // var res = await get(Uri.parse('https://api.spotify.com/v1/me/top/artists?limit=30&time_range=short_term&access_token=$accessToken'));
      print(res.statusCode);
      List<String>genres=[];
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        // print(data['items'][0]['genres'][0]);
        // print(data['items'].length);



        /* For new user */
        if(data['items'].length==0){
          // write code for giving user option to select his/her favourite artists
          return [];
        }





        for(int i=0;i<data['items'].length && i<50;i++){
          // print(data['items'][i]['name']);
          for(int j=0;j<data['items'][i]['genres'].length;j++){
            genres.add(data['items'][i]['genres'][j]);
          }
        }
        // print(genres);
        // Map<String,int>m={};
        for(int i=0;i<genres.length;i++){
          // print(m[genres[i]]);
          if(m[genres[i]]==null){
            m[genres[i]] = 1;
          }else{
            m[genres[i]] = m[genres[i]]! + 1;
          }
          // if(m[genres[i]]==0){

          // }
        }
        var l = await sort(m);
        // print(l);
        // m = (await sort(m)) as Map<String, int>;
        // m = Map<String,int>.from((await sort(m)));
        
        // StaticStore.userGenre.add(m);
        // print(StaticStore.userGenre[0].entries.elementAt(5).key);
        List<String> temp=[];
        for(var k in l.keys){
          // print(k);
          temp.add(k);
        }
        StaticStore.userGenre = temp;
        // print(StaticStore.userGenre);

        // print(StaticStore.userGenre[5].entries.elementAt(4).key);
        // for (var k in m.keys) {
        //   print("$k\n${m[k]}");
        //   // StaticStore.userGenre[k]=m[k];
        //   // StaticStore.userGenre.add({k:m[k]});

        // }


        
        // print(StaticStore.userGenre);
        // for (int i = 0; i < 50; i++) {
        //   // fetching 50 similar songs
        //   name.add(data['tracks'][i]['name']);
        //   id.add(data['tracks'][i]['id']);
        //   // imgUrl.add(data['items'][i]['track']['album']['images'][2]['url']);
        // }
        // print(imgUrl);
        // DateTime now = DateTime.now(); // 30/09/2021 15:54:30
        // var dateToday = now.day.toString();
        // dateToday += "-";
        // dateToday += now.month.toString();
        // dateToday += "-";
        // dateToday += now.year.toString();
        // if (StaticStore.dateStored != dateToday || StaticStore.m1[ind] == {}) {
        //   print(dateToday);
          // StaticStore.m1[ind].addEntries({'id': id}.entries);
          // StaticStore.m1[ind].addEntries({'name': name}.entries);
          // StaticStore.dateStored = dateToday;
          // StaticStore.carouselInd = ind;
          // m1.addEntries({'date':dateOnly}.entries);
        // }
        // return;
        // print();
        // m.addEntries({'image':imgUrl}.entries);
        // print(m1['name']);
        return temp;
      } else {
        AccessError e = AccessError();
        if(await e.handleError(res)!=1){
          print("Error is not resolved");
          return [];
        }
      }
    }
  }

Future<LinkedHashMap> sort(var m) async {
  var sortedKeys = m.keys.toList(growable:false)
    // ..sort((k1, k2) => (m[k1] as num).compareTo(m[k2] as num));
    /* For reverse sorted order just do the below line in place of above line */
    ..sort((k1, k2) => (m[k2] as num).compareTo(m[k1] as num));
  LinkedHashMap sortedMap = new LinkedHashMap
      .fromIterable(sortedKeys, key: (k) => k, value: (k) => m[k]);
  // print(sortedMap);
  return sortedMap;
}


Future<List<String>> fetchUserSelectedArtistsGenres() async {

  return await getArtistsGenres(StaticStore.userSelectedArtists);
}