import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class SingleVideoPlayerScreen extends StatefulWidget {
  XFile res;
  SingleVideoPlayerScreen(this.res,{super.key});

  @override
  State<SingleVideoPlayerScreen> createState() => _SingleVideoPlayerScreenState();
}

class _SingleVideoPlayerScreenState extends State<SingleVideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();


    /* For landscape view */
  //   SystemChrome.setPreferredOrientations([
  //     DeviceOrientation.landscapeRight,
  //     DeviceOrientation.landscapeLeft,
  // ]);
    _controller = VideoPlayerController.file(
      File(widget.res.path)
    );

    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    /* Dispose landscape view */
  //   SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.landscapeRight,
  //   DeviceOrientation.landscapeLeft,
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    // Complete the code in the next step.
    return // Use a FutureBuilder to display a loading spinner while waiting for the
// VideoPlayerController to finish initializing.
Scaffold(
  body:
  // body: ListView.builder(
  //   // stream: null,
  //   itemCount: widget.res.length,
  //   itemBuilder: (context, snapshot) {
  //     return 
      Column(
            mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              FutureBuilder(
                future: _initializeVideoPlayerFuture,
                
                builder: (context, snapshot) {
                  
                  if (snapshot.connectionState == ConnectionState.done) {
        //             _controller = VideoPlayerController.file(
        //         File(widget.res[0].path)
        //       );
      
        // _initializeVideoPlayerFuture = _controller.initialize();
                    // If the VideoPlayerController has finished initialization, use
                    // the data it provides to limit the aspect ratio of the video.
                    return Center(
                      child: Container(
                        // padding: EdgeInsets.only(top:300),
                        height: 300,
                        color:Colors.red,
                        child: VideoPlayer(_controller),
                      ),
                    );
                    // return AspectRatio(
                    //   aspectRatio: _controller.value.aspectRatio,
                    //   // Use the VideoPlayer widget to display the video.
                    //   child: VideoPlayer(_controller),
                    // );
                  } else {
                    // If the VideoPlayerController is still initializing, show a
                    // loading spinner.
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  
                },
              ),
              FloatingActionButton(
                onPressed: () {
                  // Wrap the play or pause in a call to `setState`. This ensures the
                  // correct icon is shown.
                  setState(() {
                    // If the video is playing, pause it.
                    if (_controller.value.isPlaying) {
                      _controller.pause();
                    } else {
                      // If the video is paused, play it.
                      _controller.play();
                    }
                  });
                },
                // Display the correct icon depending on the state of the player.
                child: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                ),
              ),
              // Text("hello"),
          Padding(
            padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*90/100),
            child: Padding(
          padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.01),
          child: 
          // Column(children: [
          Row(
                    mainAxisAlignment: MainAxisAlignment.end,
            children: [
      
                    MaterialButton(
                      onPressed: (){},
                      padding:EdgeInsets.only(top:10,left:10,right:5,bottom:10),
                      shape:const CircleBorder(),
                      color:Colors.green,
                      child:Icon(Icons.send,color:Colors.white,size:15),
                    )
            ],
          ),
        )
      ,
          ),
      
      
            ],
          ),
      ],
      ));
    }
  // ),
// );
//   }
  
}