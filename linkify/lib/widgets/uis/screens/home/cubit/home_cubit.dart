import 'package:bloc/bloc.dart';
import 'package:linkify/controller/first_page_categories.dart';
import 'package:linkify/controller/recommendations.dart';
import 'package:linkify/widgets/uis/models/album_model.dart';
import '../../../models/loading_enum.dart';
import '../../../models/song_model.dart';
import '../../../repositories/get_home_page.dart';

import '../../../models/user.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  // final repo = GetHomePage();
  HomeCubit() : super(HomeState.initial());

  Future<void> getAlbums() async {
    // print("ishu");
    // return;
    try {
      emit(state.copyWith(status: LoadPage.loading));

      emit(state.copyWith(
        // albums: await repo.getAlbum(),
        // songs: await repo.getSongs(),
        carouselSongs: await getCarouselSongs(),
        categories: await fetchCategory(),
        // id: await repo.getId(),
        status: LoadPage.loaded,
      ));
    } catch (e) {
      // print(e.toString());
      print("Error happened at homecubit getalbums function");
      emit(state.copyWith(status: LoadPage.error));
    }
  }
}