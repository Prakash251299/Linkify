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
    UserInfo? _userInfo = await s.fetchCurrentUserInfo();
    var topTrackGenres = await fetchTopTrackGenres(); // For storing it
    await writeTofirestore(_userInfo);
  }
  Future<UserInfo?> fetchCurrentUserInfo()async{
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
        


        // var topTrackGenres = await fetchTopTrackGenres();


        UserInfo? _userInfo;
        _userInfo = UserInfo.fromJson(data);
        StaticStore.currentUserId = _userInfo.id;
        StaticStore.currentUserName = _userInfo.displayName;
        StaticStore.currentUserEmail=_userInfo.email;
        StaticStore.currentUserCountry=_userInfo.country;
        StaticStore.currentUserImage=_userInfo.image;

        print("user data fetched");


        /* Write conditions for data updating */
        // if(){

        // }
        // await _firebaseCall.writeUserData(
        //   _userInfo,
        //   StaticStore.userGenre
        // );
        // await _firebaseCall.writeSpotifyGenreData(StaticStore.userGenre);

        return _userInfo;
      } else {
        AccessError e = AccessError();
        if(await e.handleError(res)!=1){
          print("Error is not resolved for getting accesstoken in userinfo");
          return null;
        }
      }
    }
  }

  Future<void> writeTofirestore(UserInfo? _userInfo)async{
    FirebaseCall _firebaseCall = FirebaseCall();
    // UserInfo _userInfo;
    // _userInfo = await fetchInfo();
    await _firebaseCall.writeUserData(
          _userInfo!,
          StaticStore.userGenre
        );
        await _firebaseCall.writeSpotifyGenreData(StaticStore.userGenre);
  }
}