class LikedTracks{
  static List<String>?name;
  static List<String>id=[];
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










// class LikedTracks {
//   String? name;
//   String? href;
//   int? limit;
//   String? next;
//   int? offset;
//   String? previous;
//   int? total;
//   List<Items>? items;

//   LikedTracks(
//       {this.href,
//       this.limit,
//       this.next,
//       this.offset,
//       this.previous,
//       this.total,
//       this.items});

//   LikedTracks.fromJson(Map<String, dynamic> json) {
//     href = json['href'];
//     limit = json['limit'];
//     next = json['next'];
//     offset = json['offset'];
//     previous = json['previous'];
//     total = json['total'];
//     if (json['items'] != null) {
//       items = <Items>[];
//       json['items'].forEach((v) {
//         items!.add(new Items.fromJson(v));
//       });
//     }
//     // if (json['items'] != null) {
//     //   items = <Items>[];
//     //   json['items']['track']['name'].forEach((v) {
//     //     items!.add(new Items.fromJson(v));
//     //   });
//     // }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['href'] = this.href;
//     data['limit'] = this.limit;
//     data['next'] = this.next;
//     data['offset'] = this.offset;
//     data['previous'] = this.previous;
//     data['total'] = this.total;
//     if (this.items != null) {
//       data['items'] = this.items!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Items {
//   String? addedAt;
//   Track? track;

//   Items({this.addedAt, this.track});

//   Items.fromJson(Map<String, dynamic> json) {
//     addedAt = json['added_at'];
//     track = json['track'] != null ? new Track.fromJson(json['track']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['added_at'] = this.addedAt;
//     if (this.track != null) {
//       data['track'] = this.track!.toJson();
//     }
//     return data;
//   }
// }

// class Track {
//   Album? album;
//   List<Artists>? artists;
//   List<String>? availableMarkets;
//   int? discNumber;
//   int? durationMs;
//   bool? explicit;
//   ExternalIds? externalIds;
//   ExternalUrls? externalUrls;
//   String? href;
//   String? id;
//   String? name;
//   int? popularity;
//   String? previewUrl;
//   int? trackNumber;
//   String? type;
//   String? uri;
//   bool? isLocal;

//   Track(
//       {this.album,
//       this.artists,
//       this.availableMarkets,
//       this.discNumber,
//       this.durationMs,
//       this.explicit,
//       this.externalIds,
//       this.externalUrls,
//       this.href,
//       this.id,
//       this.name,
//       this.popularity,
//       this.previewUrl,
//       this.trackNumber,
//       this.type,
//       this.uri,
//       this.isLocal});

//   Track.fromJson(Map<String, dynamic> json) {
//     album = json['album'] != null ? new Album.fromJson(json['album']) : null;
//     if (json['artists'] != null) {
//       artists = <Artists>[];
//       json['artists'].forEach((v) {
//         artists!.add(new Artists.fromJson(v));
//       });
//     }
//     availableMarkets = json['available_markets'].cast<String>();
//     discNumber = json['disc_number'];
//     durationMs = json['duration_ms'];
//     explicit = json['explicit'];
//     externalIds = json['external_ids'] != null
//         ? new ExternalIds.fromJson(json['external_ids'])
//         : null;
//     externalUrls = json['external_urls'] != null
//         ? new ExternalUrls.fromJson(json['external_urls'])
//         : null;
//     href = json['href'];
//     id = json['id'];
//     name = json['name'];
//     popularity = json['popularity'];
//     previewUrl = json['preview_url'];
//     trackNumber = json['track_number'];
//     type = json['type'];
//     uri = json['uri'];
//     isLocal = json['is_local'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.album != null) {
//       data['album'] = this.album!.toJson();
//     }
//     if (this.artists != null) {
//       data['artists'] = this.artists!.map((v) => v.toJson()).toList();
//     }
//     data['available_markets'] = this.availableMarkets;
//     data['disc_number'] = this.discNumber;
//     data['duration_ms'] = this.durationMs;
//     data['explicit'] = this.explicit;
//     if (this.externalIds != null) {
//       data['external_ids'] = this.externalIds!.toJson();
//     }
//     if (this.externalUrls != null) {
//       data['external_urls'] = this.externalUrls!.toJson();
//     }
//     data['href'] = this.href;
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['popularity'] = this.popularity;
//     data['preview_url'] = this.previewUrl;
//     data['track_number'] = this.trackNumber;
//     data['type'] = this.type;
//     data['uri'] = this.uri;
//     data['is_local'] = this.isLocal;
//     return data;
//   }
// }

// class Album {
//   String? albumType;
//   int? totalTracks;
//   List<String>? availableMarkets;
//   ExternalUrls? externalUrls;
//   String? href;
//   String? id;
//   List<Images>? images;
//   String? name;
//   String? releaseDate;
//   String? releaseDatePrecision;
//   String? type;
//   String? uri;
//   List<Artists>? artists;

//   Album(
//       {this.albumType,
//       this.totalTracks,
//       this.availableMarkets,
//       this.externalUrls,
//       this.href,
//       this.id,
//       this.images,
//       this.name,
//       this.releaseDate,
//       this.releaseDatePrecision,
//       this.type,
//       this.uri,
//       this.artists});

//   Album.fromJson(Map<String, dynamic> json) {
//     albumType = json['album_type'];
//     totalTracks = json['total_tracks'];
//     availableMarkets = json['available_markets'].cast<String>();
//     externalUrls = json['external_urls'] != null
//         ? new ExternalUrls.fromJson(json['external_urls'])
//         : null;
//     href = json['href'];
//     id = json['id'];
//     if (json['images'] != null) {
//       images = <Images>[];
//       json['images'].forEach((v) {
//         images!.add(new Images.fromJson(v));
//       });
//     }
//     name = json['name'];
//     releaseDate = json['release_date'];
//     releaseDatePrecision = json['release_date_precision'];
//     type = json['type'];
//     uri = json['uri'];
//     if (json['artists'] != null) {
//       artists = <Artists>[];
//       json['artists'].forEach((v) {
//         artists!.add(new Artists.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['album_type'] = this.albumType;
//     data['total_tracks'] = this.totalTracks;
//     data['available_markets'] = this.availableMarkets;
//     if (this.externalUrls != null) {
//       data['external_urls'] = this.externalUrls!.toJson();
//     }
//     data['href'] = this.href;
//     data['id'] = this.id;
//     if (this.images != null) {
//       data['images'] = this.images!.map((v) => v.toJson()).toList();
//     }
//     data['name'] = this.name;
//     data['release_date'] = this.releaseDate;
//     data['release_date_precision'] = this.releaseDatePrecision;
//     data['type'] = this.type;
//     data['uri'] = this.uri;
//     if (this.artists != null) {
//       data['artists'] = this.artists!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class ExternalUrls {
//   String? spotify;

//   ExternalUrls({this.spotify});

//   ExternalUrls.fromJson(Map<String, dynamic> json) {
//     spotify = json['spotify'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['spotify'] = this.spotify;
//     return data;
//   }
// }

// class Images {
//   String? url;
//   int? height;
//   int? width;

//   Images({this.url, this.height, this.width});

//   Images.fromJson(Map<String, dynamic> json) {
//     url = json['url'];
//     height = json['height'];
//     width = json['width'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['url'] = this.url;
//     data['height'] = this.height;
//     data['width'] = this.width;
//     return data;
//   }
// }

// class Artists {
//   ExternalUrls? externalUrls;
//   String? href;
//   String? id;
//   String? name;
//   String? type;
//   String? uri;

//   Artists(
//       {this.externalUrls, this.href, this.id, this.name, this.type, this.uri});

//   Artists.fromJson(Map<String, dynamic> json) {
//     externalUrls = json['external_urls'] != null
//         ? new ExternalUrls.fromJson(json['external_urls'])
//         : null;
//     href = json['href'];
//     id = json['id'];
//     name = json['name'];
//     type = json['type'];
//     uri = json['uri'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.externalUrls != null) {
//       data['external_urls'] = this.externalUrls!.toJson();
//     }
//     data['href'] = this.href;
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['type'] = this.type;
//     data['uri'] = this.uri;
//     return data;
//   }
// }

// class ExternalIds {
//   String? isrc;

//   ExternalIds({this.isrc});

//   ExternalIds.fromJson(Map<String, dynamic> json) {
//     isrc = json['isrc'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['isrc'] = this.isrc;
//     return data;
//   }
// }