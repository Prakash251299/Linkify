part of 'home_cubit.dart';

// import 'package:linkify/widgets/uis/models/album_model.dart';
// import 'package:linkify/widgets/uis/models/loading_enum.dart';
// import 'package:linkify/widgets/uis/models/song_model.dart';

class HomeState {
  final LoadPage status;
  // final List<User> users;
  // final List<SongModel>? songs;
  // final List<AlbumModeling>? albums;
  Map<String,List<dynamic>>? likedTrack;
  // final List<String>? id;
  HomeState({
    required this.status,
    // required this.users,
    this.likedTrack,
    // this.id,
  });
  factory HomeState.initial() {
    return HomeState(
      // name: 
      // id: [],
      // likedTrack:{},
      status: LoadPage.initial,
      // users: [],
    );
  }

  HomeState copyWith({
    LoadPage? status,
    Map<String,List<dynamic>>?likedTrack,
    // List<String>?id,
    // List<AlbumModeling>? albums,
    // List<SongModel>? songs,
  }) {
    return HomeState(
      status: status ?? this.status,
      // users: users ?? this.users,
      // songs: songs ?? this.songs,
      likedTrack: likedTrack ?? this.likedTrack,
      // id: id ?? this.id,
    );
  }
}
