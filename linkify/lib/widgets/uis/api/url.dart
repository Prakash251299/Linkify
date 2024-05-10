import 'dart:convert';

import 'package:http/http.dart';
import 'package:linkify/controller/accesstoken_error.dart';
import 'package:linkify/controller/read_write.dart';
// import 'package:linkify/model/carousel.dart';
import 'package:linkify/model/liked_songs.dart';
import 'package:linkify/widgets/uis/screens/liked_songs/liked_songs.dart';

const String baseUrl = 'cryptic-forest-99443.herokuapp.com';
const String basePath = '/api/v1';



class CallApi{
  ReadWrite _readWrite = ReadWrite();
  AccessError _accessError = AccessError();
  var accessToken;
  // CallApi c = CallApi();


  /* Songs same like a song for queue */
    // var res = await get(Uri.parse('https://api.spotify.com/v1/recommendations?seed_tracks=2ncqKdTj6dz7tWoTMMrAtq&access_token=$accessToken'));

  LikedTracks l = LikedTracks();
  /* Liked songs */
  Future<void>getLikedSongs(var accessToken)async{
    // Carousel _carousel = Carousel(name, id, imgUrl);
    var res = await get(Uri.parse('https://api.spotify.com/v1/me/tracks?limit=30&access_token=$accessToken'));
    if(res.statusCode==200){
      print('wait...');
      var data = jsonDecode(res.body);
      var item = data['items'];
      l.storeLikedTracks(item);
    }else{
        await getData();
    }
    return;
  }

  


  int lim=20;
  Future<void>getPlaylistSongs(var accessToken,var id)async{
    var res = await get(Uri.parse('https://api.spotify.com/v1/playlists/$id/tracks?offset=0&limit=20&locale=en-GB%2Cen-US%3Bq%3D0.9%2Cen%3Bq%3D0.8&access_token=$accessToken'));
    if(res.statusCode==200){
      print('wait...');
      var data = jsonDecode(res.body);
      // print(data);
      var item = data['items'];
      for(int i=0;i<lim;i++){
        print(item[i]['track']['album']['name']); // track name
        print(item[i]['track']['id']); // track id
      }
    }else{
        await getData();
    }
    return;
  }



  // Future<void>featuredPlaylist()async{
  Future<void>getData()async{
    print("calling...");
    // await getLikedSongs(accessToken);
    // return;
    if(accessToken==""){
      accessToken = await _readWrite.getAccessToken();
    }

    print(accessToken);

    /* recently played */
    // https://api.spotify.com/v1/me/player/recently-played?offset=0&access_token=$accessToken

    /* Featured playlists */
    var res = await get(Uri.parse('https://api.spotify.com/v1/browse/featured-playlists?offset=0&locale=en-GB%2Cen-US%3Bq%3D0.9%2Cen%3Bq%3D0.8&access_token=$accessToken'));
    /* Current user's playlist */
    // var res = await get(Uri.parse('https://api.spotify.com/v1/me/playlists&access_token=$accessToken'));


    if(res.statusCode==200){
      print('wait...');
      var data = jsonDecode(res.body);
      // print(data);
      // for(int i=0;i<data['playlists']['items'].length;i++){
        var item = data['playlists']['items'][0];
        // print(item['name']);
        // if(item['name'] == 'Charts'){
          // await getPlaylistSongs(accessToken,item['id']);
        print("hello1");
        await getLikedSongs(accessToken);
        print("hello2");

          // print(item['id']);
        // }
      // }
      
    }else{
      print("error occurred");
      int a = await _accessError.handleError(res);
      if(a==1){
        accessToken = await _readWrite.getAccessToken();
        await getData();
        return;
      }else{
        print("something went wrong while calling api using this accesstoken");
      }
    }
    return;
  }


  // Future<void>getData()async{
  //   print("calling...");
  //   if(accessToken==""){
  //     accessToken = await _readWrite.getAccessToken();
  //   }

  //   print(accessToken);
  //   var res = await get(Uri.parse('https://api.spotify.com/v1/browse/categories?offset=0&limit=$lim&locale=en-GB%2Cen-US%3Bq%3D0.9%2Cen%3Bq%3D0.8&access_token=$accessToken'));
  //   if(res.statusCode==200){
  //     print('wait...');
  //     var data = jsonDecode(res.body);
  //     print(data);
  //     for(int i=0;i<data['categories']['items'].length;i++){
  //       var item = data['categories']['items'][i];
  //       print(item['name']);
  //       // if(item['name'] == 'Charts'){
  //         // await getAlbumSong(accessToken,item['id']);
  //         print(item['id']);
  //       // }
  //     }
  //   }else{
  //     print("error occurred");
  //     int a = await _accessError.handleError(res);
  //     if(a==1){
  //       accessToken = await _readWrite.getAccessToken();
  //       await getData();
  //       return;
  //     }else{
  //       print("something went wrong while calling api using this accesstoken");
  //     }
  //   }
  //   return;
  // }
}
