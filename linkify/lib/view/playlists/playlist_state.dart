part of 'playlist_cubit.dart';

// import 'package:linkify/widgets/uis/models/album_model.dart';
// import 'package:linkify/widgets/uis/models/loading_enum.dart';
// import 'package:linkify/widgets/uis/models/song_model.dart';

class PlaylistState {
  final LoadPage status;
  List<MyPlaylist> playlists;
  // final List<User> users;
  // final List<SongModel>? songs;
  // final List<AlbumModeling>? albums;
  // Map<String,List<dynamic>>? carouselSongs;
  // List<FrontPageCategories>? categories=[];
  // final List<String>? id;
  PlaylistState({
    required this.status,
    required this.playlists,
    // required this.users,
    // this.carouselSongs,
    // this.categories,
    // this.id,
  });
  factory PlaylistState.initial() {
    return PlaylistState(
      // name: 
      // id: [],
      // likedTrack:{},
      playlists: [],
      status: LoadPage.initial,
      // users: [],
    );
  }

  PlaylistState copyWith({
    LoadPage? status,
    // Map<String,List<dynamic>>?carouselSongs,
    List<MyPlaylist>? playlists,
    // List<String>?id,
    // List<AlbumModeling>? albums,
    // List<SongModel>? songs,
  }) {
    return PlaylistState(
      status: status ?? this.status,
      // users: users ?? this.users,
      // songs: songs ?? this.songs,
      // carouselSongs: carouselSongs ?? this.carouselSongs,
      playlists: playlists ?? this.playlists,
      // id: id ?? this.id,
    );
  }
}
