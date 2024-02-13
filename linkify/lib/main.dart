import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:linkify/controller/login.dart';
import 'package:linkify/controller/song_data_contoller.dart';
import 'package:linkify/controller/youtube_player.dart';
import 'package:linkify/widgets/cloudSongPage.dart';
import 'package:linkify/widgets/homeNav.dart';
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

void main() {
  WidgetsFlutterBinding.ensureInitialized();



  
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setSystemUIOverlayStyle(
  //   const SystemUiOverlayStyle(
  //     statusBarColor: Colors.blueAccent,
  //   ),
  // );
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
      home: 
        // Container(
        //   height: 100,
        //   width: 100,
        //   color: Colors.red,
        // ),
      
      
      
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






              if(LoginPage.loginStatus==1){ // Go to login ( implementation pending )
               
                // if(await c.getPermission()==1)
                // if(song_type=="cloud_song"){
                //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => CloudPlay())),
                // }else{
                //   if(await c.getLocalSongs()==1)
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeNav())),
                // }
                  // h.loadMusic(),
              }else{
                await loginController.Login(),
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





              if(LoginPage.loginStatus==1){
                 Navigator.of(context).push(MaterialPageRoute(builder: (context) => CloudPlay()));
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => YoutubePlayerDemoApp()));
              }else{
                await loginController.Login();
                if(LoginPage.loginStatus==1){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => CloudPlay()));
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => YoutubePlayerDemoApp())),
                }
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
