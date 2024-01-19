import 'package:flutter/material.dart';
import 'package:linkify/controller/login.dart';
import 'package:linkify/controller/login.dart';
import 'package:linkify/controller/song_data_contoller.dart';
import 'package:linkify/widgets/homeNav.dart';
import 'package:linkify/widgets/homepage.dart';
// import 'package:linkify/app.dart';
// import 'package:music_player1/app.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  SongDataController c = SongDataController();
  LoginPage loginController = LoginPage();
  // Homepage h = Homepage();

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return 
    MaterialApp(
      home: Builder(
        builder: (context) => Center(
          child: ElevatedButton(
            child: Text("Click here"),
            onPressed: () async => {
              if(LoginPage.loginStatus==1){ // Go to login ( implementation pending )
                if(await c.getPermission()==1)
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeNav())),
                  // h.loadMusic(),
              }else{
                await loginController.Login(),
                if(await c.getPermission()==1){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeNav())),
                }
              }
            },
          ),
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
