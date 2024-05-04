import 'dart:convert';

import 'package:linkify/controller/call_spotify.dart';

class AccessError{
  CallSpotify c = CallSpotify();
  Future<int> handleError(var res)async{
      if(res.statusCode==401) {
        print(jsonDecode(res.body)['error']['message']);
        if(jsonDecode(res.body)['error']['message']=="The access token expired"){
          return await c.getNewAccessToken();
          // return 1;
        }
        if(jsonDecode(res.body)['error']['message']=="Invalid access token"){
          return await c.getNewAccessToken();
          // return 1;
          // await getUserProfile();
        }
        if(jsonDecode(res.body)['error']['message']=="No token provided"){
          print("add '?' sign in place of '&' sign before access_token");
        }
        // print(jsonDecode(res.body));
      }
      if(res.statusCode==400){
        print("api has some fault {bad api request}");
      }
      return 0;
  }
}