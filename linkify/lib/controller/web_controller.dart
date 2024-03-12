import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
// import 'package:url_launcher/url_launcher_string.dart';
// import 'package:linkify/widgets/webview.dart';
import 'package:webview_flutter/webview_flutter.dart';
// import 'package:http/http.dart' as http;

class WebContainer extends StatefulWidget {
  @override
  WebContainerState createState() => WebContainerState();
}

class WebContainerState extends State<WebContainer> {
  late WebViewController controller;
  int _dstReached=0;
  var urlForAuth = "https://accounts.spotify.com/authorize?client_id=80c5fa373a4f4ef793721969b1e25fac&response_type=code&redirect_uri=https://prakash2001.000webhostapp.com/start&show_dialog=true&scope=user-read-private+user-read-email+user-modify-playback-state+user-read-playback-position+user-library-read+streaming+user-read-playback-state+user-read-recently-played+playlist-read-private";
  var urlForToken = "https://accounts.spotify.com/api/token?grant_type=authorization_code&code=AQBU_qYcx9RV3cEuyF2R076xjHP6rhXE6oTeLGqGx_8iAbgntju9cRT1r38WSIn9QsZFioQS5Li-D2XBzxn8Ub8AoOmM1i_MGolV0qMCFF-48Qxb0q_AzvqlYGNwqRl4GUUGjaWqrHS17iK1ptI5LJpAS0Z4Xi046vNvb1wlpEDBrgEL_31kwT3y4QboX8bzfBwNfNU9dEHmCzqkcEXScsFmnmU2FHHR1t1DkIpr51Mt1BBo_rdBE9qvbUTXT-5kTEBXKMO33wKMvTS0VMrJPsWga5VZJy9gfbsoanES2FH32jlfCa1v0hYsU56wrLeJxAk14mjxH38KqQjFm6YWOanY_ZKRhSuCqAx9yTkMYasSQSlOmXypXwjipoQ5PxM8SqBvMPHsFUxGg9OyAcZyN9OM859WDjRAdXMXw9lEd8A2R5SMYDzkRK8_&redirect_uri=https://webauthspotify.web.app/&client_id=80c5fa373a4f4ef793721969b1e25fac&client_secret=a58469d7127d4690ab1dcb4f706c0dbe";
  // var urlForToken = "https://accounts.spotify.com/api/token";
  var clientId = "80c5fa373a4f4ef793721969b1e25fac";
  var clientSecret = "a58469d7127d4690ab1dcb4f706c0dbe";
  // var redirect_uri1 = "https://localhost:8888/callback";
  // var redirect_uri1 = "http://127.0.0.1:5500/SpotifyWebAuth/SpotifyWebAPI/index.html";
  // var redirect_uri1 = "https://www.google.com";
  // var redirect_uri1 = "https://jp251299.000webhostapp.com/linkify.js";
  // var redirect_uri1 = "https://oauth.pstmn.io/v1/callback/";
  // var redirect_uri1 = "com.example.linkify://login-callback";
  // var redirect_uri1 = "https://ishuapp/start";
  var redirect_uri1 = "https://prakash2001.000webhostapp.com/start";
  var code;






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

  void handleAuthorizationResponse(http.Response response) {
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      if (data.containsKey('access_token')) {
        String access_token = data['access_token'];
        print("Access token: $access_token");
        // localStorage.setItem("access_token", access_token);
      }
      if (data.containsKey('refresh_token')) {
        String refresh_token = data['refresh_token'];
        print("Refresh token: $refresh_token");
        // localStorage.setItem("refresh_token", refresh_token);
      }
      // onPageLoad();
    } else {
      print("Error: ${response.statusCode}");
      print(response.body);
      // alert(response.body);
    }
  }



  Future<void> call() async {
    await fetchAccessToken(code);
    // await tokenUrl();
    // print(a);
    // String credentials = '$clientId:$clientSecret';
    // print(await base64Encode(utf8.encode(credentials)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WebView'),
      ),
      body: 
      _dstReached==0?
      WebView(
        javascriptMode: JavascriptMode.unrestricted,
        // javascriptMode: JavascriptMode.unrestricted,
        // initialUrl:"https://www.google.com",
        // initialUrl:"https://webauthspotify.web.app/",
        // initialUrl:"https://accounts.spotify.com/en/login",
        initialUrl: urlForAuth,
        // initialUrl: "https://webauthspotify.web.app",
        //  launchUrlString(_url,mode: launchMode.externalApplication),
        onWebViewCreated:(controller) async {
          this.controller = controller;
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyWebView(controller)));
        },
        onPageStarted: (url){
          print("web: $url");
        },
        onWebResourceError: (error){
          print("Webview error: $error");
        },
        navigationDelegate: (NavigationRequest request) async {
          // print(request.runtimeType);
          print("Herereere: ");
          var url1 = await controller.currentUrl();
          // print(url1);
          // var a = await get(Uri.parse("${controller.currentUrl()}"));
          // print(a.body);
          if (request.url.startsWith("https://prakash2001.000webhostapp.com")) {
            var res=Uri.parse(request.url);
            // http.get(Uri.parse(request.url)).then((value) => {
            //   //  res = value.body,

            //   print(jsonDecode(jsonDecode(value.body)['code'])),
            // });
            Map<String, String> params = res.queryParameters;
            // var k = jsonEncode(params);
            code = await res.queryParameters['code'];
            // print(code);
            await call();
            // await tokenUrl();
            // print(k);
            print("reached");
            setState(() {
                _dstReached = 1;
            });
            // do not navigate
            // controller.goBack();
            return NavigationDecision.prevent;
          }

            // return NavigationDecision.prevent;
          return NavigationDecision.navigate;
        }
      ):
      SizedBox(),


      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){
      //     controller.loadUrl("https://www.youtube.com");
      //   }
      // ),
    );
  }
}