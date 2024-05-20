import 'dart:convert';

import 'package:http/http.dart';
import 'package:linkify/model/album_track.dart';
import 'package:linkify/controller/accesstoken_error.dart';
import 'package:linkify/controller/read_write.dart';

Future<List<AlbumTrack>?> fetchPlaylistTracks(String? playlistId)async{
  print("fetching playlist tracks");
  // print(playlistId);


  ReadWrite _readWrite = ReadWrite();
  List<AlbumTrack>? _albumTracks=[];
  while (true) {
    var accessToken = await _readWrite.getAccessToken();
    /* Fetching category playlsts */
    var res = await get(Uri.parse(
      // 'https://api.spotify.com/v1/recommendations?seed_tracks=$trackId&limit=6&access_token=$accessToken'
      'https://api.spotify.com/v1/playlists/$playlistId/tracks?access_token=$accessToken'
        ));
    print("CategoryPlaylistsState: ${res.statusCode}");
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      print("playlist tracks:");
      for(int i=0;i<50 && i<data['items'].length;i++){
        List<String>?trackArtists=[];
        // print(data['items'][i]['track']['name']);
        // print(data['items'][i]['track']['id']);
        // print(data['items'][i]['track']['artists'][0]['name']);
        for(int j=0;j<data['items'][i]['track']['artists'].length;j++){
          trackArtists.add(data['items'][i]['track']['artists'].length!=0?data['items'][i]['track']['artists'][j]['name']:null);
        }
        // print(trackArtists);
        // print(data['items'][i]['track']['album']['images'][0]['url']);
        // return;
        AlbumTrack _singleAlbumTrackInfo = AlbumTrack.fromJson({
          "name":data['items'][i]['track']['name']??"",
          "id":data['items'][i]['track']['id']??"",
          "trackArtists":trackArtists,
          "trackImg":data['items'][i]['track']['album']['images'].length!=0?data['items'][i]['track']['album']['images'][0]['url']:"unknown",
        });
        if(_singleAlbumTrackInfo.name=="" || _singleAlbumTrackInfo.id=="" || _singleAlbumTrackInfo.imgUrl==""){
          continue;
        }else{
          _albumTracks.add(_singleAlbumTrackInfo);
        }
        // print(data['items'][i]['track']['name']);
        // print(_singleAlbumTrackInfo.imgUrl);
      }
      // print(_albumTracks.length);
      return _albumTracks;
    } else {
      AccessError e = AccessError();
      await e.handleError(res);
    }
  }



  // print(playlistId);
  // ReadWrite _readWrite = ReadWrite();
  // List<AlbumTrack> _albumTracks=[];
  // while (true) {
  //   var accessToken = await _readWrite.getAccessToken();
  //   /* Fetching category playlsts */
  //   var res = await get(Uri.parse(
  //     // 'https://api.spotify.com/v1/recommendations?seed_tracks=$trackId&limit=6&access_token=$accessToken'
  //     'https://api.spotify.com/v1/playlists/$playlistId/tracks?access_token=$accessToken'
  //       ));
  //   print("CategoryPlaylistsState: ${res.statusCode}");
  //   if (res.statusCode == 200) {
  //     var data = jsonDecode(res.body);
  //     print("playlist tracks:");
  //     for(int i=0;i<50 && i<data['items'].length;i++){
  //       List<String>trackArtists=[];
  //       // print(data['items'][i]['track']['name']);
  //       // print(data['items'][i]['track']['id']);
  //       // print(data['items'][i]['track']['artists']);
  //       for(int j=0;j<data['items'][i]['track']['artists'].length;j++){
  //         trackArtists.add(data['items'][i]['track']['artists'][j]['name']);
  //       }
  //       // print(trackArtists);
  //       // print(data['items'][i]['track']['album']['images'][0]['url']);
  //       // return;
  //       AlbumTrack _singleAlbumTrackInfo = AlbumTrack.fromJson({
  //         "name":data['items'][i]['track']['name'],
  //         "id":data['items'][i]['track']['id'],
  //         "trackArtists":trackArtists,
  //         "trackImg":data['items'][i]['track']['album']['images'][0]['url'],
  //       });
  //       _albumTracks.add(_singleAlbumTrackInfo);
  //       // print(_singleAlbumTrackInfo.imgUrl);
  //     }
  //     // print(_albumTracks.length);
  //     return _albumTracks;
  //   } else {
  //     AccessError e = AccessError();
  //     await e.handleError(res);
  //   }
  // }
  
}