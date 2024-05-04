import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:linkify/controller/read_write.dart';
import 'package:linkify/main.dart';

Future<void> callSignOutApi(context)async{
  ReadWrite _readWrite = ReadWrite();
  try {
    var a = await get(Uri.parse('https://accounts.spotify.com/en/logout'));
    print("logoutStatuscode: ${a.statusCode}");
    await _readWrite.writeAccessToken("");
    await _readWrite.writeRefreshToken("");
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyApp()));
    return ;
  } catch (e) {
    print("Error while login after logout");
  }
}