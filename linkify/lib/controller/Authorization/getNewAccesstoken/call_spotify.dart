import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:linkify/controller/local_storing/read_write.dart';

String clientId = "80c5fa373a4f4ef793721969b1e25fac";
String clientSecret = "a58469d7127d4690ab1dcb4f706c0dbe";

class CallSpotify {
  ReadWrite _readWrite = ReadWrite();
  String refreshToken = "";
  String accessToken = "";

  Future<int> getNewAccessToken() async {
    refreshToken = await _readWrite.getRefreshToken();
    if (refreshToken == "") {
      print("null refresh token");
      return 2;
    }
    String body = 'grant_type=refresh_token';
    body += '&refresh_token=$refreshToken';
    body += '&client_id=$clientId';

    await callAuthorizationApi(body, clientId, clientSecret);
    return 1;
  }

  Future<void> callAuthorizationApi(
      String body, String clientId, String clientSecret) async {
    String tokenUrl = 'https://accounts.spotify.com/api/token';

    try {
      var response = await http.post(Uri.parse(tokenUrl),
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'Authorization':
                'Basic ${base64.encode(utf8.encode('$clientId:$clientSecret'))}'
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
      if (responseData['access_token'] != null) {
        _readWrite.writeAccessToken(responseData['access_token']);
      } else {
        print("null access token");
      }
      if (responseData['refresh_token'] != null) {
        _readWrite.writeRefreshToken(responseData['refresh_token']);
      } else {
        print("AuthState :null refresh token");
      }
      // Handle successful response
    } else {
      print('Failed to refresh access token: ${response.body}');
      // Handle error response
    }
  }
}
