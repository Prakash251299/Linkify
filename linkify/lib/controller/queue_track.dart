import 'dart:convert';
import 'package:http/http.dart';
import 'package:linkify/controller/accesstoken_error.dart';
import 'package:linkify/controller/read_write.dart';
import 'package:linkify/controller/static_store.dart';
import 'package:linkify/model/album_track.dart';

Future<(double, double)> fetchTrackFeature(String songId) async {
  /* Fetch energy and valence of the song and use it for recommendation 
    */
  double energy;
  double valence;
  print(songId);
  ReadWrite _readWrite = ReadWrite();
  while (true) {
    var accessToken = await _readWrite.getAccessToken();
    // print(accessToken);
    var res = await get(Uri.parse("https://api.spotify.com/v1/audio-features/$songId?access_token=$accessToken"));
    if (res.statusCode == 200) {
      var audioFeature = jsonDecode(res.body);
      energy = audioFeature['energy'];
      // print(audioFeature['']);
      valence = audioFeature['valence'];
      
      return (energy,valence);
    } else {
      AccessError e = AccessError();
      var a = await e.handleError(res);

      // if(a==2){
      //   print("null refresh token plaese go to login or restart the app");
      // }
    }
  }

  // return;


}

Future<void>fetchQueueTrack(songName,songId,List<dynamic> songArtists,songImgUrl) async {
  // var energy, valence;
  // print(songName);
  // return;
  var (energy,valence) = await fetchTrackFeature(songId);
  // print(energy);
  // print(valence);
  // return;
  List<String> trackArtists=[];
  List<AlbumTrack> queueTracks=[
    AlbumTrack.fromJson({
      "name":songName,
      "id":songId,
      "trackImg":songImgUrl,
      "trackArtists":songArtists,
    })
  ];
  // queueTracks = List.from([AlbumTrack.fromJson({
  //     "name":songName,
  //   })]);
  // print(queueTracks.length);
  // return;
  // AlbumTrack? firstQueueTrack = AlbumTrack.fromJson({
  //     "name":songName,
  //     "id":songId,
  //     "trackImg":songImgUrl,
  //     "trackArtists":songArtists,
  // });
  // queueTracks.add(firstQueueTrack);
  // print(queueTracks.length);
  // return;
  // queueTracks.add(AlbumTrack.fromJson({
  //   "name":"ishu",
  // }));

  ReadWrite _readWrite = ReadWrite();
  while (true) {
    var accessToken = await _readWrite.getAccessToken();

    /* Fetching album tracks */
    var res = await get(Uri.parse(
      // ''
        'https://api.spotify.com/v1/recommendations?target_energy=$energy&target_valence=$valence&seed_tracks=$songId&access_token=$accessToken'
        ));
    // var res = await get(Uri.parse('https://api.spotify.com/v1/me/tracks?limit=30&time_range=short_term&access_token=$accessToken'));
    print(res.statusCode);
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      // print(data['tracks'].length);
      
      for (int i = 0; i<50 && i<data['tracks'].length; i++) {
        trackArtists=[];
        // print(data['tracks'][i]['name']);
        // print(data['tracks'][i]['id']);
        // print(data['tracks'][i]['album']['images'][0]['url']);
        if(data['tracks'][i]['name']==songName){
          continue;
        }
        for(int j=0;j<data['tracks'][i]['artists'].length;j++){
          trackArtists.add(data['tracks'][i]['artists'].length!=0?data['tracks'][i]['artists'][j]['name']:"unknown");
        }
        AlbumTrack? _singleQueueTrack = AlbumTrack.fromJson({
          "name":data['tracks'][i]['name'],
          "id":data['tracks'][i]['id'],
          "trackImg":data['tracks'][i]['album']['images'].length!=0?data['tracks'][i]['album']['images'][0]['url']:"",
          "trackArtists":trackArtists,

        });
        if(_singleQueueTrack.name=="" || _singleQueueTrack.id=="" || _singleQueueTrack.imgUrl==""){
          continue;
        }
        queueTracks.add(_singleQueueTrack);
      }

      // queueTracks.insert(0, AlbumTrack.fromJson({
      //   "name":songName,
      //   "id":songId,
      //   "trackImg":songImgUrl,
      //   "trackArtists":songArtists,
      // }));

      StaticStore.myQueueTrack=queueTracks;
      // print(queueTracks.length);
      // StaticStore.queueLoaded = 1;
      StaticStore.queueIndex = 0;
      // print(StaticStore.myQueueTrack[0].name);
      // for(int i=0;i<queueTracks.length;i++){
        // StaticStore.myQueueTrack.add(queueTracks[i]);
      //  = queueTracks;

      // List.from();
      // }
      //   print(data['tracks'][i]['name']);
      // }
      return;
    } else {
      AccessError e = AccessError();
      var a = await e.handleError(res);
    }
  }
}