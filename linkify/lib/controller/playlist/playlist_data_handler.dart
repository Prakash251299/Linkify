import 'dart:convert';

import 'package:http/http.dart';
import 'package:linkify/controller/error/accesstoken_error.dart';
import 'package:linkify/controller/local_storing/read_write.dart';
import 'package:linkify/model/playlists/playlist.dart';

Future<List<MyPlaylist>> fetchPlaylists()async{
  print("fetching playlist info");
  ReadWrite _readWrite = ReadWrite();
  List<MyPlaylist> _playlist=[];
  while (true) {
    var accessToken = await _readWrite.getAccessToken();
    /* Fetching category playlsts */
    var res = await get(Uri.parse(
      'https://api.spotify.com/v1/me/playlists?access_token=$accessToken'
        ));
    if(res.statusCode==200){
      var data = jsonDecode(res.body);
      for(int i=0;i<data['items'].length;i++){
        _playlist.add(MyPlaylist.fromJson({'id':data['items'][i]['id'],'name':data['items'][i]['name'],'playlistImg':data['items'][i]['images'][0]['url']}));
        // print(data['items'][i]['name']);
        // print(data['items'][i]['images'][0]['url']);
      }
      // print(_playlist[0].imgUrl);
      return _playlist;
    }else {
      AccessError e = AccessError();
      await e.handleError(res);
    }
  }
}
