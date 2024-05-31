import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:linkify/controller/local_songs/get_local_songs/fetch_localsong.dart';
import 'package:linkify/controller/local_songs/get_local_songs/login.dart';
import 'package:linkify/controller/local_songs/get_local_songs/permission/permission_handler.dart';
import 'package:linkify/controller/variables/static_store.dart';
import 'package:linkify/view/local_music/homeNav.dart';
import 'package:linkify/view/home/bottom_nav_bar.dart';
import 'package:on_audio_query/on_audio_query.dart';

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

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  SongDataController c = SongDataController();
  LoginPage loginController = LoginPage();
  List<SongModel> localSongs = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

      home: Container(
        // backgroundColor: Colors.black,
        decoration: BoxDecoration(
          image: DecorationImage(
            opacity: 0.5,
            colorFilter: ColorFilter.srgbToLinearGamma(),
            image: AssetImage('icon/linkify.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Builder(
          builder: (context) => Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                child: Text("Cloud Songs"),
                onPressed: () async {
                  if (StaticStore.player.playing == true) {
                    StaticStore.player.stop();
                    StaticStore.playing = false;
                    StaticStore.pause = false;
                  }
                  StaticStore.miniplayerMargin = 50;
                  if (await loginController.getLoginStatus() == 1) {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => App()));
                    print("Already logged in");
                  } else {
                    try {
                      await loginController.login(context);
                      if (loginController.loginStatus == 1) {
                        print("logged in");

                        Navigator.pop(context);
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => App()));
                      }
                    } catch (e) {
                      print("something at start went wrong while login");
                    }
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: Text("Device Songs"),
                onPressed: () async {
                  if (StaticStore.player.playing == true) {
                    StaticStore.player.stop();
                    StaticStore.playing = false;
                    StaticStore.pause = false;
                  }
                  StaticStore.miniplayerMargin = 0;
                  if (SongDataController.loaded == true) {
                    localSongs = await readLocalSongs();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HomeNav(localSongs)));
                  } else {
                    if (await c.getLocalSongs() == 1) {
                      localSongs = await readLocalSongs();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HomeNav(localSongs)));
                    }
                  }
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
