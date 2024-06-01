import 'dart:convert';
import 'package:http/http.dart';
import 'package:linkify/controller/error/accesstoken_error.dart';
import 'package:linkify/model/home/first_page_categories.dart';
import 'package:linkify/controller/local_storing/read_write.dart';
import 'package:linkify/model/playlists/playlist.dart';

Future<List<MyPlaylist>> fetchGenrePlaylists(String genreName)async{

  ReadWrite _readWrite = ReadWrite();
  List<MyPlaylist> _playlist=[];
  while (true) {
    var accessToken = await _readWrite.getAccessToken();
    /* Fetching category playlsts */
    var res = await get(Uri.parse(
      'https://api.spotify.com/v1/search?query=$genreName&type=playlist&locale=en-GB%2Cen-US%3Bq%3D0.9%2Cen%3Bq%3D0.8&offset=0&limit=20&access_token=$accessToken'
        ));
    if(res.statusCode==200){
      var data = jsonDecode(res.body);
      for(int i=0;i<data['playlists']['items'].length && i<20;i++){
        _playlist.add(MyPlaylist.fromJson({'id':data['playlists']['items'][i]['id'],'name':data['playlists']['items'][i]['name'],'playlistImg':data['playlists']['items'][i]['images'][0]['url']}));
      }
      return _playlist;
    }else {
      AccessError e = AccessError();
      await e.handleError(res);
    }
  }
}