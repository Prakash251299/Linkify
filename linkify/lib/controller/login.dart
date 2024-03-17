// import 'package:linkify/controller/song_data_contoller.dart';

import 'package:flutter/material.dart';
import 'package:linkify/controller/caller.dart';
import 'package:linkify/controller/read_write.dart';
import 'package:linkify/controller/webview.dart';
import 'package:linkify/widgets/uis/screens/bottom_nav_bar/bottom_nav_bar.dart';

class LoginPage{
  ReadWrite _readWrite = ReadWrite();
  static var loginStatus = 0;
  Future<int> getLoginStatus() async {
    loginStatus =  await _readWrite.getAccessToken()==""?0:1;
    return loginStatus;
  }
  
  Future<void> Login(context)async {
    LoginPage loginPage = LoginPage();
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) => WebContainer()));
    // loginStatus = await _readWrite.getAccessToken()==""?0:1;
    // SongDataController.loginHandler = 1;
    loginStatus = await loginPage.getLoginStatus();
  }
}
