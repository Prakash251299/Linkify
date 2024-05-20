import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:linkify/widgets/Network/chatting/widget/picked_image_video_screen.dart';
import 'package:linkify/model/user_info.dart';
// import 'package:linkify/chatting/widget/picked_video_screen.dart';
// import 'package:video_player/video_player.dart';
// import 'package:linkify/chatting/widget/video_player.dart';

Future<void> imageVideoPicker(var context, UserInfo receiverInfo, String messageId) async {
  final ImagePicker picker = ImagePicker();
  List<XFile> res =  await picker.pickMultipleMedia();

  // print(res[0].name);
  // if(res[])
  // await getVideoController(res);

  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PickedImageVideo(res,receiverInfo,messageId)));
  return;
}