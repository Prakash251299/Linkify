import 'package:on_audio_query/on_audio_query.dart';

class Categories{
  String name="";
  String id="";
  List<Items>playlists=[];
  Categories.fromJson(Map<String,dynamic> json){
    name = json['name'];
    id = json['id'];
    playlists = json['playlists'];
  }
}

class Items{
  String? name="";
  String? id="";
  String? imgUrl="";
  Items.fromJson(Map<String,dynamic> json){
    name = json['name']??"";
    id = json['id']??"";
    imgUrl = json['imgUrl']??"";
  }
}