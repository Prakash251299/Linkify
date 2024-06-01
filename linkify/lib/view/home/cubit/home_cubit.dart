import 'package:bloc/bloc.dart';
import 'package:linkify/model/home/first_page_categories.dart';
import 'package:linkify/controller/home/front_page_data/recommendations.dart';
import '../../../controller/variables/loading_enum.dart';


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