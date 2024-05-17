// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:linkify/widgets/Network/chatting/modal/mes_info.dart';
import 'package:linkify/controller/static_store.dart';
import 'package:linkify/model/user_info.dart';
// import 'apis.dart';
// import 'chatUser.dart';
// import 'message.dart';
// import 'chatuserCard.dart';

class MessageCard extends StatefulWidget {
  
  // final Message message;
  // final ChatUser user;
  // final String message;
  MesInfo _mesInfo;
  UserInfo _receiverInfo;
  MessageCard(this._mesInfo,this._receiverInfo, {super.key});
  // const MessageCard({super.key,required this.message,required this.user,});
  @override
  State<MessageCard> createState() => _MessageCardState();
}
// var from = 'prakashpratapsingh2512@gmail.com';
// var from = 'prakashpratapsingh6@gmail.com';
class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    // print("MessageState: ${widget._mesInfo.message}");

    return 
    widget._mesInfo.sender==widget._mesInfo.receiver?greenMess():widget._mesInfo.sender==StaticStore.currentUserId?greenMess():blueMess();
  }

  Widget greenMess(){
    var mq = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment:MainAxisAlignment.spaceBetween,
      children:[
        Row(children:[
          SizedBox(width:mq.width*.04),
          Icon(Icons.done_all_rounded, color: Colors.blue, size: 20),
          // Text("hello"),
          // widget._mesInfo.message!=""?Text("${widget._mesInfo.message}",style:TextStyle(fontSize:13,color:Colors.black54),):Text("${widget._mesInfo.type} data",style:TextStyle(fontSize:13,color:Colors.black54),),
        ]),
      Flexible(
        child: Container(
          padding:EdgeInsets.all(mq.width*.04),
          margin:EdgeInsets.symmetric(horizontal: mq.width*.04,vertical: mq.height*0.01),
          decoration:BoxDecoration(
            color: Color.fromARGB(255, 221, 245, 255),
            border: Border.all(color:Colors.lightBlue),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30),
            )
            // borderRadius: BorderRadius.only(
            //   topRight: Radius.circular(30),
            //   topLeft: Radius.circular(30),
            //   bottomLeft: Radius.circular(30),
            // )
          ),

          child:widget._mesInfo.type=="video"?Text("video data",style:TextStyle(fontSize:13,color:Colors.black54),):widget._mesInfo.type=="image"?Text("image data",style:TextStyle(fontSize:13,color:Colors.black54),):Text("${widget._mesInfo.message}",style:TextStyle(fontSize:13,color:Colors.black54),),

          // child: widget._mesInfo.message!=""?Text("${widget._mesInfo.message}",style:TextStyle(fontSize:13,color:Colors.black54),):Text("${widget._mesInfo.type} data",style:TextStyle(fontSize:13,color:Colors.black54),),

          
          // child: Text("${widget._mesInfo.message}",style:TextStyle(fontSize: 15,color:Colors.black87)),
        ),
      ),
      // Text(widget.message.sent,style: TextStyle(fontSize: 13,color:Colors.black54),),
    ]);
  }
  Widget blueMess(){
    var mq = MediaQuery.of(context).size;
    return Row(children:[
      Flexible(
        child: Container(
          padding:EdgeInsets.all(mq.width*.04),
          margin:EdgeInsets.symmetric(horizontal: mq.width*.04,vertical: mq.height*0.01),
          decoration:BoxDecoration(
            color: Color.fromARGB(255, 221, 245, 255),
            border: Border.all(color:Colors.lightBlue),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            )
          ),
          // child: Text("${widget._mesInfo.message}",style:TextStyle(fontSize: 15,color:Colors.black87)),
          // child: widget._mesInfo.message!=""?Text("${widget._mesInfo.message}",style:TextStyle(fontSize:13,color:Colors.black54),):Text("${widget._mesInfo.type} data",style:TextStyle(fontSize:13,color:Colors.black54),),
          child:widget._mesInfo.type=="video"?Text("video data",style:TextStyle(fontSize:13,color:Colors.black54),):widget._mesInfo.type=="image"?Text("image data",style:TextStyle(fontSize:13,color:Colors.black54),):Text("${widget._mesInfo.message}",style:TextStyle(fontSize:13,color:Colors.black54),),
        ),
      ),
    ]);
  }
}