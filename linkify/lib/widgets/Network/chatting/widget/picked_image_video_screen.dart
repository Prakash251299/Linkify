import 'dart:io';

// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:linkify/widgets/Network/chatting/controller/important_functions.dart';
import 'package:linkify/widgets/Network/chatting/widget/dynamic_file_sender.dart';
import 'package:linkify/widgets/Network/chatting/widget/picked_image_screen.dart';
import 'package:linkify/widgets/Network/chatting/widget/picked_video_screen.dart';
import 'package:linkify/controller/firebase_call.dart';
import 'package:linkify/controller/static_store.dart';
import 'package:linkify/model/user_info.dart';
// import 'package:video_player/video_player.dart';


// import 'package:video_player/video_player.dart';
// import 'package:flutter_video_view/flutter_video_view.dart';

class PickedImageVideo extends StatefulWidget {
  List<XFile> res;
  UserInfo receiverInfo;
  String messageId;

  PickedImageVideo(this.res,this.receiverInfo,this.messageId,{super.key});
  // PickedImageVideo(this.widget.res,{super.key});

  @override
  State<PickedImageVideo> createState() => _PickedImageVideoState();
}

List<String> videoExtensions = ['.mp4','.wav'];
List<String> imageExtensions = ['.jpg','.jpeg','.png'];

class _PickedImageVideoState extends State<PickedImageVideo> {

// class PickedImageVideo extends StatelessWidget {
  // late List<XFile> widget.res;
    // late VideoPlayerController _controller;
    // late Future<void> _initializeVideoPlayerFuture;
    
  // @override
  // void initState(){
  //   _controller = VideoPlayerController.file(
  //     File(widget.res[0].path),
  //   );

  //   _initializeVideoPlayerFuture = _controller.initialize();
  // }

  FirebaseCall _firebaseCall = FirebaseCall();
  TextEditingController _textController = TextEditingController();



  @override
  void dispose() {
    /* Dispose landscape view */
  //   SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.landscapeRight,
  //   DeviceOrientation.landscapeLeft,
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
    // _controller.dispose();

    super.dispose();
  }

  // String fileType(var path){
  //   // final path = '/some/path/to/file/file.dart';
  //   String extension = p.extension(path);
  //   return extension;
  // }

  @override
  Widget build(BuildContext context) {
    return 
    
    
    SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   leading: IconButton(icon:Icon(LineIcons.arrowLeft), onPressed: () {
        //     StaticStore.videoPlayingIndex=-1;
        //     Navigator.pop(context);
        //   },),
        //   title: Text("Image Video Screen"),
        // ),
        body: 
        
        Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height*3/4,
                  child: 
                  videoExtensions.contains(fileType(widget.res[0].path))?VideoScreen(widget.res,0,widget.receiverInfo,widget.messageId):imageExtensions.contains(fileType(widget.res[0].path))?ImageScreen(widget.res,0,widget.receiverInfo,widget.messageId):SizedBox(), // keep here warning of not supported file type
                  // VideoScreen(widget.res)
              
              ),
            ),



            // dynamicSenderFooter(context,widget.receiverInfo,widget.messageId),





            
    // Padding(
    //   padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.01),
    //   child: 
    //   // Column(children: [
    //   Row(
    //     children: [

    //       Expanded(
    //         child: Card(
    //           shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(15)),
    //           child: Row(children: [
    //             IconButton(onPressed: (){},
    //               icon: Icon(Icons.emoji_emotions,color:Colors.blueAccent),
    //             ),
          
    //             Expanded(
    //               child: TextField(
    //                 keyboardType: TextInputType.multiline,
    //                 controller: _textController,
    //                 maxLines: null,
    //                 decoration: InputDecoration(
    //                   hintText: "Input...",
    //                   hintStyle: TextStyle(color:Colors.blueAccent),
    //                   border: InputBorder.none,
    //                 ),
    //               ),
    //             ),
          
    //             MaterialButton(
    //               onPressed: () async {
    //                 // print("message send option clicked");
    //                 if(_textController.text.isNotEmpty){
    //                   // print(_textController.text);
    //                   // Timestamp t;
    //                   // var t = DateTime.fromMillisecondsSinceEpoch(1713196304253);
    //                   int t = DateTime.now().millisecondsSinceEpoch;
    //                   var mes = {
    //                     "message":_textController.text,
    //                     "timestamp":t,
    //                     "sender":StaticStore.currentUserId,
    //                     "receiver":widget.receiverInfo.id,
    //                     "status":"sent",
    //                     "type":"text"
    //                   };
    //                   // var k = MesInfo.fromJson(mes);
    //                   // print(k.timestamp);
    //                   // List<String?> s = [StaticStore.currentUserId,widget.receiverInfo.id];
    //                   // s.sort();
    //                   // String messageId = "${s[0]}_${s[1]}";
    //                   // print(messageId);
    //                   await _firebaseCall.storeChats(widget.messageId,mes);


    //                   _textController.text = '';
    //                 }
    //               },
    //               padding:EdgeInsets.only(top:10,left:10,right:5,bottom:10),
    //               shape:const CircleBorder(),
    //               color:Colors.green,
    //               child:Icon(Icons.send,color:Colors.white,size:15),
    //             )
    //           ],),
    //         ),
    //       ),
    //     ],
    //   ),
    // )









            // MaterialButton(
            //       onPressed: () async {
            //         // print("message send option clicked");
            //         // if(_textController.text.isNotEmpty){
            //           // print(_textController.text);
            //           // Timestamp t;
            //           // var t = DateTime.fromMillisecondsSinceEpoch(1713196304253);
            //           int t = DateTime.now().millisecondsSinceEpoch;
            //           for(int i=0;i<widget.res.length;i++){
            //             var mes = {
            //               "message":_textController.text,
            //               "timestamp":t,
            //               "sender":StaticStore.currentUserId,
            //               "receiver":widget.receiverInfo.id,
            //               "status":"sent",
            //               "type":"text",
            //               "doc":widget.res[i],
            //             };
            //             await _firebaseCall.storeChats(widget.messageId,mes);
            //             _textController.text = '';
            //           }
            //         // }
            //       },
            //       padding:EdgeInsets.only(top:10,left:10,right:5,bottom:10),
            //       shape:const CircleBorder(),
            //       color:Colors.green,
            //       child:Icon(Icons.send,color:Colors.white,size:15),
            //     )
              
          ],
        ),
      ),
    );
  }
}