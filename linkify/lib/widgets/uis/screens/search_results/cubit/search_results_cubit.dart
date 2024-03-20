import 'package:bloc/bloc.dart';
// import '../../../controllers/main_controller.dart';
import '../../../models/loading_enum.dart';
import '../../../models/song_model.dart';
// import '../../../models/user.dart';
import '../../../repositories/get_search_results.dart';

part 'search_results_state.dart';

class SearchResultsCubit extends Cubit<SearchResultsState> {
  final repo = SearchRepository();

  SearchResultsCubit() : super(SearchResultsState.initial());
  Future<void> searchSongs(String query) async {
    // if (state.isSong) {

      try {
        // print("1a");
        // emit(state.copyWith(status: LoadPage.loading));
        // List<SongModel> songs = await repo.getSongs("mahiye jinna sohna");
        List<SongModel> songs = await repo.getSearchedSongOptions(query);
        // List<SongModel> songs=[];
        // print(songs);
        // print("1b");
        emit(state.copyWith(
          status: LoadPage.loaded,
          songs: songs,
        ));
      } catch (e) {
        print("error occurred");
        print("$e");
        emit(state.copyWith(status: LoadPage.error));
      }
    // } else {
      // try {
      //   emit(state.copyWith(status: LoadPage.loading));
      //   var users = await repo.getUsers(tag.toString());
      //   emit(state.copyWith(
      //     status: LoadPage.loaded,
      //     // users: users,
      //   ));
      // } catch (e) {
      //   emit(state.copyWith(status: LoadPage.error));
      // }
    }
  }

  // void playSongs(MainController controller, int initial) {
  //   controller.playSong(controller.convertToAudio(state.songs), initial);
  // }

  // void isNullToggle() {
  //   emit(state.copyWith(isNull: !state.isNull));
  // }

  // void isSongToggle() {
  //   emit(state.copyWith(isSong: !state.isSong));
  // }
// }
