

// import 'dart:convert';
// // import 'dart:ffi';
// // import 'dart:io';
// import 'dart:math';

// // import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// // import 'package:flutter/services.dart' as Services;
// // import 'package:flutter/foundation.dart';
// // import 'package:oauth2_client/google_oauth2_client.dart';
// // import 'package:oauth2_client/oauth2_client.dart';
// // import 'package:audioplayers/audioplayers.dart';
// import 'package:cryptography/cryptography.dart';
// import 'package:flutter/material.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/services.dart';
// // import 'package:flutter_web_auth/flutter_web_auth.dart';
// // import 'package:get/get.dart';
// // import 'package:flutter/foundation.dart';
// // import 'package:get/get.dart';
// import 'package:http/http.dart';
// import 'package:just_audio/just_audio.dart';
// // import 'package:oauth2_client/oauth2_helper.dart';
// // import 'package:oauth2_client/google_oauth2_client.dart';
// // import 'package:oauth2_client/oauth2_helper.dart';
// // import 'package:path_provider/path_provider.dart';
// // import 'package:just_audio/just_audio.dart';
// import 'package:spotify/spotify.dart';
// import 'package:url_launcher/url_launcher.dart';
// // import 'package:url_launcher/src/url_launcher_uri.dart';
// // import 'package:url_launcher/url_launcher.dart';
// import 'package:youtube_explode_dart/youtube_explode_dart.dart';
// // import 'package:crypto/crypto.dart';
// import 'package:http/http.dart' as http;

// class SpotifyHandler{
//   var clientId = "80c5fa373a4f4ef793721969b1e25fac";
//   var clientSecret = "a58469d7127d4690ab1dcb4f706c0dbe";
//   var albumId = "2Hog1V8mdTWKhCYqI5paph";
//   // var redirect_uri1 = "http://127.0.0.1:62454/Ec2aYbQgp3c=/";
//   // var redirect_uri1 = "http://127.0.0.1:54591/f-EFACcR0zY=/callback";
//   // var redirect_uri1 = "https://localhost:8888/callback";
//   // var redirect_uri1 = "http://127.0.0.1:5500/SpotifyWebAuth/SpotifyWebAPI/index.html";
//   // var redirect_uri1 = "https://www.google.com";
//   // var redirect_uri1 = "https://jp251299.000webhostapp.com/linkify.js";
//   // var redirect_uri1 = "https://oauth.pstmn.io/v1/callback/";
//   // var redirect_uri1 = "com.example.linkify://login-callback";
//   var redirect_uri1 = "https://ishuapp/start";
//   // var redirect_uri1 = "https://linkify-42653.firebaseapp.com/callback";
//   var authUrl = "https://accounts.spotify.com/authorize?client_id=80c5fa373a4f4ef793721969b1e25fac&response_type=code&redirect_uri=https://ishuapp/start&show_dialog=true&scope=user-read-private+user-read-email+user-modify-playback-state+user-read-playback-position+user-library-read+streaming+user-read-playback-state+user-read-recently-played+playlist-read-private";

//   var scope = 'user-read-private user-read-email';
//   var myAccessToken = 'BQBlrrFFK_hyxmOpmoc11gjxxtLJxXR35nfUv1-sb6DbiOhnFg1S9ASZ8JGk1YVNPFv9kIFDq5IiyBddXYSR1O2PO9yRPT79eCW-fWi43SkNBd3VGreMASTocAeAJenSA7IgC8a4JJYhSAZt-cMsnW6UsX7LfwNgARqSsM77xOPWOOGbxgWlYhUbzWlXe1ZuBlGWuMsJab2UjkKveP3cZA';
//   // var token = "BQD1Ae47LNqRqKe3zT9ypoZVl9yvLfb1lRZu94QCL1ypJt1GPs4JByIaCzcT4W57_g66UbVnmh4s-7k0jTdyVXIktgyiTlihoGlLKFIyZhCflY-SZDU";
  
//   // var token = "BQBPfmiLWxXwJduBVAlnUB19Si8OMWIAwvkbv7DfTuDydcRMJqIdnAerVoeewQ4lf-v_bLb_uEakhM9rjkkftwJ6nyRwG36zGhkrxCciw9usS_Q5B_0";


//   var player =  AudioPlayer();
//   // var _player = AudioPlayer();
//   // final player = AudioPlayer();                   // Create a player
//   // Future<void> plays() async {
//   //   var url = "";
//   //   await _player.setUrl('url');
//   //   _player.play();  
//   // }
//   var playing = false;
//   var paused = false;

//   var songName = "Mahiye jinna sohna";
//   var authorize = 'https://accounts.spotify.com/en/authorize?response_type=code&client_id=80c5fa373a4f4ef793721969b1e25fac&scope=user-read-private%20user-read-email&redirect_uri=http://127.0.0.1:62454/Ec2aYbQgp3c=/';
//   var tokenEndpoint = "https://accounts.spotify.com/api/token";




//   Future<void> spotify_conn()async{
    
//     // var url = Uri.parse(redirectToAuthorization1(clientId, scope, redirect_uri1));
//     // Uri url = await redirectToAuthorization1(clientId, scope, redirect_uri1);
//     // var res = await get(url);
//     // print(res.body);

//     var url = Uri.parse("https://webauthspotify.web.app/");
//     // var url = Uri.parse(authUrl);

//     if (await canLaunchUrl(url)) {
//       await launchUrl(url).then((value){
//         // print(value.runtimeType);
//         print("hello");
//       });
//     }

//     // var url = Uri.parse('https://webauthspotify.web.app');
//     // if (await canLaunchUrl(url)) {
//     //   await launchUrl(url).then((value){
//     //     print("hello");
//     //     // handleCallback('');
//     //   });
//     // }

//   }



//   // Future<void> spotify_conn()async{
//   //   // Present the dialog to the user
//   //   final result = await FlutterWebAuth.authenticate(
//   //     url:
//   //         "https://accounts.spotify.com/authorize?client_id=$clientId&redirect_uri=yourname:/&scope=user-read-currently-playing&response_type=token&state=123",
//   //     callbackUrlScheme: "https://partyai:/callback",
//   //   );

//   // // Extract token from resulting url
//   //   final token = Uri.parse(result);
//   //   String at = token.fragment;
//   //   at = "http://website/index.html?$at"; // Just for easy persing
//   //   var accesstoken = Uri.parse(at).queryParameters['access_token'];
//   //   print('token');
//   //   print(accesstoken);
//   // }



//   // Build the authorization URL
//   Uri buildTokenUrl(String clientId, String scope, String redirect_uri1) {
//     String credentials = '$clientId:$clientSecret';
//     String basicAuth = 'Basic ' + base64Encode(utf8.encode(credentials));
//     final params = {
//       // 'code':code,
//       'headers' :{
//         'Content-Type': 'application/x-www-form-urlencoded',
//         'Authorization': basicAuth,
//       },
//       // 'code_challenge_method': 'S256',
//       // 'code_challenge': codeChallenge,
      
//       'redirect_uri': redirect_uri1,
//     };

//     return Uri.https('accounts.spotify.com', '/authorize', params);
//   }




//   // Uri buildAuthorizationUrl1(String clientId, String scope, String redirect_uri1) {
//   //   final params = {
//   //     'response_type': 'code',
//   //     'client_id': clientId,
//   //     'scope': scope,
//   //     // 'code_challenge_method': 'S256',
//   //     // 'code_challenge': codeChallenge,
      
//   //     'redirect_uri': redirect_uri1,
//   //   };

//   //   return Uri.https('accounts.spotify.com', '/authorize', params);
//   // }

//   // Redirect the user
//   Future<Uri> redirectToAuthorization1(String clientId, String scope, String redirect_uri1) async {
//     // final url = buildAuthorizationUrl1(clientId, scope, redirect_uri1);
//     // print(url);
//     var url = Uri.parse("");
//     return url;
    
//     // if (await canLaunchUrl(url)) {
//     //   await launchUrl(url);
//     //   // return true;
//     // } 
//     // else {
//     //   // Handle the case where the URL cannot be launched
//     //   return false;
//     // }
//   }

//   // Future<void>fun()async{
//   // vredirectUri = 'your_redirect_uri'; // Replace with your actual redirect URI
//   // const clientId = 'your_client_id'; // Replace with your Spotify client ID
//   // const clientSecret = 'your_client_secret'; // Replace with your Spotify client secret

//   void handleCallback(var code) async {
//       var params = {
//         'code': 'AQAeDDLRQ3yOfMsxsZPsvUh29hu2ENnOh-zIfLV6x45VQ4w03Uu-3PsxUnzNEyvrmqhsov0iUPC5NJr6309S_4Y946rGBLJIm8FVEVGIbud3tNAOaxoC__c59od9-xhG4dZ46FSHeBISjlEVeVoloRoEd8iV6eHGL7de1Hyabn8rE0OwwW2tDwzmM7uOu2uPwKKeJz8RlcLxAzDn3-iiy851FTqDgEY',
//         'redirect_uri': redirect_uri1,
//         'grant_type': 'authorization_code',
//       };

//       try {
//         final tokenResponse = await http.post(
//           Uri.parse('https://accounts.spotify.com/api/token'),
//           headers: {
//             'Content-Type': 'application/x-www-form-urlencoded',
//             'Authorization':
//             'Basic ODBjNWZhMzczYTRmNGVmNzkzNzIxOTY5YjFlMjVmYWM6YTU4NDY5ZDcxMjdkNDY5MGFiMWRjYjRmNzA2YzBkYmU='
//                 // 'Basic ${base64Encode(Uint8List.from(utf8.encode('$clientId:$clientSecret')))}',
//           },
//           body: Uri(queryParameters: params).toString(),
//         );

//         if (tokenResponse.statusCode == 200) {
//           // final tokenData = jsonDecode(tokenResponse.body);
//           print("Done");
//           // Handle successful token exchange, e.g., store tokens or redirect
//         } else {
//           // Handle error, e.g., log error, redirect with error message
//           print("Wait little more to go");
//           print("${tokenResponse.statusCode}");
//         }
//       } on Exception catch (e) {
//         // Handle exception, e.g., log error, redirect with error message
//         print("little bit");
//       }
//     }
//   // }
//   // }


//   // Future<void> authenticate() async {
//   //   final authFlow = AuthorizationCodeFlow(
//   //     clientId: clientId,
//   //     scopes: ['streaming'],
//   //     redirectUri: redirectUri,
//   //     authorizationEndpoint: Uri.parse('https://accounts.spotify.com/authorize'),
//   //     tokenEndpoint: Uri.parse('https://accounts.spotify.com/api/token'),
//   //   );

//   //   // Initiate authentication
//   //   final result = await authFlow.authorizeAndExchangeCode();

//   //   // Handle the response
//   //   if (result.error != null) {
//   //     print('Error during authentication: ${result.error}');
//   //     // Handle error (e.g., display message to user)
//   //   } else {
//   //     final accessToken = result.accessToken;
//   //     // Store access token securely
//   //     // ... Use the access token for Spotify API calls
//   //   }
//   // }

// //   import 'package:oauth2_client/google_oauth2_client.dart';
// // import 'package:oauth2_client/oauth2_helper.dart';

// // class Oauth2ClientExample {
//   // Oauth2ClientExample();

//   // Future<void> fetchFiles(Uri url) async {
//   //   var hlp = OAuth2Helper(
//   //     GoogleOAuth2Client(
//   //         redirectUri: 'com.example.linkify:/oauth2redirect',
//   //         customUriScheme: 'com.example.linkify'),
//   //     grantType: OAuth2Helper.authorizationCode,
//   //     clientId: clientId,
//   //     clientSecret: clientSecret,
//   //     scopes: ['user-read-private user-read-email'],
//   //   );

//   //   var resp = await hlp.get('${url.toString()}');

//   //   print(resp.statusCode);
//   // }
// // }


// //   import 'package:flutter_auth_code_flow/flutter_auth_code_flow.dart';

// // final clientId = 'YOUR_CLIENT_ID';




//   // import 'package:oauth2_client/oauth2_client.dart';

//   // final clientId = 'YOUR_CLIENT_ID';
//   // final clientSecret = 'YOUR_CLIENT_SECRET';
//   // final redirectUri = Uri.parse('yourcustomprotocol://callback'); // Replace with your redirect URI

//   // Create a custom Spotify client
//   // var scope1 = 'user-read-private user-read-email';
//   // var clientId = "80c5fa373a4f4ef793721969b1e25fac";
//   // var clientSecret = "a58469d7127d4690ab1dcb4f706c0dbe";
//   // Future<void> fetch(Uri url)async{
//   //   var hlp = OAuth2Helper(
//   //       GoogleOAuth2Client(
//   //           // redirectUri: 'com.example.linkify:/oauth2redirect',
//   //           redirectUri: 'com.example.linkify://login-callback',
//   //           customUriScheme: 'com.example.linkify'),
//   //       grantType: OAuth2Helper.authorizationCode,
//   //       clientId: '80c5fa373a4f4ef793721969b1e25fac',
//   //       clientSecret: 'a58469d7127d4690ab1dcb4f706c0dbe',
//   //       scopes: ['user-read-private user-read-email'],
//   //   );
//   //   var resp = await hlp.get(url.toString());
//   //   print(resp);
//   // }



//   void onPageChange(_, Uri? uri, __) {
//     var url = uri.toString();
//     if (url.contains('success')) {
//       //close browser using navigator pop and send him to some flutter screen
//     } else if (url.contains('cancelled')) {
//       //close browser using navigator pop and send him to some flutter screen
//     }
//   }

//   Future<void> spotify_conn4()async{
//     Uri url = await redirectToAuthorization1(clientId, scope, redirect_uri1);
//     // final response = await http.post(Uri.parse(url.toString()));
//     // var url = "http";
//     if (await canLaunchUrl(url)) {
//       await launchUrl(url).then((value){
//         print("hello");

//         // handleCallback('');
//       });
//       // await closeWebView();
//     }
//     // print(response.body);

//     // Uri url = Uri.parse('$url&action=login');

//       // final responce = await http.post(url,
//       //     body: ({
//       //       'client_id': clientId,
//       //       'client_secret': clientSecret,
//       //     }));

//       // final responceData = json.decode(response.body);
//       // print(responceData);



//     // var responseData = await json.decode(response.body);
//     // print(responseData);
//     // print("h");

//     // String s = await evalJS();
//     // print(s);



//     // var res = await get(Uri.parse(url.toString()));
//     // print(res.body);
//     // var a = await initUniversalLinks();
   




//     // await fetch(url);
//     // https://accounts.spotify.com/authorize?response_type=code&client_id=80c5fa373a4f4ef793721969b1e25fac&scope=user-read-private%20user-read-email&redirect_uri=https%3A%2F%2Foauth.pstmn.io%2Fv1%2Fcallback


//     // https://localhost:8000/callback?code=AQAeDDLRQ3yOfMsxsZPsvUh29hu2ENnOh-zIfLV6x45VQ4w03Uu-3PsxUnzNEyvrmqhsov0iUPC5NJr6309S_4Y946rGBLJIm8FVEVGIbud3tNAOaxoC__c59od9-xhG4dZ46FSHeBISjlEVeVoloRoEd8iV6eHGL7de1Hyabn8rE0OwwW2tDwzmM7uOu2uPwKKeJz8RlcLxAzDn3-iiy851FTqDgEY


//     // var res = await get(Uri.parse(url.toString()));
//     // print(url);
//     // var res = await http.get(url);
//     // print(res.body);
//     // print(redirect_uri1);
//     // import 'dart:convert';


//     // final Uri uri = Uri.parse(redirect_uri1); // Replace 'redirectUrl' with the actual URL
//     // final Map<String, String> queryParams = uri.queryParameters;

//     // print(queryParams);
//     // final String code = queryParams['code'];

//     // await fetchFiles(url);


//     // final response = await client.get(url);
//     // var r = await get(Uri.parse(redirect_uri1.toString()));
//     // print(r.body);

//     // final Uri uri = Uri.parse(res.body.toString()); // Assuming 'queryString' is a String containing the URL

//     // final Uri uri = res.body; // Assuming 'queryString' is a String containing the URL

//     // final Map<String, String> queryParams = uri.queryParameters;
//     // print(queryParams);
//     // final String code = queryParams['code'];


//     // var k = await get(Uri.parse("https://accounts.spotify.com/api/token/Content-Type=application/x-www-form-urlencoded&client_id=$clientId&grant_type=authorization_code&code=$code&redirect_uri=$redirect_uri1"));
//     // print(res);


//     // url = Uri.https();


//     // if (await canLaunchUrl(url)) {
//     //   await launchUrl(url).then((value){
//     //     print("hello");
//     //     // handleCallback('');
//     //   });
//     // }



//     // else {
//     //   // Handle the case where the URL cannot be launched
//     //   // return;
//     // }




//     // var res = await get(Uri.parse(url.toString()));
//     // print(res.body);
//     // handleCallback(res.body);
//     // write(res.body);
//     // read();
//   }




















  

//   String _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789AB';

//   Future<String> generateRandomString(int length) async{
//     var r = Random();
//     // final random = r; // Use cryptographically secure random generator
//     // print(r.nextInt());
//     return String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(r.nextInt(_chars.length))));
//   }

//   String base64encode(List<int> input) {
//     // print(input);

//     // Encode as a string to handle UTF-8 characters
//     final encoded = utf8.encode(String.fromCharCodes(input));
//     // final base64Input = base64Url.encode(input);
//     // print(base64Input);

//     // Perform base64 encoding with URL-safe characters
//     final base64 = base64Url.encode(encoded);
//     // print(base64);

//     // Remove padding and replace special characters
//     return base64.replaceAll('=', '').replaceAll('+', '-').replaceAll('/', '_');
//   }

//   // var digest;
//   // Future<List<int>> sha256(String plain) async {
//   Future<String> sha256fun(String plain) async {
//     final encoded = utf8.encode(plain); // Encode plain text as UTF-8 bytes
//     // digest = await sha256(plain); // Hash using SHA-256 algorithm
//     // await sha256.hashCode(encoded); // Hash using SHA-256 algorithm
//     // print(plain);
//     // final digest = sha256.convert(encoded);
//     final algorithm = Sha256();
//     final hash = await algorithm.hash(encoded);
//     // var a = String.fromCharCodes(hash.bytes);
//     print(hash);
//     // print('Hash: ${hash.bytes.length}');
//     var res = await base64encode(hash.bytes);
//     // print(res.length);
//     return res;
//   }




// // Build the authorization URL
// Uri buildAuthorizationUrl(String clientId, String scope, String codeChallenge, String redirectUri) {
//   final params = {
//     'client_id': clientId,
//     'response_type': 'code',
//     'scope': scope,
//     'code_challenge_method': 'S256',
//     'code_challenge': codeChallenge,
//     'redirect_uri': redirect_uri1,
//   };

//   return Uri.https('accounts.spotify.com', '/authorize', params);
// }

// // Redirect the user
// Future<String> redirectToAuthorization(String clientId, String scope, String codeChallenge, String redirectUri) async {
//   final url = buildAuthorizationUrl(clientId, scope, codeChallenge, redirectUri);
//   // print(url);
//   return url.toString();

//   // if (await canLaunchUrl(url)) {
//   //   await launchUrl(url);
//   //   // return true;
//   // } 
//   // else {
//   //   // Handle the case where the URL cannot be launched
//   //   return false;
//   // }
// }

//   // Future<Map<String, dynamic>> fetchToken(String clientId, String code, String redirectUri, String codeVerifier) async {
//   Future<void> fetchToken(String clientId, String code, String redirect_uri1, String codeVerifier) async {
//     String url = tokenEndpoint;
//     final params = {
//       'client_id': clientId,
//       'client_secret': clientSecret,
//       'grant_type': 'authorization_code',
//       'redirect_uri': redirect_uri1,
//       'code_verifier': codeVerifier,
//       // 'code_verifier': clientSecret,
//       'code': code,
//     };

//     // final body = Uri(queryParameters: params).toString();
//     final body = Uri(queryParameters: params).toString();
//     // print(body);
//     try{
//       // var k = await get(Uri.parse("https://accounts.spotify.com/api/token/Content-Type=application/x-www-form-urlencoded&client_id=$clientId&grant_type=authorization_code&code=$code&redirect_uri=$redirect_uri1&code_verifier=$codeVerifier"));
//       // print(k.statusCode);

//       var h = await http.post(
//         Uri.parse(url),
//         headers: {'Content-Type': 'application/x-www-form-urlencoded',},
//         body: body
//       );
//       print(h.statusCode);

//     }
//     catch(e){
//       print("Not working");
//     }

//     // var p2 = {
//     //   'Content-Type': 'application/x-www-form-urlencoded',
//     //   'body': body.toString(),
//     // };
    
//     // final response = await http.post(
//     //   Uri.parse(url),
//     //   headers: {'Content-Type': 'application/x-www-form-urlencoded'},
//     //   body: body,
//     // );

//     print("gettingToken");
//     // print(response.body);

//     // if (response.statusCode == 200) {
//     //   return jsonDecode(response.body) as Map<String, dynamic>;
//     // } else {
//     //   // Handle error
//     //   throw Exception('Failed to fetch token: ${response.statusCode}');
//     // }
//   }

//   Future<void> getAccessToken(String code, var codeVerifier)async{
//     try {
//       final tokenResponse = await fetchToken(clientId, code, redirect_uri1, codeVerifier);
//       // Use the access token from the response
//       // print(tokenResponse['access_token']);
//     } catch (error) {
//       print(error); // Handle errors appropriately
//     }
//   }
  

//   Future<void> spotify_conn2()async{
//     final credentials = SpotifyApiCredentials(clientId, clientSecret);
//     final spotify = SpotifyApi(credentials);
//     var cr = await spotify.getCredentials();
//     var accessToken = cr.accessToken;
//     // print(accessToken);
//     String codeVerifier="",code_challenge="";
//     // codeVerifier = await generateRandomString(64);
//     // code_challenge = await sha256fun(codeVerifier);
//     // print(code_challenge);


//     codeVerifier = _chars;
//     print(codeVerifier);
//     // code_challenge = await sha256fun(codeVerifier);
//     // var hash = '180EFA1CD028FB62950D3E535632C471D0DC92486413A656237C971C78CC28A0';
//     // code_challenge = 'MTgwRUZBMUNEMDI4RkI2Mjk1MEQzRTUzNTYzMkM0NzFEMERDOTI0ODY0MTNBNjU2MjM3Qzk3MUM3OENDMjhBMA';
//     // print(code_challenge);

//     // 180EFA1CD028FB62950D3E535632C471D0DC92486413A656237C971C78CC28A0
//     // 180EFA1CD028FB62950D3E535632C471D0DC92486413A656237C971C78CC28A0


//     // code_challenge = '180EFA1CD028FB62950D3E535632C471D0DC92486413A656237C971C78CC28A0';

//     code_challenge = 'GA76HNAo-2KVDT5TVjLEcdDckkhkE6ZWI3yXHHjMKKA';




//     /* This is the authorization link which is working fine */
//     var authLink = await redirectToAuthorization(clientId, scope, code_challenge, redirect_uri1);
//     // print(authLink);
//     try{
//       var auth_code = await get(Uri.parse(authLink));
//       // print(auth_code.headers);
//       getAccessToken(auth_code.body,codeVerifier);

//       // var probableAccessToken = '013acda7192cc245850388c54a95f2aed070a7935831373039363038313433313038';

//     }
//     catch(e){
//       print("access is denied");
//     }

    




//   }


//   // getProfile(accessToken) async {
//     // var accessToken = localStorage.getItem('access_token');

//     // const response = await fetch('https://api.spotify.com/v1/me', {
//     //   headers: {
//     //     Authorization: 'Bearer ' + accessToken
//     //   }
//     // });

//     // const data = await response.json();
//   // }



//   // await SpotifySdk.connectToSpotifyRemote(clientId: "", redirectUrl: "")
//   // Future<void> spotify_conn()async {
//   //   try {
//   //     await SpotifySdk.play(spotifyUri: 'spotify:track:58kNJana4w5BIjlZE2wq5m');
//   //   } on PlatformException catch (e) {
//   //     // setStatus(e.code, message: e.message);
//   //   } on MissingPluginException {
//   //     // setStatus('not implemented');
//   //   }
//   // }





//   Future<void> spotify_conn1()async {
    
//     // if(playing==true){
//     //   player.stop();
//     // }
//     // var artist = "shad";
//     // print("hello");
//     final credentials = SpotifyApiCredentials(clientId, clientSecret);
//     final spotify = SpotifyApi(credentials);
//     var cr = await spotify.getCredentials();
//     var accessToken = cr.accessToken;
//     // print(accessToken);

//     var trackId="";
//     final tracks = await spotify.tracks.get('6rWblGW0pBcB3uygxBuWZV');
//     // print(tracks);
//     // final tracks = await spotify.tracks;
//     // final tracks = await spotify.browse.newReleases().first().then((v) => print(v.items?.elementAt(18).name));
//     // final tracks = await spotify.categories.newReleases().first().then((v) => print(v.items?.elementAt(18).name));
//     // final tracks = await spotify.albums.get(albumId);
//     // final tracks = await spotify.albums.getTracks(albumId).all();





//     /* track at specific index in album */
//     // final tracks = await spotify.albums.tracks(albumId).all();
//     // for(int i=0;i<tracks.length;i++){
//     //   print(tracks.elementAt(i).name);
//     // }



//     /* Playlists */
//     // var a=[];
//     // var featuredPlaylists = await spotify.playlists.featured.all();
//     // featuredPlaylists.forEach((playlist) {
//     //   a.add(playlist.name);
//     //   // print(playlist.owner?.displayName);
//     // });
//     // print(a);


//     /* Tracks */
//     // var a=[];
//     // var tracks = await spotify.tracks;
//     // featuredPlaylists.forEach((playlist) {
//     //   a.add(playlist.owner?.country);
//     //   // print(playlist.owner?.displayName);
//     // });

//     // print(tracks);

//     // print(tracks.length);






//     /* For lyrics of a song */

//     // var songName = "Mahiye jinna Sohna";
//     // var songId = 
//     // get(Uri.parse("https://api.spotify.com/v1/search?q=track:"' + despacito + '"%20artist:"' + bieber + '"&type=track")).then((res) {
//     // get(Uri.parse("https://api.spotify.com/v1/search?q=track:")).then((res) {
//     //   var data = res.body;
//     //   print(data);
//     // });

//     // get(Uri.parse("https://paxsenixofc.my.id/server/getLyricsMusix.php?q=${tracks.elementAt(0).name}&type=default")).then((res) {
//     // get(Uri.parse("https://paxsenixofc.my.id/server/getLyricsMusix.php?q=${songName}&type=default")).then((res) {
//     // get(Uri.parse("https://paxsenixofc.my.id/server/getMusix.php?q=${songName}&type=default")).then((res) {
//     //   String data = res.body;
//       // var list = data.split('\n').map((e)=>e).toList();
//       // print(list);
//     // });




//     /* Recommendation */
//   //   get(Uri.parse('https://api.spotify.com/v1/recommendations?seed_artists=4NHQUGzhtTLFvgF5SZesLK&seed_genres=classical%2Ccountry&seed_tracks=0c6xIDDpzE81m2q797ordA'
//   // 'Bearer 1POdFZRZbvb...qqillRxMr2z')).then((res) {
//   //     String data = res.body;
//   //     // var list = data.split('\n').map((e)=>e).toList();
//   //     print(data);
//   //   });








    




//     // get(Uri.parse('https://accounts.spotify.com/api/token')).then((res) {
//     //   String data = res.body;
//     //   // var list = data.split('\n').map((e)=>e).toList();
//     //   print(data);
//     // });





//     // var accessToken = "";
//     // get(Uri.parse ('https://api.spotify.com/v1/search?q=remaster%2520track%3ADoxy%2520artist%3AMiles%2520Davis&type=album',
//     //   --Headers:accessToken
//     // )).then((res) {
//     //   print(res.body);
//     // });






//     // var accessToken = await spotify.(clientId: clientId, redirectUrl: "https://github.com/Prakash251299/Linkify", scope: "app-remote-control,user-modify-playback-state,playlist-read-private");

    






//     /* Authorize */
//     // await 'https://accounts.spotify.com/authorize?client_id=80c5fa373a4f4ef793721969b1e25fac&redirect_uri=https://github.com/Prakash251299/Linkify';
//     // var myProfile;
//     // get(Uri.parse('https://api.spotify.com/v1/me')).then((r) {
//     //   myProfile = r.body;
//     // });
//     // print(myProfile);


//     // print(spotify.me.follow());
    

//     // if(accessToken!=null){
//     //   // print(spotify.users.playlists(spotify.me as String));
//     // // }
//     // get(Uri.parse ('https://api.spotify.com/v1/search?q=remaster%2520track%3ADoxy%2520artist%3AMiles%2520Davis&type=album?&Authorization:"Bearer%201POdFZRZbvb...qqillRxMr2z"?access_token=$accessToken')).then((r) {
//     //   print(r.body);
//     // });
//     // }else{
//     //   print("no");
//     // }



//     // get(Uri.parse('https://accounts.spotify.com/authorize?client_id=80c5fa373a4f4ef793721969b1e25fac&redirect_uri=https://github.com/Prakash251299/Linkify')).then((r){
//     //   print(r.body);
//     // });



//     // const authOptions = {
//     //   method:'POST',
//     //   headers:{
//     //     'Content-Type':'application/x-www-form-urlencoded',
//     //     'Authorization': 'Basic ($clientId)
//     //   }
//     // }


//     // get(Uri.parse('https://accounts.spotify.com/api/access_token=$accessToken')).then((r) => print(r.body));


//     // print(cr.refreshToken);


//     // get(Uri.parse('https://api.spotify.com/v1/search?q=remaster%2520track%3ADoxy%2520artist%3AMiles%2520Davis&type=track&access_token=$accessToken')).then((r){
//     //   print(r.body);
//     // });








//     /* Access song with access token */


//     // var player = AudioPlayer();

//     // String songName="Mahiye jinna";
    
//     // print(spotify.me);
//     // var t = await spotify.me.topTracks();
//     // var da =t.all();
//     // print(da);
//     // final user = jsonDecode(data) as Map<String, dynamic>;

//     try{
//       print(accessToken);

//     // await get(Uri.parse('https://api.spotify.com/v1/search?query=remaster%2520recommendations&type=playlist&access_token=$accessToken&limit=8')).then((r) async {




//     await get(Uri.parse('https://api.spotify.com/v1/search?query=remaster%2520recommendations&type=track&access_token=$accessToken&limit=1')).then((r) async {


    
//       // print(r);
//       var data =r.body;
//       final user = jsonDecode(data) as Map<String, dynamic>;
//       // print(user['tracks']['items'][0]['id']);
//       // var trackLink = user['tracks']['items'][0]['href'];
//       // print(user);










//     // await get(Uri.parse('https://api.spotify.com/v1/search?query=remaster%2520track%3A$songName&type=track&access_token=$accessToken&limit=1')).then((r) async {

//     // await get(Uri.parse('https://api.spotify.com/v1/search?query=remaster%2520track%3A$songName%2520artist%3AArijit&type=track&access_token=$accessToken&limit=1')).then((r) async {
//     // await get(Uri.parse('https://api.spotify.com/v1/search?query=remaster%2520track%3A$songName%2520artist%3AArijit%2520include_external=audio&type=track&access_token=$accessToken&limit=1')).then((r) async {


//       // var data =r.body;
//       // final user = jsonDecode(data) as Map<String, dynamic>;
//       // // print(user['tracks']['items'][0]['id']);
//       // var trackLink = user['tracks']['items'][0]['href'];
//       // print(trackLink);


















//       // print(trackId);
//       // await play(spotifyUri: '$trackId',asRadio: true);

//       // print(tracks.href);




//       // var url = 'https://api.spotify.com/v1/tracks/$trackId';



//       // var url = '${tracks.href}&access_token=$accessToken';
//       // final player = AudioPlayer();                   // Create a player
//       // final duration = await player.setUrl(tracks.href as String);                 // Schemes: (https: | file: | asset: )
//       // player.play();



//       // await player.setAudioSource(AudioSource.uri(Uri.parse(url)));
//       // await player.play(UrlSource('$url'));
//       // player.play();

//       // print(s);
//       // print('We sent the verification link to ${user['email']}.');


//       // print(r.body);
//       // var list = data.split('\n').map((e)=>e).toList();
//       // print(list);






//       // handle_play(accessToken);


//       /* Youtube player */
//       // final res;
//     });

//     var auth_code;
//     await get(Uri.parse(authorize)).then((value) async => {
//       print("authenticated"),
//       print(value.body.toString()),
//       auth_code = value.body.toString(),
//     },);


//     print("Start");
//     var acc = await get(Uri.parse('https://accounts.spotify.com/en-GB/api/token/response_type=code&redirect_uri=http://127.0.0.1:62454/Ec2aYbQgp3c=/&grant_type=$auth_code&content-type=application/x-www-form-urlencoded&client_id=80c5fa373a4f4ef793721969b1e25fac&client_secret=a58469d7127d4690ab1dcb4f706c0dbe'));
//     // print(acc.body);

//     await get(Uri.parse('https://api.spotify.com/v1/me/following?type=artist&access_token=$acc')).then((r) {
//          var data = r.body;
//          print(data);
//       });
//     print("End");


//     }catch(e){
//       print("Error getting values from spotify");
//     }







//     /* For playing songs using youtube api */
//     // youtubePlay(songName); 









//   }











//   Future<void> youtubePlay(String songName) async {
//     if(songName!=""){
//         try{
//           final yt = YoutubeExplode();
//           // final querySuggestions = (await yt.search.getQuerySuggestions(songName)).first;
//           final video = (await yt.search.search(songName)).first;
//           // print(video);
//           final videoId = video.id.value;
//           var manifest = await yt.videos.streamsClient.getManifest(videoId);
//           var audio = await manifest.audioOnly.first;
//           // SongDataController.songList.add(audio as SongModel);
//           var audioUrl = await audio.url;
//           print(audioUrl);
//           // await player.play(UrlSource(audioUrl.toString()));
//           await player.setUrl(audioUrl.toString());
//           player.play();





//           // await player.play(UrlSource('https://open.spotify.com/track/2FCXQHugkoHE1K3tiDu8pu'));
//         }
//         catch(e){
//           print("e");
//         }
//       }
//   }


//   // Future<void> play(var trackId) async {
//   //   try {
//   //     // await SpotifySdk.play(spotifyUri: 'spotify:track:58kNJana4w5BIjlZE2wq5m');
//   //     await SpotifySdk.play(spotifyUri: '$trackId');
//   //   } catch(e){
//   //     print("Error occured");
//   //   }
//   // }



//   void handle_play(var accessToken) async {
//     // await SpotifySdk.connectToSpotifyRemote(clientId: "80c5fa373a4f4ef793721969b1e25fac", redirectUrl: "https://github.com/Prakash251299/Linkify");
//     // SpotifySdk.subscribePlayerState();
//     // SpotifySdk.subscribePlayerContext();
//     // final accessToken = ;
//     // SpotifySdkPlugin.tokenSwapURL = 'https://example.com/api/spotify/token';
//     // SpotifySdkPlugin.tokenRefreshURL = 'https://example.com/api/spotify/refresh';
//     // play(spotifyUri: 'https://api.spotify.com/v1/tracks/0Jiaz0O4AqnJICa9PxHhaR',asRadio: false);



//   }

//   // Future play({
//   //   required String spotifyUri,
//   //   bool asRadio = false,
//   // }) async {
//   //   try {
//   //     const MethodChannel _channel =
//   //     MethodChannel(MethodChannels.spotifySdk);
//   //     await _channel.invokeMethod(MethodNames.play, {
//   //       ParamNames.spotifyUri: spotifyUri,
//   //       ParamNames.asRadio: asRadio,
//   //     });
//   //   } on Exception catch (e) {
//   //     // print(MethodNames.play);
//   //     rethrow;
//   //   }
//   // }





//   /* For read write */
//   // Future<String> get _localPath async {
//   //   final directory = await getApplicationDocumentsDirectory();
//   //   // print(directory.path);
//   //   return directory.path;
//   // }

//   // Future<File> get _localFile async {
//   //   final path = await _localPath;
//   //   // final path = '/Users/amankumarsaw/Documents/Prakash/project/linkify/lib';
//   //   // print(path);
//   //   return File('$path/test.txt');
//   // }

//   // // /data/data/com.example.linkify/app_flutter/test.txt

//   // Future<File> write(String s) async {
//   //   final file = await _localFile;

//   //   // Write the file
//   //   return file.writeAsString('$s');
//   // }

//   // Future<void> read() async {
//   //   try {
//   //     final file = await _localFile;

//   //     // Read the file
//   //     final contents = await file.readAsString();
//   //     print(contents);
//   //     // return int.parse(contents);
//   //   } catch (e) {
//   //     // If encountering an error, return 0
//   //     return;
//   //   }
//   // }
// }