import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InternetErrorScrren extends StatelessWidget {
  const InternetErrorScrren({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
          
          Center(child:
              Text("Probably you are not conneceted to the internet",overflow: TextOverflow.ellipsis,),
            
          
      ),
    );
  }
}