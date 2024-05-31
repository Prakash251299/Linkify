import 'package:flutter/material.dart';
import 'package:linkify/model/playlists/playlist.dart';
import 'package:linkify/view/search/search_page/horizontal_playlists.dart';
import 'package:linkify/view/home/horizontal_songs_list.dart';

class GenrePlaylistScreen extends StatefulWidget {
  List<MyPlaylist> _playlist = [];
  GenrePlaylistScreen(this._playlist,{super.key});

  @override
  State<GenrePlaylistScreen> createState() => _GenrePlaylistScreenState();
}

class _GenrePlaylistScreenState extends State<GenrePlaylistScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,),onPressed: (){
            Navigator.pop(context);
          },),
          title: Text("${widget._playlist[0].name}",overflow: TextOverflow.ellipsis,style:TextStyle(color: Colors.white)),
          backgroundColor: Colors.black,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Padding(
            padding: const EdgeInsets.only(left:7.0,top:10,bottom:10),
            child: Text("Top lists",style: TextStyle(fontSize: 24),),
          ),
          HorizontalPlaylist(widget._playlist,0),
          // Spacer(),
          SizedBox(
            height:20
          ),
          Padding(
            padding: const EdgeInsets.only(left:7.0,top:10,bottom:10),
            child: Text("General lists",style: TextStyle(fontSize: 24),),
          ),
          HorizontalPlaylist(widget._playlist,10),
        ],)
      ),
    );
  }
}