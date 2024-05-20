import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:linkify/widgets/Network/chatting/controller/important_functions.dart';
import 'package:linkify/widgets/Network/chatting/widget/dynamic_file_sender.dart';
import 'package:linkify/widgets/Network/chatting/widget/picked_image_video_screen.dart';
import 'package:linkify/widgets/Network/chatting/widget/picked_video_screen.dart';
import 'package:linkify/widgets/Network/chatting/widget/video_playing_screen.dart';
import 'package:linkify/controller/static_store.dart';
import 'package:linkify/model/user_info.dart';
import 'package:video_player/video_player.dart';

class ImageScreen extends StatefulWidget {
  List<XFile> res;
  int position;
  UserInfo receiverInfo;
  String messageId;
  ImageScreen(this.res, this.position,this.receiverInfo,this.messageId, {super.key});

  @override
  State<ImageScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<ImageScreen> {

  var _counter=0;

  

  @override
  Widget build(BuildContext context) {
    _counter = widget.position;
    // Complete the code in the next step.
    return 
    // Use a FutureBuilder to display a loading spinner while waiting for the
// VideoPlayerController to finish initializing.
        Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
          Navigator.pop(context);
        },),
        title: Text("Image screen"),
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
                  // physics: const NeverScrollableScrollPhysics(),
                  // scrollDirection: Axis.vertical,
                  // scrollDirection: Axis.horizontal,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    // VideoPlayerController _controller;
                    // late Future<void> _initializeVideoPlayerFuture;
                    // _controller.dispose();
                    // if(_controller.value.isBlank==true){
                    //   print("yeah");
            
                    // }
                    // print(_controller);
            
                    // try{
            
                    //   if(StaticStore.videoPlayingIndex!=index){
                    //     if(StaticStore.videoPlayingIndex>=0){
                    //       _controller.dispose();
                    //       _controller = VideoPlayerController.file(File(widget.res[index].path))
                    //         ..initialize().then((value) {
                    //           print("CheckControllerSize:${_controller.value.size}");
                    //           return;
                    //           // return;
                    //         }
                    //       );
                    //       StaticStore.videoPlayingIndex=index;
                    //     }else{
                    //       _controller = VideoPlayerController.file(File(widget.res[index].path))
                    //         ..initialize().then((value) {
                    //           print("CheckControllerSize:${_controller.value.size}");
                    //           return;
                    //         }
                    //       );
                    //       StaticStore.videoPlayingIndex=index;
                    //     }
                    //   }
                    // }
                    // catch(e){
                    //   print("Low device storage");
                    // }
                      // print(_controller.value.aspectRatio);
                      
                      return 
                      Column(
                        children: [
                          Dismissible(
                            resizeDuration: null,
                            onUpdate: (details)  {
                              setState(() {
                                _counter += details.direction == DismissDirection.endToStart ? 1 : -1;
                                // _counter=0;
                          
                          
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
                          
                              // _controller = VideoPlayerController.file(File(widget.res[index].path))
                              //   ..initialize().then((value) {
                              //     print("CheckControllerSize:${_controller.value.size}");
                              //     return;
                              //   }
                              // );
                          
                          
                          
                          
                          
                          
                          
                              // setState(() {
                              //   _counter += direction == DismissDirection.endToStart ? 1 : -1;
                              //   // _counter=0;
                          
                          
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
                            key: ValueKey(_counter),
                            // background: Container(width:200,height:200,color:Colors.white),
                            child: 
                            // ListTile(
                            //   // leading: Text("askdjfbak",style:TextStyle(color: Colors.white,fontSize: 30))
                            //   leading: 
                              Image.file(File(widget.res[_counter].path),width: MediaQuery.of(context).size.width,),
                            // )
                            // SizedBox(),
                            // const Center(
                            //   child: 
                            //   Column(children: [
                            //     // Image.file(File(widget.res[index].path),width: MediaQuery.of(context).size.width,),
                          
                          
                            //     SizedBox(
                            //       // color: Colors.red,
                            //       child: const DecoratedBox(
                            //         decoration: const BoxDecoration(
                            //           color: Colors.red
                            //         ),
                            //       ),
                            //       width:200,
                            //       height:200,
                            //     ),
                          
                          
                          
                            //   // Center(),
                              
                            //   Text(
                            //     // '$_counter',
                            //     "hello",
                            //     style: TextStyle(color:Colors.white,fontSize: 60)
                            //   ),
                            //   ],)
                            // ),
                          ),
                        ],
                      );
            
            
            
                  }),
            ),
          ),
          dynamicSenderFooter(context,widget.receiverInfo,widget.messageId,widget.res),
        ],
      ),
    );
  }
}
