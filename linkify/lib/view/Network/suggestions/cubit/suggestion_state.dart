part of 'suggestion_cubit.dart';

// import 'package:linkify/widgets/uis/models/album_model.dart';
// import 'package:linkify/widgets/uis/models/loading_enum.dart';
// import 'package:linkify/widgets/uis/models/song_model.dart';

class SuggestionState {
  final LoadPage status;
  List<List<UserInfo>?> recommendedUsers;
  // final List<User> users;
  // final List<SongModel>? songs;
  // final List<AlbumModeling>? albums;
  // Map<String,List<dynamic>>? carouselSongs;
  // List<FrontPageCategories>? categories=[];
  // final List<String>? id;
  SuggestionState({
    required this.status,
    required this.recommendedUsers,
    // required this.users,
    // this.carouselSongs,
    // this.categories,
    // this.id,
  });
  factory SuggestionState.initial() {
    return SuggestionState(
      // name: 
      // id: [],
      // likedTrack:{},
      recommendedUsers: [[],[],[]],
      status: LoadPage.initial,
      // users: [],
    );
  }

  SuggestionState copyWith({
    LoadPage? status,
    List<List<UserInfo>?>? recommendedUsers,
    // Map<String,List<dynamic>>?carouselSongs,
    // List<FrontPageCategories>? categories,
    // List<String>?id,
    // List<AlbumModeling>? albums,
    // List<SongModel>? songs,
  }) {
    return SuggestionState(
      status: status ?? this.status,
      recommendedUsers: recommendedUsers ?? this.recommendedUsers,
      // users: users ?? this.users,
      // songs: songs ?? this.songs,
      // carouselSongs: carouselSongs ?? this.carouselSongs,
      // categories: categories ?? this.categories,
      // id: id ?? this.id,
    );
  }
}
