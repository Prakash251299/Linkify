import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linkify/controller/static_store.dart';
import 'package:linkify/controller/user_genre.dart';

Future<void> recommender() async {
  await fetchTopTrackGenres();
  await fetchTopTrackGenresPercentage();
  print("hello");
  // print(StaticStore.userGenreWithCount);
}

Future<void> fetchTopTrackGenresPercentage() async {
  int sum = 0;
  if (StaticStore.userGenreWithCount == null) {
    return;
  }
  for (int k in StaticStore.userGenreWithCount!.values) {
    sum += k;
  }
  print(sum);
  for (var k in StaticStore.userGenreWithCount!.keys) {
    int a = (StaticStore.userGenreWithCount?[k]*100/sum).round();
    if(a>=8){
      StaticStore.userGenreWithCount?[k] = a;
    }else{
      StaticStore.userGenreWithCount?[k] = 0;
    }
  }
  print("User genre with count");
  // print(StaticStore.userGenreWithCount);
  // print(StaticStore.userGenre);
  await genreStoreWithPercentage();
}

Future<void> genreStoreWithPercentage() async {
  var db = FirebaseFirestore.instance;
    // List<dynamic> topThreeGenres = getTopThreeGenres(topGenre);
    // for(int i=0;StaticStore.userGenreWithCount!=null && i<StaticStore.userGenreWithCount!.length;i++){
    for (var k in StaticStore.userGenreWithCount!.keys) {
      // print(k);
      // print(StaticStore.userGenreWithCount?[k]);

      if(StaticStore.userGenreWithCount?[k]>0)
      

      await db
      .collection("userPercentageGenrewise")
      .doc("genreUser")
      .set({
        "${k}":{
          "${StaticStore.userGenreWithCount?[k]}":FieldValue.arrayUnion([StaticStore.currentUserId]),
        },
      },SetOptions(merge: true)
      );
      // .onError((e, _) => print("Error writing user info in firebase: $e"));
    }
    return;
}

Future<void> genreWiseUserWithPercentage() async {}

Future<void> fetchKNearestUsers() async {
  
}
