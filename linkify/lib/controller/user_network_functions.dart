import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linkify/controller/static_store.dart';
import 'package:linkify/model/user_info.dart';

class NetworkFunction {
  Future<UserInfo?> fetchUserInfo(var userId) async {
    var db = FirebaseFirestore.instance;
    UserInfo users = UserInfo();
    await db.collection("users").doc(userId).get().then((v) {
      users.displayName = v.data()?['name'];
      users.image = v.data()?['images'];
      users.spotifyBasedGenre = v.data()?['spotifyGenre'];
      return users;
    });
    return users;
  }

  Future<List<UserInfo?>> fetchRecommendedUsersInfo() async {
    List<dynamic>? likeUsersId = []; // In firebase type is dynamic
    List<UserInfo?> likeUsersInfo = [];
    await FirebaseFirestore.instance
        .collection('spotifyBasedGenreUsers')
        .get()
        .then((value) async {
      likeUsersId =
          await value.docs[0]['genreList'][StaticStore.currentUserGenreId];
      likeUsersId?.remove(StaticStore.currentUserId);
      for (int i = 0; likeUsersId != null && i < likeUsersId!.length; i++) {
        likeUsersInfo.add(await fetchUserInfo(likeUsersId?[i]));
      }
      return likeUsersInfo;
    });

    return likeUsersInfo;
  }

  Future<List<UserInfo?>> fetchAllUsersInfo() async {
    List<dynamic>? allUsersId = []; // In firebase type is dynamic
    List<UserInfo?> allUsersInfo = [];
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value) async {
      // print(value.docs[0].id);
      try{
        for(int i=0;i<value.docs.length;i++){
          allUsersId.add(value.docs[i].id);
        }
        if(allUsersId.length>2){
          allUsersId.remove(StaticStore.currentUserId);
        }
        for (int i = 0;i < allUsersId.length;i++) {
          allUsersInfo.add(await fetchUserInfo(allUsersId[i]));
        }
        return allUsersInfo;
      }catch(e){
        return allUsersInfo;
      }
    });

    return allUsersInfo;
  }

  Future<int> getNumberOfUsers() async {
    var a = 0;
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value) async {
      a = value.docs.length;
    });
    return a;
  }
}
