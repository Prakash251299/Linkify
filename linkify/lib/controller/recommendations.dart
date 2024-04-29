import 'dart:convert';

import 'package:http/http.dart';
import 'package:linkify/controller/accesstoken_error.dart';
import 'package:linkify/controller/read_write.dart';
import 'package:http/http.dart' as http;
// import 'package:linkify/controller/static_store.dart';

void callSignOutApi(String tokenEndpoint, String body) async {
  var clientId = "80c5fa373a4f4ef793721969b1e25fac";
  var clientSecret = "a58469d7127d4690ab1dcb4f706c0dbe";
    print("start");

    try {
      var response = await http.post(
        Uri.parse(tokenEndpoint),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Basic ' + base64Encode(utf8.encode('$clientId:$clientSecret'))
        },
        body: body,
      );
      print(response.statusCode);

      print("end");

      // handleAuthorizationResponse(response);
    } catch (e) {
      print("Error: $e");
    }
  }

Future<void> carouselRecommendation(var trackId)async{
  var url = 'https://accounts.spotify.com/api/token';
  var body = '';
  // return;
  trackId = '5PUXKVVVQ74C3gl5vKy9Li';
    ReadWrite _readWrite = ReadWrite();
    while (true) {
      var accessToken = await _readWrite.getAccessToken();
      body+="token=$accessToken";
      body+="token_type_hint=access_token";
      callSignOutApi(url,body);
      // print("Hhhhh");

      /* Fetching album tracks */
      // var res = await get(Uri.parse(
      //   'https://accounts.spotify.com/api/token?access_token=$accessToken'
      //   // 'https://api.spotify.com/v1/recommendations?seed_tracks=$trackId&limit=6&access_token=$accessToken'
      //     ));
      // print(res.statusCode);
      // if (res.statusCode == 200) {
      //   var data = jsonDecode(res.body);

        // for(int i=0;i<data['tracks'].length;i++){
        //   print(data['tracks'][i]['name']);
        // }
        return;
      // } else {
      //   AccessError e = AccessError();
      //   await e.handleError(res);
      // }
    }
  }