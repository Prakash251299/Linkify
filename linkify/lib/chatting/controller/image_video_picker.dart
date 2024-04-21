import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:linkify/chatting/widget/picked_image_video.dart';

Future<List<XFile>> imageVideoPicker(var context) async {
  final ImagePicker picker = ImagePicker();
  List<XFile> res =  await picker.pickMultipleMedia();

  // print(res[0].path..then((value) => print(value)));
  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PickedImageVideo(res)));
  return res;
}