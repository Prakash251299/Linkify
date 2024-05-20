class AlbumTrack{
  String? id="";
  String? name="";
  List<dynamic> trackArtists=[];
  String? imgUrl="";
  AlbumTrack.fromJson(json){
    id = json['id'];
    name = json['name'];
    trackArtists = json['trackArtists'];
    imgUrl = json['trackImg'];
  }
}