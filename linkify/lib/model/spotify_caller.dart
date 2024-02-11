import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:linkify/controller/songPlayerController.dart';
import 'package:linkify/controller/song_data_contoller.dart';
import 'package:on_audio_query_platform_interface/src/models/song_model.dart';
// import 'package:just_audio/just_audio.dart';
import 'package:spotify/spotify.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
// import 'package:spotify_sdk/platform_channels.dart';
// import 'package:spotify_sdk/spotify_sdk.dart';
// import 'package:spotify_sdk/spotify_sdk_web.dart';

class SpotifyHandler{
  var clientId = "80c5fa373a4f4ef793721969b1e25fac";
  var clientSecret = "a58469d7127d4690ab1dcb4f706c0dbe";
  var albumId = "2Hog1V8mdTWKhCYqI5paph";
  // var token = "BQD1Ae47LNqRqKe3zT9ypoZVl9yvLfb1lRZu94QCL1ypJt1GPs4JByIaCzcT4W57_g66UbVnmh4s-7k0jTdyVXIktgyiTlihoGlLKFIyZhCflY-SZDU";
  var token = "BQBPfmiLWxXwJduBVAlnUB19Si8OMWIAwvkbv7DfTuDydcRMJqIdnAerVoeewQ4lf-v_bLb_uEakhM9rjkkftwJ6nyRwG36zGhkrxCciw9usS_Q5B_0";
  static var player =  AudioPlayer();
  static var playing = false;
  static var songName = "Mahiye jinna sohna";




  // getProfile(accessToken) async {
    // var accessToken = localStorage.getItem('access_token');

    // const response = await fetch('https://api.spotify.com/v1/me', {
    //   headers: {
    //     Authorization: 'Bearer ' + accessToken
    //   }
    // });

    // const data = await response.json();
  // }



  // await SpotifySdk.connectToSpotifyRemote(clientId: "", redirectUrl: "")
  // Future<void> spotify_conn()async {
  //   try {
  //     await SpotifySdk.play(spotifyUri: 'spotify:track:58kNJana4w5BIjlZE2wq5m');
  //   } on PlatformException catch (e) {
  //     // setStatus(e.code, message: e.message);
  //   } on MissingPluginException {
  //     // setStatus('not implemented');
  //   }
  // }


  Future<void> spotify_conn()async {
    // if(playing==true){
    //   player.stop();
    // }
    // var artist = "shad";
    print("hello");
    final credentials = SpotifyApiCredentials(clientId, clientSecret);
    final spotify = SpotifyApi(credentials);
    var trackId="";
    final tracks = await spotify.tracks.get('6rWblGW0pBcB3uygxBuWZV');
    // final tracks = await spotify.tracks;
    // final tracks = await spotify.browse.newReleases().first().then((v) => print(v.items?.elementAt(18).name));
    // final tracks = await spotify.categories.newReleases().first().then((v) => print(v.items?.elementAt(18).name));
    // final tracks = await spotify.albums.get(albumId);
    // final tracks = await spotify.albums.getTracks(albumId).all();





    /* track at specific index in album */
    // final tracks = await spotify.albums.tracks(albumId).all();
    // for(int i=0;i<tracks.length;i++){
    //   print(tracks.elementAt(i).name);
    // }



    /* Playlists */
    // var a=[];
    // var featuredPlaylists = await spotify.playlists.featured.all();
    // featuredPlaylists.forEach((playlist) {
    //   a.add(playlist.name);
    //   // print(playlist.owner?.displayName);
    // });
    // print(a);


    /* Tracks */
    // var a=[];
    // var tracks = await spotify.tracks;
    // featuredPlaylists.forEach((playlist) {
    //   a.add(playlist.owner?.country);
    //   // print(playlist.owner?.displayName);
    // });

    // print(tracks);

    // print(tracks.length);






    /* For lyrics of a song */

    // var songName = "Mahiye jinna Sohna";
    // var songId = 
    // get(Uri.parse("https://api.spotify.com/v1/search?q=track:"' + despacito + '"%20artist:"' + bieber + '"&type=track")).then((res) {
    // get(Uri.parse("https://api.spotify.com/v1/search?q=track:")).then((res) {
    //   var data = res.body;
    //   print(data);
    // });

    // get(Uri.parse("https://paxsenixofc.my.id/server/getLyricsMusix.php?q=${tracks.elementAt(0).name}&type=default")).then((res) {
    // get(Uri.parse("https://paxsenixofc.my.id/server/getLyricsMusix.php?q=${songName}&type=default")).then((res) {
    // get(Uri.parse("https://paxsenixofc.my.id/server/getMusix.php?q=${songName}&type=default")).then((res) {
    //   String data = res.body;
      // var list = data.split('\n').map((e)=>e).toList();
      // print(list);
    // });




    /* Recommendation */
  //   get(Uri.parse('https://api.spotify.com/v1/recommendations?seed_artists=4NHQUGzhtTLFvgF5SZesLK&seed_genres=classical%2Ccountry&seed_tracks=0c6xIDDpzE81m2q797ordA'
  // 'Bearer 1POdFZRZbvb...qqillRxMr2z')).then((res) {
  //     String data = res.body;
  //     // var list = data.split('\n').map((e)=>e).toList();
  //     print(data);
  //   });








    




    // get(Uri.parse('https://accounts.spotify.com/api/token')).then((res) {
    //   String data = res.body;
    //   // var list = data.split('\n').map((e)=>e).toList();
    //   print(data);
    // });





    // var accessToken = "";
    // get(Uri.parse ('https://api.spotify.com/v1/search?q=remaster%2520track%3ADoxy%2520artist%3AMiles%2520Davis&type=album',
    //   --Headers:accessToken
    // )).then((res) {
    //   print(res.body);
    // });






    // var accessToken = await spotify.(clientId: clientId, redirectUrl: "https://github.com/Prakash251299/Linkify", scope: "app-remote-control,user-modify-playback-state,playlist-read-private");

    var cr = await spotify.getCredentials();
    var accessToken = cr.accessToken;
    print(accessToken);
    // var url = get(Uri.parse ('com.spotify.sdk.android.auth')).then((r){
    //   print(r.body);
    // });







    /* Authorize */
    // await 'https://accounts.spotify.com/authorize?client_id=80c5fa373a4f4ef793721969b1e25fac&redirect_uri=https://github.com/Prakash251299/Linkify';
    // var myProfile;
    // get(Uri.parse('https://api.spotify.com/v1/me')).then((r) {
    //   myProfile = r.body;
    // });
    // print(myProfile);


    // print(spotify.me.follow());
    

    // if(accessToken!=null){
    //   // print(spotify.users.playlists(spotify.me as String));
    // // }
    // get(Uri.parse ('https://api.spotify.com/v1/search?q=remaster%2520track%3ADoxy%2520artist%3AMiles%2520Davis&type=album?&Authorization:"Bearer%201POdFZRZbvb...qqillRxMr2z"?access_token=$accessToken')).then((r) {
    //   print(r.body);
    // });
    // }else{
    //   print("no");
    // }



    // get(Uri.parse('https://accounts.spotify.com/authorize?client_id=80c5fa373a4f4ef793721969b1e25fac&redirect_uri=https://github.com/Prakash251299/Linkify')).then((r){
    //   print(r.body);
    // });



    // const authOptions = {
    //   method:'POST',
    //   headers:{
    //     'Content-Type':'application/x-www-form-urlencoded',
    //     'Authorization': 'Basic ($clientId)
    //   }
    // }


    // get(Uri.parse('https://accounts.spotify.com/api/access_token=$accessToken')).then((r) => print(r.body));


    // print(cr.refreshToken);


    // get(Uri.parse('https://api.spotify.com/v1/search?q=remaster%2520track%3ADoxy%2520artist%3AMiles%2520Davis&type=track&access_token=$accessToken')).then((r){
    //   print(r.body);
    // });








    /* Access song with access token */


    // var player = AudioPlayer();

    // String songName="Mahiye jinna";
    


    try{

    await get(Uri.parse('https://api.spotify.com/v1/search?query=remaster%2520track%3A$songName%2520artist%3AArijit&type=track&access_token=$accessToken&limit=1')).then((r) async {
    // await get(Uri.parse('https://api.spotify.com/v1/search?query=remaster%2520track%3A$songName%2520artist%3AArijit%2520include_external=audio&type=track&access_token=$accessToken&limit=1')).then((r) async {
      var data =r.body;

      final user = jsonDecode(data) as Map<String, dynamic>;
      // print(user['tracks']['items'][0]['id']);
      trackId = user['tracks']['items'][0]['href'];
      print(trackId);
      // await play(spotifyUri: '$trackId',asRadio: true);

      // print(tracks.href);




      // var url = 'https://api.spotify.com/v1/tracks/$trackId';



      // var url = '${tracks.href}&access_token=$accessToken';
      // final player = AudioPlayer();                   // Create a player
      // final duration = await player.setUrl(tracks.href as String);                 // Schemes: (https: | file: | asset: )
      // player.play();



      // await player.setAudioSource(AudioSource.uri(Uri.parse(url)));
      // await player.play(UrlSource('$url'));
      // player.play();

      // print(s);
      // print('We sent the verification link to ${user['email']}.');


      // print(r.body);
      // var list = data.split('\n').map((e)=>e).toList();
      // print(list);






      // handle_play(accessToken);


      /* Youtube player */
      // final res;
    });
    }catch(e){

    }


      if(songName!=""){
        try{
          final yt = YoutubeExplode();
          // final querySuggestions = (await yt.search.getQuerySuggestions(songName)).first;
          final video = (await yt.search.search(songName)).first;
          // print(video);
          final videoId = video.id.value;
          var manifest = await yt.videos.streamsClient.getManifest(videoId);
          var audio = await manifest.audioOnly.first;
          // SongDataController.songList.add(audio as SongModel);
          var audioUrl = await audio.url;
          print(audioUrl);
          await player.play(UrlSource(audioUrl.toString()));


          // await player.play(UrlSource('https://open.spotify.com/track/2FCXQHugkoHE1K3tiDu8pu'));
        }
        catch(e){
          print("e");
        }
      }


    // print(s);



  }



  // Future<void> play(var trackId) async {
  //   try {
  //     // await SpotifySdk.play(spotifyUri: 'spotify:track:58kNJana4w5BIjlZE2wq5m');
  //     await SpotifySdk.play(spotifyUri: '$trackId');
  //   } catch(e){
  //     print("Error occured");
  //   }
  // }



  void handle_play(var accessToken) async {
    // await SpotifySdk.connectToSpotifyRemote(clientId: "80c5fa373a4f4ef793721969b1e25fac", redirectUrl: "https://github.com/Prakash251299/Linkify");
    // SpotifySdk.subscribePlayerState();
    // SpotifySdk.subscribePlayerContext();
    // final accessToken = ;
    // SpotifySdkPlugin.tokenSwapURL = 'https://example.com/api/spotify/token';
    // SpotifySdkPlugin.tokenRefreshURL = 'https://example.com/api/spotify/refresh';
    // play(spotifyUri: 'https://api.spotify.com/v1/tracks/0Jiaz0O4AqnJICa9PxHhaR',asRadio: false);



  }

  // static Future play({
  //   required String spotifyUri,
  //   bool asRadio = false,
  // }) async {
  //   try {
  //     const MethodChannel _channel =
  //     MethodChannel(MethodChannels.spotifySdk);
  //     await _channel.invokeMethod(MethodNames.play, {
  //       ParamNames.spotifyUri: spotifyUri,
  //       ParamNames.asRadio: asRadio,
  //     });
  //   } on Exception catch (e) {
  //     // print(MethodNames.play);
  //     rethrow;
  //   }
  // }
}