import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class LoadingImage extends StatelessWidget {
  final double? size;
  final Icon? icon;
  const LoadingImage({
    Key? key,
    this.size,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
    // StreamBuilder(stream: , builder:(context, snapshot){return SizedBox();},)
    Container(
      color: Colors.grey.shade800,
      child: icon ??
          Icon(
            LineIcons.music,
            color: Colors.black,
            size: size,
          ),
    );
  }
}
