import 'package:bloc/bloc.dart';
import 'package:linkify/model/home/first_page_categories.dart';
import 'package:linkify/controller/playlist/playlist_data_handler.dart';
import 'package:linkify/controller/home/front_page_data/recommendations.dart';
import 'package:linkify/model/playlists/playlist.dart';
import 'package:linkify/controller/variables/loading_enum.dart';
// import '../../../models/loading_enum.dart';
// import '../../../models/song_model.dart';
// import '../../../repositories/get_home_page.dart';

// import '../../../models/user.dart';

part 'playlist_state.dart';

class PlaylistCubit extends Cubit<PlaylistState> {
  // final repo = GetHomePage();
  PlaylistCubit() : super(PlaylistState.initial());

  Future<void> getPlaylists() async {
    // print("ishu");
    // return;
    try {
      emit(state.copyWith(status: LoadPage.loading));

      emit(state.copyWith(
        // albums: await repo.getAlbum(),
        // songs: await repo.getSongs(),
        playlists: await fetchPlaylists(),
        // categories: await fetchCategory(),
        // id: await repo.getId(),
        status: LoadPage.loaded,
      ));
    } catch (e) {
      // print(e.toString());
      print("Error happened at PlaylistCubit getalbums function");
      emit(state.copyWith(status: LoadPage.error));
    }
  }
}