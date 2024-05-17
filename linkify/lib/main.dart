import 'package:audio_session/audio_session.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:linkify/controller/login.dart';
import 'package:linkify/controller/song_data_contoller.dart';
import 'package:linkify/controller/static_store.dart';
import 'package:linkify/controller/youtube_player.dart';
import 'package:linkify/widgets/homeNav.dart';
import 'package:linkify/widgets/uis/screens/bottom_nav_bar/bottom_nav_bar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();



  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );



  
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  @override
  State<MyApp>createState()=>MyAppState();
}

class MyAppState extends State<MyApp> {
  // MyApp({Key? key}) : super(key: key);


  SongDataController c = SongDataController();
  LoginPage loginController = LoginPage();



  @override
  void initState() {
    super.initState();
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarColor: Colors.black,
    // ));
    // _init();
  }

  // var songUrl = "https://rr4---sn-ci5gup-jj0s.googlevideo.com/videoplayback?expire=1715624577&ei=IQZCZp2YDY-KjuMP4Z6PuAw&ip=110.225.105.62&id=o-AKaEqpA-Ap5_FW67WpI40whr5YmiOGi-a1acqVBlwKbb&itag=139&source=youtube&requiressl=yes&xpc=EgVo2aDSNQ%3D%3D&mh=wc&mm=31%2C29&mn=sn-ci5gup-jj0s%2Csn-ci5gup-h55d&ms=au%2Crdu&mv=m&mvi=4&pl=21&gcr=in&initcwndbps=1520000&vprv=1&svpuc=1&mime=audio%2Fmp4&rqh=1&gir=yes&clen=1304588&dur=213.809&lmt=1713597429269325&mt=1715602615&fvip=1&keepalive=yes&c=ANDROID_TESTSUITE&txp=5532434&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cxpc%2Cgcr%2Cvprv%2Csvpuc%2Cmime%2Crqh%2Cgir%2Cclen%2Cdur%2Clmt&sig=AJfQdSswRgIhAKI2azqv8h-0o0Or6s2gIJpbvczeyamGsqT7rbcB-Q4qAiEAtK7mRASnZ7x4L7m4QTgFmQhECKAti4z7fqm_uhSE4B8%3D&lsparams=mh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Cinitcwndbps&lsig=AHWaYeowRQIgKXv4yQJSrMFuKb_9TbRi1mUhN4hicy-Lf4or9iO-644CIQCXeBHZBKwhGzrJVXbqoJM2lJU10Ijqbz6royP9m5s-9w%3D%3D";

  // YoutubeSongPlayer _player = YoutubeSongPlayer();

  // Future<void> _init(var songUrl) async {
  //   final session = await AudioSession.instance;
  //   await session.configure(const AudioSessionConfiguration.speech());
  //   // Listen to errors during playback.
  //   StaticStore.player.playbackEventStream.listen((event) {},
  //       onError: (Object e, StackTrace stackTrace) {
  //     print('A stream error occurred: $e');
  //   });
  //   try {
  //     await StaticStore.player.setAudioSource(AudioSource.uri(
  //       Uri.parse(songUrl),
  //       tag: MediaItem(
  //       // Specify a unique ID for each media item:
  //       id: '1',
  //       album: "Album name",
  //       title: "Song name",
  //       artUri: Uri.parse('https://example.com/albumart.jpg'),
  //     ),
  //     ));
  //     StaticStore.player.play();

  //     // _player.youtubePlay("Mahiye jinna sohna","");
  //   } catch (e, stackTrace) {
  //     // Catch load errors: 404, invalid url ...
  //     print("Error loading playlist: $e");
  //     print(stackTrace);
  //   }
  // }

  @override
  void dispose(){
    super.dispose();
  }



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
      title: 'Linkify',
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





              if(SongDataController.loaded==true){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeNav())),
              }else{
                  if(await c.getLocalSongs()==1)
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeNav())),
              }






            },
          ),



          ElevatedButton(
            child: Text("Cloud Songs"),
            onPressed: () async {
              if(await loginController.getLoginStatus()==1){
                 Navigator.of(context).push(MaterialPageRoute(builder: (context) => App()));






                 print("Already logged in");
              }else{
                try{
                  await loginController.login(context);
                  if(loginController.loginStatus==1){
                    print("logged in");

                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => App()));
                  }
                }catch(e){
                    print("something at start went wrong while login");
                }
              }





            },
          ),
          



          
          ]),







        ),
      ),
    );
    
    
      }
}
