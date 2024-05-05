// import 'package:linkify/controller/song_data_contoller.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:linkify/controller/caller.dart';
import 'package:linkify/controller/read_write.dart';
import 'package:linkify/controller/webview.dart';
import 'package:linkify/widgets/uis/screens/bottom_nav_bar/bottom_nav_bar.dart';

class LoginPage{
  ReadWrite _readWrite = ReadWrite();
  var loginStatus = 0;
  Future<int> getLoginStatus() async {
    loginStatus =  await _readWrite.getAccessToken()==""?0:1;
    return loginStatus;
  }
  
  Future<void> login(context)async {
    // var logoutState = await get(Uri.parse('https://accounts.spotify.com/en/logout'));
    // print('logoutState: ${logoutState.statusCode}');
    LoginPage loginPage = LoginPage();
    // Navigator.pop(context);
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) => WebContainer()));
    // loginStatus = await _readWrite.getAccessToken()==""?0:1;
    // SongDataController.loginHandler = 1;
    loginStatus = await loginPage.getLoginStatus();
  }
}
