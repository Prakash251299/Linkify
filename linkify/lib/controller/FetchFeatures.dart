import 'dart:convert';

import 'package:http/http.dart';

class FetchFeatures{

  Future<void> searchSongs(var data, var lim)async{
  // Future<void> searchSongs(var accessToken)async{
    // var songName = "mahiye jinna sohna";
    // var lim = 5;
    // var data;
    // var res = await get(Uri.parse('https://api.spotify.com/v1/search?q=$songName&type=album&limit=$lim&access_token=$accessToken'));
    // if(res.statusCode==200){
    //   data = jsonDecode(res.body);
    // }
    // print(data);

    try{
      for(int i=0;i<lim;i++){
        var songName = data['albums']['items'][i]['name'];
        print("$songName");
      }
    }catch(e){
      print("Error searching songs");
    }
  }

  Future<void> getPlaylists(var data, var lim)async{
    try{
      for(int i=0;i<lim;i++){
        // var playlistName = data['items'][i]['name'];
        var playlistName = data['playlists']['items'][i]['name'];
        // var playlistName = data['playlists'];
        print("$playlistName");
      }
    }catch(e){
      print("Error fetching playlists");
    }
  }

  Future<void> getArtists(var data, var lim)async{
    // res = await get(Uri.parse('https://api.spotify.com/v1/me/top/artists?offset=0&limit=$lim&access_token=$accessToken'));
    try{
      for(int i=0;i<lim;i++){
        // var playlistName = data['items'][i]['name'];
        var artistName = data['items'][i]['name'];
        // var playlistName = data['playlists'];
        print("$artistName");
      }
    }catch(e){
      print("Error fetching favourite artists");
    }
  }

  Future<void>recommendedAlbums(var data,var lim)async{
    try{
      for(int i=0;i<lim;i++){
        var albumName = data['tracks'][i]['album']['name'];
        // var albumName = data['tracks'][0];
        print(albumName);
      }
    }catch(e){
      print("Error in fetching recommendations");
    }
  }

  /* Get data of an album */
  Future<void>getAlbumData(var data, var lim)async{
    try{
      for(int i=0;i<lim;i++){
        var albumName = data['albums']['items'][i]['name'];
        // var albumName = data['tracks'][0];
        print(albumName);
      }
    }catch(e){
      print("Error in fetching recommendations");
    }
  }


}