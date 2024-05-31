import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InternetErrorScreen extends StatelessWidget {
  const InternetErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
          
          Center(
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Probably you are not conneceted to the internet",overflow: TextOverflow.ellipsis,),
                Text("or your emailid need to be added on spotify developer console for debugging",overflow: TextOverflow.ellipsis,),
            ],)
            
          
      ),
    );
  }
}