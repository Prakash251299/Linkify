import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:linkify/widgets/Network/chatting/controller/important_functions.dart';
import 'package:linkify/widgets/Network/chatting/widget/picked_image_video_screen.dart';
import 'package:linkify/controller/firebase_call.dart';
import 'package:linkify/controller/static_store.dart';

Widget dynamicSenderFooter(context,receiverInfo,messageId,List<XFile> doc){
  FirebaseCall _firebaseCall = FirebaseCall();
  TextEditingController _textController = TextEditingController();
  FirebaseStorage storage = FirebaseStorage.instance;
  return 
  Padding(
      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.01),
      child: 
      // Column(children: [
      Row(
        children: [

          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(15)),
              child: Row(children: [
                IconButton(onPressed: (){},
                  icon: Icon(Icons.emoji_emotions,color:Colors.blueAccent),
                ),
          
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    controller: _textController,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: "Input...",
                      hintStyle: TextStyle(color:Colors.blueAccent),
                      border: InputBorder.none,
                    ),
                  ),
                ),
          
                MaterialButton(
                  onPressed: () async {
                    // print("message send option clicked");
                    // if(_textController.text.isNotEmpty){
                      // print(_textController.text);
                      // Timestamp t;
                      // var t = DateTime.fromMillisecondsSinceEpoch(1713196304253);
                      try{
                        print("inputForDoc: ${_textController.text}");
                        // print("file name: ${doc[0].name}");
                        for(int i=0;i<doc.length;i++){

                        final storageRef = storage.ref();
                        var type = fileType(doc[0].path);
                        var docType = "";
                        var downloadUrl="";
                        if(imageExtensions.contains(type)){
                          docType = "image";
                        }
                        if(videoExtensions.contains(type)){
                          docType = "video";
                        }
                        // print("1");

                        final documentRef = storageRef.child("/${StaticStore.currentUserId}/${docType}/${doc[0].name}");
                        var file = File(doc[0].path);
                        
                        try {
                          // print("inside");
                          await documentRef.putFile(file).then((v){
                            // print("file uploaded");
                            // print(v);
                          });
                          // print("Uploaded");
                          downloadUrl = await documentRef.getDownloadURL();
                          // print("downloadUrl: $downloadUrl");

                        } catch (e) {
                          print("File not uploaded");
                          // ...
                        }
                        // print("outside");


                          /* First upload file in firebase storage then the reference should be sent as doc in message for storing it on firestore */
                          // var type = fileType(doc[i].path);
                          // var a = File(doc[i].path) as dynamic;
                          int t = DateTime.now().millisecondsSinceEpoch;
                          var mes = {
                            "message":_textController.text,
                            "timestamp":t,
                            "sender":StaticStore.currentUserId,
                            "receiver":receiverInfo.id,
                            "status":"sent",
                            "type":docType,
                            "doc":downloadUrl,
                          };
                          await _firebaseCall.storeChats(messageId,mes);
                          Navigator.pop(context);
                        }
                      }catch(e){
                        print("Error occurred while sending doc(image/video) data");
                      }
                      // var k = MesInfo.fromJson(mes);
                      // print(k.timestamp);
                      // List<String?> s = [StaticStore.currentUserId,widget.receiverInfo.id];
                      // s.sort();
                      // String messageId = "${s[0]}_${s[1]}";
                      // print(messageId);


                      _textController.text = '';
                    // }
                  },
                  padding:EdgeInsets.only(top:10,left:10,right:5,bottom:10),
                  shape:const CircleBorder(),
                  color:Colors.green,
                  child:Icon(Icons.send,color:Colors.white,size:15),
                )
              ],),
            ),
          ),
        ],
      ),
    );

}