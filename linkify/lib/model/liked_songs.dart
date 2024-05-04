class LikedTracks{
  static List<String>?name;
  static List<String>?id;
  void storeLikedTracks(var json){
    // print(json);
    for(int i=0;i<json.length;i++){
      print("hi");
      name?.add(json[i]['track']['name']);
      id?.add(json[i]['track']['id']);
      // print(json['track']);
    }
  }
}