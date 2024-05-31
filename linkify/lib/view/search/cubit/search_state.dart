part of 'search_cubit.dart';

// import 'package:linkify/widgets/uis/models/album_model.dart';
// import 'package:linkify/widgets/uis/models/loading_enum.dart';
// import 'package:linkify/widgets/uis/models/song_model.dart';

class SearchState {
  final LoadPage status;
  // final List<User> users;
  // final List<SongModel>? songs;
  // final List<AlbumModeling>? albums;
  List<String>? userGenre;
  // final List<String>? id;
  SearchState({
    required this.status,
    // required this.users,
    this.userGenre,
    // this.id,
  });
  factory SearchState.initial() {
    return SearchState(
      // name: 
      // id: [],
      // likedTrack:{},
      status: LoadPage.initial,
      // users: [],
    );
  }

  SearchState copyWith({
    LoadPage? status,
    List<String>?userGenre,
    // List<String>?id,
    // List<AlbumModeling>? albums,
    // List<SongModel>? songs,
  }) {
    return SearchState(
      status: status ?? this.status,
      // users: users ?? this.users,
      // songs: songs ?? this.songs,
      userGenre: userGenre ?? this.userGenre,
      // id: id ?? this.id,
    );
  }
}
