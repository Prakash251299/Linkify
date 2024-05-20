// import 'package:flutter/services.dart';
// import 'package:just_audio/just_audio.dart';
// // import 'package:linkify/controller/read_write.dart';
// import 'package:linkify/controller/youtube_player.dart';
// import 'package:linkify/widgets/uis/utils/sliver_appbar.dart';

// class PlaySpotifySong{
//   // void playTrack(var id){
//   //   print("playing");
//   // }
//   // const platform = MethodChannel('com.example.Linkify/player');
//   AudioPlayer a = AudioPlayer();
//   YoutubeSongPlayer _player = YoutubeSongPlayer();

//   Future<void> playTrack(var name,var artistName) async {

//     // ReadWrite _readWrite = ReadWrite();
//     // var accessToken = await _readWrite.getAccessToken();
//     _player.youtubePlay(name,artistName);
//     // await a.setUrl('https://api.spotify.com/v1/tracks/6OmhkSOpvYBokMKQxpIGx2?access_token=$accessToken');
//     // await a.play();






//     // try {
//     //   await platform.invokeMethod('playPlaylist', {"uri": "spotify:playlist:37i9dQZF1DX2sUQwD7tbmL"});
//     //   print('Playlist is playing');
//     //   // await SpotifySdk.play(spotifyUri: 'spotify:track:58kNJana4w5BIjlZE2wq5m');
//     // } on PlatformException catch (e) {
//     //   print("error");
//     // } on MissingPluginException {
//     //   print("error2");

//     // }
//   }

//   // Future<void> connectToSpotify() async {
//   //   try {
//   //     final connectionParams = SpotifySdkConnectParams(
//   //       clientId: 'YOUR_CLIENT_ID',
//   //       redirectUrl: 'YOUR_REDIRECT_URL',
//   //       scopes: [SpotifyScope.appRemoteControl],
//   //     );
//   //     final result = await SpotifySdk.connectToSpotify(connectionParams);
//   //     if (result.success) {
//   //       print('Connected to Spotify');
//   //       await playPlaylist();
//   //     } else {
//   //       print('Failed to connect to Spotify');
//   //     }
//   //   } catch (e) {
//   //     print('Error connecting to Spotify: $e');
//   //   }
//   // }

//   // Future<void> playPlaylist() async {
//   //   try {
//   //     await SpotifySdk.play("spotify:playlist:37i9dQZF1DX2sUQwD7tbmL");
//   //     print('Playlist is playing');
//   //   } catch (e) {
//   //     print('Error playing playlist: $e');
//   //   }
//   // }


// }