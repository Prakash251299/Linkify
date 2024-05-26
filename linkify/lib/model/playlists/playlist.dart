class MyPlaylist{
  String? id="";
  String? name="";
  String? imgUrl="";
  MyPlaylist.fromJson(json){
    id = json['id'];
    name = json['name'];
    imgUrl = json['playlistImg'];
  }
}