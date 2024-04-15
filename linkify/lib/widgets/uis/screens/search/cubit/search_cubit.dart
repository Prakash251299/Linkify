import 'package:bloc/bloc.dart';
import 'package:linkify/controller/user_genre.dart';
import 'package:linkify/widgets/uis/repositories/get_search_page.dart';
// import 'package:linkify/widgets/uis/models/album_model.dart';
import '../../../models/loading_enum.dart';
// import '../../../models/song_model.dart';
// import '../../../repositories/get_home_page.dart';

// import '../../../models/user.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  // final repo = GetSearchPage();
  SearchCubit() : super(SearchState.initial());

  Future<void> getGenre() async {
    // print("ishu");
    // return;
    try {
      /* For new users */
      // if(newUser==true){
      //    await fetchUserSelectedArtistsGenres();
      // }

      emit(state.copyWith(status: LoadPage.loading));

      emit(state.copyWith(
        userGenre: await fetchTopTrackGenres(),
        status: LoadPage.loaded,
      ));
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(status: LoadPage.error));
    }
  }
}