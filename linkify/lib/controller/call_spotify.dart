import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:linkify/controller/read_write.dart';


String clientId = "80c5fa373a4f4ef793721969b1e25fac";
String clientSecret = "a58469d7127d4690ab1dcb4f706c0dbe";


class CallSpotify extends StatelessWidget {
  // String accessToken;
  CallSpotify({super.key});
  ReadWrite _readWrite = ReadWrite();
  String refreshToken="";
  String accessToken="";


  // import 'dart:convert';
// import 'package:http/http.dart' as http;

Future<void> getNewAccessToken() async {
  // String? refreshToken = window.localStorage['refresh_token'];
  // String clientId = 'YOUR_CLIENT_ID'; // Replace 'YOUR_CLIENT_ID' with your actual client ID
  // String clientSecret = 'YOUR_CLIENT_SECRET'; // Replace 'YOUR_CLIENT_SECRET' with your actual client secret

  refreshToken = await _readWrite.getRefreshToken();

  String body = 'grant_type=refresh_token';
  body += '&refresh_token=$refreshToken';
  body += '&client_id=$clientId';

  await callAuthorizationApi(body, clientId, clientSecret);
}

Future<void> callAuthorizationApi(String body, String clientId, String clientSecret) async {
  String tokenUrl = 'https://accounts.spotify.com/api/token'; // Replace 'TOKEN' with your authorization token URL

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
      print("null refresh token");
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
      res = await get(Uri.parse('https://api.spotify.com/v1/recommendations?access_token=$accessToken'));
    // data = await jsonDecode(res.body);
    if(res.statusCode==200){
      data = jsonDecode(res.body);
      
      print(data);
      print("correct");
    }else{
      print(res.statusCode);
      if(res.statusCode==401) {
        await getNewAccessToken();
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
