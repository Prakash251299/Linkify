import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:linkify/controller/login.dart';
import 'package:linkify/controller/song_data_contoller.dart';
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

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  SongDataController c = SongDataController();
  LoginPage loginController = LoginPage();

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
        // textTheme: const TextTheme(
        //   headline4: TextStyle(
        //     color: Colors.white,
        //     fontSize: 24,
        //     fontFamily: 'Proxima Bold',
        //     fontWeight: FontWeight.w600,
        //   ),
        //   bodyText2: TextStyle(
        //     fontSize: 16,
        //     color: Colors.white,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
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
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                child: Text("Cloud Songs"),
                onPressed: () async {
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
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) => App()));
                      }
                    } catch (e) {
                      print("something at start went wrong while login");
                    }
                  }
                },
              ),

              SizedBox(height: 20,),
              ElevatedButton(
                child: Text("Device Songs"),
                onPressed: () async => {
                  if (SongDataController.loaded == true)
                    {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => HomeNav())),
                    }
                  else
                    {
                      if (await c.getLocalSongs() == 1)
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => HomeNav())),
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
