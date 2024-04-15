import 'dart:convert';

import 'package:http/http.dart';
import 'package:linkify/controller/accesstoken_error.dart';
import 'package:linkify/controller/firebase_call.dart';
import 'package:linkify/controller/read_write.dart';
import 'package:linkify/controller/static_store.dart';
import 'package:linkify/controller/user_genre.dart';
import 'package:linkify/model/user_info.dart';

class StoreUserInfo{
  Future<void> fetch_store_user_info()async{
    StoreUserInfo s = StoreUserInfo();
    await s.fetchInfo();
  }
  Future<List<String>> fetchInfo()async{
    FirebaseCall _firebaseCall = FirebaseCall();
    var accessToken = "";
    ReadWrite _readWrite = ReadWrite();
    while (true) {
      accessToken = await _readWrite.getAccessToken();
      print("Hhhhh");

      /* Fetching user info */
      var res = await get(Uri.parse('https://api.spotify.com/v1/me?access_token=$accessToken'));
      
      print("userinfo: ${res.statusCode}");
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        


        var topTrackGenres = await fetchTopTrackGenres();


        UserInfo? _userInfo;
        _userInfo = UserInfo.fromJson(data);
        // StaticStore._userInfo = userInfo;
        StaticStore.currentUserId = _userInfo.id;
        StaticStore.currentUserName = _userInfo.displayName;
        StaticStore.currentUserEmail=_userInfo.email;
        StaticStore.currentUserCountry=_userInfo.country;
        StaticStore.currentUserImage=_userInfo.image;
        // print(_userInfo.image);
        // return [];

        // try to fetch only one image here
        // StaticStore.currentUserImage=_userInfo.image?[0]['url']; 

        print("user data fetched");
        
        // print(StaticStore._userInfo.id);
        // return topTrackGenres;


        /* Write conditions for data updating */
        // if(){

        // }
        await _firebaseCall.writeUserData(
          _userInfo,
          // data['display_name'],
          // data['id'],
          // data['email'],
          // data['country'],
          // data['userImg'],
          StaticStore.userGenre
        );
        await _firebaseCall.writeSpotifyGenreData(StaticStore.userGenre);

        return topTrackGenres;
      } else {
        AccessError e = AccessError();
        if(await e.handleError(res)!=1){
          print("Error is not resolved for getting accesstoken in userinfo");
          return [];
        }
      }
      // return;
    }
  }
}