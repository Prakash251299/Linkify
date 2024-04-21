import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:video_player/video_player.dart';

class PickedImageVideo extends StatelessWidget {
  List<XFile> res;
  PickedImageVideo(this.res,{super.key});

  late VideoPlayerController _controller;

  @override
  void videoPlay(var index) {
    // super.initState();
    _controller = VideoPlayerController.file(
      File(res[index].path)
    )
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        // setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return 
    
    
    SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(icon:Icon(LineIcons.arrowLeft), onPressed: () {
            Navigator.pop(context);
          },),
          title: Text("Image Video Screen"),
        ),
        body: 
        Container(
          height: MediaQuery.of(context).size.height*3/4,
          // width: MediaQuery.of(context).size.width,
          // child: ClipRect(
            child: 
            ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: res.length,
            itemBuilder: ((context, index) {
              // bool last = list.length == (index + 1);
              return Container(
                height: MediaQuery.of(context).size.height*3/4,
          // width: MediaQuery.of(context).size.width,
                // width: MediaQuery.of(context).size.width,
                // child: 
                // Padding(
                  // padding: EdgeInsets.only(
                  //   left: 8,
                  //   // right: last ? 16 : 0,
                  //   // right: 16,
                  // ),
                  child: 
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
      
                      Image.file(File(res[index].path),width: MediaQuery.of(context).size.width,),
                      // SizedBox(width: 8),
                      // Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
      
                      //     ]),
                      // Spacer(),
                    ],
                  ),
                // ),
              );
            }),
          )
            // Image.file(File(res[0].path)),
          // ),
        ),
      ),
    );
  }
}