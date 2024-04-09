import 'dart:convert';
// import 'dart:math';

import 'package:http/http.dart';
import 'package:linkify/controller/accesstoken_error.dart';
// import 'package:linkify/controller/accesstoken_error.dart';
import 'package:linkify/controller/read_write.dart';
import 'package:linkify/widgets/uis/utils/sliver_appbar.dart';
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
    List<String>trackName=[];
    List<String>trackId=[];
    // List<String>singleTrackArtists=[];
    // List<List<String>>trackArtists=[];
    // List<String>bigImgUrl=[];

    ReadWrite _readWrite = ReadWrite();
    while(true){
      var accessToken = await _readWrite.getAccessToken();
      print("Hhhhh");
      var res = await get(Uri.parse('https://api.spotify.com/v1/me/tracks?limit=30&time_range=medium_term&access_token=$accessToken'));
      // print(res.statusCode);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        print("kl");
        print(data['items'].length);
        print("kl");
        if(data['items'].length>0){
          for(int i=0;i<data['items'].length;i++){
            // print(data['items'].keys.toList()[0]);

            // name.add(data['items'])
            // print(data['items'][0].name);
            trackName.add(data['items'][i]['track']['name']);
            trackId.add(data['items'][i]['track']['id']);
            // for(int j=0;j<data['items'][i]['track']['artists'].length;j++){
            //   singleTrackArtists.add(data['items'][i]['track']['artists'][j]['name']);
            // }
            // trackImg.add(data['items'][i]['track']['album']['images'][0]['url']);

            name.add(data['items'][i]['track']['album']['name']);
            id.add(data['items'][i]['track']['album']['id']);
            imgUrl.add(data['items'][i]['track']['album']['images'][0]['url']);
            // trackArtists.add(singleTrackArtists);
           // print(data['items'][i]['track']['album']['name']);
           //  print(data['items'][i]['track']['name']);
          }
        }
        else{
           /* write code for new user */







          // res = await get(Uri.parse('https://api.spotify.com/v1/search?query=mahiye+jinna+&type=track'
          //     '&locale=en-GB%2Cen-US%3Bq%3D0.9%2Cen%3Bq%3D0.8&access_token=$accessToken'));
          // data = jsonDecode(res.body);
          // print(data);
          // // https://api.spotify.com/v1/search?query=mahiye+jinna+&type=track&locale=en-GB%2Cen-US%3Bq%3D0.9%2Cen%3Bq%3D0.8&offset=0&limit=20
          // name.add(data['tracks']['items'][0]['name']);
          // id.add(data['tracks']['items'][0]['id']);
          // imgUrl.add(data['tracks']['items'][0]['album']['images'][0]);
        }
        // print(imgUrl);

        m.addEntries({'name':name}.entries);
        m.addEntries({'id':id}.entries);
        m.addEntries({'image':imgUrl}.entries);

        m.addEntries({'trackName':trackName}.entries);
        m.addEntries({'trackId':trackId}.entries);
        // m.addEntries({'artists':trackArtists}.entries);
        // m.addEntries({'trackImage':trackImg}.entries);
        // print("heer");
        // print("heer1");
        // print(m.length);
        print(name.length);
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
