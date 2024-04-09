class SongModel {
  String id;
  // String? songname;
  // String? userid;
  // String? trackid;
  // String? duration;
  String imgUrl;
  String name;
  List<dynamic> artists;

  SongModel({
    // this.albumImg,
    // this.trackArtists,



    required this.id,
    // this.songname,
    // this.userid,
    // this.trackid,
    // this.duration,
    required this.imgUrl,
    required this.name,
    required this.artists,
  });

  Future<List<String>> fetchArtists(var json)async {
    List<String>s=[];
    for(int i=0;i<json['artists'].length;i++){


    }
    return s;
  }
  factory SongModel.fromJson(Map<String, dynamic> json)  => SongModel(
        id: json['id'] as String,
        name: json['name'] as String,
        // imgUrl: json['album']['id'] as String?,
        imgUrl: json['album']['images'][0]['url'] as String,
        // List<String> s = json['artists'].entries.map( (entry) => String(entry['name'].value)).toList(),;
        // await (data['tracks']['items'] as List)
        //   .map((e) => SongModel.fromJson(e))
        //   .toList();
        // artists: json['artists'].entries.map( (entry) => String(entry.value)).toList(),
        // artists: json['artists'].entries.map((e)=>e['name'].toList())

        // artists: ["ishu","jatin","aman"]
        artists: (json['artists'])
          .map((e) => e['name'])
          .toList()
        // json['tracks']['items'][0]['artists'][0]['name'],
        // artists: ["ishu","jatin","aman"]
        // artists: fetchArtists(json),
        // for(int i=0;i<json['artists'].length;i++){

        // }


        // userid: json['userid'] as String?,
        // trackid: json['trackid'] as String?,
        // duration: json['duration'] as String?,
        // name: json['first_name'] + ' ' + json['last_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        // 'userid': userid,
        // 'trackid': trackid,
        // 'duration': duration,
        'image': imgUrl,
        'artists':artists,
      };
}
