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
          name.add(data['items'][i]['track']['name']);
          id.add(data['items'][i]['track']['id']);
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




    // ReadWrite _readWrite = ReadWrite();
    // var accessToken = await _readWrite.getAccessToken();
  //   // var res = await get(Uri.parse('https://api.spotify.com/v1/browse/categories?offset=0&limit=20&locale=en-GB%2Cen-US%3Bq%3D0.9%2Cen%3Bq%3D0.8&access_token=$accessToken'));
  //   var res = await get(Uri.parse('https://api.spotify.com/v1/me/tracks?limit=30&access_token=$accessToken'));
    
  //   var id,name;
  //   Map<String,List<dynamic>>?m = {"id":[],"name":[]};

  //   if (res.statusCode == 200) {
  //     final body = await jsonDecode(res.body);
  //     print(body);
  //     final items = body['items'];
  //     // final items = (body as List)
  //     //     .map<AlbumModeling>((v) => AlbumModeling.fromJson(v))
  //     //     .toList();
  //     for(int i=0;i<items.length;i++){
  //       await id?.add(items[i]['track']['id']);
  //       await name?.add(items[i]['track']['name']);
  //     }
  //     m['id'] = id;
  //     m['name'] = name;
  //     print(id);

  //     return m;
  //   } else {
  //     // AccessError _accessError = AccessError();
  //     // int a = await _accessError.handleError(res);


  //     // if(a==1){
  //     //   getName();
  //     // }else{
  //     //   print("Error persists");
  //     // }
  //     // return await getName();
  //     // if(res.statusCode==403){

  //     // }
  //     throw Exception('Failed to load users');
  //   }






  }

}
