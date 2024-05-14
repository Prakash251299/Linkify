class UserInfo {
  String? displayName;
  ExternalUrls? externalUrls;
  String? href;
  String? id;
  List<dynamic>? image;
  // String? image;

  String? type;
  String? uri;
  Followers? followers;
  String? country;
  String? product;
  ExplicitContent? explicitContent;
  String? email;
  List<dynamic>?spotifyBasedGenre;

  UserInfo(
      {this.displayName,
      this.externalUrls,
      this.href,
      this.id,
      this.image,
      this.type,
      this.uri,
      this.followers,
      this.country,
      this.product,
      this.explicitContent,
      this.email,
      this.spotifyBasedGenre});

  UserInfo.fromJson(Map<String, dynamic> json) {
    displayName = json['display_name'];
    externalUrls = json['external_urls'] != null
        ? new ExternalUrls.fromJson(json['external_urls'])
        : null;
    href = json['href'];
    id = json['id'];
    if (json['images']!=null) {
      image = json['images'];
      // json['images'].forEach((v) {
      //   images!.add(v);
      // });
    }
    type = json['type'];
    uri = json['uri'];
    followers = json['followers'] != null
        ? new Followers.fromJson(json['followers'])
        : null;
    country = json['country'];
    product = json['product'];
    explicitContent = json['explicit_content'] != null
        ? new ExplicitContent.fromJson(json['explicit_content'])
        : null;
    email = json['email'];
    spotifyBasedGenre = json['spotifyGenre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['display_name'] = this.displayName;
    if (this.externalUrls != null) {
      data['external_urls'] = this.externalUrls!.toJson();
    }
    data['href'] = this.href;
    data['id'] = this.id;
    if (this.image != null) {
      data['images'] = this.image;
    }
    data['type'] = this.type;
    data['uri'] = this.uri;
    if (this.followers != null) {
      data['followers'] = this.followers!.toJson();
    }
    data['country'] = this.country;
    data['product'] = this.product;
    if (this.explicitContent != null) {
      data['explicit_content'] = this.explicitContent!.toJson();
    }
    data['email'] = this.email;
    return data;
  }
}

class ExternalUrls {
  String? spotify;

  ExternalUrls({this.spotify});

  ExternalUrls.fromJson(Map<String, dynamic> json) {
    spotify = json['spotify'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['spotify'] = this.spotify;
    return data;
  }
}

class Followers {
  Null? href;
  int? total;

  Followers({this.href, this.total});

  Followers.fromJson(Map<String, dynamic> json) {
    href = json['href'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    data['total'] = this.total;
    return data;
  }
}

class ExplicitContent {
  bool? filterEnabled;
  bool? filterLocked;

  ExplicitContent({this.filterEnabled, this.filterLocked});

  ExplicitContent.fromJson(Map<String, dynamic> json) {
    filterEnabled = json['filter_enabled'];
    filterLocked = json['filter_locked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['filter_enabled'] = this.filterEnabled;
    data['filter_locked'] = this.filterLocked;
    return data;
  }
}