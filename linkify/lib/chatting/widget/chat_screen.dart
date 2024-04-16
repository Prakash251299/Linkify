import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linkify/chatting/modal/mes_info.dart';
import 'package:linkify/controller/firebase_call.dart';
import 'package:linkify/controller/static_store.dart';
import 'package:linkify/model/user_info.dart';
import 'package:linkify/widgets/loading_user_img.dart';
// import 'package:wechat/messageCard.dart';
// import 'apis.dart';
// import 'chatUser.dart';
// import 'message.dart';

class ChatScreen extends StatefulWidget {
  UserInfo receiverInfo;
  String messageId;
  ChatScreen(this.receiverInfo,this.messageId,{super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _textController = TextEditingController();
  FirebaseCall _firebaseCall = FirebaseCall();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return 
    SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.black,
        appBar:AppBar(
          
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          flexibleSpace: _appBar(),
        ),
        body:
        Column(children: [
          Expanded(
            child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('chats').snapshots(),
          // stream: null,
          builder: (context, AsyncSnapshot snapshot){
            switch(snapshot.connectionState){
              case ConnectionState.waiting:
              case ConnectionState.none:
                return const SizedBox();
                // return const Center(
                //   child:CircularProgressIndicator());
              case ConnectionState.active:
              case ConnectionState.done:


              // FirebaseFirestore.instance.collection('chats').doc("dummy").get().then((value) {
              FirebaseFirestore.instance.collection('chats').doc("${widget.messageId}").get().then((value) {
                print(value.exists);

                if(value.exists){
                  // print(value.data());
                  List list=[];
                  // list = data?.map((e)=>MesInfo.fromJson(e.data())).toList()??[];
                  list = value.data()?['messageInfo'];
                  print(list[0]);

                  if(list.isNotEmpty){
                    return
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: list.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context,index){
        
                        return SizedBox();
                        // MessageCard(message: list[index],user:widget.user);
                      }
                    );
                  }else{
                    return Center(child: Text("Hello there!",style: TextStyle(fontSize: 20)),);
                  }
                }else{

                }
              });
              
              return Center(child: Text("Hello there!",style: TextStyle(fontSize: 20)),);
      
      
            }
          }
        ),
          ),
      
          _chatInp(),
        ],)
      ),
    );
  }

  
  Widget _appBar(){
    final devicePexelRatio = MediaQuery.of(context).devicePixelRatio;
    return 
    Row(children: [
        IconButton(
          onPressed: (){
            Navigator.pop(context);
          }, 
          icon: Icon(Icons.arrow_back,color: Colors.white,),
        ),
        ClipRRect(
                                                borderRadius: 
                                                BorderRadius.all(
                                                  Radius.circular(30),
                                                ),
                                                // BorderRadius.only(
                                                //   topLeft: Radius.circular(3),
                                                //   bottomLeft: Radius.circular(3),
                                                // ),
                                                child:
                                                // StaticStore.currentSongImg==""?
                                                    // CachedNetworkImage(imageUrl: ""),
                                                    widget.receiverInfo.image?.length==0?
              
                                                    Container(
                                                      width: 55,
                                                      height: 55,
                                                      child:
                                                      const LoadingUserImage(),
                                                    )
              
              
                                                /* For user's friends image */
                                                :
                                                    CachedNetworkImage(
                                                  // imageUrl: user.avatar!,
              
                                                  imageUrl: widget.receiverInfo.image?.length==2?"${widget.receiverInfo.image?[1]['url']}":"${widget.receiverInfo.image?[0]['url']}",
              
                                                  width: 55,
                                                  height: 55,
                                                  memCacheHeight:
                                                      (55 * devicePexelRatio).round(),
                                                  memCacheWidth:
                                                      (55 * devicePexelRatio).round(),
                                                  maxHeightDiskCache:
                                                      (55 * devicePexelRatio).round(),
                                                  maxWidthDiskCache:
                                                      (55 * devicePexelRatio).round(),
                                                  // progressIndicatorBuilder:
                                                  //     (context, url, l) {
                                                  //           return const LoadingImage();
                                                  //     },
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
        // IconButton(
        //   onPressed: (){
        //     // Navigator.pop(context);
        //   }, 
        //   icon: Icon(Icons.person, color: Colors.white,),
        // ),
        Padding(
          padding: const EdgeInsets.only(left:8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text("${widget.receiverInfo.displayName}",style: TextStyle(fontSize:16,fontWeight: FontWeight.w500),),
            Text("Last seen",style: TextStyle(fontSize:13,fontWeight: FontWeight.w100),),
          ],),
        ),
        
      ],);
  }
  Widget _chatInp(){
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
                IconButton(onPressed: (){}, 
                  icon: Icon(Icons.image,color:Colors.blueAccent),
                ),
                IconButton(onPressed: (){}, 
                  icon: Icon(Icons.camera_alt_rounded, color:Colors.blueAccent),
                ),
          
                MaterialButton(
                  onPressed: () async {
                    print("message send option clicked");
                    if(_textController.text.isNotEmpty){
                      // print(_textController.text);
                      // Timestamp t;
                      // var t = DateTime.fromMillisecondsSinceEpoch(1713196304253);
                      int t = DateTime.now().millisecondsSinceEpoch;
                      var mes = {
                        "message":_textController.text,
                        "timestamp":t,
                        "sender":StaticStore.currentUserId,
                        "receiver":widget.receiverInfo.id,
                        "status":"sent",
                        "type":"text"
                      };
                      // var k = MesInfo.fromJson(mes);
                      // print(k.timestamp);
                      // List<String?> s = [StaticStore.currentUserId,widget.receiverInfo.id];
                      // s.sort();
                      // String messageId = "${s[0]}_${s[1]}";
                      // print(messageId);
                      await _firebaseCall.storeChats(widget.messageId,mes);


                      _textController.text = '';
                    }
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

}