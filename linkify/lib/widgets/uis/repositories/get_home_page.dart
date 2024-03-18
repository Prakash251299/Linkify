import 'dart:convert';
// import 'dart:math';

import 'package:http/http.dart';
import 'package:linkify/controller/accesstoken_error.dart';
// import 'package:linkify/controller/accesstoken_error.dart';
import 'package:linkify/controller/read_write.dart';
// import 'package:linkify/widgets/uis/models/album_model.dart';
// import '../api/url.dart';
// import '../methods/get_response.dart';
// import '../models/song_model.dart';
// import '../models/user.dart';

class GetHomePage {
  // Future<Map<String,List<dynamic>>?> getName() async {
  Future<Map<String,List<dynamic>>?> getLikedSongData() async {
    Map<String,List<dynamic>>? m={};
    List<String>id =[];
    List<String>name=[];
    List<String>imgUrl=[];
    ReadWrite _readWrite = ReadWrite();
    while(true){
      var accessToken = await _readWrite.getAccessToken();
      // print("Hhhhh");
      var res = await get(Uri.parse('https://api.spotify.com/v1/me/tracks?limit=30&time_range=short_term&access_token=$accessToken'));
      print(res.statusCode);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        for(int i=0;i<data['items'].length;i++){
          name.add(data['items'][i]['track']['album']['name']);
          id.add(data['items'][i]['track']['album']['id']);
          imgUrl.add(data['items'][i]['track']['album']['images'][2]['url']);
        }
        // print(imgUrl);

        m.addEntries({'id':id}.entries);
        m.addEntries({'name':name}.entries);
        m.addEntries({'image':imgUrl}.entries);
        // print(m['id']);
        return m;
      }else{
        AccessError e = AccessError();
        await e.handleError(res);
      }
    }

  }


  // Future<Map<String,List<dynamic>>?> getLikedSongData() async {
  //   Map<String,List<dynamic>>? m={};
  //   List<String>id =[];
  //   List<String>name=[];
  //   List<String>imgUrl=[];
  //   ReadWrite _readWrite = ReadWrite();
  //   while(true){
  //     var accessToken = await _readWrite.getAccessToken();
  //     // print("Hhhhh");
  //     var res = await get(Uri.parse('https://api.spotify.com/v1/me/tracks?limit=30&time_range=short_term&access_token=$accessToken'));
  //     print(res.statusCode);
  //     if (res.statusCode == 200) {
  //       var data = jsonDecode(res.body);
  //       for(int i=0;i<data['items'].length;i++){
  //         name.add(data['items'][i]['track']['name']);
  //         id.add(data['items'][i]['track']['id']);
  //         imgUrl.add(data['items'][i]['track']['album']['images'][2]['url']);
  //       }
  //       // print(imgUrl);

  //       m.addEntries({'id':id}.entries);
  //       m.addEntries({'name':name}.entries);
  //       m.addEntries({'image':imgUrl}.entries);
  //       // print(m['id']);
  //       return m;
  //     }else{
  //       AccessError e = AccessError();
  //       await e.handleError(res);
  //     }
  //   }

  // }

}
