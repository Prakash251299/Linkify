part of 'home_cubit.dart';

// import 'package:linkify/widgets/uis/models/album_model.dart';
// import 'package:linkify/widgets/uis/models/loading_enum.dart';
// import 'package:linkify/widgets/uis/models/song_model.dart';

class HomeState {
  final LoadPage status;
  // final List<User> users;
  // final List<SongModel>? songs;
  // final List<AlbumModeling>? albums;
  Map<String,List<dynamic>>? carouselSongs;
  List<FrontPageCategories>? categories=[];
  // final List<String>? id;
  HomeState({
    required this.status,
    // required this.users,
    this.carouselSongs,
    this.categories,
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
    Map<String,List<dynamic>>?carouselSongs,
    List<FrontPageCategories>? categories,
    // List<String>?id,
    // List<AlbumModeling>? albums,
    // List<SongModel>? songs,
  }) {
    return HomeState(
      status: status ?? this.status,
      // users: users ?? this.users,
      // songs: songs ?? this.songs,
      carouselSongs: carouselSongs ?? this.carouselSongs,
      categories: categories ?? this.categories,
      // id: id ?? this.id,
    );
  }
}
