import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:linkify/controller/read_write.dart';
import 'package:linkify/controller/FetchFeatures.dart';


String clientId = "80c5fa373a4f4ef793721969b1e25fac";
String clientSecret = "a58469d7127d4690ab1dcb4f706c0dbe";


class CallSpotify extends StatelessWidget {
  // String accessToken;
  CallSpotify({super.key});
  ReadWrite _readWrite = ReadWrite();
  String refreshToken="";
  String accessToken="";
  FetchFeatures s = FetchFeatures();


  // import 'dart:convert';
// import 'package:http/http.dart' as http;

Future<int> getNewAccessToken() async {
  // String? refreshToken = window.localStorage['refresh_token'];
  // String clientId = 'YOUR_CLIENT_ID'; // Replace 'YOUR_CLIENT_ID' with your actual client ID
  // String clientSecret = 'YOUR_CLIENT_SECRET'; // Replace 'YOUR_CLIENT_SECRET' with your actual client secret

  refreshToken = await _readWrite.getRefreshToken();
  if(refreshToken==""){
    print("null refresh token");
    return 2;
  }
  String body = 'grant_type=refresh_token';
  body += '&refresh_token=$refreshToken';
  body += '&client_id=$clientId';

  await callAuthorizationApi(body, clientId, clientSecret);
  return 1;
}

Future<void> callAuthorizationApi(String body, String clientId, String clientSecret) async {
  String tokenUrl = 'https://accounts.spotify.com/api/token';

  try {
    var response = await http.post(
        Uri.parse(tokenUrl),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Basic ${base64.encode(utf8.encode('$clientId:$clientSecret'))}'
        },
        body: body);

    handleAuthorizationResponse(response);
  } catch (e) {
    print('Error calling authorization API: $e');
    // Handle error
  }
}

void handleAuthorizationResponse(http.Response response) {
  if (response.statusCode == 200) {
    Map<String, dynamic> responseData = jsonDecode(response.body);
    print("got it");
    print(responseData);
    // print(responseData);
    if(responseData['access_token']!=null){
      _readWrite.writeAccessToken(responseData['access_token']);
    }else{
      print("null access token");
    }
    if(responseData['refresh_token']!=null){
      _readWrite.writeRefreshToken(responseData['refresh_token']);
    }else{
      print("AuthState :null refresh token");
    }
    // Handle successful response
  } else {
    print('Failed to refresh access token: ${response.body}');
    // Handle error response
  }
}




  Future<void>getNewAccessToken2()async{
    String body = "grant_type=refresh_token";
    body += "&refresh_token=$refreshToken";
    body += "&client_id=$clientId";
    body += "&client_secret=$clientSecret";

    var res = await http.post(
        Uri.parse('https://accounts.spotify.com/api/token'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Basic ' + base64Encode(utf8.encode('$clientId:$clientSecret'))
        },
        body: body,
    );
    print(res.statusCode);


  }

  
  Future<void> getNewAccessToken1() async {
    // refresh token that has been previously stored
    // String? refreshToken = window.localStorage['refresh_token'];
    refreshToken = await _readWrite.getRefreshToken();
    // print(refreshToken);
    
    // String clientId = ""; 

    try{
    var res = await get(Uri.parse('https://accounts.spotify.com/api/token?Content-Type=application/x-www-form-urlencoded&grant_type=refresh_token&refresh_token=$refreshToken&client_id=$clientId'));
    // var data = jsonDecode(res.body);


    print(res.statusCode);
    // Map<String, dynamic> response = json.decode(res.body);
    // _readWrite.writeAccessToken(response['access_token']);
    // _readWrite.writeRefreshToken(response['refresh_token']);
    // accessToken = data['access_token'];
    // print(accessToken);
    }catch(e){
      print("here err");
    }
  }

  // Future<void> getUserProfile1()async{
  //   var res;
  //   var data;
  //   try{
  //     // print(accessToken);
  //     // accessToken = "BQAq8RkLnEajL7WB6jPOLpnuPFLOH5JuhnCdPbPgwVntz1zCv4pBOCYyTtrt-9N7aeScWz1Fi7WR_ZJ-ol34WTA7Y5Jrv7S3soH9k53RqJiM7SFbxdUjeyTKDzyeZeezBveUWfzasjCqCXBkwXB6PbFPrw9OT5Yc5N-AuhqA2EOSEnngKj5P1YnAtr3p68n5_7D1x30Fzk8pHuvHwO8XtQlBdRGVIlo2LLRGBRrJv6MJOna3aVB1GZp3vQ";
  //     // accessToken = "BQAq8RkLnEajL7WB6jPOLpnuPFLOH5JuhnCdPbPgwVntz1zCv4pBOCYyTtrt-9N7aeScWz1Fi7WR_ZJ-ol34WTA7Y5Jrv7S3soH9k53RqJiM7SFbxdUjeyTKDzyeZeezBveUWfzasjCqCXBkwXB6PbFPrw9OT5Yc5N-AuhqA2EOSEnngKj5P1YnAtr3p68n5_7D1x30Fzk8pHuvHwO8XtQlBdRGVIlo2LLRGBRrJv6MJOna3aVB1GZp3vQ";
  //     res = await http.get(
  //       Uri.parse('https://api.spotify.com/v1/me'),
  //       headers: {
  //         'Authorization': 'Bearer $accessToken',
  //       }
  //     );
  //     // var res = await get(Uri.parse('https://api.spotify.com/v1/me?access_token=$accessToken'));
  //     data = jsonDecode(res.body);
  //     print(data);
  //     // print(data['error']['message']);
  //     // if(data['error']['message']=="The access token expired"){
  //     //   await getNewAccessToken();
  //     // }
  //     // if(res.body=="User not registered in the Developer Dashboard"){
  //     //   print("Invalid client id");
  //     //   // await getNewAccessToken();
  //     //   // await getUserProfile();
  //     // }
  //   }catch(e){
  //     print("err start");
  //     if(data['error']['message']=="The access token expired"){
  //       // await getNewAccessToken();
  //     }
  //     if(res.body=="User not registered in the Developer Dashboard"){
  //       print("Invalid client id");
  //       // await getNewAccessToken();
  //       // await getUserProfile();
  //     }
  //     print("err end");
  //   }
  // }


  Future<void> getUserProfile()async{
    accessToken = await _readWrite.getAccessToken();
    print(accessToken);
    var res;
    var data;
    // res = await http.get(
    //     Uri.parse('https://api.spotify.com/v1/me/top/tracks'),
    //     headers: {
    //       // 'Authorization': 'Bearer $accessToken',
    //       'Authorization': 'Basic ' + base64Encode(utf8.encode('$clientId:$clientSecret'))
    //     }
    // );
      // res = await get(Uri.parse('https://api.spotify.com/v1/me?access_token=$accessToken'));
      // res = await get(Uri.parse('https://api.spotify.com/v1/recommendations/available-genre-seeds?access_token=$accessToken'));
      // res = await get(Uri.parse('https://api.spotify.com/v1/browse/categories?access_token=$accessToken'));
      var userForSearch = "kelly";
      // res = await get(Uri.parse('https://api.spotify.com/v1/users/$userForSearch?access_token=$accessToken'));
      // res = await get(Uri.parse('https://api.spotify.com/v1/recommendations?seed_artists=4NHQUGzhtTLFvgF5SZesLK&seed_genres=classical%2Ccountry&seed_tracks=0c6xIDDpzE81m2q797ordA&access_token=$accessToken'));
      var lim = 20;
      var songName = "mahiye jina sona";
      // res = await get(Uri.parse('https://api.spotify.com/v1/search?q=remaster%2520track%3ADoxy%2520artist%3AMiles%2520Davis&type=album&limit=$lim&access_token=$accessToken'));
      // res = await get(Uri.parse('https://api.spotify.com/v1/search?q=$songName&type=album&limit=$lim&access_token=$accessToken'));
      // res = await get(Uri.parse('https://api.spotify.com/v1/me/player/play&access_token=$accessToken'));

      // For getting current user's playlists
      // res = await get(Uri.parse('https://api.spotify.com/v1/me/playlists?offset=0&limit=$lim&access_token=$accessToken'));

      /*  */
      // res = await get(Uri.parse('https://api.spotify.com/v1/browse/featured-playlists?offset=0&limit=$lim&access_token=$accessToken'));


      /* Not much known about this api response */
      // res = await get(Uri.parse('https://api.spotify.com/v1/browse/new-releases?offset=0&limit=20&locale=india&access_token=$accessToken'));

      /* Getting user's top songs */
      // res = await get(Uri.parse('https://api.spotify.com/v1/me/top/track?offset=0&limit=$lim&access_token=$accessToken'));

      /* Getting user's top artists */
      res = await get(Uri.parse('https://api.spotify.com/v1/me/top/artists?offset=0&limit=$lim&access_token=$accessToken'));
      // res = await get(Uri.parse('https://api.spotify.com/v1/recommendations?market=IN&seed_artists=0oOet2f43PA68X5RxKobEy,0oOet2f43PA68X5RxKobEy&access_token=$accessToken'));

      /* This can be used for making my own song recommendations for a song */
      // Just give 5 previously played songs on basic of that this will fetch songs which will be played next {for initial songs it would be directly}
      // res = await get(Uri.parse('https://api.spotify.com/v1/recommendations?market=IN&seed_tracks=5PUXKVVVQ74C3gl5vKy9Li%2C2PonaFfmtrK4B252AQaa2H%2C6N4Hz7OhMhCf6oa7yVGbfQ&access_token=$accessToken'));
      // res = await get(Uri.parse('https://api.spotify.com/v1/recommendations?market=IN&seed_tracks=33jG8BikKNeC0PPDtxluYW&access_token=$accessToken'));

      /* Getting list of albums for front page */
      // res = await get(Uri.parse('https://api.spotify.com/v1/browse/categories?offset=0&limit=20&locale=en-GB%2Cen-US%3Bq%3D0.9%2Cen%3Bq%3D0.8&access_token=$accessToken'));

      // res = await get(Uri.parse('https://api.spotify.com/v1/albums/0JQ5DAudkNjCgYMM0TZXDw?access_token=$accessToken'));
      res = await get(Uri.parse('https://api.spotify.com/v1/search?q=chart&type=album&offset=0&limit=20&access_token=$accessToken'));

    // data = await jsonDecode(res.body);
    if(res.statusCode==200){
      data = jsonDecode(res.body);
      
      print(data);

      /* Get recommendations based on genre or artist */
      // await s.recommendedAlbums(data,lim);

      /* Get album data */
      await s.getAlbumData(data, lim);

      /* Get User's favourite artists */
      // await s.getArtists(data,lim);

      /* Get featured playlists */
      // await s.getPlaylists(data,lim);

      /* Song search */
      // await s.searchSongs(data,lim);
      // await s.searchSongs(data,lim);
      print("correct");
    }else{
      print(res.statusCode);
      if(res.statusCode==401) {
        print(jsonDecode(res.body)['error']['message']);
        if(jsonDecode(res.body)['error']['message']=="The access token expired"){
          await getNewAccessToken();
          await getUserProfile();
        }
        if(jsonDecode(res.body)['error']['message']=="No token provided"){
          print("add '?' sign in place of '&' sign before access_token");
        }
        // print(jsonDecode(res.body));
      }
      if(res.statusCode==400){
        print("api has some fault {bad api request}");
      }
      
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: FloatingActionButton(
      onPressed: () async {
      await getUserProfile();
    },),);
  }
}
