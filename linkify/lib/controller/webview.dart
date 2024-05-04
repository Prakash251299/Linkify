import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:linkify/controller/call_spotify.dart';
import 'package:linkify/controller/caller.dart';
import 'package:linkify/controller/login.dart';
import 'package:linkify/controller/read_write.dart';
import 'package:linkify/controller/get_user_info.dart';
import 'package:linkify/main.dart';
import 'package:linkify/widgets/internetError.dart';
import 'package:linkify/widgets/uis/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:linkify/widgets/webview_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class WebContainer extends StatefulWidget {
  @override
  WebContainerState createState() => WebContainerState();
}
var urlForAuth = "https://accounts.spotify.com/authorize?client_id=80c5fa373a4f4ef793721969b1e25fac&response_type=code&redirect_uri=https://prakash2001.000webhostapp.com/start&show_dialog=true&scope=user-read-private+user-read-email+user-top-read+user-modify-playback-state+user-read-playback-position+user-library-read+streaming+user-read-playback-state+user-read-recently-played+playlist-read-private+user-read-currently-playing";
var clientId = "80c5fa373a4f4ef793721969b1e25fac";
var clientSecret = "a58469d7127d4690ab1dcb4f706c0dbe";
var redirect_uri1 = "https://prakash2001.000webhostapp.com/start";

class WebContainerState extends State<WebContainer> {
  int _dstReached=0;
  var code;

  final ReadWrite _readWrite = ReadWrite();
  WebViewController controller = WebViewController();
  StoreUserInfo _storeUserInfo = StoreUserInfo();
   @override
  void initState() {
    super.initState();
    try{
      // cookieManager.clearCookies();
      print("start auth");
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {
          print("page started");
        },
        onPageFinished: (String url) {
          print("page finished");
        },
        onWebResourceError: (WebResourceError error) {
          print("Probably you are not connected to the internet or your emailid need to be added to spotify developer console for debugging");
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const InternetErrorScrren()));
        },
        onNavigationRequest: (NavigationRequest request) async {
          if (request.url.startsWith("https://prakash2001.000webhostapp.com")) {
            var res = Uri.parse(request.url);
            // Map<String, String> params = res.queryParameters;
            // var er = res.queryParameters['error'];
            // print("QueryParameters: ${res.queryParameters}");
            // print(er);
            code = res.queryParameters['code'];
            print("code");
            // log(code);
            await call(code);
            print("reached");
            setState(() {
              _dstReached = 1;
            });
            return NavigationDecision.prevent;
          }
          print("Errorroror");
          // setState(() {
          //   _errorInAuth = 1;
          // });
          return NavigationDecision.navigate;
        },
      ))
      ..loadRequest(Uri.parse(urlForAuth));
      print("end auth");
    }catch(e){
      print("Hello err");
      // setState(() {
      //       _errorInAuth = 1;
      //     });
    }
  }

  Future<void> call(String code) async {
    await fetchAccessToken(code);
  }

  Future<void> fetchAccessToken(String code) async{
    // String client_id = 'your_client_id';
    // String client_secret = 'your_client_secret';
    // String redirect_uri = 'your_redirect_uri';
    String TOKEN = 'https://accounts.spotify.com/api/token';

    String body = "grant_type=authorization_code";
    // String body = "grant_type=authorization_code";
    body += "&code=$code";
    body += "&redirect_uri=$redirect_uri1";
    body += "&client_id=$clientId";
    body += "&client_secret=$clientSecret";

    callAuthorizationApi(TOKEN, body);
  }

  void callAuthorizationApi(String tokenEndpoint, String body) async {
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

      print("end");

      handleAuthorizationResponse(response);
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> handleAuthorizationResponse(http.Response response) async {
    String access_token="";
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      if (data.containsKey('access_token')) {
        access_token = data['access_token'];
        print("Access token: $access_token");
        await _readWrite.writeAccessToken(access_token);
        // localStorage.setItem("access_token", access_token);
      }
      if (data.containsKey('refresh_token')) {
        String refresh_token = data['refresh_token'];
        print("Refresh token: $refresh_token");
        await _readWrite.writeRefreshToken(refresh_token);
        // localStorage.setItem("refresh_token", refresh_token);
      }
      await _storeUserInfo.fetch_store_user_info();
      // onPageLoad();
    } else {
      print("Error: ${response.statusCode}");
      print(response.body);
      // alert(response.body);
    }
  }


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Flutter Simple Example')),
      // body: WebViewWidget(controller: controller),
      body: 
      _dstReached==0?MyWebView(controller):App(),
    );
  }
  
}