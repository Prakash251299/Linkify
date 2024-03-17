import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:linkify/controller/call_spotify.dart';
import 'package:linkify/controller/caller.dart';
import 'package:linkify/controller/login.dart';
import 'package:linkify/controller/song_data_contoller.dart';
import 'package:linkify/controller/webview.dart';
import 'package:linkify/controller/youtube_player.dart';
import 'package:linkify/widgets/cloudSongPage.dart';
import 'package:linkify/widgets/homeNav.dart';
import 'package:linkify/widgets/uis/screens/bottom_nav_bar/bottom_nav_bar.dart';
// import 'package:prac/controller/login.dart';
// import 'package:prac/controller/song_data_contoller.dart';
// import 'package:prac/controller/youtube_player.dart';
// import 'package:prac/widgets/cloudSongPage.dart';
// import 'package:prac/widgets/homeNav.dart';
// import 'package:prac/controller/login.dart';
// import 'package:prac/controller/song_data_contoller.dart';
// import 'package:prac/controller/youtube_player.dart';



// import 'package:linkify/controller/login.dart';
// import 'package:linkify/controller/login.dart';
// import 'package:linkify/controller/song_data_contoller.dart';
// import 'package:linkify/controller/youtube_player.dart';
// import 'package:linkify/model/spotify_caller.dart';
// import 'package:linkify/widgets/cloudSongPage.dart';
// import 'package:linkify/widgets/homeNav.dart';
// import 'package:linkify/widgets/homepage.dart';


// import 'package:youtube_player_flutter/youtube_player_flutter.dart';


// import 'package:linkify/widgets/homepage.dart';
// import 'package:linkify/app.dart';
// import 'package:music_player1/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();



  
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setSystemUIOverlayStyle(
  //   const SystemUiOverlayStyle(
  //     statusBarColor: Colors.blueAccent,
  //   ),
  // );
  // const firebaseConfig = {
  //   apiKey: "AIzaSyBtkJGUpLZz1zSCLFG5xouqzsJfdCohU6U",
  //   authDomain: "linkify-42653.firebaseapp.com",
  //   projectId: "linkify-42653",
  //   storageBucket: "linkify-42653.appspot.com",
  //   messagingSenderId: "560723909414",
  //   appId: "1:560723909414:web:083f845c8a02bbe2fd3fe7"
  // };
// WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
// Initialize Firebase
  // Firebase.initializeApp();
// const app = initializeApp(firebaseConfig);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);


  SongDataController c = SongDataController();
  LoginPage loginController = LoginPage();
  YoutubeSongPlayer _youtubeSongPlayer = YoutubeSongPlayer();



  // SpotifyHandler spotify_handler = SpotifyHandler();
  // String song_type = "cloud_song";
  // String song_type = "device_song";
  
  // Homepage h = Homepage();


  // void initState(){
  //   super.initState();
  // }



  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return 
    MaterialApp(
      // home: 
        // Container(
        //   height: 100,
        //   width: 100,
        //   color: Colors.red,
        // ),
        // MaterialApp(
      title: 'Musive',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Proxima',
        canvasColor: Colors.transparent,
        shadowColor: Colors.transparent,
        highlightColor: Colors.transparent,
        scaffoldBackgroundColor: Colors.black,
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        progressIndicatorTheme: ProgressIndicatorThemeData(
          circularTrackColor: Colors.greenAccent[700],
          color: Colors.greenAccent[400],
          linearMinHeight: 10,
        ),
        textTheme: const TextTheme(
          headline4: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontFamily: 'Proxima Bold',
            fontWeight: FontWeight.w600,
          ),
          bodyText2: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        primarySwatch: Colors.blue,
      ),
      
      
      home:
      Builder(
        builder: (context) => Center(
          child: 
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          ElevatedButton(
            child: Text("Device Song"),
            onPressed: () async => {
              // await spotify_handler.spotify_conn(),






              // if(LoginPage.loginStatus==1){ // Go to login ( implementation pending )
              if(SongDataController.loaded==true){
                // if(await c.getPermission()==1)
                // if(song_type=="cloud_song"){
                //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => CloudPlay())),
                // }else{
                //   if(await c.getLocalSongs()==1)
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeNav())),
                // }
                  // h.loadMusic(),
              }else{
                // await loginController.Login(),

                //  if(song_type=="cloud_song"){
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => CloudPlay())),
                // }else{
                  if(await c.getLocalSongs()==1)
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeNav())),
              }
                // if(await c.getLocalSongs()==1){
                //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeNav())),
                // }
              // }






            },
          ),



          ElevatedButton(
            child: Text("Cloud Songs"),
            onPressed: () async {
              // String? videoId="";
              // _youtubeSongPlayer.playUrl();
              // // videoId = YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=BBAyRBTfsOU");

              // print(videoId);



              // YoutubeSongPlayer yt = YoutubeSongPlayer();
              // yt.youtubePlay("Mahiye jinna sohna");
              if(await loginController.getLoginStatus()==1){
                 Navigator.of(context).push(MaterialPageRoute(builder: (context) => App()));

                 print("Already logged in");
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => YoutubePlayerDemoApp()));
              }else{
                // while(LoginPage.loginStatus==0){
                  // Navigator.pop(context); // For removing previous screen
                  await loginController.Login(context);
                  if(LoginPage.loginStatus==1){
                    print("logged in");

                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => App()));

                      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => YoutubePlayerDemoApp())),
                  }
                  print("again");
                // }
              }






              // if(LoginPage.loginStatus==1){ // Go to login ( implementation pending )
               
              //   // if(await c.getPermission()==1)
              //   if(song_type=="cloud_song"){
              //   }else{
              //     if(await c.getLocalSongs()==1)
              //       Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeNav())),
              //   }
              //     // h.loadMusic(),
              // }else{
              //   await loginController.Login(),
              //    if(song_type=="cloud_song"){
              //       Navigator.of(context).push(MaterialPageRoute(builder: (context) => CloudPlay())),
              //   }else{
              //     if(await c.getLocalSongs()==1)
              //       Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeNav())),
              //   }
              //   // if(await c.getLocalSongs()==1){
              //   //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeNav())),
              //   // }
              // }






            },
          ),
          



          
          ]),







        ),
      ),
    );
    
    
    
    
    // MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    //   home: MaterialApp(
    //     home:
    //   IconButton(
    //     icon: Icon(Icons.next_plan),
    //     onPressed: (){
    //       Navigator.of(context).push(MaterialPageRoute(builder: (context) => Homepage()));
    //     },
      
    //   ),
    //   // Homepage(),
    //   // home:Container(height: 100,width:100,color:Colors.red)
    //   ),
    // );
  }
}
