import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:linkify/widgets/Network/chatting/controller/important_functions.dart';
import 'package:linkify/widgets/Network/chatting/widget/chat_screen.dart';
import 'package:linkify/widgets/Network/chatting/widget/dynamic_file_sender.dart';
import 'package:linkify/widgets/Network/chatting/widget/picked_image_screen.dart';
import 'package:linkify/widgets/Network/chatting/widget/picked_image_video_screen.dart';
import 'package:linkify/widgets/Network/chatting/widget/video_playing_screen.dart';
import 'package:linkify/controller/static_store.dart';
import 'package:linkify/model/user_info.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  List<XFile> res;
  int position;
  UserInfo receiverInfo;
  String messageId;
  VideoScreen(this.res,this.position,this.receiverInfo,this.messageId, {super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  // late List<VideoPlayerController> _controller;
  // late List<Future<void>> _initializeVideoPlayerFuture;
  late VideoPlayerController _controller;
  // late Future<void> _initializeVideoPlayerFuture;
  var _counter = 0;

  @override
  void initState() {

    _controller = VideoPlayerController.file(File(widget.res[widget.position].path))
                      ..initialize().then((value) {
                        print("CheckControllerSize:${_controller.value.size}");
                        // return;
                        // return;
                      }
                    );
    super.initState();

    /* For landscape view */
    //   SystemChrome.setPreferredOrientations([
    //     DeviceOrientation.landscapeRight,
    //     DeviceOrientation.landscapeLeft,
    // ]);
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
    _counter = widget.position;
    return 
        Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
          Navigator.pop(context);
          
        },),
        title: Text("video screen"),
      ),
      body: 
      
      Column(
        children: [
          Expanded(
            child: Container(
              // color: Colors.yellow,
            
              width: MediaQuery.of(context).size.width,
              // width: 300,
              height: 500,
              child: ListView.builder(
                  // stream: null,
                  physics: const NeverScrollableScrollPhysics(),
                  // scrollDirection: Axis.vertical,
                  // scrollDirection: Axis.horizontal,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                      return 
            
                      // AspectRatio(
                      //     aspectRatio: 16 / 9,
                      //     child: VideoPlayer(
                      //         _controller
                      //     ),
                      // );
                      // VideoPlayer(_controller);
            
            
            
                      Column(
                        children: [
                          Dismissible(
                            resizeDuration: null,
                            onUpdate:(details) async {
                          
                              
                          
                          
                          
                          
                          
                            //   // _controller.dispose();
                            //   Navigator.pop(context);
                          
                          
                            //   // _controller = await VideoPlayerController.file(File(widget.res[_counter].path))
                            //   //   ..initialize();
                            //   //   .then((value) {
                            //   //     print("CheckControllerSize:${_controller.value.size}");
                            //   //     return;
                            //   //   }
                            //   // );
                              setState(() {
                                _counter += details.direction == DismissDirection.endToStart ? 1 : -1;
                              });
                              if(_counter<0){
                                // _counter+=DismissDirection.none
                                setState(() {
                                  _counter = widget.res.length-1;
                                  // _counter = 0;
                          
                                });
                              }
                              if(_counter>widget.res.length-1){
                                setState(() {
                                  _counter = 0;
                                  // _counter = widget.res.length-1;
                                });
                              }
                          
                              // Navigator.pushAndRemoveUntil(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (BuildContext context) =>
                              //           VideoScreen(widget.res,_counter)),
                              // (Route<dynamic> route) => false);
                          
                              if(videoExtensions.contains(fileType(widget.res[_counter].path))){
                              Navigator.pop(context);
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => VideoScreen(widget.res,_counter,widget.receiverInfo,widget.messageId)));
                              }
                              if(imageExtensions.contains(fileType(widget.res[_counter].path))){
                              Navigator.pop(context);
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ImageScreen(widget.res,_counter,widget.receiverInfo,widget.messageId)));
                              }
                          
                            },
                            onDismissed: (DismissDirection direction) {
                          
                              // _controller.dispose();
                              
                          
                          
                              // _controller = await VideoPlayerController.file(File(widget.res[_counter].path))
                              //   ..initialize();
                              //   .then((value) {
                              //     print("CheckControllerSize:${_controller.value.size}");
                              //     return;
                              //   }
                              // // );
                              // setState(() {
                              //   _counter += direction == DismissDirection.endToStart ? 1 : -1;
                              // });
                              // if(_counter<0){
                              //   // _counter+=DismissDirection.none
                              //   setState(() {
                              //     _counter = widget.res.length-1;
                              //   });
                              // }
                              // if(_counter>widget.res.length-1){
                              //   setState(() {
                              //     _counter = 0;
                              //   });
                              // }
                              // Navigator.pop(context);
                              // Navigator.of(context).push(MaterialPageRoute(builder: (context) => VideoScreen(widget.res,_counter)));
                          
                              // Navigator.pushAndRemoveUntil(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (BuildContext context) =>
                              //           VideoScreen(widget.res,_counter)),
                              // (Route<dynamic> route) => false);
                          
                              // });
                          
                              // _controller.dispose();
                          
                              // _controller = VideoPlayerController.file(File(widget.res[_counter].path))
                              //   ..initialize().then((value) {
                              //     print("CheckControllerSize:${_controller.value.size}");
                              //     return;
                              //   }
                              // );
                              // setState(() {
                              //   _counter += direction == DismissDirection.endToStart ? 1 : -1;
                              // });
                              // if(_counter<0){
                              //   // _counter+=DismissDirection.none
                              //   setState(() {
                              //     _counter = widget.res.length-1;
                              //   });
                              // }
                              // if(_counter>widget.res.length-1){
                              //   setState(() {
                              //     _counter = 0;
                              //   });
                              // }
                            },
                            // key: ValueKey(_counter),
                            key: ValueKey(_counter),
                            // background: Container(width:200,height:200,color:Colors.white),
                            child: 
                            
                            // Column(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 16 / 9,
                                      child: 
                                      
                                      VideoPlayer(
                                          _controller
                                      ),
                                    ),
                          
                          
                          
                          
                          
                          
                                    FloatingActionButton(
                                  onPressed: () {
                                    // Wrap the play or pause in a call to `setState`. This ensures the
                                    // correct icon is shown.
                                    try{
                                    setState(() {
                                      // If the video is playing, pause it.
                                      if (_controller.value.isPlaying) {
                                        _controller.pause();

                                      } else {
                                        // If the video is paused, play it.
                                        // if(StaticStore.videoPlayingIndex!=index){
                                        //   StaticStore.videoPlayingIndex=index;
                                        //   _controller.dispose();
                                        // }

                          
                                        _controller.play();
                                        // StaticStore.playing=false;
                                        // StaticStore.pause=true;
                                        // _controller.dispose();
                                      }
                                    });
                                    }catch(e){
                                      print("Low device storage");
                                    }
                                  },
                                  // Display the correct icon depending on the state of the player.
                                  child: Icon(
                                    _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                                  ),
                                ),
                          
                          
                          
                          
                          
                          
                                  ],
                                ),
                            //   ],
                            // ),
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          
                          ),
                        ],
                      );
            
            
            
            
            
            
            
            
            
            
            
            
                      // Stack(
                      //   alignment: Alignment.center,
                      //   children: [
                      //     Center(
                      //       child:GestureDetector(
              
                      //                   child: Container(
                      //                     // padding: EdgeInsets.only(top:300),
                      //                     height: 300,
                      //                     width: MediaQuery.of(context).size.width,
                      //                     color:Colors.red,
                      //                     child: VideoPlayer(_controller),
                      //                   ),
                                        
                      //                   onHorizontalDragUpdate:(details) {
                      //                     new Dismissible(
                      //                       resizeDuration: null,
                      //                       onDismissed: (DismissDirection direction) {
                      //                         setState(() {
                      //                           _counter += direction == DismissDirection.endToStart ? 1 : -1;
                      //                         });
                      //                       },
                      //                       key: new ValueKey(_counter),
                      //                       child: new Center(
                      //                         child: new Text(
                      //                           '$_counter',
                      //                           style: Theme.of(context).textTheme.displaySmall,
                      //                         ),
                      //                       ),
                      //                     );
            
            
            
            
                      //                   // onHorizontalDragUpdate:(details) {
                      //                   //   _controller.dispose();
                      //                   //   _controller = VideoPlayerController.file(File(widget.res[index].path))
                      //                   //     ..initialize().then((value) {
                      //                   //       print("CheckControllerSize:${_controller.value.size}");
                      //                   //       return;
                      //                   //     }
                      //                   //   );
                      //                   //   print(index);
                      //                   },
                      //                 ),
                                      
                      //     ),
                      //     FloatingActionButton(
                      //         onPressed: () {
                      //           // Wrap the play or pause in a call to `setState`. This ensures the
                      //           // correct icon is shown.
                      //           try{
                      //           setState(() {
                      //             // If the video is playing, pause it.
                      //             if (_controller.value.isPlaying) {
                      //               _controller.pause();
                      //             } else {
                      //               // If the video is paused, play it.
                      //               // if(StaticStore.videoPlayingIndex!=index){
                      //               //   StaticStore.videoPlayingIndex=index;
                      //               //   _controller.dispose();
                      //               // }
            
                      //               _controller.play();
                      //               // _controller.dispose();
                      //             }
                      //           });
                      //           }catch(e){
                      //             print("Low device storage");
                      //           }
                      //         },
                      //         // Display the correct icon depending on the state of the player.
                      //         child: Icon(
                      //           _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                      //         ),
                      //       ),
              
                      //   ],
                      // );
            
            
            
            
              
                  }),
            ),
          ),
          dynamicSenderFooter(context,widget.receiverInfo,widget.messageId,widget.res),

        ],
      ),
    );
  }
}
